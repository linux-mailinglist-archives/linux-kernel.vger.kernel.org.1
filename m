Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0381A27CFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgI2NrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:47:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59471 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728346AbgI2NrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:47:00 -0400
X-UUID: ae66b812ba684c5baeb9fa97e39db982-20200929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BdSCULrhdfeC57PSNC1Tcx2pJe2PGvOBvyLTmGWEl9Q=;
        b=UNZVSSCwjqibJRBiBIU8G8NHCaPN+R+ox7yifndUKb+AR6rwM3iEqNsguGAYodGNf2IQuLFkB67Bn7eDQZ0PqvsUCQxMS67Z0RNoNLXmR+JGdpMiqHiQXpZedJwz/Qjr0CG6qhJboe0eKHMmIS5tisJagfkftE2AVX+w/Vlq6sw=;
X-UUID: ae66b812ba684c5baeb9fa97e39db982-20200929
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1970195362; Tue, 29 Sep 2020 21:46:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Sep 2020 21:46:49 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Sep 2020 21:46:48 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <s-anna@ti.com>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>
Subject: [v5,0/3] introduce TI reset controller for MT8192 SoC 
Date:   Tue, 29 Sep 2020 21:46:39 +0800
Message-ID: <20200929134642.26561-1-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

djU6DQoxLiByZXZlcnQgdGktc3lzY29uLXJlc2V0LnR4dCwgYW5kIGFkZCBhIG5ldyBtZWRpYXRl
ayByZXNldCBiaW5kaW5nLg0KMi4gc3BsaXQgdGhlIHBhdGNoIFt2NCwgMy80XSB3aXRoIHRoZSBj
aGFuZ2UgdG8gZm9yY2Ugd3JpdGUgYW5kIHRoZQ0KY2hhbmdlIHRvIGludGVncmF0ZSBhc3NlcnQg
YW5kIGRlYXNzZXJ0IHRvZ2V0aGVyLg0KMy4gc2VwYXJhdGUgdGhlIGR0cyBwYXRjaCBmcm9tIHRo
aXMgcGF0Y2ggc2V0cw0KDQp2NDoNCmZpeCB0eXBvcyBvbiB2MyBjb21taXQgbWVzc2FnZS4NCg0K
djM6DQoxLiByZXZlcnQgdjIgY2hhbmdlcy4NCjIuIGFkZCAncmVzZXQtZHVyYXRpb24tdXMnIHBy
b3BlcnR5IHRvIGRlY2xhcmUgYSBtaW5pbXVtIGRlbGF5LA0Kd2hpY2ggbmVlZHMgdG8gYmUgd2Fp
dGVkIGJldHdlZW4gYXNzZXJ0IGFuZCBkZWFzc2VydC4NCjMuIGFkZCAnbWVkaWF0ZWssaW5mcmEt
cmVzZXQnIHRvIGNvbXBhdGlibGUuDQoNCnYyIGNoYW5nZXM6DQpodHRwczovL3BhdGNod29yay5r
ZXJuZWwub3JnL3BhdGNoLzExNjk3MzcxLw0KMS4gYWRkICdhc3NlcnQtZGVhc3NlcnQtdG9nZXRo
ZXInIHByb3BlcnR5IHRvIGludHJvZHVjZSBhIG5ldyByZXNldCBoYW5kbGVyLA0Kd2hpY2ggYWxs
b3dzIGRldmljZSB0byBkbyBzZXJpYWxpemVkIGFzc2VydCBhbmQgZGVhc3NlcnQgb3BlcmF0aW9u
cyBpbiBhIHNpbmdsZQ0Kc3RlcCBieSAncmVzZXQnIG1ldGhvZC4NCjIuIGFkZCAndXBkYXRlLWZv
cmNlJyBwcm9wZXJ0eSB0byBpbnRyb2R1Y2UgZm9yY2UtdXBkYXRlIG1ldGhvZCwgd2hpY2ggZm9y
Y2VzDQp0aGUgd3JpdGUgb3BlcmF0aW9uIGluIGNhc2UgdGhlIHJlYWQgYWxyZWFkeSBoYXBwZW5z
IHRvIHJldHVybiB0aGUgY29ycmVjdCB2YWx1ZS4NCjMuIGFkZCAnZ2VuZXJpYy1yZXNldCcgdG8g
Y29tcGF0aWJsZQ0KDQp2MSBjaGFuZ2VzOg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
YXRjaC8xMTY5MDUyMy8NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE2OTA1
MjcvDQoNCkNyeXN0YWwgR3VvICgzKToNCiAgZHQtYmluZGluZzogcmVzZXQtY29udHJvbGxlcjog
bWVkaWF0ZWs6IGFkZCBZQU1MIHNjaGVtYXMNCiAgcmVzZXQtY29udHJvbGxlcjogdGk6IGludHJv
ZHVjZSBhIG5ldyByZXNldCBoYW5kbGVyDQogIHJlc2V0LWNvbnRyb2xsZXI6IHRpOiBmb3JjZSB0
aGUgd3JpdGUgb3BlcmF0aW9uIHdoZW4gYXNzZXJ0IG9yDQogICAgZGVhc3NlcnQNCg0KIC4uLi9i
aW5kaW5ncy9yZXNldC9tZWRpYXRlay1zeXNjb24tcmVzZXQueWFtbCB8IDUxICsrKysrKysrKysr
KysrKysrKysNCiBkcml2ZXJzL3Jlc2V0L3Jlc2V0LXRpLXN5c2Nvbi5jICAgICAgICAgICAgICAg
fCA0NCArKysrKysrKysrKysrKy0tDQogMiBmaWxlcyBjaGFuZ2VkLCA5MiBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcmVzZXQvbWVkaWF0ZWstc3lzY29uLXJlc2V0LnlhbWwNCg0K

