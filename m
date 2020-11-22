Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177E02BC5BC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 14:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgKVM7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 07:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbgKVM7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 07:59:19 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0EDC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 04:59:19 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 131so12308702pfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 04:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9SmLUL6dJlY5EsVIhDBNTqL4CGAyd1Gb/jZPmSbLDd0=;
        b=XEGr/uo+SXkDkE5mWL1n1SpeZTTmMBYncL3HeB8Xz5QEcxGsRUFYqFGGAQHPLVk11O
         ojGEaZa9SV+TsO2GR2gyOOiGuqmEltEt5dRj8PH4S4WbqPUCIJwncH8VNTbhf7dUJvw6
         vexEBu4saj+Mj9+4LcbiEqbs8V33qaAxoHFbVCCICnOHFZ3WPur9TdcvXSiU4xTadi8E
         p667UKccaZNOh2E/xicPs5ztrH/eX9BkOKEOtusXsxnq5LLeNzYhWSi5WwveZxe2ubcp
         iemc4Q7pC8s9Dmv8uuO+q7mrHpRRLELzQhTj8c01lzcmVjPOqkDwnNNMekqhxkVLdb12
         XFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9SmLUL6dJlY5EsVIhDBNTqL4CGAyd1Gb/jZPmSbLDd0=;
        b=oKJZXLjrT8+pirNtzCNm9PxAlBO+b6YJfRYpI89fWkfrxJirJ7enZTjAWyX1lgZzkC
         LeWkqkWhb/ySmY7T7urtXdJX187QFOZIFJbAYCisBEGpjNRFRQY3mJAN86imCRqr0pMD
         J8hmfNIZ2lxrACD1WEXZTmPYyTbBdRTnVEESpdZYhgWn5L5A+ER+qTUOVo/W1v7PazIS
         /YxzDPGqHCKB7mCQOlgeBNKayusp4leJxQrgYeVMph4xT20zZXQMeRYzqKRRhTo8cojL
         ejZLXCuor0BVyz5auFahwafQShmyOdEFG/ce2zWLE94eDCVnksh994Y1OfoMUqzCc+4j
         B7Bg==
X-Gm-Message-State: AOAM533QMXzzasONHfmzzkEUq6BT+wF7KGbmDMqniHsF2doYTqWtEjwV
        hk0rhlnr6L0vVHPbH+TbdsFposbORySlVw==
X-Google-Smtp-Source: ABdhPJz5cEgu3Toa32UC45hXb2CDE3MnjEgP5ZLLiIHoU/tY510iRyWXgOPSOUDjZe2ydBHwG+un5A==
X-Received: by 2002:aa7:9709:0:b029:196:45d6:88d4 with SMTP id a9-20020aa797090000b029019645d688d4mr21214992pfg.27.1606049958535;
        Sun, 22 Nov 2020 04:59:18 -0800 (PST)
Received: from localhost.localdomain ([42.111.137.80])
        by smtp.googlemail.com with ESMTPSA id 12sm10961472pjn.19.2020.11.22.04.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 04:59:18 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6] checkpatch: add fix option for LOGICAL_CONTINUATIONS
Date:   Sun, 22 Nov 2020 18:29:08 +0530
Message-Id: <20201122125908.22212-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <368300090d93ad66f7fb19076d076d4321a04c42.camel@perches.com>
References: <368300090d93ad66f7fb19076d076d4321a04c42.camel@perches.com>
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

Provide a simple fix by inserting logical operator at the last
non-comment, non-whitespace char of the previous line and removing from
current line, if both the lines are additions(ie start with '+')

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
changes in v2: quote $operator at substitution

changes in v3: add a check for previous line ending with comment;
If so, insert $operator at the last non-comment, non-whitespace char of the previous line

changes in v4: improve the matching mechanism by matching line termination at comment or white space;
insert the operator before comments (if any) separated by a whitespace;
append the comment and its pre-whitespace after the inserted operator (if comment was present),
ie if no comment was present nothing will be inserted after the operator

changes in v5: improve regex for comment and line end with '$;'

changes in v6: remove if-check; modify commit message

 scripts/checkpatch.pl | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5b1a5a65e69a..dc5b031b45b9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3553,8 +3553,16 @@ sub process {
 
 # check for && or || at the start of a line
 		if ($rawline =~ /^\+\s*(&&|\|\|)/) {
-			CHK("LOGICAL_CONTINUATIONS",
-			    "Logical continuations should be on the previous line\n" . $hereprev);
+			my $operator = $1;
+			if (CHK("LOGICAL_CONTINUATIONS",
+				"Logical continuations should be on the previous line\n" . $hereprev) &&
+			    $fix && $prevrawline =~ /^\+/) {
+				# insert logical operator at last non-comment, non-whitepsace char on previous line
+				$prevline =~ /[\s$;]*$/;
+				my $line_end = substr($prevrawline, $-[0]);
+				$fixed[$fixlinenr - 1] =~ s/\Q$line_end\E/ $operator$line_end/;
+				$fixed[$fixlinenr] =~ s/\Q$operator\E\s*//;
+			}
 		}
 
 # check indentation starts on a tab stop
-- 
2.17.1

