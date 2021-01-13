Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AB82F5AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 07:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbhANGbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 01:31:49 -0500
Received: from regular1.263xmail.com ([211.150.70.200]:55866 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbhANGbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 01:31:48 -0500
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id 5C1301E20;
        Thu, 14 Jan 2021 14:25:57 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from laptop-6u0merh5 (unknown [61.183.83.60])
        by smtp.263.net (postfix) whith ESMTP id P1325T139709754091264S1610605554603432_;
        Thu, 14 Jan 2021 14:25:57 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <053e2eb86d4b2c43f2e5b4653ea7c815>
X-RL-SENDER: changlianzhi@uniontech.com
X-SENDER: changlianzhi@uniontech.com
X-LOGIN-NAME: changlianzhi@uniontech.com
X-FST-TO: magnani@ieee.org
X-SENDER-IP: 61.183.83.60
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Date:   Thu, 14 Jan 2021 06:25:57 +0800
From:   "changlianzhi@uniontech.com" <changlianzhi@uniontech.com>
To:     magnani <magnani@ieee.org>
Cc:     jack <jack@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>,
        282827961 <282827961@qq.com>
Subject: Re: [PATCH] udf: fix the problem that the disc content is not displayed
References: <20210112055304.31842-1-changlianzhi@uniontech.com>, 
        <9495f2dcd2882a43678532eb8df356bc@ieee.org>, 
        <1400033179.660265.1610592703732.JavaMail.xmail@bj-wm-cp-9>, 
        <25d238d333d16079d4cc992c8dc0ff94@ieee.org>
X-Priority: 3
X-GUID: A3EDA00A-B1B1-4DED-BBB0-5D8D0E3FF94C
X-Has-Attach: no
X-Mailer: Foxmail 7.2.20.258[cn]
Mime-Version: 1.0
Message-ID: <202101140625555106736@uniontech.com>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMS0wMS0xMyAyMDo1MSwg5bi45buJ5b+XIHdyb3RlOgoKPj4gT24gMjAyMS0wMS0xMSAy
Mzo1MywgbGlhbnpoaSBjaGFuZyB3cm90ZToKPj4KPj4+PiBXaGVuIHRoZSBjYXBhY2l0eSBvZiB0
aGUgZGlzYyBpcyB0b28gbGFyZ2UgKGFzc3VtaW5nIHRoZSA0LjdHCj4+Pj4gc3BlY2lmaWNhdGlv
biksIHRoZSBkaXNjIChVREYgZmlsZSBzeXN0ZW0pIHdpbGwgYmUgYnVybmVkCj4+Pj4gbXVsdGlw
bGUgdGltZXMgaW4gdGhlIHdpbmRvd3MgKE11bHRpc2Vzc2lvbiBVc2FnZSkuIFdoZW4gdGhlCj4+
Pj4gcmVtYWluaW5nIGNhcGFjaXR5IG9mIHRoZSBDRCBpcyBsZXNzIHRoYW4gMzAwTSAoZXN0aW1h
dGVkCj4+Pj4gdmFsdWUsIGZvciByZWZlcmVuY2Ugb25seSksIG9wZW4gdGhlIENEIGluIHRoZSBM
aW51eCBzeXN0ZW0sCj4+Pj4gdGhlIGNvbnRlbnQgb2YgdGhlIENEIGlzIGRpc3BsYXllZCBhcyBi
bGFuayAodGhlIGtlcm5lbCB3aWxsCj4+Pj4gc2F5ICJObyBWUlMgZm91bmQiKS4gV2luZG93cyBj
YW4gZGlzcGxheSB0aGUgY29udGVudHMgb2YgdGhlCj4+Pj4gQ0Qgbm9ybWFsbHkuCj4+Pj4gVGhy
b3VnaCBhbmFseXNpcywgaW4gdGhlICJmcy91ZGYvc3VwZXIuYyI6IHVkZl9jaGVja192c2QKPj4+
PiBmdW5jdGlvbiwgdGhlIGFjdHVhbCB2YWx1ZSBvZiBWU0RfTUFYX1NFQ1RPUl9PRkZTRVQgbWF5
Cj4+Pj4gYmUgbXVjaCBsYXJnZXIgdGhhbiAweDgwMDAwMC4gQWNjb3JkaW5nIHRvIHRoZSBjdXJy
ZW50IGNvZGUKPj4+IGw+b2dpYywgaXQgaXMgZm91bmQgdGhhdCB0aGUgdHlwZSBvZiBzYmktPnNf
c2Vzc2lvbiBpcyAiX19zMzIiLAo+Pj4+IHdoZW4gdGhlIHJlbWFpbmluZyBjYXBhY2l0eSBvZiB0
aGUgZGlzYyBpcyBsZXNzIHRoYW4gMzAwTQo+Pj4+ICh0YWtlIGEgc2V0IG9mIHRlc3QgdmFsdWVz
OiBzZWN0b3I9MzE1NDkwMzA0MCwKPj4+PiBzYmktPnNfc2Vzc2lvbj0xNTQwNDY0LCBzYi0+c19i
bG9ja3NpemVfYml0cz0xMSApLCB0aGUKPj4+PiBjYWxjdWxhdGlvbiByZXN1bHQgb2YgInNiaS0+
c19zZXNzaW9uIDw8IHNiLT5zX2Jsb2Nrc2l6ZV9iaXRzIgo+Pj4+IHdpbGwgb3ZlcmZsb3cuIFRo
ZXJlZm9yZSwgaXQgaXMgbmVjZXNzYXJ5IHRvIGNvbnZlcnQgdGhlCj4+Pj4gdHlwZSBvZiBzX3Nl
c3Npb24gdG8gImxvZmZfdCIgKHdoZW4gdWRmX2NoZWNrX3ZzZCBzdGFydHMsCj4+Pj4gYXNzaWdu
IGEgdmFsdWUgdG8gX3NlY3Rvciwgd2hpY2ggaXMgYWxzbyBjb252ZXJ0ZWQgaW4gdGhpcwo+Pj4+
IHdheSksIHNvIHRoYXQgdGhlIHJlc3VsdCB3aWxsIG5vdCBvdmVyZmxvdywgYW5kIHRoZW4gdGhl
Cj4+Pj4gY29udGVudCBvZiB0aGUgZGlzYyBjYW4gYmUgZGlzcGxheWVkIG5vcm1hbGx5Lgo+Pj4+
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBsaWFuemhpIGNoYW5nIDxjaGFuZ2xpYW56aGlAdW5pb250ZWNo
LmNvbT4KPj4+PiAtLS0KPj4+PiBmcy91ZGYvc3VwZXIuYyB8IDIgKy0KPj4+PiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQg
YS9mcy91ZGYvc3VwZXIuYyBiL2ZzL3VkZi9zdXBlci5jCj4+Pj4gaW5kZXggNWJlZjNhNjgzOTVk
Li42YzMwNjljZDEzMjEgMTAwNjQ0Cj4+Pj4gLS0tIGEvZnMvdWRmL3N1cGVyLmMKPj4+PiArKysg
Yi9mcy91ZGYvc3VwZXIuYwo+Pj4+IEBAIC03NTcsNyArNzU3LDcgQEAgc3RhdGljIGludCB1ZGZf
Y2hlY2tfdnNkKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpCj4+Pj4KPj4+PiBpZiAobnNyID4gMCkK
Pj4+PiByZXR1cm4gMTsKPj4+PiAtIGVsc2UgaWYgKCFiaCAmJiBzZWN0b3IgLSAoc2JpLT5zX3Nl
c3Npb24gPDwgc2ItPnNfYmxvY2tzaXplX2JpdHMpCj4+Pj4gPT0KPj4+PiArIGVsc2UgaWYgKCFi
aCAmJiBzZWN0b3IgLSAoKGxvZmZfdClzYmktPnNfc2Vzc2lvbiA8PAo+Pj4+IHNiLT5zX2Jsb2Nr
c2l6ZV9iaXRzKSA9PQo+Pj4+IFZTRF9GSVJTVF9TRUNUT1JfT0ZGU0VUKQo+Pj4+IHJldHVybiAt
MTsKPj4+PiBlbHNlCj4+Pgo+Pj4KPj4+IExvb2tzIGdvb2QuIFBlcmhhcHMgY29uc2lkZXIgZmFj
dG9yaW5nIG91dCB0aGUgY29udmVyc2lvbiAod2hpY2ggYWxzbwo+Pj4gb2NjdXJzCj4+PiBlYXJs
aWVyIGluIHRoZSBmdW5jdGlvbikgc28gdGhhdCB0aGUgY29tcGxleGl0eSBvZiB0aGlzICJlbHNl
IGlmIiBjYW4KPj4+IGJlCj4+PiByZWR1Y2VkPwo+Pj4KPj4KPj4+IFJldmlld2VkLWJ5OiBTdGV2
ZW4gSi4gTWFnbmFuaSA8bWFnbmFuaUB4eHh4eHh4eD4KPj4KPj4gVGhhbmsgeW91IHZlcnkgbXVj
aCEgU28sIHdoaWNoIG9uZSBvZiB0aGUgZm9sbG93aW5nIG1ldGhvZHMgZG8geW91Cj4+IHRoaW5r
IGlzIGJldHRlcjoKPj4KPj4gKDEpIENoYW5nZSB0aGUgdHlwZSBvZiBzX3Nlc3Npb24gaW4gc3Ry
dWN0IHVkZl9zYl9pbmZvIHRvIF9fczY0LiBJZiB5b3UKPj4gbW9kaWZ5IHRoaXMgd2F5LCBpdCBt
YXkgaW52b2x2ZSBzb21lIG1lbW9yeSBjb3B5IHByb2JsZW1zIG9mIHRoZQo+PiBzdHJ1Y3R1cmUs
IGFuZCB0aGVyZSBhcmUgbW9yZSBtb2RpZmljYXRpb25zLgo+Pgo+PiAoMikgRGVmaW5pdGlvbjog
bG9mZl90IHNlY3Rvcl9vZmZzZXQ9c2JpLT5zX3Nlc3Npb24gPDwKPj4gc2ItPnNfYmxvY2tzaXpl
X2JpdHMsIGFuZCB0aGVuIHB1dCBzZWN0b3Jfb2Zmc2V0IGludG8gdGhlICJlbHNlIGlmIgo+PiBz
dGF0ZW1lbnQuCj4+Cj4+ICgzKSBPciBpcyB0aGVyZSBhbnkgb3RoZXIgYmV0dGVyIHdheT8KCj5J
IGhhZCAjMiBpbiBtaW5kLgo+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIFN0ZXZlbiBKLiBNYWduYW5pICAg
ICAgICAgICAgICAgIkkgY2xhaW0gdGhpcyBuZXR3b3JrIGZvciBNQVJTIQoKVGhhbmsgeW91IHZl
cnkgbXVjaCBmb3IgeW91ciBzdWdnZXN0aW9uLCBJIHdpbGwgc3VibWl0IGEgbmV3IHBhdGNoCgoK



