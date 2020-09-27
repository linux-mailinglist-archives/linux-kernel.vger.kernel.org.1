Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CD827A2D4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgI0Tgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:36:55 -0400
Received: from crapouillou.net ([89.234.176.41]:49820 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgI0Tgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1601235412; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=pavLK66rhjuKcvqnQT7C0OY+j32Kq1CGYnAD9KagotU=;
        b=Jj/gSxqdoFuSPtt00AcnTahEMQfhDEpggOzgqfre4KdDqaD9hzZbRk7XmWWPitC9ymKHA4
        I7CXNSZrsP7hCpNK7Xo3We9dHeweg04PjKvBHmH99xICiclnUJF3rzpKipRJOC1TzwGpcM
        aaScW39ArvUYdbNckYmBFE8WOYnGAzU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 0/1] 8bpp support for Ingenic-drm
Date:   Sun, 27 Sep 2020 21:36:44 +0200
Message-Id: <20200927193645.262612-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Final (?) version of my "small improvements to ingenic-drm" patchset.

Most of the patches of V2 have been merged to drm-misc-next, except this
one which required some more work.

In the CRTC's .atomic_check callback, the size of the gamma LUT property
is now checked, so that only a complete 256-entry palette is accepted.

Cheers,
-Paul

Paul Cercueil (1):
  drm/ingenic: Add support for paletted 8bpp

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 66 +++++++++++++++++++++--
 1 file changed, 62 insertions(+), 4 deletions(-)

-- 
2.28.0

