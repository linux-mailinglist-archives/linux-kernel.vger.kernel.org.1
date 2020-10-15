Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C7D28EB6E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 05:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgJODVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 23:21:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40144 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727890AbgJODVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 23:21:06 -0400
X-UUID: 04564c50f99c4c6b96c3ede4cd91ac4d-20201015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vt87zy5BJM1AmjZx6qAP3QE6Ib1rAbIpP0es8xsUK4Y=;
        b=tJhrLAB62qidQrVMKhkT6wzdSrfoVV5Fah16+Jkm/OithWi+kzNCI0A/eq1iO23Y1ISmzTpYJ5V8bipbTM5vZcjehknDEWnbM+YVKldpUuZ6hZtyDJ9eB4TAxN5XSS93Iz2VpePp3+owPvLkyafs0sNvsjFYyt56m7uGvA/ahkE=;
X-UUID: 04564c50f99c4c6b96c3ede4cd91ac4d-20201015
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2128735321; Thu, 15 Oct 2020 11:21:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Oct 2020 11:20:46 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Oct 2020 11:20:40 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: 
Date:   Thu, 15 Oct 2020 11:20:37 +0800
Message-ID: <1602732039-12179-1-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlc2UgcGF0Y2ggc2VyaWVzIGludHJvZHVjZSBhIE1lZGlhVGVrIE1UNjc3OSBkZXZhcGMgZHJp
dmVyLg0KDQpNZWRpYVRlayBidXMgZmFicmljIHByb3ZpZGVzIFRydXN0Wm9uZSBzZWN1cml0eSBz
dXBwb3J0IGFuZCBkYXRhIHByb3RlY3Rpb24gdG8gcHJldmVudCBzbGF2ZXMgZnJvbSBiZWluZyBh
Y2Nlc3NlZCBieSB1bmV4cGVjdGVkIG1hc3RlcnMuDQpUaGUgc2VjdXJpdHkgdmlvbGF0aW9uIGlz
IGxvZ2dlZCBhbmQgc2VudCB0byB0aGUgcHJvY2Vzc29yIGZvciBmdXJ0aGVyIGFuYWx5c2lzIG9y
IGNvdW50ZXJtZWFzdXJlcy4NCg0KQW55IG9jY3VycmVuY2Ugb2Ygc2VjdXJpdHkgdmlvbGF0aW9u
IHdvdWxkIHJhaXNlIGFuIGludGVycnVwdCwgYW5kIGl0IHdpbGwgYmUgaGFuZGxlZCBieSBtdGst
ZGV2YXBjIGRyaXZlci4NClRoZSB2aW9sYXRpb24gaW5mb3JtYXRpb24gaXMgcHJpbnRlZCBpbiBv
cmRlciB0byBmaW5kIHRoZSBtdXJkZXJlci4NCg0KY2hhbmdlcyBzaW5jZSB2NzoNCi0gZml4IFZJ
T19NT0RfVE9fUkVHX0lORCBjYWxjdWxhdGlvbiB3cm9uZyBwcm9ibGVtLg0KLSByZXZpc2UgcGFy
YW1ldGVyIHR5cGUgb2YgSVNSLg0KDQpjaGFuZ2VzIHNpbmNlIHY2Og0KLSByZW1vdmUgdW5uZWNl
c3NhcnkgbWFzay91bm1hc2sgbW9kdWxlIGlycSBkdXJpbmcgSVNSLg0KDQpjaGFuZ2VzIHNpbmNl
IHY1Og0KLSByZW1vdmUgcmVkdW5kYW50IHdyaXRlIHJlZyBvcGVyYXRpb24uDQotIHVzZSBzdGF0
aWMgdmFyaWFibGUgb2YgdmlvX2RiZ3MgaW5zdGVhZC4NCi0gYWRkIHN0b3BfZGV2YXBjKCkgaWYg
ZHJpdmVyIGlzIHJlbW92ZWQuDQoNCmNoYW5nZXMgc2luY2UgdjQ6DQotIHJlZmFjdG9yIGRhdGEg
c3RydWN0dXJlLg0KLSBtZXJnZSB0d28gc2ltcGxlIGZ1bmN0aW9ucyBpbnRvIG9uZS4NCi0gcmVm
YWN0b3IgcmVnaXN0ZXIgc2V0dGluZyB0byBwcmV2ZW50IHRvbyBtYW55IGZ1bmN0aW9uIGNhbGwg
b3ZlcmhlYWQuDQoNCmNoYW5nZXMgc2luY2UgdjM6DQotIHJldmlzZSB2aW9sYXRpb24gaGFuZGxp
bmcgZmxvdyB0byBtYWtlIGl0IG1vcmUgZWFzaWx5IHRvIHVuZGVyc3RhbmQNCiAgaGFyZHdhcmUg
YmVoYXZpb3IuDQotIGFkZCBtb3JlIGNvbW1lbnRzIHRvIHVuZGVyc3RhbmQgaG93IGhhcmR3YXJl
IHdvcmtzLg0KDQpjaGFuZ2VzIHNpbmNlIHYyOg0KLSBwYXNzIHBsYXRmb3JtIGluZm8gdGhyb3Vn
aCBEVCBkYXRhLg0KLSByZW1vdmUgdW5uZWNlc3NhcnkgZnVuY3Rpb24uDQotIHJlbW92ZSBzbGF2
ZV90eXBlIGJlY2F1c2UgaXQgYWx3YXlzIGVxdWFscyB0byAxIGluIGN1cnJlbnQgc3VwcG9ydCBT
b0MuDQotIHVzZSB2aW9faWR4X251bSBpbnN0cmVhZCBvZiBsaXN0IGFsbCBkZXZpY2VzJyBpbmRl
eC4NCi0gYWRkIG1vcmUgY29tbWVudHMgdG8gZGVzY3JpYmUgaGFyZHdhcmUgYmVoYXZpb3IuDQoN
CmNoYW5nZXMgc2luY2UgdjE6DQotIG1vdmUgU29DIHNwZWNpZmljIHBhcnQgdG8gRFQgZGF0YS4N
Ci0gcmVtb3ZlIHVubmVjZXNzYXJ5IGJvdW5kYXJ5IGNoZWNrLg0KLSByZW1vdmUgdW5uZWNlc3Nh
cnkgZGF0YSB0eXBlIGRlY2xhcmF0aW9uLg0KLSB1c2UgcmVhZF9wb2xsX3RpbWVvdXQoKSBpbnN0
cmVhZCBvZiBmb3IgbG9vcCBwb2xsaW5nLg0KLSByZXZpc2UgY29kaW5nIHN0eWxlIGVsZWdhbnRs
eS4NCg0KDQoqKiogQkxVUkIgSEVSRSAqKioNCg0KTmVhbCBMaXUgKDIpOg0KICBkdC1iaW5kaW5n
czogZGV2YXBjOiBhZGQgYmluZGluZ3MgZm9yIG10ay1kZXZhcGMNCiAgc29jOiBtZWRpYXRlazog
YWRkIG10Njc3OSBkZXZhcGMgZHJpdmVyDQoNCiAuLi4vYmluZGluZ3Mvc29jL21lZGlhdGVrL2Rl
dmFwYy55YW1sICAgICAgICAgfCAgNTggKysrKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL0tjb25m
aWcgICAgICAgICAgICAgICAgICB8ICAgOSArDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvTWFrZWZp
bGUgICAgICAgICAgICAgICAgIHwgICAxICsNCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstZGV2
YXBjLmMgICAgICAgICAgICAgfCAzMDggKysrKysrKysrKysrKysrKysrDQogNCBmaWxlcyBjaGFu
Z2VkLCAzNzYgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy55YW1sDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1kZXZhcGMuYw0KDQotLSANCjIuMTgu
MA0K

