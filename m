Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C2321FD82
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 21:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgGNTkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 15:40:03 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:40740 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729832AbgGNTkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:40:02 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 10AE0BC070;
        Tue, 14 Jul 2020 19:39:59 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     torvalds@linux-foundation.org, corbet@lwn.net, f4bug@amsat.org,
        geert+renesas@glider.be, paulburton@kernel.org,
        mchehab+samsung@kernel.org, ribalda@kernel.org, martink@posteo.de,
        cyphar@cyphar.com, davej@codemonkey.org.uk,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] CREDITS: remove link: http://www.andante.org
Date:   Tue, 14 Jul 2020 21:39:54 +0200
Message-Id: <20200714193954.49979-1-grandmaster@al2klimov.de>
In-Reply-To: <20200714175528.46712-1-grandmaster@al2klimov.de>
References: <20200714175528.46712-1-grandmaster@al2klimov.de>
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
A completely white page with just an <iframe> in the <body>.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Yes, I noted that some of the links removed by these "CREDITS: remove link:"
 patches have email addresses with the same domain nearby.

 Don't worry, I'll take care of them together with all other
 dead email addresses - but not right now.


 CREDITS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 0787b5872906..ed58df9db15b 100644
--- a/CREDITS
+++ b/CREDITS
@@ -4113,7 +4113,6 @@ S: Japan
 
 N: Eric Youngdale
 E: eric@andante.org
-W: http://www.andante.org
 D: General kernel hacker
 D: SCSI iso9660 and ELF
 S: 6389 Hawk View Lane
-- 
2.27.0

