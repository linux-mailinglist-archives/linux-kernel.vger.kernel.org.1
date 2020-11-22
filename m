Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4FE2BC546
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 12:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgKVLKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 06:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbgKVLKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 06:10:38 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720E8C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 03:10:36 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id v12so12165845pfm.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 03:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CVH5IQJC2i5boVYg8xv9KMvfHv3c/wN7xTCKIYiu7zc=;
        b=OiUOiiJIxe11MFzjnGn7H9TIvg6lg4fvYqXN/hv8RCrCYEFro2emd/WlxcLD8BjGP+
         HHgg1CLPj4tsZxJnBLonkHL3z/p5J27H7vlkbslenXwk379S2/im1gojqoAjzeW2qcUP
         OjtSKPTQf5QHzN/HefLgFs5t+RErArliGednD71jTAZWU7B5jO8KosRgcG52ax+buvH5
         8baF2E4wVg79MhYDqNzy0ybLklFDUTrw0pRj8tUS+gdJzO0CavBeaPAcgqdRy13T5rcu
         +kUFBLO1uMxfaDfQ2fmV1VsDq8D9JoXHpYUpqK8VRDhbNEvxl4fDJdX9z2+vo5QaQejm
         h0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CVH5IQJC2i5boVYg8xv9KMvfHv3c/wN7xTCKIYiu7zc=;
        b=l8KWVpz6xM3M1JSW591J3T/PcDhjNO/tJBwFjszO1k8bVqJHkWJLNZ5jF+EAFE5bZF
         0JE1j8pJUHMqqM7tNEGqIywlV1oF/GDH7PnK9SZ6k8HRNAEEsB6lQCd9cPoJ5JxecDc8
         XROwGyyOXL6yzxw/VVDhAUaUXmaL+5D8JjUBRazS55Vn9bMqdQEzV+TAo22wurN3MVgo
         kOxKl2wUan8GeyXISlA4hk3cwTiMTfELDzD5DCvRZfqltH6bPOFOM83Aflj88cA6wHA7
         shO1QD/ge+pRd6mPBixkvlge4FhZCvIsBu1/mw5AQKzMYCghI8nnIkIEH4uq7ScDAtBp
         kwUg==
X-Gm-Message-State: AOAM532+xbT7GPN2oj1vvn7vJsd+ruZhX8aRxA+i97XHzJSl65da3U+v
        dc6G8wL0ooQiOr7PPCf8YzA=
X-Google-Smtp-Source: ABdhPJwdTrsqTE9+bKbXqvLz1hwnA4mcRhGZwRcARKYmnNDKa79EKogodTPl1u9nfaQSsSsam6DtnQ==
X-Received: by 2002:a63:f20:: with SMTP id e32mr23711028pgl.130.1606043435693;
        Sun, 22 Nov 2020 03:10:35 -0800 (PST)
Received: from localhost.localdomain ([42.111.137.80])
        by smtp.googlemail.com with ESMTPSA id 5sm9520234pfx.63.2020.11.22.03.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 03:10:35 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] checkpatch: add fix option for LOGICAL_CONTINUATIONS
Date:   Sun, 22 Nov 2020 16:40:25 +0530
Message-Id: <20201122111025.17978-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1823e72eb92280d30457dda49e0a0036dee15dd3.camel@perches.com>
References: <1823e72eb92280d30457dda49e0a0036dee15dd3.camel@perches.com>
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

changes in v4: improve the matching mechanism by matching line termination at comment or white space;
insert the operator before comments (if any) separated by a whitespace;
append the comment and its pre-whitespace after the inserted operator (if comment was present),
ie if no comment was present nothing will be inserted after the operator

changes in v5: improve regex for comment and line end with '$;'

 scripts/checkpatch.pl | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5b1a5a65e69a..708a56f31466 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3553,8 +3553,17 @@ sub process {
 
 # check for && or || at the start of a line
 		if ($rawline =~ /^\+\s*(&&|\|\|)/) {
-			CHK("LOGICAL_CONTINUATIONS",
-			    "Logical continuations should be on the previous line\n" . $hereprev);
+			my $operator = $1;
+			if (CHK("LOGICAL_CONTINUATIONS",
+				"Logical continuations should be on the previous line\n" . $hereprev) &&
+			    $fix && $prevrawline =~ /^\+/) {
+				# add logical operator to the previous line, remove from current line
+				if ($prevline =~ /[\s$;]*$/) {
+					my $line_end = substr($prevrawline, $-[0]);
+					$fixed[$fixlinenr - 1] =~ s/\Q$line_end\E/ $operator$line_end/;
+				}
+				$fixed[$fixlinenr] =~ s/\Q$operator\E\s*//;
+			}
 		}
 
 # check indentation starts on a tab stop
-- 
2.17.1

