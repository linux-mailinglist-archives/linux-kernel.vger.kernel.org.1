Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753492CB69C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgLBISV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:18:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgLBISU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:18:20 -0500
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: kernel-doc: fix parsing function-like typedefs
Date:   Wed,  2 Dec 2020 09:17:32 +0100
Message-Id: <218ff56dcb8e73755005d3fb64586eb1841a276b.1606896997.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 6b80975c6308 ("scripts: kernel-doc: fix typedef parsing")
added support for things like:

	typedef unsigned long foo();

However, it caused a regression on this prototype:

	typedef bool v4l2_check_dv_timings_fnc(const struct v4l2_dv_timings *t, void *handle);

This is only noticed after adding a patch that checks if the
kernel-doc identifier matches the typedef:

	./scripts/kernel-doc -none $(git grep '^.. kernel-doc::' Documentation/ |cut -d ' ' -f 3|sort|uniq) 2>&1|grep expecting
	include/media/v4l2-dv-timings.h:38: warning: expecting prototype for typedef v4l2_check_dv_timings_fnc. Prototype was for typedef nc instead

The problem is that, with the new parsing logic, it is not
checking for complete words at the type part.

Fix it by adding a \b at the end of each type word at the
regex.

fixes: 6b80975c6308 ("scripts: kernel-doc: fix typedef parsing")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 919acae23fad..a9a92e623dbc 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1444,7 +1444,7 @@ sub dump_enum($$) {
     }
 }
 
-my $typedef_type = qr { ((?:\s+[\w\*]+){1,8})\s* }x;
+my $typedef_type = qr { ((?:\s+[\w\*]+\b){1,8})\s* }x;
 my $typedef_ident = qr { \*?\s*(\w\S+)\s* }x;
 my $typedef_args = qr { \s*\((.*)\); }x;
 
-- 
2.28.0


