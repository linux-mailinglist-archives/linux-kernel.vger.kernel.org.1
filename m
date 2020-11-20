Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFC42BB36B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbgKTSeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:34:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730386AbgKTSeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:34:07 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63A212408E;
        Fri, 20 Nov 2020 18:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897247;
        bh=j3HUa+fnGHNDQulbJXTCYVUqAPDa46eOQU6quqLLw58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+GSDdceKqdEuI5kBb/K2Ns/xhwihJJnV0cWEIUHhkKXKFjz/WUVZ0EVPhhyg/XbN
         X7LV6AM/4spe9voqSRn8CZYvbrkJoeon0V8AoRpLSJ52qLOP4hztg8Jye8a/Y7iKSM
         y0M2KhugiVgURcLekTfbwBlAFrmpICeVpoTWXB3c=
Date:   Fri, 20 Nov 2020 12:34:12 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 068/141] ALSA: sb: Fix fall-through warnings for Clang
Message-ID: <0f6d5b94f1890be2b8f88d6f930fc75779e26345.1605896059.git.gustavoars@kernel.org>
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
 sound/isa/sb/sb8_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index 86d0d2fdf48a..8d01692c4f2a 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -506,6 +506,7 @@ static int snd_sb8_open(struct snd_pcm_substream *substream)
 		} else {
 			runtime->hw.rate_max = 15000;
 		}
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

