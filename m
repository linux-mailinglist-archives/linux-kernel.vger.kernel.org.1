Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE142FC6BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 02:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbhATB1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 20:27:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbhATB0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:26:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9664223109;
        Wed, 20 Jan 2021 01:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611105964;
        bh=HmkN0mm9wbN/TCVJTimhHdMI1XEsCsdxLiIIZk5t0hQ=;
        h=From:To:Cc:Subject:Date:From;
        b=gGhhP42zJgjqLRPVs79DVu3aXg0iu5vMzBO+51S1vhqWpfX2cUHxb0vKO5u696JRX
         mfHcrYAU+nEzAgp1+udbwg14OJP8XfXtvDpnM22HEn8pG2xHZEmhKPGTa4OVVtugbo
         ToxAxu8ebqPadsA1HgEUPS6MF3uRy1W/RWBWM+lmMqUlPjqC5xRVcmRWyBGUG32kXM
         Chtx+ec4rc/nQ2PJYXCB7XZ3D+IKT06hnxjmR4dTh5bJw0PFwd3aDjNB0dCBTmZnq3
         vEU6ybA1s2HK+nxRtuDSSmlyJw2O5sgUOr8UWGEnLDi8G+ksuuDKyG2tdXunaZw8N0
         ReQBwrnXc2K9g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.10 01/45] ASoC: Intel: haswell: Add missing pm_ops
Date:   Tue, 19 Jan 2021 20:25:18 -0500
Message-Id: <20210120012602.769683-1-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit bb224c3e3e41d940612d4cc9573289cdbd5cb8f5 ]

haswell machine board is missing pm_ops what prevents it from undergoing
suspend-resume procedure successfully. Assign default snd_soc_pm_ops so
this is no longer the case.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://lore.kernel.org/r/20201217105401.27865-1-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/haswell.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/haswell.c b/sound/soc/intel/boards/haswell.c
index c55d1239e705b..c763bfeb1f38f 100644
--- a/sound/soc/intel/boards/haswell.c
+++ b/sound/soc/intel/boards/haswell.c
@@ -189,6 +189,7 @@ static struct platform_driver haswell_audio = {
 	.probe = haswell_audio_probe,
 	.driver = {
 		.name = "haswell-audio",
+		.pm = &snd_soc_pm_ops,
 	},
 };
 
-- 
2.27.0

