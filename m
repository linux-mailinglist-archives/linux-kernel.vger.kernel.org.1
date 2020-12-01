Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712022CAB47
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbgLATCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgLATCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:02:02 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49742C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:01:16 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so4398850wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/1A6J8+RLm48YTOJpb4QYlNWmGZ+O1jQHGeFKlJp25E=;
        b=B1YbjTRs0XanOUXyptXmsSZgYuC0HYufuUpXd8zqOe++qesS/YgUcyLhMnO95l0/jY
         m5V/NfzEp+QU646WKFfyDzTLXFMHupEBMA5zakBS+BRlH39R8iftWau51PXfJuY8910A
         q2FAXCBd5OvfaccCBE9m7Djqch6c9+feQaqxinW7u8DXkoOJtdFMc4YQxAFa0ree5Lex
         byWEqt5vgTtCUIMeKJ3hVZCqHUJ0US44fMcfJ6KJzYer5EGd2hUQAh0oKiZinjWubnkf
         tUIPdGNAPeXmodiRRAvJbEppk/GhzeMWkz06i6suzUdwCwJShpulXqok/iSUf5sfbwzY
         ndfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/1A6J8+RLm48YTOJpb4QYlNWmGZ+O1jQHGeFKlJp25E=;
        b=fgvMNqaJwazCBqxatq+7ONspUoGf8D++a3uUasvTtNA2NA2Bx8/Emfo5OA/Ol3SI8u
         Wl4vJBUMmEafuGvDpV4syuOkAdTWr8KEU7GggvpoEOJy3/Rnq9Znn+tMfJNIqsYFvwc4
         e54fhUoeoNqfjFdj/EVXOJ0uYbC+0LlRquBdwK4Yi/1mkqu5fevWGelHJQvIDcPv7wFV
         XLw5O98rq4msIILytHFWyLeHQLYhCayAu9Sur08+8fj1dwhGZ+JZgd7Pa18ixdEJfb42
         B/2fzC7+YRsetCiM7/XWlZ33Ns42W4LO7xfY9tBCblqQYLTzHUzolj5015cCC9hxEoiY
         9+1w==
X-Gm-Message-State: AOAM533JCdF85TupkY48PHXtv7CvU2nTieEatpIB1SPHVzdEnjIHbRLy
        GOsl6NzkPWe0oqBKUeViUrVnipRytIr0dQ==
X-Google-Smtp-Source: ABdhPJwSaBnvIOnpi6UID0dW6tSRk/e9h+ZqxfJb2aCutgMj/Terhs6TB0VH6S2ZP2VNPaeNnVHakA==
X-Received: by 2002:a5d:50c6:: with SMTP id f6mr5857607wrt.150.1606849275001;
        Tue, 01 Dec 2020 11:01:15 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3a84:7260:40a4:a590:1da6:9599])
        by smtp.googlemail.com with ESMTPSA id 138sm887733wma.41.2020.12.01.11.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:01:14 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Felipe Balbi <balbi@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 0/3] usb: meson: fix shared reset control use
Date:   Tue,  1 Dec 2020 20:00:57 +0100
Message-Id: <20201201190100.17831-1-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes a usb suspend warning seen on the libretech-cc by
using reset_control_rearm() call of the reset framework API. 
This call allows a reset consummer to release the reset line even when 
just triggered so that it may be triggered again by other reset
consummers.

reset_control_(de)assert() calls are called, in some meson usb drivers, 
on a shared reset line when reset_control_reset has been used. This is not
allowed by the reset framework.

Finally the meson usb drivers are updated to use this new call, which
solves the suspend issue addressed by the previous reverted 
commit 7a410953d1fb ("usb: dwc3: meson-g12a: fix shared reset control
use").

changes since v1: [1]
* Moved reset_control_rearm after clk_disable_unprepare to clean things up
in reverse order of initialization for phy: amlogic: meson drivers

IMPORTANT:
This patchset depends on this patch [2], it adds reset_control_rearm() call
to the reset framework API, it has been approved by the maintainer, and
will be applied to reset/next

There is currently an immutable branch with it [3]

[1]: https://lore.kernel.org/lkml/20201113000508.14702-1-aouledameur@baylib
re.com/
[2]: https://lore.kernel.org/lkml/20201112230043.28987-1-aouledameur@baylib
re.com/
[3]: git://git.pengutronix.de/git/pza/linux.git reset/shared-retrigger

Amjad Ouled-Ameur (3):
  phy: amlogic: phy-meson-gxl-usb2: fix shared reset controller use
  usb: dwc3: meson-g12a: fix shared reset control use
  phy: amlogic: meson8b-usb2: fix shared reset control use

 drivers/phy/amlogic/phy-meson-gxl-usb2.c |  5 ++++-
 drivers/phy/amlogic/phy-meson8b-usb2.c   |  4 ++++
 drivers/usb/dwc3/dwc3-meson-g12a.c       | 19 +++++++++++++------
 3 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.17.1

