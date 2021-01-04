Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7212E9390
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbhADKpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:45:45 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42780 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726313AbhADKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:45:44 -0500
X-UUID: 64258abdd98a4ec791d81b5549e3519c-20210104
X-UUID: 64258abdd98a4ec791d81b5549e3519c-20210104
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1790601655; Mon, 04 Jan 2021 18:44:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 4 Jan 2021 18:44:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 4 Jan 2021 18:44:57 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH 0/2] Fixes for new SCPSYS power domains controller driver
Date:   Mon, 4 Jan 2021 18:44:51 +0800
Message-ID: <1609757093-30618-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is base on v5.10-rc1 and
series "Add new driver for SCPSYS power domains controller"[1]

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=374013

Weiyi Lu (2):
  soc: mediatek: Add regulator control for MT8192 MFG power domain
  soc: mediatek: Fix the clock prepared issue

 drivers/soc/mediatek/mt8192-pm-domains.h |  1 +
 drivers/soc/mediatek/mtk-pm-domains.c    | 73 ++++++++++++++++--------
 drivers/soc/mediatek/mtk-pm-domains.h    |  2 +
 3 files changed, 51 insertions(+), 25 deletions(-)

