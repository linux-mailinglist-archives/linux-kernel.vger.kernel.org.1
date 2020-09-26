Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C428279B1D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgIZRFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:05:11 -0400
Received: from crapouillou.net ([89.234.176.41]:38492 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgIZRFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1601139908; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=kXsmVIEyF09DDOALmG2G0CJL3flbnplebaqT/U8aoTw=;
        b=C+lnivDr7Enp2bKqnFAXdhQMPXxKZV7hoolH/+McifTHbKrTrP13M0HhfZTc5unwWK1YAb
        fMkxdyOGZoDxPrDY9PIM59bztuuE0x4D4CcaeN+hPdEBdEZ/+iEKNuKK3N9zgrPq+w4Dl6
        c+s+womc3BXuwTwQWU4TxTNIIIolDv0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 0/7] Ingenic-drm improvements + new pixel formats
Date:   Sat, 26 Sep 2020 19:04:54 +0200
Message-Id: <20200926170501.1109197-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a V2 of my small patchset "Small improvements to ingenic-drm"
that I sent about two weeks ago. In that time, I worked on new
improvements, so I thought I'd just add them to the patchset, since
I needed a V2 anyway.

Sam: the patches you acked have been all slightly modified, I kept your
acked-by on them, please tell me if that's OK.

Cheers,
-Paul

Paul Cercueil (7):
  drm/ingenic: Reset pixclock rate when parent clock rate changes
  drm/ingenic: Add support for reserved memory
  drm/ingenic: Alloc F0 and F1 DMA descriptors at once
  drm/ingenic: Support handling different pixel formats in F0/F1 planes
  drm/ingenic: Add support for paletted 8bpp
  drm/ingenic: Add support for 30-bit modes
  drm/ingenic: Add support for 24-bit modes

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 262 +++++++++++++++++++---
 drivers/gpu/drm/ingenic/ingenic-drm.h     |   3 +
 2 files changed, 228 insertions(+), 37 deletions(-)

-- 
2.28.0

