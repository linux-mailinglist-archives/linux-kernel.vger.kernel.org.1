Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0CE2BB014
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgKTQTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:19:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbgKTQTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:19:46 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A374E223BE;
        Fri, 20 Nov 2020 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889186;
        bh=DS1nymrUd49e3536q4ErunpnmZeajDywtvhVRNThnTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FWt/auyCYm37V+iCdWDzUDspvxKLit5Fv1AI3iRwpPU+Ix91ErfGOR3agGY4QvOG3
         TdwDRqFzDOYHzM2+SMMZbFGcV1rGkZfWrF9P8gGhsp4KBjTAQIPxRjtBKuC790i2+l
         V6b1QiDDOpSnnf2Agtguy7qB3ha65+iTFN3P9vbo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 32/38] ASoC: es7134: mark OF related data as maybe unused
Date:   Fri, 20 Nov 2020 17:16:46 +0100
Message-Id: <20201120161653.445521-32-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  sound/soc/codecs/es7134.c:264:33: warning: ‘es7154_chip’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/es7134.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 00518406eb2b..e2b79879354b 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -183,7 +183,7 @@ static const struct snd_soc_dapm_route es7134_extra_routes[] = {
 	{ "Playback", NULL, "VDD", }
 };
 
-static const struct es7134_chip es7134_chip = {
+static const struct es7134_chip es7134_chip __maybe_unused = {
 	.dai_drv = &es7134_dai,
 	.modes = es7134_modes,
 	.mode_num = ARRAY_SIZE(es7134_modes),
@@ -261,7 +261,7 @@ static const struct snd_soc_dapm_route es7154_extra_routes[] = {
 	{ "Playback", NULL, "PVDD", }
 };
 
-static const struct es7134_chip es7154_chip = {
+static const struct es7134_chip es7154_chip __maybe_unused = {
 	.dai_drv = &es7154_dai,
 	.modes = es7154_modes,
 	.mode_num = ARRAY_SIZE(es7154_modes),
-- 
2.25.1

