Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9D71D10D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 13:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbgEMLNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 07:13:53 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:12201 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbgEMLNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:13:49 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5ebbd658ecd-cf4c5; Wed, 13 May 2020 19:13:28 +0800 (CST)
X-RM-TRANSID: 2eeb5ebbd658ecd-cf4c5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65ebbd655ed9-e0e21;
        Wed, 13 May 2020 19:13:28 +0800 (CST)
X-RM-TRANSID: 2ee65ebbd655ed9-e0e21
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com,
        perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: fsl: imx-audmix: Fix unused assignment to variable 'ret'
Date:   Wed, 13 May 2020 19:14:08 +0800
Message-Id: <20200513111408.11452-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Omit unused initialized value, because 'ret' will be assigined
by the function snd_soc_component_read().

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/fsl/fsl_audmix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index 5faecbeb5..8b9027f76 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -116,7 +116,7 @@ static int fsl_audmix_put_mix_clk_src(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int *item = ucontrol->value.enumerated.item;
 	unsigned int reg_val, val, mix_clk;
-	int ret = 0;
+	int ret;
 
 	/* Get current state */
 	ret = snd_soc_component_read(comp, FSL_AUDMIX_CTR, &reg_val);
@@ -159,7 +159,7 @@ static int fsl_audmix_put_out_src(struct snd_kcontrol *kcontrol,
 	unsigned int *item = ucontrol->value.enumerated.item;
 	u32 out_src, mix_clk;
 	unsigned int reg_val, val, mask = 0, ctr = 0;
-	int ret = 0;
+	int ret;
 
 	/* Get current state */
 	ret = snd_soc_component_read(comp, FSL_AUDMIX_CTR, &reg_val);
-- 
2.20.1.windows.1



