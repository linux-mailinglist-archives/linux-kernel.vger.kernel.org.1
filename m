Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0752BB41C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbgKTSkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:40:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731283AbgKTSkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:40:33 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83C8F24199;
        Fri, 20 Nov 2020 18:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897633;
        bh=oIjtqNLYIkTSqEv6yZBBls96BEPjwIXxLUv/qgXxB+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=czM23Dg4ah+n8l8q7M67LASBY9rWzxM+56iA+3K4dlqM9yoymjdIUHf/YjzFgEJkl
         lVRmF+KMJ5CmcVtktjoMi1D8qCZyjVcsIefsE3/lobXMkJ4i13PojEGbf/mISutYL3
         y4uMiP4rUMt7hAT4YT5gSDo6va9q3OObex3tqZEE=
Date:   Fri, 20 Nov 2020 12:40:38 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 135/141] video: fbdev: pm2fb: Fix fall-through warnings for
 Clang
Message-ID: <0eedb3972a0032da4997a2a47cf0665fbe9c56ca.1605896060.git.gustavoars@kernel.org>
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
by explicitly adding a fallthrough pseudo-keyword.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/video/fbdev/pm2fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index 0642555289e0..27893fa139b0 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -239,6 +239,7 @@ static u32 to3264(u32 timing, int bpp, int is64)
 		fallthrough;
 	case 16:
 		timing >>= 1;
+		fallthrough;
 	case 32:
 		break;
 	}
-- 
2.27.0

