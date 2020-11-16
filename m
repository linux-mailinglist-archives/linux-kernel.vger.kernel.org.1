Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AB42B4CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbgKPRYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732722AbgKPRYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:24:34 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CA3C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:24:33 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so24336973wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WtMD9HUNCd7ZhC138zP7kvjxUP0uAPHZgUTaa91+Qcc=;
        b=NFxvcrQEPFkb93g/IBtJ/uRqBozR3l3vlNfcc3pD1YOP/jYIgX5hH75BkC3XJiPcKV
         GNPWB1vBbrQWhHeC+i/oychqXkOU/ddKdJPT3K5aug5fayuGyLFhdjnoEJ8LJztn+qeI
         9OTSt8sfTbVjrybvdp4TcZ2vCj3BfcutkR69qe0iHDFlqQZwMbKPVFuWhsPMKe/udgAM
         zbb0tSAxaj8ReqS+miXkzIhNk7yNw6a4R/k8U2xe5GeAnvdfbMEHlIn0EhC/T/rru/00
         UMzvzcmarWLLB1ErQmgrsr7RznPI4XAnbs47fCRvlMOk8RwzmYr6MZu/w4MIBjTFkPdi
         jkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WtMD9HUNCd7ZhC138zP7kvjxUP0uAPHZgUTaa91+Qcc=;
        b=BQ58qN0/NgPuqcKw2mUo3lffFl0W5aA0Zd/sTnQxBgdsR3tSB0weMyya+0rpLU90Ag
         cS1EpUP7ycfKgZdwyK82IQbzein/s/tpFsR/jAJh6CAPgkcQuzUeY/94lZj5B8yVtCSx
         KsSZeR/ohyFWQC5pI5s7lrmFp+k8cNU4xkXw2jIwgHJlZKUswjuO/nQ7+0FJECyVN2yM
         tpJJ5PZgq9fKghTvB658W1SaW0mwKEmshiACPwVtMvsNMzdpVcuq7zYeybOH5KI7Wcjy
         xLq0zbaNynXtmdU3aI5xrQkEml4eas2SVMDj+7rwiJyXEc/1rI7/G1o5aP0UFn4W5YST
         hUAw==
X-Gm-Message-State: AOAM5314XTItIMBN8+3Di36zouw+27yfkvEq7bmQE3fgsi2WfKDDNBEN
        affX5Oe3m9HqJy34jyhFetN9ew==
X-Google-Smtp-Source: ABdhPJzR+k3v4Mwybe0vCGdYqAqSGoEIjkYxAtsoASKSWzdNHfe23t1SJRHTenco765aUJ4maCS1dQ==
X-Received: by 2002:a05:600c:209:: with SMTP id 9mr16522232wmi.89.1605547472634;
        Mon, 16 Nov 2020 09:24:32 -0800 (PST)
Received: from starbuck.lan (253.35.17.109.rev.sfr.net. [109.17.35.253])
        by smtp.googlemail.com with ESMTPSA id 34sm24128949wrq.27.2020.11.16.09.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:24:32 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: meson: fix COMPILE_TEST error
Date:   Mon, 16 Nov 2020 18:24:23 +0100
Message-Id: <20201116172423.546855-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiled with CONFIG_HAVE_CLK, the kernel need to get provider for the
clock API. This is usually selected by the platform and the sound drivers
should not really care about this. However COMPILE_TEST is special and the
platform required may not have been selected, leading to this type of
error:

> aiu-encoder-spdif.c:(.text+0x3a0): undefined reference to `clk_set_parent'

Since we need a sane provider of the API with COMPILE_TEST, depends on
COMMON_CLK.

Fixes: 6dc4fa179fb8 ("ASoC: meson: add axg fifo base driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 363dc3b1bbe4..ce0cbdc69b2e 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "ASoC support for Amlogic platforms"
-	depends on ARCH_MESON || COMPILE_TEST
+	depends on ARCH_MESON || (COMPILE_TEST && COMMON_CLK)
 
 config SND_MESON_AIU
 	tristate "Amlogic AIU"
-- 
2.28.0

