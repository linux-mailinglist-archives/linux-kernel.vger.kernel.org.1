Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D672278320
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgIYIth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgIYItg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:49:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8325DC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 01:49:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so2702646wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 01:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IlWOGu61caSeoYRT7WyG/oLloBIbjO1N4nhvVBC7mNE=;
        b=uJ8JC/khJYZPpFxv5ckTXKeMcBaXe67num4gM4qocSOZJr1l6lyrJdnN5xPM0E1YVB
         8u0H9mFmMG07ZUX++hiwv5A9N9764MgcQQNEZjegt/nP5rPGsdaXo/jqfmlJOUFO/5hJ
         AWzweshbWZydtJ63TJ/BDinSkgEGEHedDFfa4dHL9pwHmhO+Gnpphsxz3QlAjDL8u6hO
         VkoJHGT7C1YtQHho9yeGBcDxmGr2KomsLO8UvyqqVNwznMWn9ubK8mChkH9E/qKpRc+9
         Cn3GlguZw1iBlI4jYc6e2xcKqRRcR4tevUJfNPxaV3NGaJTdsaB0Jlkjk3+tJHj2QqEK
         eu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IlWOGu61caSeoYRT7WyG/oLloBIbjO1N4nhvVBC7mNE=;
        b=KQp0s9zLsClgX/lxEWaarf6uwh3/+HsQBAxe29paRc1cJXEihkhZ+jtWNWK68LH4dm
         Z6tStDsC1pYK1NVXp/0FNzJv4plAvg5gmKyu23Tsy7RxtVh/+RVVMaoFjdmGZSiIg5+P
         LIB+NIJoSLinASi43YqhvwoCfO60lrnuufpDgvV0qTAiNEfaZx0gteumGRdeMG2fJ2L/
         w924Hh6NBa4niz3k++TfOQxdhCcL1kwhQNLQdjpAAZhwyN0cYYZcYH9tT8X/BX/Rvm9W
         xzsm0AX9ZSTYWt6lXOeTiFquhmvF9lKdlRRBFQiVCMAHmVB6Eyhfp7l7+2g2CFYFn8Io
         2x4w==
X-Gm-Message-State: AOAM530FPL8Wwi+ZiulEvjcltPgUQZbbUkXy3vdi6wFRK6KN8x4HfeN4
        XO/WXdJSJQrQcSCCEr24zanctQ==
X-Google-Smtp-Source: ABdhPJy9cN1jYFXrH8+KJsNFEddslJbdRN4gvdwpyB2/teUN3+XBdSj3ie3i7CfO7egVTT31ol9wrA==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr3164899wrp.332.1601023774243;
        Fri, 25 Sep 2020 01:49:34 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id u66sm2048623wme.12.2020.09.25.01.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 01:49:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] ASoC: qdsp6: fix some warnings when build without CONFIG_OF
Date:   Fri, 25 Sep 2020 09:49:23 +0100
Message-Id: <20200925084925.26926-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are fixes for two warnings types discovered while building qdsp6 drivers
without CONFIG_OF and with W=1

One of them was reported by Intel kernel test robot on q6afe-clocks patch, which
equally applies to rest of the qdsp6 drivers.

Srinivas Kandagatla (2):
  ASoC: qdsp6: Drop of_match_ptr to fix -Wunused-const-variable
  ASoC: q6asm: fix kernel doc warnings

 sound/soc/qcom/qdsp6/q6adm.c        | 2 +-
 sound/soc/qcom/qdsp6/q6afe-clocks.c | 2 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c    | 2 +-
 sound/soc/qcom/qdsp6/q6afe.c        | 2 +-
 sound/soc/qcom/qdsp6/q6asm-dai.c    | 2 +-
 sound/soc/qcom/qdsp6/q6asm.c        | 5 ++++-
 sound/soc/qcom/qdsp6/q6core.c       | 2 +-
 sound/soc/qcom/qdsp6/q6routing.c    | 2 +-
 8 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.21.0

