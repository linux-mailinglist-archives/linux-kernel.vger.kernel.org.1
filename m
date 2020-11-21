Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63EB2BBEDA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 13:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgKUMQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 07:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbgKUMQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 07:16:06 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFAEC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 04:16:05 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so9780160pgg.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 04:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2t2a5RSuhb/As1zEzgXiwAu23fEnENund7CGHbuUhkQ=;
        b=miLvxHlc4BbrEYEi+uRD0x9o2B2KdXcmQXh+NLu50hfybZ7gL0uU0ycHmcA0l5jO6Q
         gJWZ6atrttsCAPm7vU0hVtFHdh+9D1WjdXhNulmSnh486HibHA0dkj8b03L2yIFsdqYi
         SFeTKWvOhMMsa3bbUuiZycJdQacgLmfGHCABaZ1ZyC5gSuVv00Kdw7PpuxIgJKb3w5+7
         1v5NPS4S9VtHBJsA+/BkS2aLa80DJNOYazNu83IyYkNNl0yWxMjdblygmQxJofwOKqcV
         vh2rMYhqwy6n1ZcNwrBaBOHvGP0+ShkWqLg8DIvYmSyIDNuVhU3exHkyDLHAEkHx+Th6
         jwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2t2a5RSuhb/As1zEzgXiwAu23fEnENund7CGHbuUhkQ=;
        b=hWYJO4yf7VgW0i2uw6aYIpI+G8ZyiWgBceIrSR8VM4BlxtSFo7PAn7qG4fhexhgqT4
         CSRO/016GJSyoflMQGNqVjua876mZshiEwHFPhXdO0XapzbLS3JsdhalyngE4tE5Ghpa
         AyHFPPVC8zWycTEiXkNHr9xMiqQuRTDqjpV3O4Y0Cz0bIXVQroU29KsQTWOQJCIckmW1
         dAegnUKH3fcNa2Cyqe/M83ooBjFOAwmfDM030gKDVZeGCzRti7suQY9qsb2NrDMBZzNd
         WP7vR9dZDzX7ruRljiQiFCZXAqmVlM02he//dyps5kzsmvE0RJSF4fVSCnWPaPVheDOr
         73IQ==
X-Gm-Message-State: AOAM5330G4DZI1tJTJZV5gkNMgiZAXRWD+gbT2Ajc9mFTaQqiLXTIHfm
        cz6FRYzrLtw+YJAikUZp79w=
X-Google-Smtp-Source: ABdhPJw021THeZczZOFtV6/DAMEPKjirc50VNwyXspYWUCgSnKm0I4Zug9Qubs4pmU72MiDQWg3k6g==
X-Received: by 2002:a17:90a:9403:: with SMTP id r3mr15748398pjo.66.1605960965308;
        Sat, 21 Nov 2020 04:16:05 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:400:4498:ed91:20bf:333c:1bc4])
        by smtp.googlemail.com with ESMTPSA id q13sm7838249pjq.15.2020.11.21.04.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 04:16:04 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] checkpatch: add fix option for LOGICAL_CONTINUATIONS
Date:   Sat, 21 Nov 2020 17:45:57 +0530
Message-Id: <20201121121557.23528-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, checkpatch warns if logical continuations are placed at the
start of a line and not at the end of previous line.

E.g., running checkpatch on commit 3485507fc272 ("staging:
bcm2835-camera: Reduce length of enum names") reports:

CHECK:LOGICAL_CONTINUATIONS: Logical continuations should be on the
previous line
+	if (!ret
+	    && camera_port ==

Provide a simple fix by adding logical operator at the end of previous
line and removing from current line, if both the lines are additions
(ie start with '+')

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
changes in v2: quote $operator at substitution

 scripts/checkpatch.pl | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5b1a5a65e69a..7cb8942b6a16 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3553,8 +3553,14 @@ sub process {
 
 # check for && or || at the start of a line
 		if ($rawline =~ /^\+\s*(&&|\|\|)/) {
-			CHK("LOGICAL_CONTINUATIONS",
-			    "Logical continuations should be on the previous line\n" . $hereprev);
+			my $operator = $1;
+			if (CHK("LOGICAL_CONTINUATIONS",
+				"Logical continuations should be on the previous line\n" . $hereprev) &&
+			    $fix && $prevrawline =~ /^\+/) {
+				# add logical operator to the previous line, remove from current line
+				$fixed[$fixlinenr - 1] .= " $operator";
+				$fixed[$fixlinenr] =~ s/\Q$operator\E\s*//;
+			}
 		}
 
 # check indentation starts on a tab stop
-- 
2.17.1

