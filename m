Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506CB2AB397
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgKIJa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:30:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60985 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726176AbgKIJa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:30:29 -0500
X-UUID: fa6878130bc14ce48ee029f7ba602b5a-20201109
X-UUID: fa6878130bc14ce48ee029f7ba602b5a-20201109
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <shane.chien@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 693968459; Mon, 09 Nov 2020 17:30:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 17:30:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 17:30:24 +0800
From:   Shane Chien <shane.chien@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <chipeng.chang@mediatek.com>, <shane.chien@mediatek.com>
Subject: [PATCH v2 0/2] Fix vaud18 power leakage of mt6359
Date:   Mon, 9 Nov 2020 17:30:07 +0800
Message-ID: <1604914209-9174-1-git-send-email-shane.chien@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8982818A31E456278736392BC1DA4C265125EFEC122D7738F621B0C9085C90C22000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Shane.Chien" <shane.chien@mediatek.com>

This series of patches is to fix vaud18 power leakage problem.
vaud18 will be enable only when mt6359 audio path is turned on.

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

