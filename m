Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EE121EC40
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 11:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGNJJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 05:09:16 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39366 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgGNJJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:09:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8623D200F2E;
        Tue, 14 Jul 2020 11:09:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 38E5F200F35;
        Tue, 14 Jul 2020 11:09:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 220AA402B4;
        Tue, 14 Jul 2020 17:09:00 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        broonie@kernel.org, kuninori.morimoto.gx@renesas.com,
        katsuhiro@katsuster.net, samuel@sholland.org,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] ASoC: fsl-asoc-card: Support hp and mic detection
Date:   Tue, 14 Jul 2020 17:05:33 +0800
Message-Id: <1594717536-5188-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support hp and mic detection.
Add a parameter for asoc_simple_init_jack.

Shengjiu Wang (3):
  ASoC: simple-card-utils: Support configure pin_name for
    asoc_simple_init_jack
  ASoC: bindings: fsl-asoc-card: Support hp-det-gpio and mic-det-gpio
  ASoC: fsl-asoc-card: Support Headphone and Microphone Jack detection

 .../bindings/sound/fsl-asoc-card.txt          |  3 +
 include/sound/simple_card_utils.h             |  6 +-
 sound/soc/fsl/Kconfig                         |  1 +
 sound/soc/fsl/fsl-asoc-card.c                 | 69 ++++++++++++++++++-
 sound/soc/generic/simple-card-utils.c         |  7 +-
 5 files changed, 78 insertions(+), 8 deletions(-)

-- 
2.27.0

