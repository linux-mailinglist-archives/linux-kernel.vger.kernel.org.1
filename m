Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA9625EF10
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgIFQWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 12:22:37 -0400
Received: from gw.c-home.cz ([89.24.150.100]:41973 "EHLO dmz.c-home.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbgIFQW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 12:22:28 -0400
Received: from ubuntu1804.c-home.cz (unifi.c-home.cz [192.168.1.239])
        by dmz.c-home.cz (8.14.4+Sun/8.14.4) with ESMTP id 086GLoct011279;
        Sun, 6 Sep 2020 18:21:55 +0200 (CEST)
From:   Martin Cerveny <m.cerveny@computer.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Martin Cerveny <m.cerveny@computer.org>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/sun4i: sun8i-csc: Secondary CSC register correction
Date:   Sun,  6 Sep 2020 18:21:38 +0200
Message-Id: <20200906162140.5584-1-m.cerveny@computer.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The secondary video layer (VI) on "Allwinner V3s" displays
decoded video (YUV) in wrong colors. The secondary
CSC should be programmed. 
Let's correct CSC register offset and extend regmap size.

Regards.

Martin Cerveny (2):
  drm/sun4i: sun8i-csc: Secondary CSC register correction
  drm/sun4i: mixer: Extend regmap max_register

 drivers/gpu/drm/sun4i/sun8i_csc.h   | 2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

