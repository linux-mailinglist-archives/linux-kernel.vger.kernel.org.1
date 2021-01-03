Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021572E8A6C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 05:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbhACEJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 23:09:47 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:64730 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725827AbhACEJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 23:09:46 -0500
Received: by ajax-webmail-mail-app3 (Coremail) ; Sun, 3 Jan 2021 12:08:31
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.25.254]
Date:   Sun, 3 Jan 2021 12:08:31 +0800 (GMT+08:00)
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
In-Reply-To: <18add30d-a830-c531-6fd2-58a1898b157f@linux.intel.com>
References: <20210102095029.29053-1-dinghao.liu@zju.edu.cn>
 <18add30d-a830-c531-6fd2-58a1898b157f@linux.intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <50870a42.15f1a.176c66eaf92.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgDnjw0_Q_FfeFRHAA--.14395W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgIOBlZdtRzYgwAAsx
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSwKPiAKPiBPbiAyMDIxLzEvMiAxNzo1MCwgRGluZ2hhbyBMaXUgd3JvdGU6Cj4gPiBXaGVu
IGlycV9kb21haW5fZ2V0X2lycV9kYXRhKCkgb3IgaXJxZF9jZmcoKSBmYWlscwo+ID4gbWVhbndo
aWxlIGkgPT0gMCwgZGF0YSBhbGxvY2F0ZWQgYnkga3phbGxvYygpIGhhcyBub3QKPiA+IGJlZW4g
ZnJlZWQgYmVmb3JlIHJldHVybmluZywgd2hpY2ggbGVhZHMgdG8gbWVtbGVhay4KPiA+IAo+ID4g
Rml4ZXM6IGIxMDZlZTYzYWJjY2IgKCJpcnFfcmVtYXBwaW5nL3Z0LWQ6IEVuaGFuY2UgSW50ZWwg
SVIgZHJpdmVyIHRvIHN1cHBvcnQgaGllcmFyY2hpY2FsIGlycWRvbWFpbnMiKQo+ID4gU2lnbmVk
LW9mZi1ieTogRGluZ2hhbyBMaXUgPGRpbmdoYW8ubGl1QHpqdS5lZHUuY24+Cj4gPiAtLS0KPiA+
ICAgZHJpdmVycy9pb21tdS9pbnRlbC9pcnFfcmVtYXBwaW5nLmMgfCAyICsrCj4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvaW50ZWwvaXJxX3JlbWFwcGluZy5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pcnFfcmVt
YXBwaW5nLmMKPiA+IGluZGV4IGFlZmZkYTkyYjEwYi4uY2RhZWVkMzY3NTBmIDEwMDY0NAo+ID4g
LS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pcnFfcmVtYXBwaW5nLmMKPiA+ICsrKyBiL2RyaXZl
cnMvaW9tbXUvaW50ZWwvaXJxX3JlbWFwcGluZy5jCj4gPiBAQCAtMTM1NCw2ICsxMzU0LDggQEAg
c3RhdGljIGludCBpbnRlbF9pcnFfcmVtYXBwaW5nX2FsbG9jKHN0cnVjdCBpcnFfZG9tYWluICpk
b21haW4sCj4gPiAgIAkJaXJxX2NmZyA9IGlycWRfY2ZnKGlycV9kYXRhKTsKPiA+ICAgCQlpZiAo
IWlycV9kYXRhIHx8ICFpcnFfY2ZnKSB7Cj4gPiAgIAkJCXJldCA9IC1FSU5WQUw7Cj4gPiArCQkJ
a2ZyZWUoZGF0YSk7Cj4gPiArCQkJZGF0YSA9IE5VTEw7Cj4gCj4gRG8geW91IG5lZWQgdG8gY2hl
Y2sgKGkgPT0gMCkgaGVyZT8gQGRhdGEgd2lsbCBub3QgYmUgdXNlZCBhbnltb3JlIGFzIGl0Cj4g
Z29lcyB0byBvdXQgYnJhbmNoLCB3aHkgc2V0dGluZyBpdCB0byBOVUxMIGhlcmU/Cj4gCgpkYXRh
IHdpbGwgYmUgcGFzc2VkIHRvIGlyZV9kYXRhLT5jaGlwX2RhdGEgd2hlbiBpID09IDAgYW5kIApp
bnRlbF9mcmVlX2lycV9yZXNvdXJjZXMoKSB3aWxsIGZyZWUgaXQgb24gZmFpbHVyZS4gVGh1cyBJ
CnNldCBpdCB0byBOVUxMIHRvIHByZXZlbnQgZG91YmxlLWZyZWUuIEhvd2V2ZXIsIGlmIHdlIGFk
ZCAKYSBjaGVjayAoaSA9PSAwKSBoZXJlLCB3ZSB3aWxsIG5vdCBuZWVkIHRvIHNldCBpdCB0byBO
VUxMLgpJZiB0aGlzIGlzIGJldHRlciwgSSB3aWxsIHJlc2VuZCBhIG5ldyBwYXRjaCBzb29uLgoK
UmVnYXJkcywKRGluZ2hhbyA=
