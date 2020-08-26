Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5472253796
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHZSwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 14:52:35 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:53556 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgHZSwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:52:24 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id BFAC282FF7;
        Wed, 26 Aug 2020 18:52:19 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     funaho@jurai.org, geert@linux-m68k.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH v2] m68k: Replace HTTP links with HTTPS ones
Date:   Wed, 26 Aug 2020 20:52:12 +0200
Message-Id: <20200826185212.3139-1-grandmaster@al2klimov.de>
In-Reply-To: <CAMuHMdV=gy1F2dX0+eURB=hubnbPUGbokrT_9kZXtk_ruAofSg@mail.gmail.com>
References: <CAMuHMdV=gy1F2dX0+eURB=hubnbPUGbokrT_9kZXtk_ruAofSg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 v2: Thrown out de facto broken links.
 archive.org-ing is on my TODO list, but beyond this project's scope.

 arch/m68k/mac/macboing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/mac/macboing.c b/arch/m68k/mac/macboing.c
index 388780797f7d..a904146dc4e6 100644
--- a/arch/m68k/mac/macboing.c
+++ b/arch/m68k/mac/macboing.c
@@ -116,7 +116,7 @@ static void mac_init_asc( void )
 			 *   support 16-bit stereo output, but only mono input."
 			 *
 			 *   Technical Information Library (TIL) article number 16405. 
-			 *   http://support.apple.com/kb/TA32601 
+			 *   https://support.apple.com/kb/TA32601 
 			 *
 			 * --David Kilzer
 			 */
-- 
2.27.0

