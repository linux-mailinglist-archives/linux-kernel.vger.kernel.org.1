Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189672EA375
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 03:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbhAECtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:49:50 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:11702 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbhAECtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:49:49 -0500
Received: by ajax-webmail-mail-app2 (Coremail) ; Tue, 5 Jan 2021 10:48:32
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.25.254]
Date:   Tue, 5 Jan 2021 10:48:32 +0800 (GMT+08:00)
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
In-Reply-To: <dda6e03a-147a-a482-4f31-f3dcb8aa47bd@linux.intel.com>
References: <20210102095029.29053-1-dinghao.liu@zju.edu.cn>
 <18add30d-a830-c531-6fd2-58a1898b157f@linux.intel.com>
 <50870a42.15f1a.176c66eaf92.Coremail.dinghao.liu@zju.edu.cn>
 <6e1ce9ac-ac17-2b16-84d3-a18c011768f2@linux.intel.com>
 <3b0b2129.17762.176c6e9114d.Coremail.dinghao.liu@zju.edu.cn>
 <dda6e03a-147a-a482-4f31-f3dcb8aa47bd@linux.intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <577ae864.1df8f.176d0722e45.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgDnrvCA0_Nflw0IAA--.1157W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgMQBlZdtR1gpwAAsz
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxLzMvMjEgMjoyMiBQTSwgZGluZ2hhby5saXVAemp1LmVkdS5jbiB3cm90ZToKPiA+PiBP
biAyMDIxLzEvMyAxMjowOCwgZGluZ2hhby5saXVAemp1LmVkdS5jbiB3cm90ZToKPiA+Pj4+IEhp
LAo+ID4+Pj4KPiA+Pj4+IE9uIDIwMjEvMS8yIDE3OjUwLCBEaW5naGFvIExpdSB3cm90ZToKPiA+
Pj4+PiBXaGVuIGlycV9kb21haW5fZ2V0X2lycV9kYXRhKCkgb3IgaXJxZF9jZmcoKSBmYWlscwo+
ID4+Pj4+IG1lYW53aGlsZSBpID09IDAsIGRhdGEgYWxsb2NhdGVkIGJ5IGt6YWxsb2MoKSBoYXMg
bm90Cj4gPj4+Pj4gYmVlbiBmcmVlZCBiZWZvcmUgcmV0dXJuaW5nLCB3aGljaCBsZWFkcyB0byBt
ZW1sZWFrLgo+ID4+Pj4+Cj4gPj4+Pj4gRml4ZXM6IGIxMDZlZTYzYWJjY2IgKCJpcnFfcmVtYXBw
aW5nL3Z0LWQ6IEVuaGFuY2UgSW50ZWwgSVIgZHJpdmVyIHRvIHN1cHBvcnQgaGllcmFyY2hpY2Fs
IGlycWRvbWFpbnMiKQo+ID4+Pj4+IFNpZ25lZC1vZmYtYnk6IERpbmdoYW8gTGl1IDxkaW5naGFv
LmxpdUB6anUuZWR1LmNuPgo+ID4+Pj4+IC0tLQo+ID4+Pj4+ICAgICBkcml2ZXJzL2lvbW11L2lu
dGVsL2lycV9yZW1hcHBpbmcuYyB8IDIgKysKPiA+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQo+ID4+Pj4+Cj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUv
aW50ZWwvaXJxX3JlbWFwcGluZy5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pcnFfcmVtYXBwaW5n
LmMKPiA+Pj4+PiBpbmRleCBhZWZmZGE5MmIxMGIuLmNkYWVlZDM2NzUwZiAxMDA2NDQKPiA+Pj4+
PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lycV9yZW1hcHBpbmcuYwo+ID4+Pj4+ICsrKyBi
L2RyaXZlcnMvaW9tbXUvaW50ZWwvaXJxX3JlbWFwcGluZy5jCj4gPj4+Pj4gQEAgLTEzNTQsNiAr
MTM1NCw4IEBAIHN0YXRpYyBpbnQgaW50ZWxfaXJxX3JlbWFwcGluZ19hbGxvYyhzdHJ1Y3QgaXJx
X2RvbWFpbiAqZG9tYWluLAo+ID4+Pj4+ICAgICAJCWlycV9jZmcgPSBpcnFkX2NmZyhpcnFfZGF0
YSk7Cj4gPj4+Pj4gICAgIAkJaWYgKCFpcnFfZGF0YSB8fCAhaXJxX2NmZykgewo+ID4+Pj4+ICAg
ICAJCQlyZXQgPSAtRUlOVkFMOwo+ID4+Pj4+ICsJCQlrZnJlZShkYXRhKTsKPiA+Pj4+PiArCQkJ
ZGF0YSA9IE5VTEw7Cj4gPj4+Pgo+ID4+Pj4gRG8geW91IG5lZWQgdG8gY2hlY2sgKGkgPT0gMCkg
aGVyZT8gQGRhdGEgd2lsbCBub3QgYmUgdXNlZCBhbnltb3JlIGFzIGl0Cj4gPj4+PiBnb2VzIHRv
IG91dCBicmFuY2gsIHdoeSBzZXR0aW5nIGl0IHRvIE5VTEwgaGVyZT8KPiA+Pj4+Cj4gPj4+Cj4g
Pj4+IGRhdGEgd2lsbCBiZSBwYXNzZWQgdG8gaXJlX2RhdGEtPmNoaXBfZGF0YSB3aGVuIGkgPT0g
MCBhbmQKPiA+Pj4gaW50ZWxfZnJlZV9pcnFfcmVzb3VyY2VzKCkgd2lsbCBmcmVlIGl0IG9uIGZh
aWx1cmUuIFRodXMgSQo+ID4+Cj4gPj4gSXNuJ3QgaXQgZ29pbmcgdG8gImdvdG8gb3V0X2ZyZWVf
ZGF0YSI/IElmICJpID09IDAiLCB0aGUgYWxsb2NhdGVkIEBkYXRhCj4gPj4gd29uJ3QgYmUgZnJl
ZWQgYnkgaW50ZWxfZnJlZV9pcnFfcmVzb3VyY2VzKCksIGhlbmNlIG1lbW9yeSBsZWFraW5nLiBE
b2VzCj4gPj4gdGhpcyBwYXRjaCBhaW0gdG8gZml4IHRoaXM/Cj4gPj4KPiA+PiBCZXN0IHJlZ2Fy
ZHMsCj4gPj4gYmFvbHUKPiA+Pgo+ID4gCj4gPiBDb3JyZWN0LCB0aGlzIGlzIHdoYXQgSSBtZWFu
LiBXaGVuIGkgPiAwLCBkYXRhIGhhcyBiZWVuIHBhc3NlZCB0bwo+ID4gaXJxX2RhdGEtPmNoaXBf
ZGF0YSwgd2hpY2ggd2lsbCBiZSBmcmVlZCBpbiBpbnRlbF9mcmVlX2lycV9yZXNvdXJjZXMoKQo+
ID4gb24gZmFpbHVyZS4gU28gdGhlcmUgaXMgbm8gbWVtbGVhayBpbiB0aGlzIGNhc2UuIFRoZSBt
ZW1sZWFrIG9ubHkgb2NjdXJzCj4gPiBvbiBmYWlsdXJlIHdoZW4gaSA9PSAwIChkYXRhIGhhcyBu
b3QgYmVlbiBwYXNzZWQgdG8gaXJxX2RhdGEtPmNoaXBfZGF0YSkuCj4gCj4gU28gaG93IGFib3V0
Cj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaXJxX3JlbWFwcGluZy5jIAo+
IGIvZHJpdmVycy9pb21tdS9pbnRlbC9pcnFfcmVtYXBwaW5nLmMKPiBpbmRleCBhZWZmZGE5MmIx
MGIuLjY4NTIwMGE1Y2ZmMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lycV9y
ZW1hcHBpbmcuYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaXJxX3JlbWFwcGluZy5jCj4g
QEAgLTEzNTMsNiArMTM1Myw4IEBAIHN0YXRpYyBpbnQgaW50ZWxfaXJxX3JlbWFwcGluZ19hbGxv
YyhzdHJ1Y3QgCj4gaXJxX2RvbWFpbiAqZG9tYWluLAo+ICAgICAgICAgICAgICAgICAgaXJxX2Rh
dGEgPSBpcnFfZG9tYWluX2dldF9pcnFfZGF0YShkb21haW4sIHZpcnEgKyBpKTsKPiAgICAgICAg
ICAgICAgICAgIGlycV9jZmcgPSBpcnFkX2NmZyhpcnFfZGF0YSk7Cj4gICAgICAgICAgICAgICAg
ICBpZiAoIWlycV9kYXRhIHx8ICFpcnFfY2ZnKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAg
aWYgKCFpKQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAga2ZyZWUoZGF0YSk7Cj4g
ICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7Cj4gICAgICAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gb3V0X2ZyZWVfZGF0YTsKPiAgICAgICAgICAgICAgICAgIH0KPiAKPiA+
IEkgc2V0IGRhdGEgdG8gTlVMTCBhZnRlciBrZnJlZSgpIGluIHRoaXMgcGF0Y2ggdG8gcHJldmVu
dCBkb3VibGUtZnJlZQo+ID4gd2hlbiB0aGUgZmFpbHVyZSBvY2N1cnMgYXQgaSA+IDAuCj4gCj4g
aWYgaT4wLCBAZGF0YSBoYXMgYmVlbiBwYXNzZWQgYW5kIHdpbGwgYmUgZnJlZWQgYnkKPiBpbnRl
bF9mcmVlX2lycV9yZXNvdXJjZXMoKSBvbiB0aGUgZmFpbHVyZSBwYXRoLiBObyBuZWVkIHRvIGZy
ZWUgb3IKPiBjbGVhciwgcmlnaHQ/CgpSaWdodCwgdGhpcyBpcyBjbGVhcmVyLiBUaGFuayB5b3Ug
Zm9yIHlvdXIgYWR2aWNlIGFuZCBJIHdpbGwgcmVzZW5kIGEKbmV3IHBhdGNoIHNvb24uCgpSZWdh
cmRzLApEaW5naGFvCgo+IAo+IEJlc3QgcmVnYXJkcywKPiBiYW9sdQo+IAo+ID4gCj4gPiBSZWdh
cmRzLAo+ID4gRGluZ2hhbwo+ID4gCj4gPj4+IHNldCBpdCB0byBOVUxMIHRvIHByZXZlbnQgZG91
YmxlLWZyZWUuIEhvd2V2ZXIsIGlmIHdlIGFkZAo+ID4+PiBhIGNoZWNrIChpID09IDApIGhlcmUs
IHdlIHdpbGwgbm90IG5lZWQgdG8gc2V0IGl0IHRvIE5VTEwuCj4gPj4+IElmIHRoaXMgaXMgYmV0
dGVyLCBJIHdpbGwgcmVzZW5kIGEgbmV3IHBhdGNoIHNvb24uCj4gPj4+Cj4gPj4+IFJlZ2FyZHMs
Cj4gPj4+IERpbmdoYW8KPiA+Pj4K
