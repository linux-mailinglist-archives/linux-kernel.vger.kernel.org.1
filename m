Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9522AAB32
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 14:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgKHNn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 08:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHNn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 08:43:26 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B59C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 05:43:26 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id t22so3235859plr.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 05:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e0vmOXUAgAOOzA9cqQrS6Zywvk+7YcaoYXyrZKYC2Eo=;
        b=gbvjPNouvqPF9qLDMhqoR9z9SwQbkh2Hj8ILrNbmhKsY65HUPF1WHgrFUA7uCdq0Gh
         10vrlyCMPKU9+uXKQLDhpAXhxb+eTee06R3ArfaAprJ156l9uY/pSLDnWDDyLfGh5xxn
         i3ymRzGdBK4jaO0t8yJ+Thw5Mg6PAWzPisXXoUpt9MTPdmZioajDWOWQIsT4lz24Vind
         WJtGTrE/M9F1TN6BQTN1LhNFQPeoq6Xp3I5407mSGqvK70KcPg/kngCbtW2NFk7YIdjR
         T86HCDCycNPSry6Wm4WnA/x6/nZ7GhjsvLP3UNMBWtXH6zS6CVZ9YS8Ag3W7PnsCdvh0
         qG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e0vmOXUAgAOOzA9cqQrS6Zywvk+7YcaoYXyrZKYC2Eo=;
        b=aJ88wUIpR77dWmitKKkTozWd+/udwtbafbocfuugky7xwgiuxE3x7NiGspnAP68Fbm
         FOLGoek9V8AUvkKsG8KTVGEYYkCgcYtOYuxe8uznLkuU+XFg99kyoihARTMil/U9+5Zh
         t6zwHdmFLlBIGQ2nl6P7bUfYtNzyRkyyUNHzWjM0qFq9wbgEW4WdO0maX6y+hJRS9tMn
         xjNI14Foi5sXAFuUsjUEmRrGMrjvE2G44HMZug4ytrEFg/8s9GRYoUVtm/WAHlW+TiTz
         UBVe8EkHzcZt3rAgl1adwCuzY+fA+GivPMJsjz/RegscmIufh7l82d1TEXAKbvVDh2QO
         N50w==
X-Gm-Message-State: AOAM533HmYZcKoCTyHWQajrdgLrSiOccZDKFqds/6ePWYLVpEynWWXj5
        u84HKFtJ6vo/I+0iLZ/i2HM=
X-Google-Smtp-Source: ABdhPJx4zC0jWZjFIemZzvDFcVm9GKPUDhr83QMyNpXVnbVvGaXglRygdtrdwLULRDKeicPaINru+g==
X-Received: by 2002:a17:90b:4ad2:: with SMTP id mh18mr8093265pjb.0.1604843006189;
        Sun, 08 Nov 2020 05:43:26 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:42f:431f:a8c7:19b8:cb80:f5a3])
        by smtp.googlemail.com with ESMTPSA id gc17sm8188020pjb.47.2020.11.08.05.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 05:43:25 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        dwaipayanray1@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: add fix for BAD_SIGN_OFF
Date:   Sun,  8 Nov 2020 19:13:17 +0530
Message-Id: <20201108134317.25400-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, checkpatch warns us if the author of the commit signs-off
as co-developed-by.
E.g. for commit 6e88559470f5 ("Documentation: Add section about
CPU vulnerabilities for Spectre") we get:

WARNING: Co-developed-by: should not be used to attribute nominal
patch author 'Tim Chen <tim.c.chen@linux.intel.com>'
Co-developed-by: Tim Chen <tim.c.chen@linux.intel.com>

Provide a simple fix by removing the co-developed-by line from the
commit message

A quick evaluation on v4.13..v5.8 showed that this fix was getting
triggered 6 times.
A quick manual check found out that all fixes were correct in those
cases.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/checkpatch.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 58095d9d8f34..1030d4fc2abf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2827,8 +2827,11 @@ sub process {
 # Check Co-developed-by: immediately followed by Signed-off-by: with same name and email
 			if ($sign_off =~ /^co-developed-by:$/i) {
 				if ($email eq $author) {
-					WARN("BAD_SIGN_OFF",
-					      "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . "$here\n" . $rawline);
+					if (WARN("BAD_SIGN_OFF",
+						 "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . "$here\n" . $rawline) &&
+					    $fix) {
+						fix_delete_line($fixlinenr, $rawline);
+					}
 				}
 				if (!defined $lines[$linenr]) {
 					WARN("BAD_SIGN_OFF",
-- 
2.17.1

