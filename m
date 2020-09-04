Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD625D1A4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 08:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIDGpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 02:45:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3466 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726151AbgIDGpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:45:05 -0400
X-UUID: 7cb2678bed254c11a8bf9b2948914537-20200904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=OQecg9cZ8/g9Z/4uGEw+tFX+Ft+eJHlpTokpoBrahJE=;
        b=llmtnsCDSlBsYLqln0RAKgqWAJVPdZGYJcqyqvaxpunAljH0ho56AF1cEBxmplbOj8/06pbRCRFEa2VaKvIa/alaxFWYbsbs/TT4SfDk288kRehSpvgOPZkKmvURzVjzx0jhl3HVXPmXILDUzHQnUm0jzhEuXNZYuKjeZrgOgsE=;
X-UUID: 7cb2678bed254c11a8bf9b2948914537-20200904
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 578380492; Fri, 04 Sep 2020 14:44:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Sep 2020 14:44:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Sep 2020 14:44:55 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH 0/3] Mediatek MT8192 scpsys support  
Date:   Fri, 4 Sep 2020 14:44:52 +0800
Message-ID: <1599201895-11013-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdjUuOS1yYzEsIE1UODE5MiBjbG9jayB2M1sxXSBhbmQg
TVQ4MTgzIHNjcHN5cyB2MTdbMl0uDQoNClsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L2NvdmVyLzExNzUyMjMxLw0KWzJdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIv
MTE3MDMyNTMvDQoNCg0KV2VpeWkgTHUgKDMpOg0KICBkdC1iaW5kaW5nczogc29jOiBBZGQgTVQ4
MTkyIHBvd2VyIGR0LWJpbmRpbmdzDQogIHNvYzogbWVkaWF0ZWs6IEFkZCBNVDgxOTIgc2Nwc3lz
IHN1cHBvcnQNCiAgYXJtNjQ6IGR0czogQWRkIHBvd2VyIGNvbnRyb2xsZXIgZGV2aWNlIG5vZGUg
b2YgTVQ4MTkyDQoNCiAuLi4vYmluZGluZ3Mvc29jL21lZGlhdGVrL3NjcHN5cy50eHQgICAgICAg
ICAgfCAgIDUgKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kgICAg
ICB8IDE0OCArKysrKysrKysNCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgICAg
ICAgICAgICAgfCAyOTcgKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9w
b3dlci9tdDgxOTItcG93ZXIuaCAgICAgIHwgIDMyICsrDQogNCBmaWxlcyBjaGFuZ2VkLCA0ODIg
aW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bv
d2VyL210ODE5Mi1wb3dlci5oDQo=

