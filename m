Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D941C07B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 22:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgD3UTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 16:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgD3UTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:19:32 -0400
Received: from mail.kocurkovo.cz (unknown [IPv6:2a02:2b88:2:1::5b29:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9FFC035495;
        Thu, 30 Apr 2020 13:19:31 -0700 (PDT)
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id AF458955; Thu, 30 Apr 2020 22:10:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz AF458955
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1588277408;
        bh=4cf9tT90g9qSpx1yKh9/vTGX84c71O8el/wErQ+Rsrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wht5aty/8Slp8yZqhzfsFPBExwbkC4LgTdU2F7K9sgtdCRhzBKp7ekfU25/ipMn0F
         PV5AtI3CtRYuuMMW3+VhH6C+DCIX4IgT5IErTSYGCx/l39IyoBxKtpVCjUmSDSU+Ni
         IEAol/CAiSpMHrncTZgE1zGulCackz+Hc7TUwFX0=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH 1/3] staging: sm750fb: add missing case while setting FB_VISUAL
Date:   Thu, 30 Apr 2020 22:09:24 +0200
Message-Id: <1588277366-19354-2-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588277366-19354-1-git-send-email-mdujava@kocurkovo.cz>
References: <1588277366-19354-1-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch statement does not contain all cases: 8, 16, 24, 32.
This patch will add missing one (24)

Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/sm750fb/sm750.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index e478290b60a8..39e610cc3c06 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -900,6 +900,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		fix->visual = FB_VISUAL_PSEUDOCOLOR;
 		break;
 	case 16:
+	case 24:
 	case 32:
 		fix->visual = FB_VISUAL_TRUECOLOR;
 		break;
-- 
2.26.2

