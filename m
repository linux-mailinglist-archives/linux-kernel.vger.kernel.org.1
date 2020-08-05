Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0F723C632
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 08:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgHEGsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 02:48:19 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:53444 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgHEGsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:48:18 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id A20874E2B0;
        Wed,  5 Aug 2020 06:48:13 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     torvalds@linux-foundation.org, corbet@lwn.net,
        geert+renesas@glider.be, ribalda@kernel.org, martink@posteo.de,
        grandmaster@al2klimov.de, luis.f.correia@gmail.com,
        paulburton@kernel.org, cyphar@cyphar.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] CREDITS: add myself
Date:   Wed,  5 Aug 2020 08:48:05 +0200
Message-Id: <20200805064805.64688-1-grandmaster@al2klimov.de>
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
50 already merged patches of mine.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 (Let's try once more - with 50 patches instead of just 2.)

 See:
 git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master

 CREDITS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/CREDITS b/CREDITS
index 32ee70a7562e..aaa2c20c0d86 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1933,6 +1933,11 @@ S: Schwalbenstr. 96
 S: 85551 Ottobrunn
 S: Germany
 
+N: Alexander A. Klimov
+E: grandmaster@al2klimov.de
+W: https://github.com/Al2Klimov
+D: documentation
+
 N: Ian Kluft
 E: ikluft@thunder.sbay.org
 W: http://www.kluft.com/~ikluft/
-- 
2.27.0

