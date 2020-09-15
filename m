Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CC626A502
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgIOMWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgIOMTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:19:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E443FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:19:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l15so7974560wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l7j+GFEPl0J4mVX0J38jo856GeX7L/pIGsyfYoimqNU=;
        b=d5I5Am+iX/ZTlLBaMLVhIOLDVSNJtj0O2dwF8Ftj0bg09cKrSTyi9V8g45XOxGznvn
         vAwfpzCkmcX+e1qI3igNUjzoFxbWxUYP7C4mcWoPmPepGPyX3vZDdWrB3x6LIKL1NZyP
         Z4tS+WrUE+6Don7+EdPT8qRc+DL5uaYKhCpYyJ8BBeJSJTC4GhNop2Ca4EhuXoLw+Mkt
         H6L5xg53j4yjOdnP4iS1uQi/yt/yG7gfuHgM1wWAW3JqNrGcuKzy0vZEihmq4HTfTI8g
         qqpataXcDG82Cb05rb1emLdp8ao1EYm7pWbgIGGdC4AT8MEEXW4c4hjEnEO7u9ZsVQ1M
         DtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l7j+GFEPl0J4mVX0J38jo856GeX7L/pIGsyfYoimqNU=;
        b=cfNr7lZI9oL3UjmQig+pRPP1lNBEqOwCyZMCkW20r9aJbT/SAPr0CgOBd9VwuLlPal
         18b7TpypS8XZGFjFnuQpIv0KnS2xeTG6ClXCw+rgYPqg5i2tDdeYMELHJ9cJ9sLH0o1m
         3B9QlZNqJkkJDPASjNtjA3l3l9VzXQM1i33x/teDDOSJRc9396jdyWFezGPnv1TlXlFt
         YLWafYrI2GAnknXFjI1fMv9crlhJXcKvAOZ1opnX0bsyRhyjzFBO1h8G+8gwIxMuW02u
         +3oLPut5+lqhVc9t8YjCSim2H1shd5B0hEEv8ZvJEsf2KbpfCsszlLddZTdVyJ0anCXd
         ZzyA==
X-Gm-Message-State: AOAM533xEjgsvETPYqjPhCBVgda8Wjn8aJND7P1zfrurMnORLNsVusBA
        HYJ/q6DtMmBCMlp0/oFDcHOcJg==
X-Google-Smtp-Source: ABdhPJx+fzoFxjgYAof+zD34bBVjkkA+EoKo8hnXGiQSj5VtzW/TKrSu3SuFbMpSSfocHxWxCJTiHg==
X-Received: by 2002:a7b:c255:: with SMTP id b21mr4330660wmj.17.1600172356440;
        Tue, 15 Sep 2020 05:19:16 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id 2sm18271411wmf.25.2020.09.15.05.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 05:19:15 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 0/4] drm: panel: add support for TDO tl070wsh30 panel
Date:   Tue, 15 Sep 2020 14:19:08 +0200
Message-Id: <20200915121912.4347-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support bindings and support for the TDO TL070WSH30 TFT-LCD panel
module shipped with the Amlogic S400 Development Kit.
The panel has a 1024×600 resolution and uses 24 bit RGB per pixel.
It provides a MIPI DSI interface to the host, a built-in LED backlight
and touch controller.

Changes since v3 at [3]:
- reordered tdo vendor prefix

Changes since v2 at [2]:
- added reset gpio to panel-simple-dsi bindings
- moved bindings to panel-simple
- re-ordered prepare/unprepare
- added back refresh print
- moved regulator/reset handling in prepare/unprepare
- aligned remove/shutdown with panel-simple
- added sentinel comment into dt match table

Changes since v1 at [1]:
- added missing vendor-prefixes patch
- removed vrefresh
- fixed warning on add_panel return
- removed DRM logging

[1] https://patchwork.freedesktop.org/series/81376/#rev1
[2] https://patchwork.freedesktop.org/series/81376/#rev2
[3] https://patchwork.freedesktop.org/series/81376/#rev3

Neil Armstrong (4):
  dt-bindings: vendor-prefixes: Add Shanghai Top Display
    Optolelectronics vendor prefix
  dt-bindings: display: panel-simple-dsi: add optional reset gpio
  dt-bindings: display: panel-simple-dsi: add TDO TL070WSH30 DSI panel
    bindings
  drm: panel: add TDO tl070wsh30 panel driver

 .../display/panel/panel-simple-dsi.yaml       |   3 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c  | 250 ++++++++++++++++++
 5 files changed, 267 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c

-- 
2.22.0

