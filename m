Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D224323C375
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 04:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHEC2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 22:28:36 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46288 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgHEC2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:28:36 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BFDA7200354;
        Wed,  5 Aug 2020 04:28:34 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1EB2320138C;
        Wed,  5 Aug 2020 04:28:30 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 294AD4024E;
        Wed,  5 Aug 2020 04:28:24 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] refine and clean code for synchronous mode
Date:   Wed,  5 Aug 2020 10:23:51 +0800
Message-Id: <1596594233-13489-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refine and clean code for synchronous mode

Shengjiu Wang (2):
  ASoC: fsl_sai: Clean code for synchronous mode
  ASoC: fsl_sai: Refine enable and disable sequence for synchronous mode

changes in v2:
- Split the commit
- refine the sequence in trigger stop


 sound/soc/fsl/fsl_sai.c | 133 ++++++++++++++++++++++++++--------------
 1 file changed, 86 insertions(+), 47 deletions(-)

-- 
2.27.0

