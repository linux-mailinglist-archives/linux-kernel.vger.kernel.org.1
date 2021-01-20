Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32D22FD5C9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390068AbhATQf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:35:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403957AbhATQ0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:26:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C023D233E2;
        Wed, 20 Jan 2021 16:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611159959;
        bh=pplVtWu5CogqVByi3nEGtedDWrVmUgHEkMhQP3YWBzQ=;
        h=From:To:Cc:Subject:Date:From;
        b=RkindgZzngabP6z81VN2gDLFWgZM55s6+VL/ePVjObzbmAiEFXPBKM/EFsTlILE9t
         9lSdqnMno10m8nqWsG+4+D38soJVeb+loHGnYo3UhmjYuKuS3+m0A5gVW0Poiz4eLk
         +uZYaoZkOIzubvy0ODXGEgSnuJU1Us+Rg15H14IvcpZxyawiWxbmDOE3+ymrWDmvnU
         Ly9I7bK8V4V2p6bScMRG05QnkP2JsCwCmZgFgoZydcfhRlgSVWjriW525F3jGoMtwS
         z/UeirHC39tREfOsq1+AmCX7FYR8uyL8zU++MRGjuoicD2DfVjgm0ELD3RZSmNujVq
         CEZKeXDBAQQGQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/2] ASoC: remove obsolete drivers
Date:   Wed, 20 Jan 2021 17:25:51 +0100
Message-Id: <20210120162553.21666-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A few Arm platforms are getting removed in v5.12, this removes
the corresponding sound drivers.

Link: https://lore.kernel.org/linux-arm-kernel/20210120124812.2800027-1-arnd@kernel.org/T/

Arnd Bergmann (2):
  ASoC: remove sirf prima/atlas drivers
  ASoC: remove zte zx drivers

 .../bindings/sound/sirf-audio-codec.txt       |  17 -
 .../devicetree/bindings/sound/sirf-usp.txt    |  27 -
 .../devicetree/bindings/sound/zte,tdm.txt     |  30 -
 .../bindings/sound/zte,zx-aud96p22.txt        |  24 -
 .../devicetree/bindings/sound/zte,zx-i2s.txt  |  45 --
 .../bindings/sound/zte,zx-spdif.txt           |  27 -
 sound/soc/Kconfig                             |   2 -
 sound/soc/Makefile                            |   2 -
 sound/soc/codecs/Makefile                     |   4 -
 sound/soc/codecs/sirf-audio-codec.c           | 575 ------------------
 sound/soc/codecs/zx_aud96p22.c                | 401 ------------
 sound/soc/sirf/Kconfig                        |  21 -
 sound/soc/sirf/Makefile                       |   8 -
 sound/soc/sirf/sirf-audio-port.c              |  86 ---
 sound/soc/sirf/sirf-audio.c                   | 160 -----
 sound/soc/sirf/sirf-usp.c                     | 435 -------------
 sound/soc/sirf/sirf-usp.h                     | 292 ---------
 sound/soc/zte/Kconfig                         |  26 -
 sound/soc/zte/Makefile                        |   4 -
 sound/soc/zte/zx-i2s.c                        | 452 --------------
 sound/soc/zte/zx-spdif.c                      | 363 -----------
 sound/soc/zte/zx-tdm.c                        | 458 --------------
 22 files changed, 3459 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/sirf-audio-codec.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/sirf-usp.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/zte,tdm.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/zte,zx-aud96p22.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/zte,zx-spdif.txt
 delete mode 100644 sound/soc/codecs/sirf-audio-codec.c
 delete mode 100644 sound/soc/codecs/zx_aud96p22.c
 delete mode 100644 sound/soc/sirf/Kconfig
 delete mode 100644 sound/soc/sirf/Makefile
 delete mode 100644 sound/soc/sirf/sirf-audio-port.c
 delete mode 100644 sound/soc/sirf/sirf-audio.c
 delete mode 100644 sound/soc/sirf/sirf-usp.c
 delete mode 100644 sound/soc/sirf/sirf-usp.h
 delete mode 100644 sound/soc/zte/Kconfig
 delete mode 100644 sound/soc/zte/Makefile
 delete mode 100644 sound/soc/zte/zx-i2s.c
 delete mode 100644 sound/soc/zte/zx-spdif.c
 delete mode 100644 sound/soc/zte/zx-tdm.c

-- 
2.29.2

