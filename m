Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63742CA178
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbgLALex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:34:53 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:42966 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbgLALew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:34:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 680E4FB04;
        Tue,  1 Dec 2020 12:34:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 882LQzVv8614; Tue,  1 Dec 2020 12:34:08 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id EF1524068E; Tue,  1 Dec 2020 12:34:07 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] drm/imx/dcss: Add interconnect support
Date:   Tue,  1 Dec 2020 12:34:06 +0100
Message-Id: <cover.1606822378.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to raise DRAM bandiwth to a high enough value for a
stable picture on i.mx8mq. We pick a bandwidth that should be sufficient
for 4k@60Hz.

This was tested on a Librem 5 with the (not yet) mainline mhdp DP controller.
Without that initial boot works fine but e.g. fb unblank results in a cyan
screen.

Modelled like mdp5_kms.

Guido Günther (1):
  drm/imx/dcss: Add interconnect support

 drivers/gpu/drm/imx/dcss/dcss-dev.c | 47 +++++++++++++++++++++++++++--
 drivers/gpu/drm/imx/dcss/dcss-dev.h |  3 ++
 2 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.29.2

