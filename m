Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716F026C233
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 13:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgIPL2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 07:28:55 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34310 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbgIPKeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 06:34:18 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 958FC1A007D;
        Wed, 16 Sep 2020 12:23:27 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 21C411A03F5;
        Wed, 16 Sep 2020 12:23:23 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9FC0940310;
        Wed, 16 Sep 2020 12:23:16 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ASoC: fsl_sai: update the register list
Date:   Wed, 16 Sep 2020 18:16:24 +0800
Message-Id: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As sai ip is upgraded, so update sai register list.

Shengjiu Wang (3):
  ASoC: fsl_sai: Add new added registers and new bit definition
  ASoC: fsl_sai: Add fsl_sai_check_version function
  ASoC: fsl_sai: Set MCLK input or output direction

 sound/soc/fsl/fsl_sai.c | 77 ++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_sai.h | 87 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

-- 
2.27.0

