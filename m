Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE1E2BC15B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 19:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgKUSOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 13:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgKUSOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:14:08 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA4EC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 10:14:08 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id n137so973648pfd.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 10:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+/ZgAn65K2RfMWm1/R12+2z9h8SUdfpl5HlRWBvrjuw=;
        b=ipeZBrltvCVVMRe3DxVaGeYIQVgjnJwR/dPqF5qt+o4olKQYYgeeOZTKGTqyJhvy4s
         6NvLD+fgKLjcqfxy+UA3vdiTSauFu3fBV6RJ6HbTiSbjbv7Qpa4zfMIxXotH+nAV0eW+
         H7QPjB4q1W2kMC87QZtaflCKLXCQx2ICMQaCU03+0PCpOvP6Tj2uTmVnpsGqQr1OazIN
         vvp2xGui3bgNqQouxM9BxKwwbnZWetKpeLGd0nWQ7KgM7JXOdrmPY/GUTbXGGKV3+nkf
         +FmINOytMGewrr2SeEzfuZ3cBOqxn1l9BSXKHULT2Bcbkw00XkqRITGC3osy9etvFNWd
         gdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+/ZgAn65K2RfMWm1/R12+2z9h8SUdfpl5HlRWBvrjuw=;
        b=Itw9t7WHGORXhh7cdqSY0BwNGOUTk3i8cpMjRQU57pf5iEWGDJNhqDOUTpuKQqOkEv
         GDFvc0wrYHIghDPv8/UxK+BRblDH0diqyRdrHBG3L9zrrU6s677FStbWjzi8a3YkQCpM
         JdI9PSOX4wuNoULwW1FOeBkMDZ3HJiXDib3Syi02H5b2qp9lKQPjLL2nxCi+BoSDwNK3
         AJi2M/9AQT33OuaNG0b+K6NLbY3rD+qDVKmxx5E1Au04nXl+cjo/uZKQlHbsbuM9A9/S
         bOph4J7N34KTu0MzGNAzFXAcB2HloFrij1cdC0KI3eRklvCw9v3OLR1nzVMV1p5uqs24
         87gw==
X-Gm-Message-State: AOAM533FBVhPdaxSNRPT0bLuDSlQQj62+on45nly+2QolvME7GW6J+Qk
        /YjVEhrEVxb+NRgk7oI2cFI=
X-Google-Smtp-Source: ABdhPJzmDqpomjK6zMP+8OPnxE+MasuFLkfHmO+4FpgGlFmBCydCw0jcgsqH7UXDwJUCke7W98J+Pw==
X-Received: by 2002:a62:7883:0:b029:18a:e054:edf1 with SMTP id t125-20020a6278830000b029018ae054edf1mr18916039pfc.70.1605982447804;
        Sat, 21 Nov 2020 10:14:07 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:40c:d321:ed91:20bf:333c:1bc4])
        by smtp.googlemail.com with ESMTPSA id q19sm7311072pfh.37.2020.11.21.10.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 10:14:07 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] checkpatch: add fix option for LOGICAL_CONTINUATIONS
Date:   Sat, 21 Nov 2020 23:43:57 +0530
Message-Id: <20201121181357.7621-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d68afd4b87e2ce3fc846d8ca5ab9a401ce04344a.camel@perches.com>
References: <d68afd4b87e2ce3fc846d8ca5ab9a401ce04344a.camel@perches.com>
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

changes in v3: add a check for previous line ending with comment;
If so, insert $operator at the last non-comment, non-whitespace char of the previous line

 scripts/checkpatch.pl | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5b1a5a65e69a..533c4a6bbf12 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3553,8 +3553,22 @@ sub process {
 
 # check for && or || at the start of a line
 		if ($rawline =~ /^\+\s*(&&|\|\|)/) {
-			CHK("LOGICAL_CONTINUATIONS",
-			    "Logical continuations should be on the previous line\n" . $hereprev);
+			my $operator = $1;
+			if (CHK("LOGICAL_CONTINUATIONS",
+				"Logical continuations should be on the previous line\n" . $hereprev) &&
+			    $fix && $prevrawline =~ /^\+/) {
+				# add logical operator to the previous line, remove from current line
+				# if last line ends with a comment
+				if ($prevrawline =~ /(\/\/.*)$/) {
+					my $comment = trim($1);
+					$fixed[$fixlinenr - 1] =~ s/\s*$comment//;
+					$fixed[$fixlinenr - 1] .= " $operator $comment";
+				}
+				else {
+					$fixed[$fixlinenr - 1] .= " $operator";
+				}
+				$fixed[$fixlinenr] =~ s/\Q$operator\E\s*//;
+			}
 		}
 
 # check indentation starts on a tab stop
-- 
2.17.1

