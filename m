Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5570B2A1CE3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 10:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgKAJcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 04:32:16 -0500
Received: from aposti.net ([89.234.176.197]:38572 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgKAJcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 04:32:15 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Christophe Branchereau <cbranchereau@gmail.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/3] drm/panel: ABT Y030XX067A panel support
Date:   Sun,  1 Nov 2020 09:31:46 +0000
Message-Id: <20201101093150.8071-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset is for adding support for the Asia Better Technology (aka.
ABT) Y030XX067A 3.0" 320x480 24-bit LCD IPS panel.

While being 320x480 it is actually 4:3 with non-square pixels, and
requires a specific bus format, as the pixel ordering changes each line
(RGB on odd lines, GRB on even lines).

Patch #1 adds the abt,* vendor prefix.
Patch #2 adds the abt,y030xx067a panel binding documentation.
Patch #3 adds the MEDIA_BUS_FMT_RGB888_3X8_DELTA media bus format.
Patch #4 adds the driver itself.

Cheers,
-Paul

Paul Cercueil (4):
  dt-bindings: vendor-prefixes: Add abt vendor prefix
  dt-bindings: display: Add ABT Y030XX067A panel bindings
  media: uapi: Add MEDIA_BUS_FMT_RGB888_3X8_DELTA media bus format
  drm/panel: Add ABT Y030XX067A 3.0" 320x480 panel

 .../display/panel/abt,y030xx067a.yaml         |  54 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-abt-y030xx067a.c  | 363 ++++++++++++++++++
 include/uapi/linux/media-bus-format.h         |   3 +-
 6 files changed, 431 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-abt-y030xx067a.c

-- 
2.28.0

