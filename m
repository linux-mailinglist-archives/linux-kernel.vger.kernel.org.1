Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D82D5F88
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391361AbgLJPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:23:19 -0500
Received: from smtp37.cstnet.cn ([159.226.251.37]:39838 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389516AbgLJPWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:22:53 -0500
Received: by ajax-webmail-APP-12 (Coremail) ; Thu, 10 Dec 2020 23:21:52
 +0800 (GMT+08:00)
X-Originating-IP: [125.120.23.64]
Date:   Thu, 10 Dec 2020 23:21:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   shaojie.dong@isrc.iscas.ac.cn
To:     "Dan Carpenter" <dan.carpenter@oracle.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] staging: rtl8712: check register_netdev()
 return value
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20201118(d3a44678)
 Copyright (c) 2002-2020 www.mailtech.cn cnic.cn
In-Reply-To: <20201210151631.GN2789@kadam>
References: <20201209150124.23446-1-shaojie.dong@isrc.iscas.ac.cn>
 <20201209174615.GI2767@kadam>
 <30d377fa.20bd.1764d2f9aa8.Coremail.shaojie.dong@isrc.iscas.ac.cn>
 <20201210151631.GN2789@kadam>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7111e709.212e.1764d3e89da.Coremail.shaojie.dong@isrc.iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: tgCowAC3hYEQPdJfqOECAA--.11433W
X-CM-SenderInfo: pvkd0ytlhov01qj6x21ufox2xfdvhtffof0/1tbiCwcGBVz4jpfte
        AABsm
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkKCkkgZG8gbm90IGhhdmUgcnRsODcxMiBoYXJkd2FyZQpTbyB0aGF0IEkgd291bGQgcmVtYWlu
IHRoaXMgY29kZSBhbmQgZ2l2ZSB1cCBteSBwYXRjaApUaGFuayB5b3UgIQoKJmd0OyAtLS0tLeWO
n+Wni+mCruS7ti0tLS0tCiZndDsg5Y+R5Lu25Lq6OiAiRGFuIENhcnBlbnRlciIgPGRhbi5jYXJw
ZW50ZXJAb3JhY2xlLmNvbT4KJmd0OyDlj5HpgIHml7bpl7Q6IDIwMjAtMTItMTAgMjM6MTY6MzEg
KOaYn+acn+WbmykKJmd0OyDmlLbku7bkuro6IHNoYW9qaWUuZG9uZ0Bpc3JjLmlzY2FzLmFjLmNu
CiZndDsg5oqE6YCBOiBMYXJyeS5GaW5nZXJAbHdmaW5nZXIubmV0LCBmbG9yaWFuLmMuc2NoaWxo
YWJlbEBnb29nbGVtYWlsLmNvbSwgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcsIGRldmVsQGRy
aXZlcmRldi5vc3Vvc2wub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCiZndDsg5Li7
6aKYOiBSZTogUmU6IFtQQVRDSF0gc3RhZ2luZzogcnRsODcxMjogY2hlY2sgcmVnaXN0ZXJfbmV0
ZGV2KCkgcmV0dXJuIHZhbHVlCiZndDsgCiZndDsgT24gVGh1LCBEZWMgMTAsIDIwMjAgYXQgMTE6
MDU6MzRQTSArMDgwMCwgc2hhb2ppZS5kb25nQGlzcmMuaXNjYXMuYWMuY24gd3JvdGU6CiZndDsg
Jmd0OyBIaQomZ3Q7ICZndDsgCiZndDsgJmd0OyAmZ3Q7IAomZ3Q7ICZndDsgJmd0OyBUaGlzIGZ1
bmN0aW9uIHNob3VsZCBub3QgYmUgY2FsbGluZyByZWdpc3Rlcl9uZXRkZXYoKS4gIFdoYXQgZG9l
cyB0aGF0CiZndDsgJmd0OyAmZ3Q7IGhhdmUgdG8gZG8gd2l0aCBmaXJtd2FyZT8gIEl0IHNob3Vs
ZCBhbHNvIG5vdCBmcmVlX25ldGRldigpIGJlY2F1c2UKJmd0OyAmZ3Q7ICZndDsgdGhhdCB3aWxs
IGp1c3QgbGVhZCB0byBhIHVzZSBhZnRlciBmcmVlIGluIHRoZSBjYWxsZXIuCiZndDsgJmd0OyAm
Z3Q7CiZndDsgJmd0OyAKJmd0OyAmZ3Q7IC0tJmd0OyBjaGVjayBjb2RlIGhpc3RvcnkgYXV0aG9y
PGxhcnJ5LmZpbmdlckBsd2Zpbmdlci5uZXQ+IGNoYW5nZWQgc3luY2hyb25vdXMgZmlybXdhcmUg
bG9hZGluZyB0byBhc3luY2hyb25vdXMgZmlybXdhcmUgbG9hZGluZwomZ3Q7ICZndDsgICAgIGJl
Zm9yZSB0aGlzIGNoYW5nZSwgcmVnaXN0ZXJfbmV0ZGV2KCkgd2FzIG5vdCBjYWxsaW5nIGluIGZp
cm13YXJlIHJlbGF0ZWQgZnVuY3Rpb24uCiZndDsgJmd0OyAgICAgRm9yIGFzeW5jaHJvbm91cyBs
b2FkaW5nLCBtYXliZSByZWdpc3Rlcl9uZXRkZXYoKSBiZSBjYWxsaW5nIGluIHJ0bDg3MXhfbG9h
ZF9md19jYigpIGlzIHRvIGVuc3VyZSB0aGUgbmV0ZGV2IGJlIHJlZ2lzdGVyZWQgYWZ0ZXIgZmly
bXdhcmUgbG9hZGluZyBjb21wbGV0ZWQKJmd0OyAmZ3Q7IAomZ3Q7ICZndDsgLS0mZ3Q7IGZvciBw
b3RlbnRpYWwgdXNlIGFmdGVyIGZyZWUgaXNzdWUKJmd0OyAmZ3Q7ICAgICBDb3VsZCBJIG9ubHkg
Y2FsbCAiZnJlZV9pcnEoYWRhcHRlci0mZ3Q7cG5ldGRldi0mZ3Q7aXJxLCBhZGFwdGVyLSZndDtw
bmV0ZGV2KSIgd2hlbiByZWdpc3Rlcl9uZXRkZXYoKSBmYWlsZWQgPwomZ3Q7ICZndDsgICAgIElm
IG5vIG5lZWQgdG8gY2hhbmdlIGRyaXZlcnMvc3RhZ2luZy9ydGw4NzEyL2hhbF9pbml0LmMgZmls
ZSwgSSBjb3VsZCBnaXZlIHVwIG15IHBhdGNoLCB0aGFuayB5b3UgIQomZ3Q7ICZndDsgCiZndDsg
CiZndDsgQ2xlYW5pbmcgdGhpcyB1cCBpcyBhIGJpdCBjb21wbGljYXRlZCBhbmQgcmVxdWlyZXMg
cmV3b3JraW5nIHRoZQomZ3Q7IGZpcm13YXJlIGxvYWRpbmcgYW5kIGl0IHJlcXVpcmVzIHRlc3Rp
bmcuICBJIGRvbid0IHRoaW5rIHlvdSBoYXZlIHRoZQomZ3Q7IGhhcmR3YXJlIHRvIGFjdHVhbGx5
IHRlc3QgdGhpcyBkcml2ZXI/ICBQcm9iYWJseSwganVzdCBsZWF2ZSB0aGlzIGNvZGUKJmd0OyBm
b3IgYW5vdGhlciBkYXkuCiZndDsgCiZndDsgcmVnYXJkcywKJmd0OyBkYW4gY2FycGVudGVyCjwv
bGFycnkuZmluZ2VyQGx3ZmluZ2VyLm5ldD48L2Rhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4=
