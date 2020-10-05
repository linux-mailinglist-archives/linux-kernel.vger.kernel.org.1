Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBF12835C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJEMZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:25:51 -0400
Received: from z5.mailgun.us ([104.130.96.5]:35103 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJEMZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:25:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601900749; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Type: MIME-Version: Sender;
 bh=QzBKxnBMQDwW0ATgfCjedSZZRr3L88XzX1g4LaCEzdE=; b=S5fo3/qxqKz+wziA85+jgD2pk7DEwEt4PrXKnn38kTF4uBgoXPT9VI2QJ0Xj0VnwKmy0yrAv
 go+FMYeOEWI1/e4l3d8Zrv1JafzNjMG4SZDjWqNyRK6rgW0mTWHygjgOy2L4mHhAQcubcnJ+
 mdiV7EdajwSx2uD1UHTLt7WI6A8=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f7b10b883370fa1c1ac8dc7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 05 Oct 2020 12:25:28
 GMT
Sender: b_lkasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D0093C433FF; Mon,  5 Oct 2020 12:25:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: b_lkasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CC564C433CB;
        Mon,  5 Oct 2020 12:25:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_f75d1189a22a2d9eb1920f3af80508ec"
Date:   Mon, 05 Oct 2020 17:55:27 +0530
From:   b_lkasam@codeaurora.org
To:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [PATCH v2] regmap: irq: Add support to clear ack registers
In-Reply-To: <1601896560-27938-1-git-send-email-lkasam@codeaurora.org>
References: <Re: [PATCH] regmap: irq: Add support to clear ack registers>
 <1601896560-27938-1-git-send-email-lkasam@codeaurora.org>
Message-ID: <0f3da3b378ee9af7030d8bafa30b8dfd@codeaurora.org>
X-Sender: b_lkasam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_f75d1189a22a2d9eb1920f3af80508ec
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

<diff in v1 to v2 , addressed formatting and simplified logic >

For particular codec HWs have requirement to
toggle interrupt clear register twice 0->1->0.
To accommodate it, need to add one more field
(clear_ack) in the regmap_irq struct and update
regmap-irq driver to support it.

Signed-off-by: Laxminath Kasam <lkasam@codeaurora.org>
---
  drivers/base/regmap/regmap-irq.c | 33 ++++++++++++++++++++++++++++++++-
  include/linux/regmap.h           |  2 ++
  2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-irq.c 
b/drivers/base/regmap/regmap-irq.c
index 369a57e..ad5c2de 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -168,6 +168,14 @@ static void regmap_irq_sync_unlock(struct irq_data 
*data)
  				ret = regmap_write(map, reg, ~d->mask_buf[i]);
  			else
  				ret = regmap_write(map, reg, d->mask_buf[i]);
+			if (d->chip->clear_ack) {
+				if (d->chip->ack_invert && !ret)
+					ret = regmap_write(map, reg,
+							   d->mask_buf[i]);
+				else if (!ret)
+					ret = regmap_write(map, reg,
+							   ~d->mask_buf[i]);
+			}
  			if (ret != 0)
  				dev_err(d->map->dev, "Failed to ack 0x%x: %d\n",
  					reg, ret);
@@ -493,7 +501,20 @@ static irqreturn_t regmap_irq_thread(int irq, void 
*d)
  		if (data->status_buf[i] && (chip->ack_base || chip->use_ack)) {
  			reg = chip->ack_base +
  				(i * map->reg_stride * data->irq_reg_stride);
-			ret = regmap_write(map, reg, data->status_buf[i]);
+			if (chip->ack_invert)
+				ret = regmap_write(map, reg,
+						~data->status_buf[i]);
+			else
+				ret = regmap_write(map, reg,
+						data->status_buf[i]);
+			if (chip->clear_ack) {
+				if (chip->ack_invert && !ret)
+					ret = regmap_write(map, reg,
+							data->status_buf[i]);
+				else if (!ret)
+					ret = regmap_write(map, reg,
+							~data->status_buf[i]);
+			}
  			if (ret != 0)
  				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
  					reg, ret);
@@ -722,6 +743,16 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle 
*fwnode,
  			else
  				ret = regmap_write(map, reg,
  					d->status_buf[i] & d->mask_buf[i]);
+			if (chip->clear_ack) {
+				if (chip->ack_invert && !ret)
+					ret = regmap_write(map, reg,
+						(d->status_buf[i] &
+						 d->mask_buf[i]));
+				else if (!ret)
+					ret = regmap_write(map, reg,
+						~(d->status_buf[i] &
+						  d->mask_buf[i]));
+			}
  			if (ret != 0) {
  				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
  					reg, ret);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 1970ed5..0701671 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1305,6 +1305,7 @@ struct regmap_irq_sub_irq_map {
   * @mask_invert: Inverted mask register: cleared bits are masked out.
   * @use_ack:     Use @ack register even if it is zero.
   * @ack_invert:  Inverted ack register: cleared bits for ack.
+ * @clear_ack:  Use this to set 1 and 0 or vice-versa to clear 
interrupts.
   * @wake_invert: Inverted wake register: cleared bits are wake enabled.
   * @type_invert: Invert the type flags.
   * @type_in_mask: Use the mask registers for controlling irq type. For
@@ -1353,6 +1354,7 @@ struct regmap_irq_chip {
  	bool mask_invert:1;
  	bool use_ack:1;
  	bool ack_invert:1;
+	bool clear_ack:1;
  	bool wake_invert:1;
  	bool runtime_pm:1;
  	bool type_invert:1;
--
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative 
Project.
--=_f75d1189a22a2d9eb1920f3af80508ec
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
 name=v2-0001-regmap-irq-Add-support-to-clear-ack-registers.patch
Content-Disposition: attachment;
 filename=v2-0001-regmap-irq-Add-support-to-clear-ack-registers.patch;
 size=3631

RnJvbSA4MjJkODE5YzhkNTM4YjAzMjM3MDllZWZjNDFlODhkMDYyYjM0OWVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMYXhtaW5hdGggS2FzYW0gPGxrYXNhbUBjb2RlYXVyb3JhLm9y
Zz4KRGF0ZTogV2VkLCAyMyBTZXAgMjAyMCAxODo0MjozNiArMDUzMApTdWJqZWN0OiBbUEFUQ0gg
djJdIHJlZ21hcDogaXJxOiBBZGQgc3VwcG9ydCB0byBjbGVhciBhY2sgcmVnaXN0ZXJzCgpGb3Ig
cGFydGljdWxhciBjb2RlYyBIV3MgaGF2ZSByZXF1aXJlbWVudCB0bwp0b2dnbGUgaW50ZXJydXB0
IGNsZWFyIHJlZ2lzdGVyIHR3aWNlIDAtPjEtPjAuClRvIGFjY29tbW9kYXRlIGl0LCBuZWVkIHRv
IGFkZCBvbmUgbW9yZSBmaWVsZAooY2xlYXJfYWNrKSBpbiB0aGUgcmVnbWFwX2lycSBzdHJ1Y3Qg
YW5kIHVwZGF0ZQpyZWdtYXAtaXJxIGRyaXZlciB0byBzdXBwb3J0IGl0LgoKU2lnbmVkLW9mZi1i
eTogTGF4bWluYXRoIEthc2FtIDxsa2FzYW1AY29kZWF1cm9yYS5vcmc+Ci0tLQogZHJpdmVycy9i
YXNlL3JlZ21hcC9yZWdtYXAtaXJxLmMgfCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0KIGluY2x1ZGUvbGludXgvcmVnbWFwLmggICAgICAgICAgIHwgIDIgKysKIDIgZmlsZXMg
Y2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYmFzZS9yZWdtYXAvcmVnbWFwLWlycS5jIGIvZHJpdmVycy9iYXNlL3JlZ21hcC9yZWdt
YXAtaXJxLmMKaW5kZXggMzY5YTU3ZS4uYWQ1YzJkZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9iYXNl
L3JlZ21hcC9yZWdtYXAtaXJxLmMKKysrIGIvZHJpdmVycy9iYXNlL3JlZ21hcC9yZWdtYXAtaXJx
LmMKQEAgLTE2OCw2ICsxNjgsMTQgQEAgc3RhdGljIHZvaWQgcmVnbWFwX2lycV9zeW5jX3VubG9j
ayhzdHJ1Y3QgaXJxX2RhdGEgKmRhdGEpCiAJCQkJcmV0ID0gcmVnbWFwX3dyaXRlKG1hcCwgcmVn
LCB+ZC0+bWFza19idWZbaV0pOwogCQkJZWxzZQogCQkJCXJldCA9IHJlZ21hcF93cml0ZShtYXAs
IHJlZywgZC0+bWFza19idWZbaV0pOworCQkJaWYgKGQtPmNoaXAtPmNsZWFyX2FjaykgeworCQkJ
CWlmIChkLT5jaGlwLT5hY2tfaW52ZXJ0ICYmICFyZXQpCisJCQkJCXJldCA9IHJlZ21hcF93cml0
ZShtYXAsIHJlZywKKwkJCQkJCQkgICBkLT5tYXNrX2J1ZltpXSk7CisJCQkJZWxzZSBpZiAoIXJl
dCkKKwkJCQkJcmV0ID0gcmVnbWFwX3dyaXRlKG1hcCwgcmVnLAorCQkJCQkJCSAgIH5kLT5tYXNr
X2J1ZltpXSk7CisJCQl9CiAJCQlpZiAocmV0ICE9IDApCiAJCQkJZGV2X2VycihkLT5tYXAtPmRl
diwgIkZhaWxlZCB0byBhY2sgMHgleDogJWRcbiIsCiAJCQkJCXJlZywgcmV0KTsKQEAgLTQ5Myw3
ICs1MDEsMjAgQEAgc3RhdGljIGlycXJldHVybl90IHJlZ21hcF9pcnFfdGhyZWFkKGludCBpcnEs
IHZvaWQgKmQpCiAJCWlmIChkYXRhLT5zdGF0dXNfYnVmW2ldICYmIChjaGlwLT5hY2tfYmFzZSB8
fCBjaGlwLT51c2VfYWNrKSkgewogCQkJcmVnID0gY2hpcC0+YWNrX2Jhc2UgKwogCQkJCShpICog
bWFwLT5yZWdfc3RyaWRlICogZGF0YS0+aXJxX3JlZ19zdHJpZGUpOwotCQkJcmV0ID0gcmVnbWFw
X3dyaXRlKG1hcCwgcmVnLCBkYXRhLT5zdGF0dXNfYnVmW2ldKTsKKwkJCWlmIChjaGlwLT5hY2tf
aW52ZXJ0KQorCQkJCXJldCA9IHJlZ21hcF93cml0ZShtYXAsIHJlZywKKwkJCQkJCX5kYXRhLT5z
dGF0dXNfYnVmW2ldKTsKKwkJCWVsc2UKKwkJCQlyZXQgPSByZWdtYXBfd3JpdGUobWFwLCByZWcs
CisJCQkJCQlkYXRhLT5zdGF0dXNfYnVmW2ldKTsKKwkJCWlmIChjaGlwLT5jbGVhcl9hY2spIHsK
KwkJCQlpZiAoY2hpcC0+YWNrX2ludmVydCAmJiAhcmV0KQorCQkJCQlyZXQgPSByZWdtYXBfd3Jp
dGUobWFwLCByZWcsCisJCQkJCQkJZGF0YS0+c3RhdHVzX2J1ZltpXSk7CisJCQkJZWxzZSBpZiAo
IXJldCkKKwkJCQkJcmV0ID0gcmVnbWFwX3dyaXRlKG1hcCwgcmVnLAorCQkJCQkJCX5kYXRhLT5z
dGF0dXNfYnVmW2ldKTsKKwkJCX0KIAkJCWlmIChyZXQgIT0gMCkKIAkJCQlkZXZfZXJyKG1hcC0+
ZGV2LCAiRmFpbGVkIHRvIGFjayAweCV4OiAlZFxuIiwKIAkJCQkJcmVnLCByZXQpOwpAQCAtNzIy
LDYgKzc0MywxNiBAQCBpbnQgcmVnbWFwX2FkZF9pcnFfY2hpcF9md25vZGUoc3RydWN0IGZ3bm9k
ZV9oYW5kbGUgKmZ3bm9kZSwKIAkJCWVsc2UKIAkJCQlyZXQgPSByZWdtYXBfd3JpdGUobWFwLCBy
ZWcsCiAJCQkJCWQtPnN0YXR1c19idWZbaV0gJiBkLT5tYXNrX2J1ZltpXSk7CisJCQlpZiAoY2hp
cC0+Y2xlYXJfYWNrKSB7CisJCQkJaWYgKGNoaXAtPmFja19pbnZlcnQgJiYgIXJldCkKKwkJCQkJ
cmV0ID0gcmVnbWFwX3dyaXRlKG1hcCwgcmVnLAorCQkJCQkJKGQtPnN0YXR1c19idWZbaV0gJgor
CQkJCQkJIGQtPm1hc2tfYnVmW2ldKSk7CisJCQkJZWxzZSBpZiAoIXJldCkKKwkJCQkJcmV0ID0g
cmVnbWFwX3dyaXRlKG1hcCwgcmVnLAorCQkJCQkJfihkLT5zdGF0dXNfYnVmW2ldICYKKwkJCQkJ
CSAgZC0+bWFza19idWZbaV0pKTsKKwkJCX0KIAkJCWlmIChyZXQgIT0gMCkgewogCQkJCWRldl9l
cnIobWFwLT5kZXYsICJGYWlsZWQgdG8gYWNrIDB4JXg6ICVkXG4iLAogCQkJCQlyZWcsIHJldCk7
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3JlZ21hcC5oIGIvaW5jbHVkZS9saW51eC9yZWdt
YXAuaAppbmRleCAxOTcwZWQ1Li4wNzAxNjcxIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3Jl
Z21hcC5oCisrKyBiL2luY2x1ZGUvbGludXgvcmVnbWFwLmgKQEAgLTEzMDUsNiArMTMwNSw3IEBA
IHN0cnVjdCByZWdtYXBfaXJxX3N1Yl9pcnFfbWFwIHsKICAqIEBtYXNrX2ludmVydDogSW52ZXJ0
ZWQgbWFzayByZWdpc3RlcjogY2xlYXJlZCBiaXRzIGFyZSBtYXNrZWQgb3V0LgogICogQHVzZV9h
Y2s6ICAgICBVc2UgQGFjayByZWdpc3RlciBldmVuIGlmIGl0IGlzIHplcm8uCiAgKiBAYWNrX2lu
dmVydDogIEludmVydGVkIGFjayByZWdpc3RlcjogY2xlYXJlZCBiaXRzIGZvciBhY2suCisgKiBA
Y2xlYXJfYWNrOiAgVXNlIHRoaXMgdG8gc2V0IDEgYW5kIDAgb3IgdmljZS12ZXJzYSB0byBjbGVh
ciBpbnRlcnJ1cHRzLgogICogQHdha2VfaW52ZXJ0OiBJbnZlcnRlZCB3YWtlIHJlZ2lzdGVyOiBj
bGVhcmVkIGJpdHMgYXJlIHdha2UgZW5hYmxlZC4KICAqIEB0eXBlX2ludmVydDogSW52ZXJ0IHRo
ZSB0eXBlIGZsYWdzLgogICogQHR5cGVfaW5fbWFzazogVXNlIHRoZSBtYXNrIHJlZ2lzdGVycyBm
b3IgY29udHJvbGxpbmcgaXJxIHR5cGUuIEZvcgpAQCAtMTM1Myw2ICsxMzU0LDcgQEAgc3RydWN0
IHJlZ21hcF9pcnFfY2hpcCB7CiAJYm9vbCBtYXNrX2ludmVydDoxOwogCWJvb2wgdXNlX2Fjazox
OwogCWJvb2wgYWNrX2ludmVydDoxOworCWJvb2wgY2xlYXJfYWNrOjE7CiAJYm9vbCB3YWtlX2lu
dmVydDoxOwogCWJvb2wgcnVudGltZV9wbToxOwogCWJvb2wgdHlwZV9pbnZlcnQ6MTsKLS0gClF1
YWxjb21tIEluZGlhIFByaXZhdGUgTGltaXRlZCwgb24gYmVoYWxmIG9mIFF1YWxjb21tIElubm92
YXRpb24gQ2VudGVyLCBJbmMuLAppcyBhIG1lbWJlciBvZiBDb2RlIEF1cm9yYSBGb3J1bSwgYSBM
aW51eCBGb3VuZGF0aW9uIENvbGxhYm9yYXRpdmUgUHJvamVjdC4KCg==
--=_f75d1189a22a2d9eb1920f3af80508ec--
