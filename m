Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5062A90B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKFHtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:49:20 -0500
Received: from m176149.mail.qiye.163.com ([59.111.176.149]:58485 "EHLO
        m176149.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFHtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:49:20 -0500
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2020 02:49:19 EST
Received: from vivo.com (wm-9.qy.internal [127.0.0.1])
        by m176149.mail.qiye.163.com (Hmail) with ESMTP id 4C9A62832DD;
        Fri,  6 Nov 2020 15:39:41 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ACIArQBlDXHfZNI0kyjfGqo0.3.1604648380903.Hmail.wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gdXNiOiBBc3NpZ24gTlVMTCDigIvigIt0byBwaHkgdGhhdCBtYXkgYmUgcmV0dXJuZWQ=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.213.83.156
In-Reply-To: <20201106065131.GD697514@kroah.com>
MIME-Version: 1.0
Received: from wangqing@vivo.com( [58.213.83.156) ] by ajax-webmail ( [127.0.0.1] ) ; Fri, 6 Nov 2020 15:39:40 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Date:   Fri, 6 Nov 2020 15:39:40 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTEsYTUhOHU4eGhgaVkpNS09NT0NIQ0pISEJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU5CTkNDQ0NIQ0tCN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6ODI6CSo5Fz8jMx0hNTJLEAIRHTwKFEtVSFVKTUtPTU9DSENKTExCVTMWGhIXVQwaFRwKEhUc
        Ow0SDRRVGBQWRVlXWRILWUFZTkNVSUpIVUNIVUpOTVlXWQgBWUFIT0xINwY+
X-HM-Tid: 0a759c7f2b849395kuws4c9a62832dd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gQXNzaWduIGluaXRpYWwgdmFsdWVzIHRvIGxvY2FsIHZhcmlhYmxlcyB0aGF0IG1heSBiZSBy
ZXR1cm5lZAo+PiAKPj4gU2lnbmVkLW9mZi1ieTogV2FuZyBRaW5nIDx3YW5ncWluZ0B2aXZvLmNv
bT4KPgo+WW91ciBzdWJqZWN0LCBhbmQgYm9keSBvZiB0ZXh0LCBzZWVtIHRvIGhhdmUgMiAib2Rk
IiBjaGFyYWN0ZXJzIGluIGl0LAo+cGxlYXNlIGZpeCB1cC4KPgo+QWxzbywgeW91ciBzdWJqZWN0
IGFuZCBjaGFuZ2Vsb2cgYm9keSBoZXJlIGFyZSBpZGVudGljYWwsIHBsZWFzZSBiZSBtdWNoCj5t
b3JlIHZlcmJvc2UgaW4gdGhlIGJvZHkgZXhwbGFpbmluZyB3aHkgeW91IGFyZSBkb2luZyBzb21l
dGhpbmcsIG5vdAo+anVzdCB3aGF0IHlvdSBhcmUgZG9pbmcuCj4KPkFuZCB5b3VyIHN1YmplY3Qg
bGluZSBzaG91bGQgYWxzbyBtYXRjaCBvdGhlciBwYXRjaGVzIGZvciB0aGlzIGZpbGUsIGFuZAo+
aGF2ZSAidXNiOiBwaHk6IC4uLiIgaW4gdGhlIGJlZ2lubmluZy4KWWVhaCwgSSBnb3QgaXQuCj4K
Pj4gLS0tCj4+ICBkcml2ZXJzL3VzYi9waHkvcGh5LmMgfCAyICstCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9waHkvcGh5LmMgYi9kcml2ZXJzL3VzYi9waHkvcGh5LmMKPj4gaW5kZXggYjQ3Mjg1
Zi4uZGUyMTk2Nwo+PiAtLS0gYS9kcml2ZXJzL3VzYi9waHkvcGh5LmMKPj4gKysrIGIvZHJpdmVy
cy91c2IvcGh5L3BoeS5jCj4+IEBAIC01OSw3ICs1OSw3IEBAIHN0YXRpYyBzdHJ1Y3QgdXNiX3Bo
eSAqX191c2JfZmluZF9waHkoc3RydWN0IGxpc3RfaGVhZCAqbGlzdCwKPj4gIAo+PiAgc3RhdGlj
IHN0cnVjdCB1c2JfcGh5ICpfX29mX3VzYl9maW5kX3BoeShzdHJ1Y3QgZGV2aWNlX25vZGUgKm5v
ZGUpCj4+ICB7Cj4+IC0Jc3RydWN0IHVzYl9waHkgICpwaHk7Cj4+ICsJc3RydWN0IHVzYl9waHkg
ICpwaHkgPSBOVUxMOwo+Cj5XaHkgaXNuJ3QgdGhlIGNvbXBpbGVyIGNvbXBsYWluaW5nIGFib3V0
IHRoaXMgdG9kYXk/ICBBcmUgeW91IHN1cmUgdGhpcwo+aXMgbmVlZGVkPwpTb3JyeSwgSSBkaWRu
J3QgbG9vayBhdCBpdCBjYXJlZnVsbHksIGJlY2F1c2UgX191c2JfZmluZF9waHkgaGFzIGFuIGlu
aXRpYWwgdmFsdWUsIAphbmQgSSB3YXMgYWZmZWN0ZWQuLiBZb3UgZG9uJ3QgbmVlZCB0byBtb2Rp
ZnkgaXQsIEluIGZhY3QuCgp0aGFua3MsCgpXYW5nIFFpbmcKPgo+dGhhbmtzLAo+Cj5ncmVnIGst
aAoNCg0K
