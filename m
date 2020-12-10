Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AD02D5F71
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391379AbgLJPQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:16:53 -0500
Received: from smtp37.cstnet.cn ([159.226.251.37]:37508 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbgLJPQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:16:23 -0500
Received: by ajax-webmail-APP-12 (Coremail) ; Thu, 10 Dec 2020 23:15:26
 +0800 (GMT+08:00)
X-Originating-IP: [125.120.23.64]
Date:   Thu, 10 Dec 2020 23:15:26 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   shaojie.dong@isrc.iscas.ac.cn
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] staging: rtl8712: check register_netdev() return
 value
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20201118(d3a44678)
 Copyright (c) 2002-2020 www.mailtech.cn cnic.cn
In-Reply-To: <X9DppHini6848vTM@kroah.com>
References: <20201209150124.23446-1-shaojie.dong@isrc.iscas.ac.cn>
 <X9DppHini6848vTM@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4df7c198.210b.1764d38a318.Coremail.shaojie.dong@isrc.iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: tgCowAAnL1OOO9JfceECAA--.9527W
X-CM-SenderInfo: pvkd0ytlhov01qj6x21ufox2xfdvhtffof0/1tbiCgkGBVz4jNnsX
        AAAsB
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkKClRoYW5rcyAhICBJIHdpbGwgbW9kaWZ5IHNpZ24gbmFtZSBjb3JyZWN0bHkgbGF0ZXIKClNv
cnJ5IHRvIHNheSB0aGF0IEkgaGF2ZSBubyBydGw4NzEyIGhhcmR3YXJlLCBzbyB0aGF0IEkgY291
bGQgbm90IHRlc3QgaXQuCgpGcm9tIERhbiBDYXJwZW50ZXIncyBlbWFpbCByZXBseSwgImZyZWVf
bmV0ZGV2KGFkYXB0ZXItJmd0O3BuZXRkZXYpIiBmdW5jdGlvbiBtYXkgY2F1c2UgdXNlIGFmdGVy
IGZyZWUgaXNzdWUKU28gdGhhdCBJIHJlcGx5IGVtYWlsIHRvIGVuc3VyZSBpZiB0aGlzIHJldHVy
biB2YWx1ZSBzaG91bGQgYmUgY2hlY2sgb3IgaG93IHRvIGhhbmRsZSB0aGlzIHJldHVybiB2YWx1
ZSBlcnJvcgoKCiZndDsgLS0tLS3ljp/lp4vpgq7ku7YtLS0tLQomZ3Q7IOWPkeS7tuS6ujogIkdy
ZWcgS0giIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KJmd0OyDlj5HpgIHml7bpl7Q6IDIw
MjAtMTItMDkgMjM6MTM6NDAgKOaYn+acn+S4iSkKJmd0OyDmlLbku7bkuro6IHNoYW9qaWUuZG9u
Z0Bpc3JjLmlzY2FzLmFjLmNuCiZndDsg5oqE6YCBOiBMYXJyeS5GaW5nZXJAbHdmaW5nZXIubmV0
LCBmbG9yaWFuLmMuc2NoaWxoYWJlbEBnb29nbGVtYWlsLmNvbSwgZGV2ZWxAZHJpdmVyZGV2Lm9z
dW9zbC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKJmd0OyDkuLvpopg6IFJlOiBb
UEFUQ0hdIHN0YWdpbmc6IHJ0bDg3MTI6IGNoZWNrIHJlZ2lzdGVyX25ldGRldigpIHJldHVybiB2
YWx1ZQomZ3Q7IAomZ3Q7IE9uIFdlZCwgRGVjIDA5LCAyMDIwIGF0IDExOjAxOjI0UE0gKzA4MDAs
IHNoYW9qaWUuZG9uZ0Bpc3JjLmlzY2FzLmFjLmNuIHdyb3RlOgomZ3Q7ICZndDsgRnJvbTogInNo
YW9qaWUuZG9uZyIgPHNoYW9qaWUuZG9uZ0Bpc3JjLmlzY2FzLmFjLmNuPgomZ3Q7ICZndDsgCiZn
dDsgJmd0OyBGdW5jdGlvbiByZWdpc3Rlcl9uZXRkZXYoKSBjYW4gZmFpbCwgc28gd2Ugc2hvdWxk
IGNoZWNrIGl0J3MgcmV0dXJuIHZhbHVlCiZndDsgJmd0OyAKJmd0OyAmZ3Q7IFNpZ25lZC1vZmYt
Ynk6IHNoYW9qaWUuZG9uZyA8c2hhb2ppZS5kb25nQGlzcmMuaXNjYXMuYWMuY24+CiZndDsgCiZn
dDsgSSBkb3VidCB5b3Ugc2lnbiB5b3VyIG5hbWUgd2l0aCBhICcuJyBpbiBpdCwgcmlnaHQ/CiZn
dDsgCiZndDsgUGxlYXNlIHJlc2VuZCB3aXRoIHRoZSBjb3JyZWN0IG5hbWUsIGFuZCB1c2luZyBD
YXBpdGFsIGxldHRlcnMgd2hlcmUKJmd0OyBuZWVkZWQuCiZndDsgCiZndDsgJmd0OyAtLS0KJmd0
OyAmZ3Q7ICBkcml2ZXJzL3N0YWdpbmcvcnRsODcxMi9oYWxfaW5pdC5jIHwgNSArKysrLQomZ3Q7
ICZndDsgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKJmd0
OyAmZ3Q7IAomZ3Q7ICZndDsgZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9ydGw4NzEyL2hh
bF9pbml0LmMgYi9kcml2ZXJzL3N0YWdpbmcvcnRsODcxMi9oYWxfaW5pdC5jCiZndDsgJmd0OyBp
bmRleCA3MTVmMWZlOGIuLjM4YTNlM2Q0NCAxMDA2NDQKJmd0OyAmZ3Q7IC0tLSBhL2RyaXZlcnMv
c3RhZ2luZy9ydGw4NzEyL2hhbF9pbml0LmMKJmd0OyAmZ3Q7ICsrKyBiL2RyaXZlcnMvc3RhZ2lu
Zy9ydGw4NzEyL2hhbF9pbml0LmMKJmd0OyAmZ3Q7IEBAIC00NSw3ICs0NSwxMCBAQCBzdGF0aWMg
dm9pZCBydGw4NzF4X2xvYWRfZndfY2IoY29uc3Qgc3RydWN0IGZpcm13YXJlICpmaXJtd2FyZSwg
dm9pZCAqY29udGV4dCkKJmd0OyAmZ3Q7ICAJfQomZ3Q7ICZndDsgIAlhZGFwdGVyLSZndDtmdyA9
IGZpcm13YXJlOwomZ3Q7ICZndDsgIAkvKiBmaXJtd2FyZSBhdmFpbGFibGUgLSBzdGFydCBuZXRk
ZXYgKi8KJmd0OyAmZ3Q7IC0JcmVnaXN0ZXJfbmV0ZGV2KGFkYXB0ZXItJmd0O3BuZXRkZXYpOwom
Z3Q7ICZndDsgKwlpZiAocmVnaXN0ZXJfbmV0ZGV2KGFkYXB0ZXItJmd0O3BuZXRkZXYpICE9IDAp
IHsKJmd0OyAmZ3Q7ICsJCW5ldGRldl9lcnIoYWRhcHRlci0mZ3Q7cG5ldGRldiwgInJlZ2lzdGVy
X25ldGRldigpIGZhaWxlZFxuIik7CiZndDsgJmd0OyArCQlmcmVlX25ldGRldihhZGFwdGVyLSZn
dDtwbmV0ZGV2KTsKJmd0OyAmZ3Q7ICsJfQomZ3Q7IAomZ3Q7IERpZCB5b3UgdGVzdCB0aGlzIHRv
IHNlZSBpZiB0aGlzIHJlYWxseSBwcm9wZXJseSBjbGVhbnMgZXZlcnl0aGluZyB1cD8KJmd0OyAK
Jmd0OyBBbmQgeW91ciBpZiBzdGF0ZW1lbnQgY2FuIGJlIHNpbXBsaWZpZWQsIHBsZWFzZSBkbyBz
by4KJmd0OyAKJmd0OyB0aGFua3MsCiZndDsgCiZndDsgZ3JlZyBrLWgKPC9zaGFvamllLmRvbmdA
aXNyYy5pc2Nhcy5hYy5jbj48L3NoYW9qaWUuZG9uZ0Bpc3JjLmlzY2FzLmFjLmNuPjwvZ3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+
