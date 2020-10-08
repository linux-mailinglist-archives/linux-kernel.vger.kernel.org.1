Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE31287E8B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 00:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgJHWNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 18:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgJHWNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 18:13:19 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC8A22241;
        Thu,  8 Oct 2020 22:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602195199;
        bh=QwC/kxxkaru98nLEFoJk/4mhtYf+gyr8z3Rnw7Q/3Q8=;
        h=Date:From:To:Cc:Subject:From;
        b=PsCHVunq6rzcCfkb6KsoAbgWbosMsjvZIUnlSgnXksbycIEKwOU0aBvtgicRJMZsz
         2/NZwBxKr75b48N/nUFfsKkilDl0c9+2B/yNDUurNIwu/TKrhmGMe0biIg3EOwacva
         RUfKfSXB5m6uclm4GlssXSIZvPQubV9ImgvrFWBU=
Date:   Thu, 8 Oct 2020 17:18:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/i915/display: Use fallthrough pseudo-keyword
Message-ID: <20201008221842.GA9463@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to enable -Wimplicit-fallthrough for Clang[1], replace the
existing /* fall through */ comments with the new pseudo-keyword
macro fallthrough[2].

[1] https://git.kernel.org/linus/e2079e93f562c7f7a030eb7642017ee5eabaaa10
[2] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 4d06178cd76c..2941051ac3e1 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -1090,7 +1090,7 @@ ehl_get_combo_buf_trans(struct intel_encoder *encoder, int type, int rate,
 				return icl_combo_phy_ddi_translations_edp_hbr2;
 			}
 		}
-		/* fall through */
+		fallthrough;
 	default:
 		/* All combo DP and eDP ports that do not support low_vswing */
 		*n_entries = ARRAY_SIZE(ehl_combo_phy_ddi_translations_dp);
@@ -1126,7 +1126,7 @@ tgl_get_combo_buf_trans(struct intel_encoder *encoder, int type, int rate,
 			*n_entries = ARRAY_SIZE(icl_combo_phy_ddi_translations_edp_hbr2);
 			return icl_combo_phy_ddi_translations_edp_hbr2;
 		}
-		/* fall through */
+		fallthrough;
 	default:
 		/* All combo DP and eDP ports that do not support low_vswing */
 		if (rate > 270000) {
-- 
2.27.0

