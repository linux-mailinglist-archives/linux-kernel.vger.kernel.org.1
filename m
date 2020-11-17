Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147522B6B91
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgKQRTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgKQRTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:19:07 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2495C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:19:07 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id x15so10600799pll.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BU2rF0RjJies6Ad9Guc7YENeR3dvB/h0+JgOyVEnQ9g=;
        b=P38iJsldVOd0e+NPtlq3jP15XMuAnV1znsiXCfKkhRmXew9U1uaSEGj6QFX38z31vQ
         MIGa2fmyFPXdJosUIXk4GR61uNnqpMwSELS+VWfJmhIMjWPAGfj+ZsQij++n9wOsTxvv
         gywwsGvTyPhruFer06R7zp2Ka3U7lTa6U82FKXjcK3lz06wcPwEkBwkN/fXrjCF3ZueG
         rNOAgMwGT+QUH2vF/gWInsBlqtIQa0ulpfxGgt67wU4sWrLsUn00IJ8zeg17aZpIwEph
         EsQTA9rS8PX0Fu4+HDyC16QSC3ct7KmoeSIHHlgpP5YrBjnpVv9jLMajUiTY0S5UZKxr
         eXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BU2rF0RjJies6Ad9Guc7YENeR3dvB/h0+JgOyVEnQ9g=;
        b=Zd7pKJ0XApCnW+mYAwD8/+ikwjbso+sZAmOiNMOf0y72y9ve+SQ2yePGr5wRmNW3gv
         0Iz7hjXuwN8cb7UUzPrvc07E8Sy0eli73tqk8QrLYrIOAOGB8oNKPOyUT++FvU6DuzXy
         ZhFF6v5HpJT/nOo+3Hxj+72vZVYH9PIkVVDk7AKcO0RyPXQgzmEDrnDTZXFUwvalz7+C
         B6uICUOhNwj/4+/pgbqmft4sLW7ohELSTgGp+6o2rbt4ln3OQx+6Y1l8wm2Ku9WpAAFg
         ZJDaC8jsXqlL69VE8eGd7GTlETvq0ADYomonAXcITWfyjbq7E5y/U3hb5XEw//H1zAQ2
         1mrA==
X-Gm-Message-State: AOAM533OvmvtlLurvw3iGU7x5RIacPvU2siqWDAHJ/AWsq3FMFMa4oDE
        ZqpEvUOmGleFMsyOY0xdBII=
X-Google-Smtp-Source: ABdhPJzCxBg/rtq4ejDIfI2VIFNUdT4M0h79GKc8dpcq6loXBym2b8mx0waRp1IwhXUnCLELs5amKQ==
X-Received: by 2002:a17:902:7785:b029:d6:cf21:69ef with SMTP id o5-20020a1709027785b02900d6cf2169efmr584180pll.58.1605633547174;
        Tue, 17 Nov 2020 09:19:07 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:425:6282:bc1b:1de0:7718:e8a1])
        by smtp.googlemail.com with ESMTPSA id y19sm21449337pfn.147.2020.11.17.09.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 09:19:06 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Subject: [PATCH v3] checkpatch: add fix option for ASSIGNMENT_CONTINUATIONS
Date:   Tue, 17 Nov 2020 22:48:56 +0530
Message-Id: <20201117171856.13284-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, checkpatch warns us if an assignment operator is placed
at the start of a line and not at the end of previous line.

E.g., running checkpatch on commit 8195b1396ec8 ("hv_netvsc: fix
deadlock on hotplug") reports:

CHECK: Assignment operator '=' should be on the previous line
+	struct netvsc_device *nvdev
+		= container_of(w, struct netvsc_device, subchan_work);

Provide a simple fix by appending assignment operator to the previous
line and removing from the current line, if both the lines are additions
(ie start with '+')

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
Changes in v2:
add check if both the lines are additions (ie start with '+')

Changes in v3:
quote $operator; test with division assignment operator ('/=')

 scripts/checkpatch.pl | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c9aaaa443265..d5bc4d8e4f6c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3542,8 +3542,14 @@ sub process {
 
 # check for assignments on the start of a line
 		if ($sline =~ /^\+\s+($Assignment)[^=]/) {
-			CHK("ASSIGNMENT_CONTINUATIONS",
-			    "Assignment operator '$1' should be on the previous line\n" . $hereprev);
+			my $operator = "$1";
+			if (CHK("ASSIGNMENT_CONTINUATIONS",
+				"Assignment operator '$1' should be on the previous line\n" . $hereprev) &&
+			    $fix && $prevrawline =~ /^\+/) {
+				# add assignment operator to the previous line, remove from current line
+				$fixed[$fixlinenr - 1] .= " $operator";
+				$fixed[$fixlinenr] =~ s/$operator\s*//;
+			}
 		}
 
 # check for && or || at the start of a line
-- 
2.17.1

