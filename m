Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0082D38A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 03:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgLICP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 21:15:29 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:55320 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725283AbgLICP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 21:15:29 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1198706|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.101198-0.00118115-0.897621;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=liush@allwinnertech.com;NM=1;PH=DW;RN=4;RT=4;SR=0;TI=W4_6056262_DEFAULT_0AC266A6_1607478536428_o7001c132;
Received: from WS-web (liush@allwinnertech.com[W4_6056262_DEFAULT_0AC266A6_1607478536428_o7001c132]) by ay29a011140100204.et135 at Wed, 09 Dec 2020 10:14:26 +0800
Date:   Wed, 09 Dec 2020 10:14:26 +0800
From:   "=?UTF-8?B?5YiY6YK15Y2OQlRE?=" <liush@allwinnertech.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "jasowang" <jasowang@redhat.com>,
        "virtualization" <virtualization@lists.linux-foundation.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "=?UTF-8?B?5YiY6YK15Y2OQlRE?=" <liush@allwinnertech.com>
Message-ID: <b1dbcd5a-4e25-4af8-bedd-32b1e86200b6.liush@allwinnertech.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIXSB2aXJ0aW86IHJlcGxhY2UgY29uc3RhbnQgcGFyYW1ldGVyICcx?=
  =?UTF-8?B?JyB3aXRoIG51bQ==?=
X-Mailer: [Alimail-Mailagent revision 5829926][W4_6056262][DEFAULT][Firefox]
MIME-Version: 1.0
References: <1607428671-4802-1-git-send-email-liush@allwinnertech.com>,<20201208085423-mutt-send-email-mst@kernel.org>
x-aliyun-mail-creator: W4_6056262_DEFAULT_IHJTW96aWxsYS81LjAgKFgxMTsgVWJ1bnR1OyBMaW51eCB4ODZfNjQ7IHJ2OjgzLjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvODMuMA==jQ
In-Reply-To: <20201208085423-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFlbCwKPj4gJ251bScgY2FuIHJlcHJlc2VudCB0aGUgdmFsdWUgb2Ygb3V0X3Nncyhp
bl9zYWdzKSwgbm8gbmVlZCB0byBwYXNzIAo+PiBpbiBjb25zdGFudCBwYXJhbWV0ZXJzIGluICd2
aXJ0cXVldWVfYWRkJy4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IGxpdXNoIDxsaXVzaEBhbGx3aW5u
ZXJ0ZWNoLmNvbT4KCj5Qb2ludCBiZWluZz8KPkEgY29uc3RhbnQgaXMgbGlrZWx5IGVhc2llciBm
b3IgdGhlIGNvbXBpbGVyIHRvIG9wdGltaXplIC4uLgoKVGhhbmtzLgpJIHdhcyB1bmF3YXJlIHRo
YXQgYSBjb25zdGFudCB3YXMgZm9yIGNvbXBpbGVyIG9wdGltaXphdGlvbi4gCkl0IHNlZW1zIHRo
YXQgJ251bScgaXMgbW9yZSByZWFkYWJsZSBjb21wYXJlZCB0byBhIGNvbnN0YW50LiBBbmQgJ3Zp
cnRxdWV1ZV9hZGRfKicgCmRvZXMgbm90IHNwZWNpZnkgdGhhdCBvbmx5IG9uZSBidWYgaXMgYWRk
ZWQsIGJ1dCDigJgx4oCZIGlzIHBhc3NlZCBpbiDigJh2aXJ0cXVldWVfYWRk4oCZLCAKd2hpY2gg
bGltaXRzIHRoZSBmdW5jdGlvbiBvZiAndmlydHF1ZXVlX2FkZF8qJy4gQmVzaWRlcyBjb21waWxh
dGlvbiBvcHRpbWl6YXRpb24sIAphcmUgdGhlcmUgYW55IG90aGVyIGNvbnNpZGVyYXRpb25zLgoK
Pj4gLS0tCj4+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNCArKy0tCj4+ICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+PiAKPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jCj4+IGluZGV4IGJlY2M3NzYuLjc1ODNmOGIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+PiBAQCAtMTc2MCw3ICsxNzYwLDcgQEAgaW50IHZpcnRxdWV1ZV9hZGRfb3V0YnVmKHN0
cnVjdCB2aXJ0cXVldWUgKnZxLAo+PiAgICAgIHZvaWQgKmRhdGEsCj4+ICAgICAgZ2ZwX3QgZ2Zw
KQo+PiAgewo+PiAtIHJldHVybiB2aXJ0cXVldWVfYWRkKHZxLCAmc2csIG51bSwgMSwgMCwgZGF0
YSwgTlVMTCwgZ2ZwKTsKPj4gKyByZXR1cm4gdmlydHF1ZXVlX2FkZCh2cSwgJnNnLCBudW0sIG51
bSwgMCwgZGF0YSwgTlVMTCwgZ2ZwKTsKPj4gIH0KPj4gIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRx
dWV1ZV9hZGRfb3V0YnVmKTsKPj4gIAo+PiBAQCAtMTc4Miw3ICsxNzgyLDcgQEAgaW50IHZpcnRx
dWV1ZV9hZGRfaW5idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsCj4+ICAgICB2b2lkICpkYXRhLAo+
PiAgICAgZ2ZwX3QgZ2ZwKQo+PiAgewo+PiAtIHJldHVybiB2aXJ0cXVldWVfYWRkKHZxLCAmc2cs
IG51bSwgMCwgMSwgZGF0YSwgTlVMTCwgZ2ZwKTsKPj4gKyByZXR1cm4gdmlydHF1ZXVlX2FkZCh2
cSwgJnNnLCBudW0sIDAsIG51bSwgZGF0YSwgTlVMTCwgZ2ZwKTsKPj4gIH0KPj4gIEVYUE9SVF9T
WU1CT0xfR1BMKHZpcnRxdWV1ZV9hZGRfaW5idWYpOwo+PiAgCj4+IC0t
