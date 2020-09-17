Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9926D39C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 08:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIQGYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 02:24:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60124 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgIQGX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:23:59 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9CA8A200C65;
        Thu, 17 Sep 2020 08:18:10 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 286EB2000FF;
        Thu, 17 Sep 2020 08:18:06 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3CB73402C3;
        Thu, 17 Sep 2020 08:18:00 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] ASoC: fsl_sai: update the register list
Date:   Thu, 17 Sep 2020 14:11:16 +0800
Message-Id: <1600323079-5317-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As sai ip is upgraded, so update sai register list.

Shengjiu Wang (3):
  ASoC: fsl_sai: Add new added registers and new bit definition
  ASoC: fsl_sai: Add fsl_sai_check_version function
  ASoC: fsl_sai: Set MCLK input or output direction

changes in v2:
- update commit message for first commit
- Add acked-by Nicolin

 sound/soc/fsl/fsl_sai.c | 77 ++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_sai.h | 87 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

-- 
2.27.0

