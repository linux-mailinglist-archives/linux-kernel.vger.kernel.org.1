Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890E02BB372
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgKTSeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:34:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730681AbgKTSea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:34:30 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD1DC22470;
        Fri, 20 Nov 2020 18:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897269;
        bh=3ol0GXV2w5ae7brwiU4z35v9uepu/8t4+NvhW4QdRvA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=FtIfofQBVyfBnvTShsFnkOfODiHPrQdSVxIIlAI0mQXtrbci7XokI08jiy0rM3vWi
         XpVqVlBxSxdEeYL4U5NJrBG3jKNYDUHdiaQHjw1JtXSHRjvRhnB5A/gC7tI34QVOAi
         D1gSoO3U+EZphW1ouOb2T7MdWbhsl6fO2GQ6rrMM=
Date:   Fri, 20 Nov 2020 12:34:35 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 071/141] braille_console: Fix fall-through warnings for Clang
Message-ID: <a0be16871b77956d75ea2f877da2fa5fba3e64ac.1605896059.git.gustavoars@kernel.org>
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
 drivers/accessibility/braille/braille_console.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index 9861302cc7db..359bead4b280 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -246,6 +246,7 @@ static int keyboard_notifier_call(struct notifier_block *blk,
 				beep(440);
 		}
 	}
+		break;
 	case KBD_UNBOUND_KEYCODE:
 	case KBD_UNICODE:
 	case KBD_KEYSYM:
-- 
2.27.0

