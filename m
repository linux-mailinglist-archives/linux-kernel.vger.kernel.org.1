Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDD12DA918
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgLOIYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:24:23 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:57342 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgLOIYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:24:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 97FCCFB04;
        Tue, 15 Dec 2020 09:23:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lrgQtBwn5rT4; Tue, 15 Dec 2020 09:23:39 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 90C2A43FDF; Tue, 15 Dec 2020 09:23:38 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] drm: mxsfb: Silence -EPROBE_DEFER while waiting for bridge
Date:   Tue, 15 Dec 2020 09:23:37 +0100
Message-Id: <cover.1608020391.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can take multiple iterations until all components for an attached DSI
bridge are up leading to several:

[    3.796425] mxsfb 30320000.lcd-controller: Cannot connect bridge: -517
[    3.816952] mxsfb 30320000.lcd-controller: [drm:mxsfb_probe [mxsfb]] *ERROR* failed to attach bridge: -517

Silence this by checking for -EPROBE_DEFER and using dev_err_probe() so
we set a deferred reason in case a dependency fails to probe (which
quickly happens on small config/DT changes due to the rather long probe
chain which can include bridges, phys, panels, backights, leds, etc.).

This also removes the only DRM_DEV_ERROR() usage, the rest of the driver
uses dev_err().

Guido Günther (1):
  drm: mxsfb: Silence -EPROBE_DEFER while waiting for bridge

 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.29.2

