Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C6F2BB36A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbgKTSd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:33:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730557AbgKTSd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:33:56 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDB4A22D0A;
        Fri, 20 Nov 2020 18:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897235;
        bh=0BBA8F5T1JuTzlfzhd4NKZyNXiGcL+Fk/BtARfUyBmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEARSIgfnx6AQwqa71gspyLv01BNCsPibqOfyrJ7m3eXRm1goILq9oQjYyjIVvosb
         6FyVJ8+AcXoEKzkYXuFnWLCKbbE/8gHvGGKtShtZOKEDYLnQvl8vc4S6aVfQAZzLYA
         eSTYLeHmg3cLGUlWSreWSVzyKO+Pm7oAzQcE3axg=
Date:   Fri, 20 Nov 2020 12:34:01 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 067/141] ALSA: pcsp: Fix fall-through warnings for Clang
Message-ID: <9705120ac2310bb20035e375862410413359611d.1605896059.git.gustavoars@kernel.org>
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
 sound/drivers/pcsp/pcsp_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/drivers/pcsp/pcsp_input.c b/sound/drivers/pcsp/pcsp_input.c
index 52b475b310c3..e79603fe743d 100644
--- a/sound/drivers/pcsp/pcsp_input.c
+++ b/sound/drivers/pcsp/pcsp_input.c
@@ -54,6 +54,7 @@ static int pcspkr_input_event(struct input_dev *dev, unsigned int type,
 		case SND_BELL:
 			if (value)
 				value = 1000;
+			break;
 		case SND_TONE:
 			break;
 		default:
-- 
2.27.0

