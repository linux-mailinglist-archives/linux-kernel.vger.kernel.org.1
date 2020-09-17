Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7995C26DE19
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgIQOWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgIQOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:20:14 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E070C0611C3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 07:19:18 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j11so3609767ejk.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 07:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QdmLHNgHWV7EyDtK4mu8SWh5osx/6ArPk9SW2Wk9JU=;
        b=D9Cnb7fgSHrvuQt0e1Tnf0E5ipLGZaJKw+XvFXRqkdYGdK7C8Nn3GXQ/YWDZdYk1M8
         uIICO/VqVzPETutVmfHYjeJKQgxxtchOj/8REl0Mz1L9KfqIPsHSF/Ce9ie35frZKAd0
         qRGHJTXLvfDgvtzArrDFUp3NT04cRD7BkjXVp5JltB/HTNjMrq0flignNFWCcdaOWpLb
         XSfb16AscCIv7WzkxG/2cPTHSIQIiYh4yJpv6YBfAgLk9baCGNDKO7dPkPmovGdX9SDy
         dxXdn1Y2g6xqR8WNdJmlXWr2fYT5JQMlQjU51a9hVOoArjj6UGQV6MgsHvxPE0UAPbyQ
         +v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QdmLHNgHWV7EyDtK4mu8SWh5osx/6ArPk9SW2Wk9JU=;
        b=ikCxJncYCCE4FSjRy0O4cV4eMqCLkKfLOIjDGipHYg34lDMa5pKEyO5y7hn1+MbRtL
         vsFt7V86uQuiwU8aIgxuuz3oHl9oEylGcmjsJjt+aQnUnZ2l6PghT8VuHHHWqbToJgyb
         mtH8lBZZy1VuAjNyW+bS6AITqIKOnLqUZmhRooy+DMx9e/EpcFIMNdGs4wWd20E/O84H
         oFWF9pDXiJJk/o0Wx76H9XMDmn/j+W+Ok2Pg3qnTQu7+qYcz7TjPOqwoQ93KzLC0NqKa
         oRQISwzizI7Z1/gdmCEEEjATTeUgW3UAFosoqFdrXtSiU6HgGEOEoDh5C72g5uTjKxPc
         fVZA==
X-Gm-Message-State: AOAM531sTCBvHdz1SIIf3dCiKOuGV2J0xygYhFjmWlOYCjonUBVaEsnL
        iofIjWUFrfw0Eq20stTsYAIFQf4HSBLB6Q==
X-Google-Smtp-Source: ABdhPJyLUxBjXuAJW1BD8Nd5aF9NxUTWesVyqfUAkVN5f650FWip28Le9/P6ASLfBJ8o03MyXSzPvQ==
X-Received: by 2002:a17:906:250a:: with SMTP id i10mr30382001ejb.202.1600352356709;
        Thu, 17 Sep 2020 07:19:16 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
        by smtp.gmail.com with ESMTPSA id j14sm16675661edr.91.2020.09.17.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 07:19:15 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     broonie@kernel.org
Cc:     ardb@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] ASoC: cros_ec_codec: fix kconfig dependency warning for SND_SOC_CROS_EC_CODEC
Date:   Thu, 17 Sep 2020 17:18:04 +0300
Message-Id: <20200917141803.92889-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SND_SOC_CROS_EC_CODEC is enabled and CRYPTO is disabled, it results
in the following Kbuild warning:

WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
  Depends on [n]: CRYPTO [=n]
  Selected by [y]:
  - SND_SOC_CROS_EC_CODEC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && CROS_EC [=y]

The reason is that SND_SOC_CROS_EC_CODEC selects CRYPTO_LIB_SHA256 without
depending on or selecting CRYPTO while CRYPTO_LIB_SHA256 is subordinate to
CRYPTO.

Honor the kconfig menu hierarchy to remove kconfig dependency warnings.

Fixes: 93fa0af4790a ("ASoC: cros_ec_codec: switch to library API for SHA-256")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 946a70210f49..601ea45d3ea6 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -540,6 +540,7 @@ config SND_SOC_CQ0093VC
 config SND_SOC_CROS_EC_CODEC
 	tristate "codec driver for ChromeOS EC"
 	depends on CROS_EC
+	select CRYPTO
 	select CRYPTO_LIB_SHA256
 	help
 	  If you say yes here you will get support for the
-- 
2.25.1

