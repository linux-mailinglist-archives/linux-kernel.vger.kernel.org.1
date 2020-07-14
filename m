Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC7A21FD7A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 21:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgGNTiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 15:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgGNTiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:38:16 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD96C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:38:16 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 46CC0BC09D;
        Tue, 14 Jul 2020 19:38:12 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     torvalds@linux-foundation.org, corbet@lwn.net, ribalda@kernel.org,
        viro@zeniv.linux.org.uk, mchehab+samsung@kernel.org,
        luis.f.correia@gmail.com, geert+renesas@glider.be,
        paulburton@kernel.org, cyphar@cyphar.com, martink@posteo.de,
        davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] CREDITS: remove link http://www.dementia.org/~shadow
Date:   Tue, 14 Jul 2020 21:38:05 +0200
Message-Id: <20200714193805.49746-1-grandmaster@al2klimov.de>
In-Reply-To: <20200713114321.783f0ae6@lwn.net>
References: <20200713114321.783f0ae6@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
The way it redirects looks like a fallback from a dead URL to a generic one.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Yes, I noted that some of the links removed by these "CREDITS: remove link:"
 patches have email addresses with the same domain nearby.

 Don't worry, I'll take care of them together with all other
 dead email addresses - but not right now.


 CREDITS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 0787b5872906..92ad22b7ef56 100644
--- a/CREDITS
+++ b/CREDITS
@@ -483,7 +483,6 @@ D: Intel Wireless WiMAX Connection 2400 SDIO driver
 
 N: Derrick J. Brashear
 E: shadow@dementia.org
-W: http://www.dementia.org/~shadow
 P: 512/71EC9367 C5 29 0F BC 83 51 B9 F0  BC 05 89 A0 4F 1F 30 05
 D: Author of Sparc CS4231 audio driver, random Sparc work
 S: 403 Gilmore Avenue
-- 
2.27.0

