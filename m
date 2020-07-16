Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94871222286
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 14:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgGPMiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 08:38:22 -0400
Received: from vps.xff.cz ([195.181.215.36]:42166 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgGPMiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1594903092; bh=qYblAUDIZRO1zNd6viLmd487utSDKXeq71xAotYuRG8=;
        h=From:To:Cc:Subject:Date:From;
        b=twsJ8dEYPvij0y+AoCQWI6o/pVtQvDIcj3LZsx/fOE5i4Z04daXViaOC8tLUCcaiM
         5hsXrmtHlJ1vhTOfwZ4apIEonmeA5qbNcz/hHec+VEJ7h4Y7GPpat90ApH78CYsxuE
         uBk1Rl0P/nqZIO7Fs0HJx0O9g+jIYUE8crInr9Zs=
From:   Ondrej Jirman <megous@megous.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>
Cc:     Ondrej Jirman <megous@megous.com>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix st7703 panel initialization failures
Date:   Thu, 16 Jul 2020 14:37:51 +0200
Message-Id: <20200716123753.3552425-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When extending the driver for xbd599 panel support I tried to do minimal
changes and keep the existing initialization timing.

It turned out that it's not good enough and the existing init sequence
is too aggressive and doesn't follow the specification. On PinePhone
panel is being powered down/up during suspend/resume and with current
timings this frequently leads to corrupted display.

This patch series fixes the problems.

The issue was reported by Samuel Holland.

Relevant screenshots from the datasheet:

  Power on timing: https://megous.com/dl/tmp/35b72e674ce0ca27.png
  Power off timing: https://megous.com/dl/tmp/dea195517106ff17.png
  More optimal reset on poweron: https://megous.com/dl/tmp/a9e5caf14e1b0dc6.png
  Less optimal reset on poweron: https://megous.com/dl/tmp/246761039283c4cf.png
  Datasheet: https://megous.com/dl/tmp/ST7703_DS_v01_20160128.pdf

Please take a look.

thank you and regards,
  Ondrej Jirman

Ondrej Jirman (2):
  drm/panel: st7703: Make the sleep exit timing match the spec
  drm/panel: st7703: Fix the power up sequence of the panel

 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 29 ++++++++++---------
 1 file changed, 15 insertions(+), 14 deletions(-)

-- 
2.27.0

