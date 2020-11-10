Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8B02ACB22
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 03:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbgKJCbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 21:31:46 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59941 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730083AbgKJCbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:31:45 -0500
X-UUID: a3438fe8076740b9997c703394848dd8-20201110
X-UUID: a3438fe8076740b9997c703394848dd8-20201110
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <shane.chien@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1305501034; Tue, 10 Nov 2020 10:31:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Nov 2020 10:31:38 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Nov 2020 10:31:38 +0800
From:   Shane Chien <shane.chien@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <chipeng.chang@mediatek.com>, <shane.chien@mediatek.com>
Subject: [PATCH v3 0/2] Fix vaud18 power leakage of mt6359
Date:   Tue, 10 Nov 2020 10:31:30 +0800
Message-ID: <1604975492-6142-1-git-send-email-shane.chien@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Shane.Chien" <shane.chien@mediatek.com>

This series of patches is to fix vaud18 power leakage problem.
vaud18 will be enable only when mt6359 audio path is turned on.

Change since v2:
 - fix dt-binnding syntex error

Change since v1:
 - use dapm regulator supply widget for vaud18 control.
 - add vaud18 regulator property in mt6359 dt-binding.

Shane.Chien (2):
  ASoC: Fix vaud18 power leakage of mt6359
  dt-bindings: mediatek: mt6359: Add new property for mt6359

 .../devicetree/bindings/sound/mt6359.yaml          |    9 +++++++
 sound/soc/codecs/mt6359.c                          |   25 +-------------------
 sound/soc/codecs/mt6359.h                          |    8 -------
 3 files changed, 10 insertions(+), 32 deletions(-)

-- 
1.7.9.5

