Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924D92B5D49
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgKQKwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgKQKwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:52:50 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D60C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:52:48 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 62so15857287pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wcMZTaIPkIt9BoToXvaICe5+QNibl67EVvBUxobxY0o=;
        b=DbhikWaZXEBuvC6Y6+U/bYpJl8MEtJVkNRM1Qd+YWChqpvh36A4Ny1oaOXYqgqmDH1
         1dkTF4ptwoJXnBcGUSZvGopNkrLmajTWcNOfzqrZskkflGyhxx3jwCkhnRHekfok+2Kh
         nMVmqzUuWc+6uRSMsTkx6aMR1/OIzfvJatmnSXAsn/zefObwsezxbcAJbQ0KLvMzkyp9
         VwhoqOV/1U9rzgf4/R4NW6kepzSIGfS3kn61chLGir9N3JXWZje9sJB1j2R9W+5iC9KY
         At85mpMBMRZp0QYlk10qWEf2ZeFhfP4zdaPN1D7L5YWtMEAJPTGzfHTfNaICO5l51UQ7
         8QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wcMZTaIPkIt9BoToXvaICe5+QNibl67EVvBUxobxY0o=;
        b=tkh3qeSYU1W8crZCbueBKEX3Bcl3sbta3HZXb+bs1XoKUbEVxKqiHLA4gRDdkIRzTk
         kSzTk1rMn8Wfqv15NFfaeROOGUGp/RP3GOPDBewyqAJ6Ts8hnt+n9hKoXxfs3Tja+Mh/
         XmQoOKVjlGd7d7RvZAN75fUlLdd6DjWqS35Fm+gdLC/GpkwFUROzptelkmgs+gcuSAmL
         larUQkmyI6dn2QMWr9FUaA2hrOM13hU70FNxgh0nyd2IIHZ6LyWqxm4OyPKUzo9Ty4D3
         xTU6HcFq/CuWI+fMomNcc4mmvpml6KeVyOBP9aXjnPiurOfdpIhgxbnzYKfPTwLlNjib
         KUBA==
X-Gm-Message-State: AOAM531SW6MZxxTQ/083etiGTC9/SYI/MKi3m1I3JWQDKzjxU8a44ZE4
        1NJO++uSaDyPCR/6ILdT7X11jsGsn5dmYQ==
X-Google-Smtp-Source: ABdhPJxTSYrBNHKDjf2yB9lt1w4xadMNX2xQDvp6BWuCzFzbiangG/y/yA48FpkP6l2/huNkBgd2kA==
X-Received: by 2002:a63:1142:: with SMTP id 2mr3092932pgr.103.1605610368217;
        Tue, 17 Nov 2020 02:52:48 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:425:6282:bc1b:1de0:7718:e8a1])
        by smtp.googlemail.com with ESMTPSA id x28sm8773391pgk.21.2020.11.17.02.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 02:52:47 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, yashsri421@gmail.com,
        lukas.bulwahn@gmail.com
Subject: [PATCH v2] checkpatch: add fix option for ASSIGNMENT_CONTINUATIONS
Date:   Tue, 17 Nov 2020 16:22:37 +0530
Message-Id: <20201117105237.757-1-yashsri421@gmail.com>
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

 scripts/checkpatch.pl | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c9aaaa443265..e0cb36369b2f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3542,8 +3542,14 @@ sub process {
 
 # check for assignments on the start of a line
 		if ($sline =~ /^\+\s+($Assignment)[^=]/) {
-			CHK("ASSIGNMENT_CONTINUATIONS",
-			    "Assignment operator '$1' should be on the previous line\n" . $hereprev);
+			my $operator = $1;
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

