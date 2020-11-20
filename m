Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2CB2BB388
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbgKTSft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbgKTSfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:35:48 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A247424124;
        Fri, 20 Nov 2020 18:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897348;
        bh=PfgbpPujrOUZOsNzF2s+j7V65mBZ80RT8Qxkmclb2Wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0Fy85lgYLta6AufIkRoQgYGy6PMzr4LngilrFnAmevHSkK3apoutcpRAxTmZGKiW
         nTEpcVVxPj0qFCLjMStl9etnnluCXa8H32EYw5wFrP5oiy8tvp7x2ITCxnSpUap1GW
         CWTh4uhw6Ib9v84VY/ZJhvD16d4kK06uOSYzwYoc=
Date:   Fri, 20 Nov 2020 12:35:54 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 084/141] drm/via: Fix fall-through warnings for Clang
Message-ID: <c21a588bf9e222826f6b138db91de26a2b21df33.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/via/via_irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/via/via_irq.c b/drivers/gpu/drm/via/via_irq.c
index 24cc445169e2..a3e0fb5b8671 100644
--- a/drivers/gpu/drm/via/via_irq.c
+++ b/drivers/gpu/drm/via/via_irq.c
@@ -364,6 +364,7 @@ int via_wait_irq(struct drm_device *dev, void *data, struct drm_file *file_priv)
 		irqwait->request.sequence +=
 			atomic_read(&cur_irq->irq_received);
 		irqwait->request.type &= ~_DRM_VBLANK_RELATIVE;
+		break;
 	case VIA_IRQ_ABSOLUTE:
 		break;
 	default:
-- 
2.27.0

