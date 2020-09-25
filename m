Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E3B2789D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgIYNoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:44:16 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:43500 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728333AbgIYNoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:44:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601041454; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Type: MIME-Version: Sender;
 bh=3nKmLvWNBrJ3Hwv6yO8B8BqEr+SWOHB2QiTJrJjbasA=; b=tE8anEsM9QMyJ1+LwR/8gYE5rjVZAdBp41Iqw+76TbimReIWxAMmbnWvzI4kn5oEl1iQGu+i
 GJsAUQF9eaiE8oEmcOpH5elyYoEax5XNmp6/6s0NDzbE8a0DGbWHHuspBIsZNqAKkT37Sim5
 KPWPmJkQlvvh1jRB125yZba80Ss=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f6df42389f51cb4f15472d5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Sep 2020 13:44:03
 GMT
Sender: b_lkasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 513E3C433F1; Fri, 25 Sep 2020 13:44:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: b_lkasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 395C5C433CB;
        Fri, 25 Sep 2020 13:44:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5448e7ab1012bf71ca5c1874e97ebf73"
Date:   Fri, 25 Sep 2020 19:14:01 +0530
From:   b_lkasam@codeaurora.org
To:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [PATCH] regmap: irq: Add support to clear ack registers
In-Reply-To: <65dd6c86415a3d8f565160ca0cd66f2c@codeaurora.org>
References: <1601036740-23044-1-git-send-email-lkasam@codeaurora.org>
 <65dd6c86415a3d8f565160ca0cd66f2c@codeaurora.org>
Message-ID: <553eabe7ebfb94ac2e76323ef339634b@codeaurora.org>
X-Sender: b_lkasam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_5448e7ab1012bf71ca5c1874e97ebf73
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

For particular codec HWs have requirement to
writing interrupt clear and mask interrupt clear
register to toggle interrupt status. To accommodate it,
need to add one more field (clear_ack) in the regmap_irq
struct and update regmap-irq driver to support it.

Signed-off-by: Laxminath Kasam <lkasam@codeaurora.org>
---
  drivers/base/regmap/regmap-irq.c | 52 
++++++++++++++++++++++++++++++++++++----
  include/linux/regmap.h           |  2 ++
  2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c 
b/drivers/base/regmap/regmap-irq.c
index 369a57e..53a1557 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -164,10 +164,21 @@ static void regmap_irq_sync_unlock(struct irq_data 
*data)
  			reg = d->chip->ack_base +
  				(i * map->reg_stride * d->irq_reg_stride);
  			/* some chips ack by write 0 */
-			if (d->chip->ack_invert)
+			if (d->chip->ack_invert) {
  				ret = regmap_write(map, reg, ~d->mask_buf[i]);
-			else
+				if (d->chip->clear_ack) {
+					if (!ret)
+						ret = regmap_write(map, reg,
+								d->mask_buf[i]);
+				}
+			} else {
  				ret = regmap_write(map, reg, d->mask_buf[i]);
+				if (d->chip->clear_ack) {
+					if (!ret)
+						ret = regmap_write(map, reg,
+								~d->mask_buf[i]);
+				}
+			}
  			if (ret != 0)
  				dev_err(d->map->dev, "Failed to ack 0x%x: %d\n",
  					reg, ret);
@@ -493,7 +504,23 @@ static irqreturn_t regmap_irq_thread(int irq, void 
*d)
  		if (data->status_buf[i] && (chip->ack_base || chip->use_ack)) {
  			reg = chip->ack_base +
  				(i * map->reg_stride * data->irq_reg_stride);
-			ret = regmap_write(map, reg, data->status_buf[i]);
+			if (chip->ack_invert) {
+				ret = regmap_write(map, reg,
+						~data->status_buf[i]);
+				if (chip->clear_ack) {
+					if (!ret)
+						ret = regmap_write(map, reg,
+							data->status_buf[i]);
+				}
+			} else {
+				ret = regmap_write(map, reg,
+						data->status_buf[i]);
+				if (chip->clear_ack) {
+					if (!ret)
+						ret = regmap_write(map, reg,
+							~data->status_buf[i]);
+				}
+			}
  			if (ret != 0)
  				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
  					reg, ret);
@@ -716,12 +743,27 @@ int regmap_add_irq_chip_fwnode(struct 
fwnode_handle *fwnode,
  		if (d->status_buf[i] && (chip->ack_base || chip->use_ack)) {
  			reg = chip->ack_base +
  				(i * map->reg_stride * d->irq_reg_stride);
-			if (chip->ack_invert)
+			if (chip->ack_invert) {
  				ret = regmap_write(map, reg,
  					~(d->status_buf[i] & d->mask_buf[i]));
-			else
+				if (d->chip->clear_ack) {
+					if (!ret)
+						ret = regmap_write(
+							map, reg,
+							(d->status_buf[i] &
+							 d->mask_buf[i]);
+				}
+			} else {
  				ret = regmap_write(map, reg,
  					d->status_buf[i] & d->mask_buf[i]);
+				if (d->chip->clear_ack) {
+					if (!ret)
+						ret = regmap_write(
+							map, reg,
+							~(d->status_buf[i] &
+							 d->mask_buf[i]);
+				}
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
--=_5448e7ab1012bf71ca5c1874e97ebf73
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
 name=0001-regmap-irq-Add-support-to-clear-ack-registers.patch
Content-Disposition: attachment;
 filename=0001-regmap-irq-Add-support-to-clear-ack-registers.patch;
 size=4242

RnJvbSA3MDhkZGI4ZmYyZTY3M2VmMzMyYmNkNTk0NDkwNzQ0YjllNDcyMjI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMYXhtaW5hdGggS2FzYW0gPGxrYXNhbUBjb2RlYXVyb3JhLm9y
Zz4KRGF0ZTogV2VkLCAyMyBTZXAgMjAyMCAxODo0MjozNiArMDUzMApTdWJqZWN0OiBbUEFUQ0hd
IHJlZ21hcDogaXJxOiBBZGQgc3VwcG9ydCB0byBjbGVhciBhY2sgcmVnaXN0ZXJzCgpGb3IgcGFy
dGljdWxhciBjb2RlYyBIV3MgaGF2ZSByZXF1aXJlbWVudCB0bwp3cml0aW5nIGludGVycnVwdCBj
bGVhciBhbmQgbWFzayBpbnRlcnJ1cHQgY2xlYXIKcmVnaXN0ZXIgdG8gdG9nZ2xlIGludGVycnVw
dCBzdGF0dXMuIFRvIGFjY29tbW9kYXRlIGl0LApuZWVkIHRvIGFkZCBvbmUgbW9yZSBmaWVsZCAo
Y2xlYXJfYWNrKSBpbiB0aGUgcmVnbWFwX2lycQpzdHJ1Y3QgYW5kIHVwZGF0ZSByZWdtYXAtaXJx
IGRyaXZlciB0byBzdXBwb3J0IGl0LgoKU2lnbmVkLW9mZi1ieTogTGF4bWluYXRoIEthc2FtIDxs
a2FzYW1AY29kZWF1cm9yYS5vcmc+Ci0tLQogZHJpdmVycy9iYXNlL3JlZ21hcC9yZWdtYXAtaXJx
LmMgfCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tCiBpbmNsdWRl
L2xpbnV4L3JlZ21hcC5oICAgICAgICAgICB8ICAyICsrCiAyIGZpbGVzIGNoYW5nZWQsIDQ5IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL3Jl
Z21hcC9yZWdtYXAtaXJxLmMgYi9kcml2ZXJzL2Jhc2UvcmVnbWFwL3JlZ21hcC1pcnEuYwppbmRl
eCAzNjlhNTdlLi41M2ExNTU3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2Jhc2UvcmVnbWFwL3JlZ21h
cC1pcnEuYworKysgYi9kcml2ZXJzL2Jhc2UvcmVnbWFwL3JlZ21hcC1pcnEuYwpAQCAtMTY0LDEw
ICsxNjQsMjEgQEAgc3RhdGljIHZvaWQgcmVnbWFwX2lycV9zeW5jX3VubG9jayhzdHJ1Y3QgaXJx
X2RhdGEgKmRhdGEpCiAJCQlyZWcgPSBkLT5jaGlwLT5hY2tfYmFzZSArCiAJCQkJKGkgKiBtYXAt
PnJlZ19zdHJpZGUgKiBkLT5pcnFfcmVnX3N0cmlkZSk7CiAJCQkvKiBzb21lIGNoaXBzIGFjayBi
eSB3cml0ZSAwICovCi0JCQlpZiAoZC0+Y2hpcC0+YWNrX2ludmVydCkKKwkJCWlmIChkLT5jaGlw
LT5hY2tfaW52ZXJ0KSB7CiAJCQkJcmV0ID0gcmVnbWFwX3dyaXRlKG1hcCwgcmVnLCB+ZC0+bWFz
a19idWZbaV0pOwotCQkJZWxzZQorCQkJCWlmIChkLT5jaGlwLT5jbGVhcl9hY2spIHsKKwkJCQkJ
aWYgKCFyZXQpCisJCQkJCQlyZXQgPSByZWdtYXBfd3JpdGUobWFwLCByZWcsCisJCQkJCQkJCWQt
Pm1hc2tfYnVmW2ldKTsKKwkJCQl9CisJCQl9IGVsc2UgewogCQkJCXJldCA9IHJlZ21hcF93cml0
ZShtYXAsIHJlZywgZC0+bWFza19idWZbaV0pOworCQkJCWlmIChkLT5jaGlwLT5jbGVhcl9hY2sp
IHsKKwkJCQkJaWYgKCFyZXQpCisJCQkJCQlyZXQgPSByZWdtYXBfd3JpdGUobWFwLCByZWcsCisJ
CQkJCQkJCX5kLT5tYXNrX2J1ZltpXSk7CisJCQkJfQorCQkJfQogCQkJaWYgKHJldCAhPSAwKQog
CQkJCWRldl9lcnIoZC0+bWFwLT5kZXYsICJGYWlsZWQgdG8gYWNrIDB4JXg6ICVkXG4iLAogCQkJ
CQlyZWcsIHJldCk7CkBAIC00OTMsNyArNTA0LDIzIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCByZWdt
YXBfaXJxX3RocmVhZChpbnQgaXJxLCB2b2lkICpkKQogCQlpZiAoZGF0YS0+c3RhdHVzX2J1Zltp
XSAmJiAoY2hpcC0+YWNrX2Jhc2UgfHwgY2hpcC0+dXNlX2FjaykpIHsKIAkJCXJlZyA9IGNoaXAt
PmFja19iYXNlICsKIAkJCQkoaSAqIG1hcC0+cmVnX3N0cmlkZSAqIGRhdGEtPmlycV9yZWdfc3Ry
aWRlKTsKLQkJCXJldCA9IHJlZ21hcF93cml0ZShtYXAsIHJlZywgZGF0YS0+c3RhdHVzX2J1Zltp
XSk7CisJCQlpZiAoY2hpcC0+YWNrX2ludmVydCkgeworCQkJCXJldCA9IHJlZ21hcF93cml0ZSht
YXAsIHJlZywKKwkJCQkJCX5kYXRhLT5zdGF0dXNfYnVmW2ldKTsKKwkJCQlpZiAoY2hpcC0+Y2xl
YXJfYWNrKSB7CisJCQkJCWlmICghcmV0KQorCQkJCQkJcmV0ID0gcmVnbWFwX3dyaXRlKG1hcCwg
cmVnLAorCQkJCQkJCWRhdGEtPnN0YXR1c19idWZbaV0pOworCQkJCX0KKwkJCX0gZWxzZSB7CisJ
CQkJcmV0ID0gcmVnbWFwX3dyaXRlKG1hcCwgcmVnLAorCQkJCQkJZGF0YS0+c3RhdHVzX2J1Zltp
XSk7CisJCQkJaWYgKGNoaXAtPmNsZWFyX2FjaykgeworCQkJCQlpZiAoIXJldCkKKwkJCQkJCXJl
dCA9IHJlZ21hcF93cml0ZShtYXAsIHJlZywKKwkJCQkJCQl+ZGF0YS0+c3RhdHVzX2J1ZltpXSk7
CisJCQkJfQorCQkJfQogCQkJaWYgKHJldCAhPSAwKQogCQkJCWRldl9lcnIobWFwLT5kZXYsICJG
YWlsZWQgdG8gYWNrIDB4JXg6ICVkXG4iLAogCQkJCQlyZWcsIHJldCk7CkBAIC03MTYsMTIgKzc0
MywyNyBAQCBpbnQgcmVnbWFwX2FkZF9pcnFfY2hpcF9md25vZGUoc3RydWN0IGZ3bm9kZV9oYW5k
bGUgKmZ3bm9kZSwKIAkJaWYgKGQtPnN0YXR1c19idWZbaV0gJiYgKGNoaXAtPmFja19iYXNlIHx8
IGNoaXAtPnVzZV9hY2spKSB7CiAJCQlyZWcgPSBjaGlwLT5hY2tfYmFzZSArCiAJCQkJKGkgKiBt
YXAtPnJlZ19zdHJpZGUgKiBkLT5pcnFfcmVnX3N0cmlkZSk7Ci0JCQlpZiAoY2hpcC0+YWNrX2lu
dmVydCkKKwkJCWlmIChjaGlwLT5hY2tfaW52ZXJ0KSB7CiAJCQkJcmV0ID0gcmVnbWFwX3dyaXRl
KG1hcCwgcmVnLAogCQkJCQl+KGQtPnN0YXR1c19idWZbaV0gJiBkLT5tYXNrX2J1ZltpXSkpOwot
CQkJZWxzZQorCQkJCWlmIChkLT5jaGlwLT5jbGVhcl9hY2spIHsKKwkJCQkJaWYgKCFyZXQpCisJ
CQkJCQlyZXQgPSByZWdtYXBfd3JpdGUoCisJCQkJCQkJbWFwLCByZWcsCisJCQkJCQkJKGQtPnN0
YXR1c19idWZbaV0gJgorCQkJCQkJCSBkLT5tYXNrX2J1ZltpXSk7CisJCQkJfQorCQkJfSBlbHNl
IHsKIAkJCQlyZXQgPSByZWdtYXBfd3JpdGUobWFwLCByZWcsCiAJCQkJCWQtPnN0YXR1c19idWZb
aV0gJiBkLT5tYXNrX2J1ZltpXSk7CisJCQkJaWYgKGQtPmNoaXAtPmNsZWFyX2FjaykgeworCQkJ
CQlpZiAoIXJldCkKKwkJCQkJCXJldCA9IHJlZ21hcF93cml0ZSgKKwkJCQkJCQltYXAsIHJlZywK
KwkJCQkJCQl+KGQtPnN0YXR1c19idWZbaV0gJgorCQkJCQkJCSBkLT5tYXNrX2J1ZltpXSk7CisJ
CQkJfQorCQkJfQogCQkJaWYgKHJldCAhPSAwKSB7CiAJCQkJZGV2X2VycihtYXAtPmRldiwgIkZh
aWxlZCB0byBhY2sgMHgleDogJWRcbiIsCiAJCQkJCXJlZywgcmV0KTsKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvcmVnbWFwLmggYi9pbmNsdWRlL2xpbnV4L3JlZ21hcC5oCmluZGV4IDE5NzBl
ZDUuLjA3MDE2NzEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvcmVnbWFwLmgKKysrIGIvaW5j
bHVkZS9saW51eC9yZWdtYXAuaApAQCAtMTMwNSw2ICsxMzA1LDcgQEAgc3RydWN0IHJlZ21hcF9p
cnFfc3ViX2lycV9tYXAgewogICogQG1hc2tfaW52ZXJ0OiBJbnZlcnRlZCBtYXNrIHJlZ2lzdGVy
OiBjbGVhcmVkIGJpdHMgYXJlIG1hc2tlZCBvdXQuCiAgKiBAdXNlX2FjazogICAgIFVzZSBAYWNr
IHJlZ2lzdGVyIGV2ZW4gaWYgaXQgaXMgemVyby4KICAqIEBhY2tfaW52ZXJ0OiAgSW52ZXJ0ZWQg
YWNrIHJlZ2lzdGVyOiBjbGVhcmVkIGJpdHMgZm9yIGFjay4KKyAqIEBjbGVhcl9hY2s6ICBVc2Ug
dGhpcyB0byBzZXQgMSBhbmQgMCBvciB2aWNlLXZlcnNhIHRvIGNsZWFyIGludGVycnVwdHMuCiAg
KiBAd2FrZV9pbnZlcnQ6IEludmVydGVkIHdha2UgcmVnaXN0ZXI6IGNsZWFyZWQgYml0cyBhcmUg
d2FrZSBlbmFibGVkLgogICogQHR5cGVfaW52ZXJ0OiBJbnZlcnQgdGhlIHR5cGUgZmxhZ3MuCiAg
KiBAdHlwZV9pbl9tYXNrOiBVc2UgdGhlIG1hc2sgcmVnaXN0ZXJzIGZvciBjb250cm9sbGluZyBp
cnEgdHlwZS4gRm9yCkBAIC0xMzUzLDYgKzEzNTQsNyBAQCBzdHJ1Y3QgcmVnbWFwX2lycV9jaGlw
IHsKIAlib29sIG1hc2tfaW52ZXJ0OjE7CiAJYm9vbCB1c2VfYWNrOjE7CiAJYm9vbCBhY2tfaW52
ZXJ0OjE7CisJYm9vbCBjbGVhcl9hY2s6MTsKIAlib29sIHdha2VfaW52ZXJ0OjE7CiAJYm9vbCBy
dW50aW1lX3BtOjE7CiAJYm9vbCB0eXBlX2ludmVydDoxOwotLSAKUXVhbGNvbW0gSW5kaWEgUHJp
dmF0ZSBMaW1pdGVkLCBvbiBiZWhhbGYgb2YgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIElu
Yy4sCmlzIGEgbWVtYmVyIG9mIENvZGUgQXVyb3JhIEZvcnVtLCBhIExpbnV4IEZvdW5kYXRpb24g
Q29sbGFib3JhdGl2ZSBQcm9qZWN0LgoK
--=_5448e7ab1012bf71ca5c1874e97ebf73--
