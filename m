Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F072BB35A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbgKTSdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:33:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729989AbgKTSdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:33:03 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 671B022D0A;
        Fri, 20 Nov 2020 18:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897183;
        bh=Kj+C3AWC82Ljnbw9FQvL0bd9o6izQR/2jI0WIqEzQ7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sN1pHIIKph4Bv/m7CbrCmbbZTOnQeMXM77WsY/mG2nNqGVtuM+OyvhUNpNuc0ZJlP
         5ZgFfKyrb09wC8LUBDg26stn4WT5yp6GpvMMVt2D/BX1OqI97bXBq0zyuZqDsiqNzS
         z7ejA6+DrZpyhBB/0t7Za8D9QFeCJBvxQCntv63s=
Date:   Fri, 20 Nov 2020 12:33:08 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 059/141] regulator: as3722: Fix fall-through warnings for
 Clang
Message-ID: <c0efb81064f71837f19408f65b52d155103ee514.1605896059.git.gustavoars@kernel.org>
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
by explicitly adding a fallthrough pseudo-keyword instead of letting the
code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/regulator/as3722-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/as3722-regulator.c b/drivers/regulator/as3722-regulator.c
index 33ca197860b3..7bebf9ce6271 100644
--- a/drivers/regulator/as3722-regulator.c
+++ b/drivers/regulator/as3722-regulator.c
@@ -455,7 +455,8 @@ static int as3722_sd_set_mode(struct regulator_dev *rdev,
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
 		val = as3722_reg_lookup[id].mode_mask;
-	case REGULATOR_MODE_NORMAL: /* fall down */
+		fallthrough;
+	case REGULATOR_MODE_NORMAL:
 		break;
 	default:
 		return -EINVAL;
-- 
2.27.0

