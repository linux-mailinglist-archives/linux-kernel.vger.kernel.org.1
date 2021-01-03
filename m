Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF5B2E8B25
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 07:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbhACGXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 01:23:30 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:9618 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbhACGX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 01:23:29 -0500
Received: by ajax-webmail-mail-app2 (Coremail) ; Sun, 3 Jan 2021 14:22:11
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Sun, 3 Jan 2021 14:22:11 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Lu Baolu" <baolu.lu@linux.intel.com>
Cc:     kjlu@umn.edu, "David Woodhouse" <dwmw2@infradead.org>,
        "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
        "Jiang Liu" <jiang.liu@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] iommu/intel: Fix memleak in
 intel_irq_remapping_alloc
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20200917(3e19599d)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <6e1ce9ac-ac17-2b16-84d3-a18c011768f2@linux.intel.com>
References: <20210102095029.29053-1-dinghao.liu@zju.edu.cn>
 <18add30d-a830-c531-6fd2-58a1898b157f@linux.intel.com>
 <50870a42.15f1a.176c66eaf92.Coremail.dinghao.liu@zju.edu.cn>
 <6e1ce9ac-ac17-2b16-84d3-a18c011768f2@linux.intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3b0b2129.17762.176c6e9114d.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgCnr+uTYvFff_1QAA--.14443W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0OBlZdtRzbxwAAs5
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAyMDIxLzEvMyAxMjowOCwgZGluZ2hhby5saXVAemp1LmVkdS5jbiB3cm90ZToKPiA+PiBI
aSwKPiA+Pgo+ID4+IE9uIDIwMjEvMS8yIDE3OjUwLCBEaW5naGFvIExpdSB3cm90ZToKPiA+Pj4g
V2hlbiBpcnFfZG9tYWluX2dldF9pcnFfZGF0YSgpIG9yIGlycWRfY2ZnKCkgZmFpbHMKPiA+Pj4g
bWVhbndoaWxlIGkgPT0gMCwgZGF0YSBhbGxvY2F0ZWQgYnkga3phbGxvYygpIGhhcyBub3QKPiA+
Pj4gYmVlbiBmcmVlZCBiZWZvcmUgcmV0dXJuaW5nLCB3aGljaCBsZWFkcyB0byBtZW1sZWFrLgo+
ID4+Pgo+ID4+PiBGaXhlczogYjEwNmVlNjNhYmNjYiAoImlycV9yZW1hcHBpbmcvdnQtZDogRW5o
YW5jZSBJbnRlbCBJUiBkcml2ZXIgdG8gc3VwcG9ydCBoaWVyYXJjaGljYWwgaXJxZG9tYWlucyIp
Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IERpbmdoYW8gTGl1IDxkaW5naGFvLmxpdUB6anUuZWR1LmNu
Pgo+ID4+PiAtLS0KPiA+Pj4gICAgZHJpdmVycy9pb21tdS9pbnRlbC9pcnFfcmVtYXBwaW5nLmMg
fCAyICsrCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiA+Pj4KPiA+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaXJxX3JlbWFwcGluZy5jIGIvZHJp
dmVycy9pb21tdS9pbnRlbC9pcnFfcmVtYXBwaW5nLmMKPiA+Pj4gaW5kZXggYWVmZmRhOTJiMTBi
Li5jZGFlZWQzNjc1MGYgMTAwNjQ0Cj4gPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaXJx
X3JlbWFwcGluZy5jCj4gPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaXJxX3JlbWFwcGlu
Zy5jCj4gPj4+IEBAIC0xMzU0LDYgKzEzNTQsOCBAQCBzdGF0aWMgaW50IGludGVsX2lycV9yZW1h
cHBpbmdfYWxsb2Moc3RydWN0IGlycV9kb21haW4gKmRvbWFpbiwKPiA+Pj4gICAgCQlpcnFfY2Zn
ID0gaXJxZF9jZmcoaXJxX2RhdGEpOwo+ID4+PiAgICAJCWlmICghaXJxX2RhdGEgfHwgIWlycV9j
ZmcpIHsKPiA+Pj4gICAgCQkJcmV0ID0gLUVJTlZBTDsKPiA+Pj4gKwkJCWtmcmVlKGRhdGEpOwo+
ID4+PiArCQkJZGF0YSA9IE5VTEw7Cj4gPj4KPiA+PiBEbyB5b3UgbmVlZCB0byBjaGVjayAoaSA9
PSAwKSBoZXJlPyBAZGF0YSB3aWxsIG5vdCBiZSB1c2VkIGFueW1vcmUgYXMgaXQKPiA+PiBnb2Vz
IHRvIG91dCBicmFuY2gsIHdoeSBzZXR0aW5nIGl0IHRvIE5VTEwgaGVyZT8KPiA+Pgo+ID4gCj4g
PiBkYXRhIHdpbGwgYmUgcGFzc2VkIHRvIGlyZV9kYXRhLT5jaGlwX2RhdGEgd2hlbiBpID09IDAg
YW5kCj4gPiBpbnRlbF9mcmVlX2lycV9yZXNvdXJjZXMoKSB3aWxsIGZyZWUgaXQgb24gZmFpbHVy
ZS4gVGh1cyBJCj4gCj4gSXNuJ3QgaXQgZ29pbmcgdG8gImdvdG8gb3V0X2ZyZWVfZGF0YSI/IElm
ICJpID09IDAiLCB0aGUgYWxsb2NhdGVkIEBkYXRhCj4gd29uJ3QgYmUgZnJlZWQgYnkgaW50ZWxf
ZnJlZV9pcnFfcmVzb3VyY2VzKCksIGhlbmNlIG1lbW9yeSBsZWFraW5nLiBEb2VzCj4gdGhpcyBw
YXRjaCBhaW0gdG8gZml4IHRoaXM/Cj4gCj4gQmVzdCByZWdhcmRzLAo+IGJhb2x1Cj4gCgpDb3Jy
ZWN0LCB0aGlzIGlzIHdoYXQgSSBtZWFuLiBXaGVuIGkgPiAwLCBkYXRhIGhhcyBiZWVuIHBhc3Nl
ZCB0bwppcnFfZGF0YS0+Y2hpcF9kYXRhLCB3aGljaCB3aWxsIGJlIGZyZWVkIGluIGludGVsX2Zy
ZWVfaXJxX3Jlc291cmNlcygpCm9uIGZhaWx1cmUuIFNvIHRoZXJlIGlzIG5vIG1lbWxlYWsgaW4g
dGhpcyBjYXNlLiBUaGUgbWVtbGVhayBvbmx5IG9jY3VycwpvbiBmYWlsdXJlIHdoZW4gaSA9PSAw
IChkYXRhIGhhcyBub3QgYmVlbiBwYXNzZWQgdG8gaXJxX2RhdGEtPmNoaXBfZGF0YSkuCkkgc2V0
IGRhdGEgdG8gTlVMTCBhZnRlciBrZnJlZSgpIGluIHRoaXMgcGF0Y2ggdG8gcHJldmVudCBkb3Vi
bGUtZnJlZQp3aGVuIHRoZSBmYWlsdXJlIG9jY3VycyBhdCBpID4gMC4KClJlZ2FyZHMsCkRpbmdo
YW8KCj4gPiBzZXQgaXQgdG8gTlVMTCB0byBwcmV2ZW50IGRvdWJsZS1mcmVlLiBIb3dldmVyLCBp
ZiB3ZSBhZGQKPiA+IGEgY2hlY2sgKGkgPT0gMCkgaGVyZSwgd2Ugd2lsbCBub3QgbmVlZCB0byBz
ZXQgaXQgdG8gTlVMTC4KPiA+IElmIHRoaXMgaXMgYmV0dGVyLCBJIHdpbGwgcmVzZW5kIGEgbmV3
IHBhdGNoIHNvb24uCj4gPiAKPiA+IFJlZ2FyZHMsCj4gPiBEaW5naGFvCj4gPiAK
