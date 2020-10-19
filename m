Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CF429248F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 11:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgJSJZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 05:25:08 -0400
Received: from smtp26.cstnet.cn ([159.226.251.26]:57908 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730269AbgJSJZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 05:25:07 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2020 05:25:07 EDT
Received: by ajax-webmail-APP-08 (Coremail) ; Mon, 19 Oct 2020 17:17:46
 +0800 (GMT+08:00)
X-Originating-IP: [36.112.86.8]
Date:   Mon, 19 Oct 2020 17:17:46 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6JaE5b636Iqz?= <bodefang@iie.ac.cn>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix a possible NULL pointer dereference in
 bios_parser_get_src_obj()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.12 build 20200616(0f5d8152)
 Copyright (c) 2002-2020 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <44a94a03.53863.175402680b1.Coremail.bodefang@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: 0ACowACnfNK6WY1foOMDAA--.34607W
X-CM-SenderInfo: pergvwxdqjqx1lhotugofq/1tbiAwcOBl3qZcem0QABsv
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1doeV0gdGhlIGZ1bmMgIGJpb3NfcGFyc2VyX2dldF9zcmNfb2JqICgpIGlzIHNpbWlsYXIgdG8g
IGJpb3NfcGFyc2VyX2dldF9kc3Rfb2JqICgpIHdoaWNoIGlzIGZpeGVkIGJ5IHRoZSBjb21taXQ8
YThmOTc2NDczMTk2PigiZHJtL2FtZC9kaXNwbGF5OiBCYW5jaCBvZiBzbWF0Y2ggZXJyb3IgYW5k
IHdhcm5pbmcgZml4ZXMgaW4gREMiKS4KdGhlIHN5bWJvbCAnaWQnIGlzIHVuaW5pdGlhbGl6ZWQg
YW5kIGl0IGlzIG5vdCBjaGVja2VkIGJlZm9yZSBkZXJlZmVyZW5jZSBpdCxtYXkgbGVhZCB0byBu
dWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UuCltIb3ddIEluaXRpYWxpemVkIHZhcmlhYmxlIGV4cGxp
Y2l0bHkgd2l0aCBOVUxMIGFuZCBhZGQgc2FuaXRpemVyLgoKU2lnbmVkLW9mZi1ieTogZXN0aGVy
YmRmICZsdDs2MDM1NzE3ODZAcXEuY29tJmd0OwotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMKaW5kZXggMDA4ZDRkMS4uOTRjNmNjYSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9zX3BhcnNlci5j
CkBAIC0xOTAsNyArMTkwLDcgQEAgc3RhdGljIGVudW0gYnBfcmVzdWx0IGJpb3NfcGFyc2VyX2dl
dF9zcmNfb2JqKHN0cnVjdCBkY19iaW9zICpkY2IsCiAJc3RydWN0IGdyYXBoaWNzX29iamVjdF9p
ZCAqc3JjX29iamVjdF9pZCkKIHsKIAl1aW50MzJfdCBudW1iZXI7Ci0JdWludDE2X3QgKmlkOwor
CXVpbnQxNl90ICppZCA9IE5VTEw7CiAJQVRPTV9PQkpFQ1QgKm9iamVjdDsKIAlzdHJ1Y3QgYmlv
c19wYXJzZXIgKmJwID0gQlBfRlJPTV9EQ0IoZGNiKTsKIApAQCAtMjA2LDcgKzIwNiw3IEBAIHN0
YXRpYyBlbnVtIGJwX3Jlc3VsdCBiaW9zX3BhcnNlcl9nZXRfc3JjX29iaihzdHJ1Y3QgZGNfYmlv
cyAqZGNiLAogCiAJbnVtYmVyID0gZ2V0X3NyY19vYmpfbGlzdChicCwgb2JqZWN0LCAmYW1wO2lk
KTsKIAotCWlmIChudW1iZXIgJmx0Oz0gaW5kZXgpCisJaWYgKG51bWJlciAmbHQ7PSBpbmRleCB8
fCAhaWQpCiAJCXJldHVybiBCUF9SRVNVTFRfQkFESU5QVVQ7CiAKIAkqc3JjX29iamVjdF9pZCA9
IG9iamVjdF9pZF9mcm9tX2Jpb3Nfb2JqZWN0X2lkKGlkW2luZGV4XSk7Ci0tIAoxLjkuMQoKPC9h
OGY5NzY0NzMxOTY+
