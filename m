Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6F2245ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 04:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgHQCuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 22:50:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47375 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726451AbgHQCuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 22:50:20 -0400
X-UUID: 2573039bf61b41ef84fb8d778ec1fc7b-20200817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=t4ilFaoK0tLBNope3nohB/2oIAVf+4PK2ECy4GhL2WE=;
        b=uGAAkt5Hf11C0SneHLchGrIX61KNoJ1yZosegm/aiMALt/022JHTW182tqfVC9MFoi06YarTIPKbGHAYQjfMhtNFGiXDOFTL/nACVAT6dqA8TYDbSGtT40AfmnPABxLhufkz0eWRP8kQcogkJ31VT3J5zMDwt5N+K9ZY1bsfaYw=;
X-UUID: 2573039bf61b41ef84fb8d778ec1fc7b-20200817
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1744114517; Mon, 17 Aug 2020 10:50:17 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Aug 2020 10:50:10 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Aug 2020 10:50:09 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <s-anna@ti.com>, <afd@ti.com>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>,
        Crystal Guo <crystal.guo@mediatek.com>
Subject: [v3,1/4] dt-binding: reset-controller: ti: add reset-duration-us property
Date:   Mon, 17 Aug 2020 10:48:39 +0800
Message-ID: <20200817024842.5289-2-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200817024842.5289-1-crystal.guo@mediatek.com>
References: <20200817024842.5289-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E94DD4ACC9153DF574A91C2DB754D011E245F7F99EBEE0F160CFC2196866DE2D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aW50cm9kdWNlICdyZXNldCcgbWV0aG9kIHRvIGFsbG93IGRldmljZSBkbyBzZXJpYWxpemVkIGFz
c2VydCBhbmQNCmRlYXNzZXJ0IG9wZXJhdGlvbnMgaW4gYSBzaW5nbGUgc3RlcCwgd2hpY2ggbmVl
ZHMgYSBtaW5pbXVtIGRlbGF5DQp0byBiZSB3YWl0ZWQgYmV0d2VlbiBhc3NlcnQgYW5kIGRlYXNz
ZXJ0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDcnlzdGFsIEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsu
Y29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L3RpLXN5
c2Nvbi1yZXNldC50eHQgfCA1ICsrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0
L3RpLXN5c2Nvbi1yZXNldC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cmVzZXQvdGktc3lzY29uLXJlc2V0LnR4dA0KaW5kZXggODY5NDU1MDJjY2I1Li5hYjA0MTAzMjMz
OWIgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQv
dGktc3lzY29uLXJlc2V0LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3Jlc2V0L3RpLXN5c2Nvbi1yZXNldC50eHQNCkBAIC01OSw2ICs1OSwxMSBAQCBSZXF1aXJl
ZCBwcm9wZXJ0aWVzOg0KIFBsZWFzZSBhbHNvIHJlZmVyIHRvIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9yZXNldC9yZXNldC50eHQgZm9yDQogY29tbW9uIHJlc2V0IGNvbnRyb2xs
ZXIgdXNhZ2UgYnkgY29uc3VtZXJzLg0KIA0KK09wdGlvbmFsIHByb3BlcnRpZXM6DQorLSByZXNl
dC1kdXJhdGlvbi11czogV2hlbiBkbyBzZXJpYWxpemVkIGFzc2VydCBhbmQgZGVhc3NlcnQgb3Bl
cmF0aW9ucywgbWluaW11bSBkZWxheSBpbiBtaWNyb3NlY29uZHMNCitpcyBuZWVkZWQgdG8gYmUg
d2FpdGVkIGJldHdlZW4gYW4gYXNzZXJ0IGFuZCBhIGRlYXNzZXJ0IHRvIHJlc2V0IHRoZSBkZXZp
Y2UuIFRoaXMgdmFsdWUgY2FuIGJlIDAsIDAgbWVhbnMNCit0aGF0IHN1Y2ggYSBkZWxheSBpcyBu
b3QgbmVlZGVkLg0KKw0KIEV4YW1wbGU6DQogLS0tLS0tLS0NCiBUaGUgZm9sbG93aW5nIGV4YW1w
bGUgZGVtb25zdHJhdGVzIGEgc3lzY29uIG5vZGUsIHRoZSByZXNldCBjb250cm9sbGVyIG5vZGUN
Ci0tIA0KMi4xOC4wDQo=

