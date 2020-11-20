Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95B82BB40C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbgKTSjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:39:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731210AbgKTSjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:39:41 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76B3D2242B;
        Fri, 20 Nov 2020 18:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897581;
        bh=DxzWbsN/Bms1/LKoRDJpdOkI95ZnandenLyAnLVAE/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCd/AshZ5/r3P/1oIqdW8hQM1nRhKZv0sMLYyxpdx/m20ZRtDwhGvYSYPsy3FEPs2
         0pwKMOU82m3S2uspZxrUS4/m0u6pKZSTSXbaQ0Ms8Lr/TNuMcSqeG/lqs75LR2QwZ0
         cOBv52+ER1crgRf+ypbd36DHX/BU2FkefVDZHtm0=
Date:   Fri, 20 Nov 2020 12:39:46 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 126/141] slimbus: messaging: Fix fall-through warnings for
 Clang
Message-ID: <08a882fa7a3145bc33bc02392df8319e95092dcf.1605896060.git.gustavoars@kernel.org>
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
 drivers/slimbus/messaging.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index d5879142dbef..f2b5d347d227 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -258,6 +258,7 @@ int slim_xfer_msg(struct slim_device *sbdev, struct slim_val_inf *msg,
 	case SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION:
 	case SLIM_MSG_MC_CLEAR_INFORMATION:
 		txn->rl += msg->num_bytes;
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

