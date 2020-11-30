Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72DF2C80BB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgK3JQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgK3JQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:16:41 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389DEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:15:55 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id r9so953645pjl.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FXZaPZ6Wa2Q+4SL2vnWGOCxVYyiUYdZrOWiFlU+FIk8=;
        b=a+rz0XPPQfOkYA/WQqaYHGtorilV18qfphK1msjTfOrgdHfTHJu9czmXuGa/sJFpbC
         TYfGL7lU8se6EtNDZuaY6ZF25tep1rcsjwRR6+C7gJ/ADMFzK2JLW1m5C/lvSIX1LfjL
         vZLM/j1+t1Lpykl9mbgKHLjVrKZYjbtJ/Hu8DI6cQJrZ+ix9flUQgNPJ8KFO60RkKa1r
         pdecNr/D3DTDSNZCo2ITBAlg1f8ysLjC5JwG6epyEAU3Idy0NymL8bqVp6BdVJ44L8YE
         NhyoKoFH3ym69VtEabbp5QNu7UovRuU/h0Uwk6CIqC2NvmMDZK7QfuEI6d1phA1UtNDA
         MmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FXZaPZ6Wa2Q+4SL2vnWGOCxVYyiUYdZrOWiFlU+FIk8=;
        b=qCICEkmCQc5KWeqVuhHGovD69m76EwHcbKB9KrcLgDOF+SMPumymBWqMUHZUkFJv+0
         xZ9xEw/NIlcfvFfla5wAxZgkbww1FmCS6+BFwBiT14QhKXzZuqJTqMGu2DpTMAebWxB1
         UgQIFWgsJMi64560vyB57Tp6jp9P4DuVu+w92MbTY7ZTeWx9ICMkb6LmFPZiaHKCbrfr
         crzLSCNiFtXeX2FILY+begGE6Tz/K+3LciB4jMTm3Gh5+gV5Ob8j0nzo0HG59AYzt4Vr
         XKB48BY3IZRXxulX0At50P4ABodervyPW4f4KBJ3/RMYiReNlYHVXWM++u3bliJTwCjP
         eOHg==
X-Gm-Message-State: AOAM531zw9WQqxvmnUQbUAnyP2Wypjxk1ZSK/fCIcbPSEqD4467OvELf
        ljpFQYIemFmWF4/PXS3VAR1ue/zeyPU5ig==
X-Google-Smtp-Source: ABdhPJwtwyU15Po6OMUqRSu8ArVRfNBEfzMPAapekf9/lYW0UFYwnwrl6D8XGQNQvBG4MmQt938PpQ==
X-Received: by 2002:a17:90a:fa81:: with SMTP id cu1mr7080966pjb.39.1606727754623;
        Mon, 30 Nov 2020 01:15:54 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:419:6b90:c59c:7043:caf9:832d])
        by smtp.googlemail.com with ESMTPSA id fs12sm12637132pjb.49.2020.11.30.01.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 01:15:54 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] checkpatch: add fix option for MISSING_SIGN_OFF
Date:   Mon, 30 Nov 2020 14:45:45 +0530
Message-Id: <20201130091545.15585-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130091042.14987-1-yashsri421@gmail.com>
References: <20201130091042.14987-1-yashsri421@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently checkpatch warns us if there is no 'Signed-off-by' line for
the patch.

E.g., running checkpatch on commit 9ac060a708e0 ("leaking_addresses:
Completely remove --version flag") reports this error:

ERROR: Missing Signed-off-by: line(s)

Provide a fix by adding a Signed-off-by line corresponding to the author
of the patch before the patch separator line.

Also, avoid this fix with the Non-standard signature warning, as the
missing sign off is most likely because of typo.

E.g. for commit 8cde5d5f7361 ("bus: ti-sysc: Detect omap4 type timers
for quirk") we get missing sign off as well as bad sign off warnings for:

Siganed-off-by: Tony Lindgren <tony@atomide.com>

Here it is probably best to fix the typo with BAD_SIGN_OFF warning and
avoid adding an additional signoff.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
applies over next-20201120 and my last changes at:https://lore.kernel.org/linux-kernel-mentees/db1195235752685fc85fb52ecb1b1af3f35b5394.camel@perches.com/T/#u

Changes in v2:
  Add space after 'if'
  Add check for $patch_separator_linenr to be greater than 0

Changes in v3:
  Give MISSING_SIGN_OFF warning irrespective of the value of $non_standard_signature, add check with fix option instead
  Modify commit message accordingly

 scripts/checkpatch.pl | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4a026926139f..3abf34bb9b00 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2462,6 +2462,8 @@ sub process {
 
 	my $last_blank_line = 0;
 	my $last_coalesced_string_linenr = -1;
+	my $patch_separator_linenr = 0;
+	my $non_standard_signature = 0;
 
 	our @report = ();
 	our $cnt_lines = 0;
@@ -2813,6 +2815,10 @@ sub process {
 		if ($line =~ /^---$/) {
 			$has_patch_separator = 1;
 			$in_commit_log = 0;
+			# to add missing signed-off-by line before diff(s)
+			if ($patch_separator_linenr == 0) {
+				$patch_separator_linenr = $linenr;
+			}
 		}
 
 # Check if MAINTAINERS is being updated.  If so, there's probably no need to
@@ -2842,6 +2848,7 @@ sub process {
 						$fixed[$fixlinenr] =~ s/$sign_off/$suggested_signature/;
 					}
 				}
+				$non_standard_signature = 1;
 			}
 			if (defined $space_before && $space_before ne "") {
 				if (WARN("BAD_SIGN_OFF",
@@ -7188,8 +7195,11 @@ sub process {
 	}
 	if ($is_patch && $has_commit_log && $chk_signoff) {
 		if ($signoff == 0) {
-			ERROR("MISSING_SIGN_OFF",
-			      "Missing Signed-off-by: line(s)\n");
+			if (ERROR("MISSING_SIGN_OFF",
+				  "Missing Signed-off-by: line(s)\n") &&
+			    $fix && !$non_standard_signature && $patch_separator_linenr > 0) {
+				fix_insert_line($patch_separator_linenr - 1, "Signed-off-by: $author");
+			}
 		} elsif ($authorsignoff != 1) {
 			# authorsignoff values:
 			# 0 -> missing sign off
-- 
2.17.1

