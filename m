Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E4124F14B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 04:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgHXCtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 22:49:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41199 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726635AbgHXCtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 22:49:10 -0400
X-UUID: d9b9316a0d9d4d6b8b0c3a0901db0127-20200824
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MQ+lWRIMzlLcIAlBgmbEN4Xfo27oGH4DXQdB75/Yr0g=;
        b=Y7K6vJzVgIzjrVzAZBU2NeknkxBwY5bq0dUA1qjHPEoHRMl9v239GpDXy2cHTXpWbt5xzAwcj3L3HDDg/I8Kiinp127Ow55bJ2YrYn4vKQ9rzUS6MrADIMu+iIx6IaEU9AgozcKncn3k7e0OG54kphJCYe+Br6HmV2slyNAq0hY=;
X-UUID: d9b9316a0d9d4d6b8b0c3a0901db0127-20200824
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1682917385; Mon, 24 Aug 2020 10:49:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Aug 2020 10:48:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Aug 2020 10:48:54 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <mark-pk.tsai@mediatek.com>
CC:     <alix.wu@mediatek.com>, <daniel@0x0f.com>,
        <devicetree@vger.kernel.org>, <jason@lakedaemon.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <maz@kernel.org>, <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <yj.chiang@mediatek.com>
Subject: [PATCH] MAINTAINERS: Add maintenance information for MStar Interrupt Controller
Date:   Mon, 24 Aug 2020 10:48:56 +0800
Message-ID: <20200824024856.12845-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200819153757.28993-1-mark-pk.tsai@mediatek.com>
References: <20200819153757.28993-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5ECEB2847F83711C8D72F1725AB1012FAAD0F315FAF4E860FF3A8DD04AE7A0CA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGVudHJ5IGZvciBNU3RhciBJbnRlcnJ1cHQgQ29udHJvbGxlci4NCg0KU2lnbmVkLW9mZi1i
eTogTWFyay1QSyBUc2FpIDxtYXJrLXBrLnRzYWlAbWVkaWF0ZWsuY29tPg0KLS0tDQogTUFJTlRB
SU5FUlMgfCA3ICsrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQoNCmRp
ZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQppbmRleCBkZWFhZmI2MTczNjEu
LjhhYjA4ZmNjZDkxNSAxMDA2NDQNCi0tLSBhL01BSU5UQUlORVJTDQorKysgYi9NQUlOVEFJTkVS
Uw0KQEAgLTExNzU0LDYgKzExNzU0LDEzIEBAIFE6CWh0dHA6Ly9wYXRjaHdvcmsubGludXh0di5v
cmcvcHJvamVjdC9saW51eC1tZWRpYS9saXN0Lw0KIFQ6CWdpdCBnaXQ6Ly9saW51eHR2Lm9yZy9h
bnR0aXAvbWVkaWFfdHJlZS5naXQNCiBGOglkcml2ZXJzL21lZGlhL3VzYi9tc2kyNTAwLw0KIA0K
K01TVEFSIElOVEVSUlVQVCBDT05UUk9MTEVSIERSSVZFUg0KK006CU1hcmstUEsgVHNhaSA8bWFy
ay1way50c2FpQG1lZGlhdGVrLmNvbT4NCitNOglEYW5pZWwgUGFsbWVyIDxkYW5pZWxAdGhpbmd5
LmpwPg0KK1M6CU1haW50YWluZWQNCitGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvbXN0YXIsbXN0LWludGMueWFtbA0KK0Y6CWRyaXZlcnMv
aXJxY2hpcC9pcnEtbXN0LWludGMuYw0KKw0KIE1TWVNURU1TIERJU0tPTkNISVAgRzMgTVREIERS
SVZFUg0KIE06CVJvYmVydCBKYXJ6bWlrIDxyb2JlcnQuamFyem1pa0BmcmVlLmZyPg0KIEw6CWxp
bnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnDQotLSANCjIuMTguMA0K

