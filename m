Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C18245ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 04:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgHQCuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 22:50:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28935 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726918AbgHQCuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 22:50:19 -0400
X-UUID: c1bdd9e3147f477a8ec76817789a2969-20200817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JJlKMP7ee02ays8KbIJqTQ/xkRTBFEVByYajjiFisPk=;
        b=GW+/3iDIILtb1nDctYPMebyBQ258ydRh9L1J/d9xSV60Jy/qoODNxOaLmQxdIRHed8QnNOt3YYMhWk7sbGrRy+SITfN1aiY/N1K9ZWucTQLM8tKT9T8exOQKyXG4QDMhhpVZ2nKhZbt/i61G+a3fjlANamvFiBx8g7h/Y9TEjq0=;
X-UUID: c1bdd9e3147f477a8ec76817789a2969-20200817
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 281549421; Mon, 17 Aug 2020 10:50:14 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Aug 2020 10:50:11 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Aug 2020 10:50:10 +0800
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
Subject: [v3,2/4] dt-binding: reset-controller: ti: add 'mediatek,infra-reset' to compatible
Date:   Mon, 17 Aug 2020 10:48:40 +0800
Message-ID: <20200817024842.5289-3-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200817024842.5289-1-crystal.guo@mediatek.com>
References: <20200817024842.5289-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIFRJIHN5c2NvbiByZXNldCBjb250cm9sbGVyIHByb3ZpZGVzIGEgY29tbW9uIHJlc2V0IG1h
bmFnZW1lbnQsDQphbmQgaXMgc3VpdGFibGUgZm9yIE1USyBTb0NzLiBBZGQgY29tcGF0aWJsZSAn
bWVkaWF0ZWssaW5mcmEtcmVzZXQnLA0Kd2hpY2ggZGVub3RlcyB0byB1c2UgdGkgcmVzZXQtY29u
dHJvbGxlciBkcml2ZXIgZGlyZWN0bHkuDQoNClNpZ25lZC1vZmYtYnk6IENyeXN0YWwgR3VvIDxj
cnlzdGFsLmd1b0BtZWRpYXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcmVzZXQvdGktc3lzY29uLXJlc2V0LnR4dCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3Jlc2V0L3RpLXN5c2Nvbi1yZXNldC50eHQgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcmVzZXQvdGktc3lzY29uLXJlc2V0LnR4dA0KaW5kZXggYWIwNDEwMzIz
MzliLi41YTBlOTM2NWI1MWIgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcmVzZXQvdGktc3lzY29uLXJlc2V0LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L3RpLXN5c2Nvbi1yZXNldC50eHQNCkBAIC0yNSw2ICsy
NSw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogCQkJICAgICJ0aSxrMmwtcHNjcnN0Ig0KIAkJ
CSAgICAidGksazJoay1wc2Nyc3QiDQogCQkJICAgICJ0aSxzeXNjb24tcmVzZXQiDQorCQkJICAg
ICJtZWRpYXRlayxpbmZyYS1yZXNldCIsICJ0aSxzeXNjb24tcmVzZXQiDQogIC0gI3Jlc2V0LWNl
bGxzCQk6IFNob3VsZCBiZSAxLiBQbGVhc2Ugc2VlIHRoZSByZXNldCBjb25zdW1lciBub2RlIGJl
bG93DQogCQkJICBmb3IgdXNhZ2UgZGV0YWlscw0KICAtIHRpLHJlc2V0LWJpdHMJOiBDb250YWlu
cyB0aGUgcmVzZXQgY29udHJvbCByZWdpc3RlciBpbmZvcm1hdGlvbg0KLS0gDQoyLjE4LjANCg==

