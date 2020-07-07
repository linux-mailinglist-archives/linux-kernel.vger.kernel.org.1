Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64BD2168AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 10:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGGI6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 04:58:46 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46678 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgGGI6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:58:45 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9A9711A0A52;
        Tue,  7 Jul 2020 10:58:44 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5349C1A072B;
        Tue,  7 Jul 2020 10:58:40 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B169D402C8;
        Tue,  7 Jul 2020 16:58:34 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ASoC: fsl_spdif: Clear the validity bit for TX
Date:   Tue,  7 Jul 2020 16:54:24 +0800
Message-Id: <1594112066-31297-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear the validity bit for TX
Add kctl for configuring TX validity bit

Shengjiu Wang (2):
  ASoC: fsl_spdif: Clear the validity bit for TX
  ASoC: fsl_spdif: Add kctl for configuring TX validity bit

 sound/soc/fsl/fsl_spdif.c | 51 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

-- 
2.21.0

