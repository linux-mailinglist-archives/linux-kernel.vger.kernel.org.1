Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888361B255F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgDULzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 07:55:39 -0400
Received: from m176149.mail.qiye.163.com ([59.111.176.149]:62992 "EHLO
        m176149.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDULzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:55:38 -0400
Received: from vivo.com (wm-9.qy.internal [127.0.0.1])
        by m176149.mail.qiye.163.com (Hmail) with ESMTP id 978672824B9;
        Tue, 21 Apr 2020 19:55:03 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AGEAdwClCFexXOQCGFZtCqqi.3.1587470103606.Hmail.bernard@vivo.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCBWMl0ga21hbGxvY19pbmRleCBvcHRpbWl6YXRpb24oY29kZSBzaXplICYgcnVudGltZSBzdGFibGUp?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <20200421111849.GL5820@bombadil.infradead.org>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 21 Apr 2020 19:55:03 +0800 (GMT+08:00)
From:   =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Date:   Tue, 21 Apr 2020 19:55:03 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VLSExCQkJNSUJCTE9ITFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSE9IQ0xOQktON1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6PD46Hww4Fzg9HgMjNCo4PD0hDzgKChJVSFVKTkNMT0xLSktOTUxCVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBT0tOSjcG
X-HM-Tid: 0a719c9774499395kuws978672824b9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpGcm9tOiBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz4KRGF0ZTogMjAyMC0w
NC0yMSAxOToxODo0OQpUbzogIDE1ODcwODkwMTAtMTEwMDgzLTEtZ2l0LXNlbmQtZW1haWwtYmVy
bmFyZEB2aXZvLmNvbQpDYzogIENocmlzdG9waCBMYW1ldGVyIDxjbEBsaW51eC5jb20+LFBla2th
IEVuYmVyZyA8cGVuYmVyZ0BrZXJuZWwub3JnPixEYXZpZCBSaWVudGplcyA8cmllbnRqZXNAZ29v
Z2xlLmNvbT4sSm9vbnNvbyBLaW0gPGlhbWpvb25zb28ua2ltQGxnZS5jb20+LEFuZHJldyBNb3J0
b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+LGxpbnV4LW1tQGt2YWNrLm9yZyxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnLG9wZW5zb3VyY2Uua2VybmVsQHZpdm8uY29tLEJlcm5hcmQg
WmhhbyA8YmVybmFyZEB2aXZvLmNvbT4KU3ViamVjdDogUmU6IFtQQVRDSCBWMl0ga21hbGxvY19p
bmRleCBvcHRpbWl6YXRpb24oY29kZSBzaXplICYgcnVudGltZSBzdGFibGUpPk9uIE1vbiwgQXBy
IDIwLCAyMDIwIGF0IDA4OjI1OjAxUE0gLTA3MDAsIEJlcm5hcmQgWmhhbyB3cm90ZToKPj4ga21h
bGxvY19pbmRleCBpbmxpbmUgZnVuY3Rpb24gY29kZSBzaXplIG9wdGltaXphdGlvbiBhbmQgcnVu
dGltZQo+PiBwZXJmb3JtYW5jZSBzdGFiaWxpdHkgb3B0aW1pemF0aW9uLiBBZnRlciBvcHRpbWl6
YXRpb24sIHRoZSBmdW5jdGlvbgo+PiBrbWFsbG9jX2luZGV4IGlzIG1vcmUgc3RhYmxlLCB0aGUg
c2l6ZSB3aWxsIG5ldmVyIGFmZmVjdGUgdGhlIGZ1bmN0aW9uYHMKPj4gZXhlY3V0aW9uIGVmZmlj
aWVuY3kuCj4KPlBsZWFzZSBzdG9wIHBvc3RpbmcgdGhpcyBwYXRjaCB1bnRpbCBpdCdzIGZhc3Rl
ciAqZm9yIHNtYWxsIHNpemVzKi4KPkFzIEkgZXhwbGFpbmVkIGxhc3QgdGltZSB5b3UgcG9zdGVk
IGl0LCBpdCdzIG5vdCBhbiBvcHRpbWlzYXRpb24uCj4KPj4gICAgICAgICAgICAgc2l6ZSAgICAg
ICAgdGltZS9QZXIgMTAwIG1pbGxpb24gdGltZXMKPj4gICAgICAgICAgICAgICAgICAgICAgICAg
b2xkIGZ1bgkJbmV3IGZ1biB3aXRoIG9wdGltaXNlCj4+IAkJOAkyMDM3NzcJCTI0MTkzNAo+PiAJ
CTE2CTI0NTYxMQkJNDA5Mjc4Cj4+IAkJMzIJMjM2Mzg0CQk0MDg0MTkKPj4gCQk2NAkyNzU0OTkJ
CTQ0NzczMgo+PiAJCTEyOAkzNTQ5MDkJCTQxNjQzOQo+Cj5eXl5eIHRoZXNlIGFyZSB0aGUgaW1w
b3J0YW50IGNhc2VzIHRoYXQgbmVlZCB0byBiZSBmYXN0Lgo+CgpTdXJlLCBpIGp1c3QgcmVjZWl2
ZWQgc29tZSBrYnVpbGQgY29tcGlsZXIgZXJyb3IgbWFpbHMgYW5kIHByb21wdCBtZSB0byBkbyBz
b21ldGhpbmc/IApJIGRvbmB0IGtub3cgd2h5IHRoaXMgaGFwcGVuZWQsIHNvIGkgdXBkYXRlIHRo
ZSBwYXRjaCBhZ2Fpbi4KClJlZ2FyZHMsCkJlcm5hcmQNCg0K
