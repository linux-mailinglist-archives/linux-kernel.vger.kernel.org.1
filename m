Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD9426A57A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgIOMqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:46:01 -0400
Received: from crapouillou.net ([89.234.176.41]:32886 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgIOMih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1600173511; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=5k3SI0i4lxTO6Wjvdny6VfQmiflb4xroZDyrQUaQu38=;
        b=MAe072MnmRc0bo/M+K3jH+OSnVJCwIj6qEq7Pm7jJMvrnoZB5G7UlNAQVo4stT/qlL0yNv
        HbUcp4hWjJRG0pHAY/tGd61ORRmhKPFw/96/RtSkRlKkpjTxxlWo94HNfUCe4UuLw0lvUP
        QmGzvs8evBkPScC/uMUQbolID43WggY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/3] Small improvements to ingenic-drm
Date:   Tue, 15 Sep 2020 14:38:15 +0200
Message-Id: <20200915123818.13272-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are three improvements to the ingenic-drm driver.

Patch 1 adds 30-bit RGB support for the SoCs that support it. Not much
to see here.

Patch 2 is here to allow the pixel clock to be re-set when the SoC's
main PLL changes, which can happen at any time. We get a callback before
and after the PLL clock rate is changed, which allows the ingenic-drm
driver to synchronize the clock rate update with vblank. The
synchronization mechanism is implemented with a mutex. I am not sure it
is the best solution, there may be something better/simpler to do here,
but in practice it works just fine.

Patch 3 adds support for using a reserved memory area as storage space
for GEM buffers. On memory-constrained devices, it is hard to find
contiguous space even for a small 320x240 buffer, and sometimes dumb
buffer allocation from userspace fails with -ENOMEM. Using a reserved
memory area makes sure that there will always be space for our GEM
buffers (provided they fit in the memory area).

Cheers,
-Paul

Paul Cercueil (3):
  drm/ingenic: Add support for 30-bit modes
  drm/ingenic: Reset pixclock rate when parent clock rate changes
  drm/ingenic: Add support for reserved memory

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 109 +++++++++++++++++++---
 drivers/gpu/drm/ingenic/ingenic-drm.h     |   1 +
 2 files changed, 99 insertions(+), 11 deletions(-)

-- 
2.28.0

