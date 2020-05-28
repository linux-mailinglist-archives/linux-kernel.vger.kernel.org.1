Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBC11E668E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 17:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404640AbgE1Pp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 11:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404511AbgE1PpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:45:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCCFC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:45:08 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r15so3697475wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RRcpe0H3lCAzNpSzTtIGdoPxExC1gnrWV04XMN1Ki5Y=;
        b=g0HFkoJKIY9iSEkgGQr+z2ngQ5RvAXjSLWxFjTtoZKt7hmDAuvtCGVOiKVewJ4rQqt
         T2/8s2EPboAsw2RPb5z3xfaPEiobgw2PMqFJ1KOvmAxxWtVsHP9U0UvlOUIuZFjX4prO
         EROm0xvcPNCKxVAQ4MY81faMt0ml8cV0vQj1lO/w0BPMLaIBrby2hr1ncD0+i5Oordpy
         EMCYu6kRDEgoyGD2TDNNS7Uc4me45W8sJuzMWwUmnF6BmQH2E+ng5a6R0eqKr6M8kiXi
         zeJapxgvsGZrHT30JbNBOTMLluxih3uG2BT13+Qk13hcumfHzLaDzvuwG3Q7yAmDOOAc
         +mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RRcpe0H3lCAzNpSzTtIGdoPxExC1gnrWV04XMN1Ki5Y=;
        b=fu/7+f++LZLkFqPI4xU9GHp0HJmb8PmrBn1xUpZDH5Zd6sVelXJgMTO9wWrRQsIVm4
         +JVgPuFYea2r6oz+YuaYxGWjRVqfsUfFT/1K8ZWmJOSBz5OEwnURqCzJ26IVN8BcheJJ
         bDtKcbdGKWUcJMl5qcZe+IpWHiCXEGz/zDmvGpNwMBhMRfSumDPaYhoruF0l0TJL8370
         rRSjaKX1C8CH8yiKfHR6owwEe+/0Fr+z77yoEnh1gizbNOmmGQVPb8/gJwJUEe/J6WbV
         HUSCvBSwRBJ0siiJUScXz1L+fIfcmeBgcI9N4u7q8CHG0ZI8naz6xUhBlQW3E4GMdMkw
         2aIQ==
X-Gm-Message-State: AOAM5308z9TlwhlxZNWKO5bScNqfqDsQuph0D/AKEUrCr8fIXuINVxy+
        Zu578jh5hwRe8j9VEMOZWp70PQ==
X-Google-Smtp-Source: ABdhPJxsoz5O8Wu+pBo3JregNWfan6WrHopy2c2n+D7n8gRcdVSFiDJEqbgTrXNos0B2dRpaa0ksxg==
X-Received: by 2002:a05:600c:2201:: with SMTP id z1mr3945929wml.70.1590680707286;
        Thu, 28 May 2020 08:45:07 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id n1sm6285650wrp.10.2020.05.28.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:45:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 0/2] regmap: provide simple bitops and use them in a driver
Date:   Thu, 28 May 2020 17:45:01 +0200
Message-Id: <20200528154503.26304-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I noticed that oftentimes I use regmap_update_bits() for simple bit
setting or clearing. In this case the fourth argument is superfluous as
it's always 0 or equal to the mask argument.

This series proposes to add simple bit operations for setting, clearing
and testing specific bits with regmap.

The second patch uses all three in a driver that got recently picked into
the net-next tree.

The patches obviously target different trees so - if you're ok with
the change itself - I propose you pick the first one into your regmap
tree for v5.8 and then I'll resend the second patch to add the first
user for these macros for v5.9.

v1 -> v2:
- convert the new macros to static inline functions

v2 -> v3:
- drop unneeded ternary operator

Bartosz Golaszewski (2):
  regmap: provide helpers for simple bit operations
  net: ethernet: mtk-star-emac: use regmap bitops

 drivers/base/regmap/regmap.c                  | 22 +++++
 drivers/net/ethernet/mediatek/mtk_star_emac.c | 80 ++++++++-----------
 include/linux/regmap.h                        | 36 +++++++++
 3 files changed, 93 insertions(+), 45 deletions(-)

-- 
2.26.1

