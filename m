Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C797279C41
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 21:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIZTuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 15:50:20 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:45315 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgIZTuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 15:50:20 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BzK1r3yLWz18;
        Sat, 26 Sep 2020 21:42:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1601149360; bh=8xBELmKmRmFvA8NjH974wXIq97JxCKwgyG7dDWhqqdQ=;
        h=Date:From:Subject:To:Cc:From;
        b=clj6kfZgGJdEXOW1IMsmPEARNw200k85ZGQ36hzDQiWrbgk3/RvsXQKslvizlSARz
         Cenf7SZJtPN3PrXZQl9p7NEX9nufD7HeqcmciZQZ1UY6NfgFPPwm7VHTivjMB8HAXK
         SaEJ/wmKxcBhQo26VT6h/kHFvH4XJ147Kzbh5+NeiJyBLRvTYNbJaMyg38AiysyfnU
         XdG7z52qrz1eB5X9lydDNAJie/WgQW3hIxoY0t4y/r2CsDBdMoeIgCRJiYEraF1XSR
         iiFKRd/ZA9GBQzHAogL3wzWNqDw6kTuxw0LOO6YFWPkgeGWvX4dnpbhZWG5H442KBv
         tNBPEuKYb52Iw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sat, 26 Sep 2020 21:42:40 +0200
Message-Id: <ede103cf7f6914054a73cf8f1d9725ee13a7cf5d.1601149261.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] ASoC: tegra20-spdif: remove "default m"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>
Cc:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make tegra20-spdif default to N as all other drivers do.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Fixes: 774fec338bfc ("ASoC: Tegra: Implement SPDIF CPU DAI")
---
 sound/soc/tegra/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index 3d91bd3e59cd..a62cc87551ac 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -39,7 +39,6 @@ config SND_SOC_TEGRA20_I2S
 config SND_SOC_TEGRA20_SPDIF
 	tristate "Tegra20 SPDIF interface"
 	depends on SND_SOC_TEGRA
-	default m
 	help
 	  Say Y or M if you want to add support for the Tegra20 SPDIF interface.
 	  You will also need to select the individual machine drivers to support
-- 
2.20.1

