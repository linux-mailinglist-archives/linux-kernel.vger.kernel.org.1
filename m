Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F4529FA6C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgJ3BRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ3BRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:17:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73692C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:17:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k9so2108059pgt.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FioZFECWhpMnOGSDAS2R3NaknMAa9nER8bJXAhJQBW4=;
        b=LF0qBgSqyOAdwoCw4HGwLBGbAKla795/60rA/xKxOw4+v4jZtTsZbsubQAe5zD4mu6
         6PaMtQV4qnNkO65SeXt3bF/aAisUj+jlH7mapeduBruhKv5kLek9Mt9cBfT2wx3kwVpA
         PW5hoi2oiEaj39wDvLx6mW4gqiCwvE4Cbn6kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FioZFECWhpMnOGSDAS2R3NaknMAa9nER8bJXAhJQBW4=;
        b=EHDORJx9sExdt/ESdeOHpwiRwzubFwQD6Kii3wSwjsu+LfdDe+prq1IrMyftZud+73
         Pt0aI9hbm7qGuBVRcEHtg3rK/7/rkTOS9lfcDi/llA1ka/iT2Cndesisu/5parCVzfsP
         Rs9sGho5tRb5k2jFFLF9fI/YnmUwVeTnwzWLsKvFwUjJVhBasdmORgMooOQX8gKaee7V
         x03+VDQM7LxPuyPInsXzhSkO9yHqHwX7AjybCDtwAOjBtIA36ns0ZBcymZfYU0njMquU
         JeTJcWj3hXjWcqQ+1baE82ikgx2lqBXSHDZJgnWLPBx4jrwUzFPdlSwXACrLHgYT93d6
         pnkQ==
X-Gm-Message-State: AOAM530niPSHVDLjFKWZqGMn9piMhA5xeBvo+RY5cJvRoY0yp8dqjKoZ
        lzrvFBUb1S7ZIk5I6yM4+MnDUQ==
X-Google-Smtp-Source: ABdhPJwBHzI5I3chnI4NyFlttCDjWMUUT6FUuVSNqVWqoWbDON4rdwj8TYB7dKYjI+F1OUUtg5kXAg==
X-Received: by 2002:a63:f14:: with SMTP id e20mr50078pgl.52.1604020660981;
        Thu, 29 Oct 2020 18:17:40 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z26sm4477854pfq.131.2020.10.29.18.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 18:17:40 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH v2 0/4] drm/bridge: ti-sn65dsi86: Support EDID reading
Date:   Thu, 29 Oct 2020 18:17:34 -0700
Message-Id: <20201030011738.2028313-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series cleans up the DDC code a little bit so that
it is more efficient time wise and supports grabbing the EDID
of the eDP panel over the aux channel. I timed this on a board
I have on my desk and it takes about 20ms to grab the EDID out
of the panel and make sure it is valid.

The first two patches seem less controversial so I stuck them at
the beginning. The third patch does the EDID reading and caches
it so we don't have to keep grabbing it over and over again. And
finally the last patch updates the reply field so that short
reads and nacks over the channel are reflected properly instead of
treating them as some sort of error that can't be discerned.

Stephen Boyd (4):
  drm/bridge: ti-sn65dsi86: Combine register accesses in
    ti_sn_aux_transfer()
  drm/bridge: ti-sn65dsi86: Make polling a busy loop
  drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
  drm/bridge: ti-sn65dsi86: Update reply on aux failures

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 108 ++++++++++++++++++--------
 1 file changed, 75 insertions(+), 33 deletions(-)

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Sean Paul <seanpaul@chromium.org>

base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
Sent by a computer, using git, on the internet

