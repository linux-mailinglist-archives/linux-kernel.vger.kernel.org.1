Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1AF1EC7FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 05:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgFCDuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 23:50:19 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35032 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbgFCDuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:50:15 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D23BB1A0F18;
        Wed,  3 Jun 2020 05:50:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 533CB1A0084;
        Wed,  3 Jun 2020 05:50:09 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 50EFF402E8;
        Wed,  3 Jun 2020 11:50:03 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ASoC: fsl_easrc: Fix several warnings
Date:   Wed,  3 Jun 2020 11:39:38 +0800
Message-Id: <cover.1591155860.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix several warnings with "make W=1"

Shengjiu Wang (3):
  ASoC: fsl_easrc: Fix -Wmissing-prototypes warning
  ASoC: fsl_easrc: Fix -Wunused-but-set-variable
  ASoC: fsl_easrc: Fix "Function parameter not described" warnings

 sound/soc/fsl/fsl_easrc.c | 42 +++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

-- 
2.21.0

