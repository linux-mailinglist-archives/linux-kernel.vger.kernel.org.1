Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C17272222
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgIULT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:19:27 -0400
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:24891 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgIULT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:19:26 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 07:19:23 EDT
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id BF0911A37F3;
        Mon, 21 Sep 2020 19:11:57 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AN*ApwBwDVasgemZb6*hx4qM.1.1600686717774.Hmail.bernard@vivo.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: =?UTF-8?B?W1JlLXNlbmRdW1BBVENIXSBncHUvaXB1LXYzOnJlZHVjZSBwcm90ZWN0ZWQgY29kZSBhcmVhIGluIGlwdSBpZG1hYyBnZXQvcHV0?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.124
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.124) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 21 Sep 2020 19:11:57 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Mon, 21 Sep 2020 19:11:57 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSk0eHUtMHRhDTk8eVkpNS0tNQ01MSkxDTE5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzo1UToLDDkMPy0aCBweFiEZTVET
        A08KNlVKVUpNS0tNQ01MSkNITUNVMxYaEhdVGR4JFRoJHzsNEg0UVRgUFkVZV1kSC1lBWUpOTFVL
        VUhKVUpJT1lXWQgBWUFITE9NNwY+
X-HM-Tid: 0a74b05cfb5d93b4kuwsbf0911a37f3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBjaGFuZ2Ugd2lsbCBzcGVlZC11cCBhIGJpdCB0aGVzZSBpcHVfaWRtYWNfZ2V0ICYKaXB1
X2lkbWFjX3B1dCBwcm9jZXNzaW5nIGFuZCB0aGVyZSBpcyBubyBuZWVkIHRvIHByb3RlY3QKa3ph
bGxvYyAmIGtmcmVlLgoKU2lnbmVkLW9mZi1ieTogQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8u
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2lwdS12My9pcHUtY29tbW9uLmMgfCAyNCArKysrKysrKysr
KysrLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9pcHUtdjMvaXB1LWNvbW1vbi5jIGIv
ZHJpdmVycy9ncHUvaXB1LXYzL2lwdS1jb21tb24uYwppbmRleCBiM2RhZTllYzFhMzguLjhiM2E1
Nzg2NGMyZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvaXB1LXYzL2lwdS1jb21tb24uYworKysg
Yi9kcml2ZXJzL2dwdS9pcHUtdjMvaXB1LWNvbW1vbi5jCkBAIC0yNjcsMjkgKzI2NywzMCBAQCBF
WFBPUlRfU1lNQk9MX0dQTChpcHVfcm90X21vZGVfdG9fZGVncmVlcyk7CiBzdHJ1Y3QgaXB1djNf
Y2hhbm5lbCAqaXB1X2lkbWFjX2dldChzdHJ1Y3QgaXB1X3NvYyAqaXB1LCB1bnNpZ25lZCBudW0p
CiB7CiAJc3RydWN0IGlwdXYzX2NoYW5uZWwgKmNoYW5uZWw7CisJc3RydWN0IGlwdXYzX2NoYW5u
ZWwgKmVudHJ5OwogCiAJZGV2X2RiZyhpcHUtPmRldiwgIiVzICVkXG4iLCBfX2Z1bmNfXywgbnVt
KTsKIAogCWlmIChudW0gPiA2MykKIAkJcmV0dXJuIEVSUl9QVFIoLUVOT0RFVik7CiAKKwljaGFu
bmVsID0ga3phbGxvYyhzaXplb2YoKmNoYW5uZWwpLCBHRlBfS0VSTkVMKTsKKwlpZiAoIWNoYW5u
ZWwpCisJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOworCisJY2hhbm5lbC0+bnVtID0gbnVtOwor
CWNoYW5uZWwtPmlwdSA9IGlwdTsKKwogCW11dGV4X2xvY2soJmlwdS0+Y2hhbm5lbF9sb2NrKTsK
IAotCWxpc3RfZm9yX2VhY2hfZW50cnkoY2hhbm5lbCwgJmlwdS0+Y2hhbm5lbHMsIGxpc3QpIHsK
LQkJaWYgKGNoYW5uZWwtPm51bSA9PSBudW0pIHsKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KGVudHJ5
LCAmaXB1LT5jaGFubmVscywgbGlzdCkgeworCQlpZiAoZW50cnktPm51bSA9PSBudW0pIHsKKwkJ
CWtmcmVlKGNoYW5uZWwpOwogCQkJY2hhbm5lbCA9IEVSUl9QVFIoLUVCVVNZKTsKIAkJCWdvdG8g
b3V0OwogCQl9CiAJfQogCi0JY2hhbm5lbCA9IGt6YWxsb2Moc2l6ZW9mKCpjaGFubmVsKSwgR0ZQ
X0tFUk5FTCk7Ci0JaWYgKCFjaGFubmVsKSB7Ci0JCWNoYW5uZWwgPSBFUlJfUFRSKC1FTk9NRU0p
OwotCQlnb3RvIG91dDsKLQl9Ci0KLQljaGFubmVsLT5udW0gPSBudW07Ci0JY2hhbm5lbC0+aXB1
ID0gaXB1OwogCWxpc3RfYWRkKCZjaGFubmVsLT5saXN0LCAmaXB1LT5jaGFubmVscyk7CiAKIG91
dDoKQEAgLTMwOCw5ICszMDksMTAgQEAgdm9pZCBpcHVfaWRtYWNfcHV0KHN0cnVjdCBpcHV2M19j
aGFubmVsICpjaGFubmVsKQogCW11dGV4X2xvY2soJmlwdS0+Y2hhbm5lbF9sb2NrKTsKIAogCWxp
c3RfZGVsKCZjaGFubmVsLT5saXN0KTsKLQlrZnJlZShjaGFubmVsKTsKIAogCW11dGV4X3VubG9j
aygmaXB1LT5jaGFubmVsX2xvY2spOworCisJa2ZyZWUoY2hhbm5lbCk7CiB9CiBFWFBPUlRfU1lN
Qk9MX0dQTChpcHVfaWRtYWNfcHV0KTsKIAotLSAKMi4yOC4wCgoNCg0K
