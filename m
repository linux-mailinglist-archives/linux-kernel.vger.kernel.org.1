Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09461FD7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 23:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgFQVqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 17:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgFQVqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:46:24 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CFAE2070A;
        Wed, 17 Jun 2020 21:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592430384;
        bh=UbiWUnRCkAGGdldl4FnZG+4FjPU7hucL7ZHTarruCGY=;
        h=Date:From:To:Cc:Subject:From;
        b=f87SYItZuGTNKJh02sXVIPBzJpsmgkahJtpOr0RouYOG8QfVe/sEaNYeO9Kvil2ch
         AXSPNMa8agohwn8Iivxu5YM4ZkLZpCOoctwMJO7/b1TrKHBEh2dMFnt4xWBdEl5ndN
         EIhPcioC/TMCpwCewUVkAQxYG9SHOmbqfINgqMas=
Date:   Wed, 17 Jun 2020 16:51:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] drm/vmwgfx: Use struct_size() helper
Message-ID: <20200617215144.GA15547@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 126f93c0b0b8..3914bfee0533 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -1969,7 +1969,7 @@ static int vmw_surface_dirty_alloc(struct vmw_resource *res)
 		num_mip = 1;
 
 	num_subres = num_layers * num_mip;
-	dirty_size = sizeof(*dirty) + num_subres * sizeof(dirty->boxes[0]);
+	dirty_size = struct_size(dirty, boxes, num_subres);
 	acc_size = ttm_round_pot(dirty_size);
 	ret = ttm_mem_global_alloc(vmw_mem_glob(res->dev_priv),
 				   acc_size, &ctx);
-- 
2.27.0

