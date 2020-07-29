Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768932321D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 17:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgG2PpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 11:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgG2PpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:45:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374E6C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:45:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 9so3130453wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tZyrzrT0Nf0x/gyHGp8Cs5MnYb93JhfVD87ZJN1UfIU=;
        b=b+VLFMttcd/AFDxmAsi8VtfuqKDOuaZmXWDAIR/zZ4938MhI4865tTZFGExVfPlBhL
         xLVpSRa6XIhOa+/LP36WaI+2tTZ47GBE9T7gjF+py7giHDrzvkqNyJDvY8382KJNGuVp
         cCjiAw4lVH6uHGR/w6SHFGvU6rIoHbjXgKk2sNWkwv1KGUqiz/nlCfhOix6wC66nQHMS
         t4h1iSP+MVInoN7KMc6D+Rq2vTPy96OMNY9jGhFGRg/JYdivPqc9sGz2XMoh3oR4jqFs
         rnquzA/xfhfueM7cuqjDDJNQuZZUwW2IjIgGWZhDbk0px+wYgok0PiRTq86MuaEBiuo5
         GnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tZyrzrT0Nf0x/gyHGp8Cs5MnYb93JhfVD87ZJN1UfIU=;
        b=Je4YDnZ5GJJ2S+7izpKxFyuGl51qZYkZLp4Oj8TozsQqrm1Nj5Fm5JnvVzcIdqH25F
         d1Mp9dKlUBXSrlm0SIGXvS9sugCr/LFJLcidiFBewF/nwQPWa+Wj14FvXd7WjZfel8Qz
         4CD3k/zHF1CAKCkSOBHf9L45xQL1SKrehCE8Rie+JnN8vHC1ztKAGr/n80QKqf9StPZb
         1PDYoy1kpZJjEpdRlBGrhGRO9blQqJsR0avOPc5VHGmBGGyqRktbq2x7LXtOH2IjwqvU
         OpRFssSR0cf5seYz8IY4rU/446iBaTSGe/SrNkyGjyAQ1gtOExmAncoX15AxEO4PkQkm
         PCiw==
X-Gm-Message-State: AOAM531IyHLPYsFwz1zpVw8PF1uuX+OCaKEgLZh7q1fio8SQ57TgWFe5
        OC7OOUoJhsFNr95JTVHK4Zkl2w==
X-Google-Smtp-Source: ABdhPJw5uFTrnEpbYb0n1UKwvaYWnjt8taRop48MzCBBqK0z4sbTETQUcnZx4nGuZE6MZ/Ja7pWWdw==
X-Received: by 2002:a05:600c:284:: with SMTP id 4mr9474888wmk.48.1596037512993;
        Wed, 29 Jul 2020 08:45:12 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id k10sm5950967wrm.74.2020.07.29.08.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 08:45:12 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/4] ASoC: meson: tdm fixes
Date:   Wed, 29 Jul 2020 17:44:52 +0200
Message-Id: <20200729154456.1983396-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patcheset is collection of fixes for the TDM input and output the
axg audio architecture. Its fixes:
 - slave mode format setting
 - g12 and sm1 skew offset
 - tdm clock inversion
 - standard daifmt props names which don't require a specific prefix

Jerome Brunet (4):
  ASoC: meson: axg-tdm-interface: fix link fmt setup
  ASoC: meson: axg-tdmin: fix g12a skew
  ASoC: meson: axg-tdm-formatters: fix sclk inversion
  ASoC: meson: cards: remove DT_PREFIX for standard daifmt properties

 sound/soc/meson/axg-tdm-formatter.c | 11 ++++++-----
 sound/soc/meson/axg-tdm-formatter.h |  1 -
 sound/soc/meson/axg-tdm-interface.c | 26 +++++++++++++++++---------
 sound/soc/meson/axg-tdmin.c         | 16 +++++++++++++++-
 sound/soc/meson/axg-tdmout.c        |  3 ---
 sound/soc/meson/meson-card-utils.c  |  2 +-
 6 files changed, 39 insertions(+), 20 deletions(-)

-- 
2.25.4

