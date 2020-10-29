Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DA729E039
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbgJ2BL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729861AbgJ2BL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:11:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAD8C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:11:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e7so923221pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r/vYYV4pGoOTF3hMwE2gN8D0uweBjVLcgDkmz3bxrLc=;
        b=fgXKF0zM65tAhB9vfAzvt1kqnqx/6ppMtb+Z/+3y4bq+jGFJQV9v0cm+af6TjYNjXR
         OGq+trBivjMWysPDumAWZa4FD0U3r3cnG4VrvI05GQgJg6NAEJ0K9dbrRrF4w6AWJfch
         nb9/7AtAeaT4PBQJrK8hkf65x4o4D4KR1Do/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r/vYYV4pGoOTF3hMwE2gN8D0uweBjVLcgDkmz3bxrLc=;
        b=WWc4DkzrlBz7QmiaE2vle314ZEEtt+2dPRG5qKqsVdmO8xWYOHsQX+dPzJ7DRN3qm9
         03zO1UhBS5em3O1vkWGAN1roMZbAO9Rq5ISiTWJcRSyE2Je/MOaRUjdyej7DHP86cm9p
         nODZ7IJiEuzcFEBcF+yuX9tkFnHwqY8H6RVa3FSroQQmtd6Oy1zd+r7hh2OpJwVad3VI
         7PEUCSw4wsCxtj9cclTjYzaaNi3y2rSgmTq2Lme5/yd+3uBhngfee5eYVQk0DIC5638K
         39KVcVoEa9ZafwJbDIH3WaVadkdrtl/AhWAgFfa4IxNrBEJfLW3v2QijLyQE34q+tF+S
         OFyQ==
X-Gm-Message-State: AOAM532cW138NAHeEo38xkMW8tO2Gy6ZERb0nWL3WlIIUFoAaBivuF4t
        ya6uhjo9ntI5uIaDCnfoU2K6pg==
X-Google-Smtp-Source: ABdhPJwmBz/QFu0/rYf71BR9hlr1nzZuuJniIcvv+FkgSAPG2JQqgpTxF3NIK8nxhcfyFb7DWUe/gw==
X-Received: by 2002:a17:90a:a394:: with SMTP id x20mr1568689pjp.213.1603933916318;
        Wed, 28 Oct 2020 18:11:56 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id e6sm781769pfn.190.2020.10.28.18.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 18:11:55 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 0/4] drm/bridge: ti-sn65dsi86: Support EDID reading
Date:   Wed, 28 Oct 2020 18:11:50 -0700
Message-Id: <20201029011154.1515687-1-swboyd@chromium.org>
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

I was thinking about making a patch to update the drm bridge connector
code to fallback to using the DDC of the bridge if it's available. Does
that code already exist? It would be nice to not even have to implement
the bridge func get_edid() function in the future if the DDC is
implemented and we're using the new bridge connector code.

Stephen Boyd (4):
  drm/bridge: ti-sn65dsi86: Combine register accesses in
    ti_sn_aux_transfer()
  drm/bridge: ti-sn65dsi86: Make polling a busy loop
  drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
  drm/bridge: ti-sn65dsi86: Update reply on aux failures

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 101 ++++++++++++++++++--------
 1 file changed, 69 insertions(+), 32 deletions(-)

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Sean Paul <seanpaul@chromium.org>

base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
Sent by a computer, using git, on the internet

