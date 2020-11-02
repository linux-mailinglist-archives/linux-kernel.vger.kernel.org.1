Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2552A3294
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgKBSLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBSLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:11:47 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5805CC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 10:11:47 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id o3so11452164pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 10:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mKswq1EcQgawu6pr6GZR0kttWxeflecqxlBNI4Tvcs=;
        b=Umy+fG4ASnzoA6nohdwI4QpXNeVaQfmLP+bhI1tuoNFZh6aqJ2DWxVvSVoAKTO7IZA
         gFSUARhs7Eo18H1nhgRaONFTdXED+o0E58W218F/VcDbpD72f7RaYB4582uqROy2zoLh
         W0F8pzmodFpQPln9JDyqcfeovGLTLq6oJsHsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mKswq1EcQgawu6pr6GZR0kttWxeflecqxlBNI4Tvcs=;
        b=UuX4Jjj7zzeQ/QAnAU8w5NZTsdvJshoR2Evr6mXzIAzds3ndbgl0edXR1s7mFiZxW0
         zNUlLI/HF/uxmPPhEOfKOIhft3SFGegSTGnzHXrbTdIONGepBPD3k+5Kq4nNg2HwrH2o
         fd80tD/WSPDsEfoSZiCRCQBmQFikMFUrS3+H6KVLD7M00bVCcw0JgiR4O6V9u9TST4dB
         yjzOscUIri3WMiyF1WkU9FXZYMnWqsAE2xaIJFXxJy4tVpSmebdNtOGfsTnjv9UWui/L
         Dona5x+NoTOFpDYQXBYHTJM64qeHkuPG+Q7bF7N/a+2xmDl13BGVYTbNtY4OJ1j3OXZU
         RkwA==
X-Gm-Message-State: AOAM533nCHHbcS5Nzt0MoqNKtvIbCQUKUpRPeRtUD70temv94+yyClLF
        vwfrB7BGdUO6G9cLjwY851cQzw==
X-Google-Smtp-Source: ABdhPJzz+yYdn92n7Vwuhp6X6hWBm6B93LUR1QT/i1SP+y9OKejWJfRWPWKq34KEdgPelLNEeW5wMg==
X-Received: by 2002:a17:90a:5d11:: with SMTP id s17mr17500721pji.107.1604340706897;
        Mon, 02 Nov 2020 10:11:46 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id b17sm13175640pgb.94.2020.11.02.10.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:11:46 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH v3 0/4] drm/bridge: ti-sn65dsi86: Support EDID reading
Date:   Mon,  2 Nov 2020 10:11:40 -0800
Message-Id: <20201102181144.3469197-1-swboyd@chromium.org>
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

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 103 ++++++++++++++++++--------
 1 file changed, 71 insertions(+), 32 deletions(-)

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Sean Paul <seanpaul@chromium.org>

base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
Sent by a computer, using git, on the internet

