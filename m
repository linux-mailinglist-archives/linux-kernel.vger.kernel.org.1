Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DF12B12FA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgKMAF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMAF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:05:57 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D51C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:05:57 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so7877505wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=M/DNdhVAn+pj9y0xoI33n3R+K7GRe7kKavsf/Ah+nsk=;
        b=m0sxsIVG0ByZVmnxTxIO4wIiaZWWiqYENqL3CB0KdB+j6i07uxTXviGjJvMzBwHeTk
         be2JfgfJIsjWv6Sf8F6KATPB5wwYmLWqrw9nHdbZp43P/NAp/5kbiqINpmM3W1SuIINj
         Noa0/opEJVYol7p//o/y8VXhdSS9vKRIy9pI6bI0jL7SLj8ls9b3hgtck4FEcSaLXKfg
         JlS5yg89JjEBKnVOU0ojtvvss9N+42CGN3i4Mg/O45gW0R9sAVCZy2jSR3Imm6lPuHQY
         OqXu+glLJw0TbiR9tKPVEbNBTdsDV+034/11gpT0+WpXn103N1P62oAiXMtvCNTEQhy0
         nF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M/DNdhVAn+pj9y0xoI33n3R+K7GRe7kKavsf/Ah+nsk=;
        b=LRS67MX5i++lrGftX3UR65oImb6pSDMVpzzysKdOFpuVJuQ23CRtItF7vY85f/RNHR
         aoJuyG+lCZbT1xZNA/Ja860sfKtMEpfRqyW8TvmrUjl1LTO+CFoN4633CP90OaEq0SUF
         /nlRWdEFGZBe9BfnsJTax3/VdGd3aVfIND5jAl+cZ7cf+vEJ7x4ZdogwnYIef1aJFkAK
         duEX2VroOyT8971jIyDUhT6kgSM/8jJ0IEZ+h81hspHQ+DXz3VPV3QOfYzEDqYeFU4EA
         MlzXr1Lk9nxfQ7fjil2NJ5s+OiaXIuZv7X4DQzXE6pJx7BX++UMWses3QMbCKe5e/sXK
         y5bg==
X-Gm-Message-State: AOAM5319FTFbYLlSa34IpwkKBL0CJfCBPvYkD+GgU87xCdE53C7GL1F9
        AurYChIxKdXrbhgwxWIVRRSHPg==
X-Google-Smtp-Source: ABdhPJyOfMhgxUx1TQm9cSxUD6UDuhp2p0OWAe5n5ufvbYsNNIbvJu1hetzgvu2L4r0uzBW0o4MSgQ==
X-Received: by 2002:a5d:4e07:: with SMTP id p7mr2397929wrt.63.1605225955746;
        Thu, 12 Nov 2020 16:05:55 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3a84:7260:5d3c:83d5:8524:33ca])
        by smtp.googlemail.com with ESMTPSA id t11sm2010114wrm.8.2020.11.12.16.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:05:54 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Felipe Balbi <balbi@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 0/3] usb: meson: fix shared reset control use
Date:   Fri, 13 Nov 2020 01:05:05 +0100
Message-Id: <20201113000508.14702-1-aouledameur@baylibre.com>
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

Important:
Please DO NOT merge before this patch [0] is merged, it adds 
reset_control_rearm() call to the reset framework API.

[0] https://lore.kernel.org/lkml/20201112230043.28987-1-aouledameur@baylib
re.com/

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

