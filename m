Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6126E2C0347
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgKWK2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbgKWK2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:28:30 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE28AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 02:28:30 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id 81so13868397pgf.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 02:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qRhACkl7Rv1uiFh8nGeVLLx0hitLFn3xGhjC9ZYYm2s=;
        b=mIR/WMKDFuVlCPGZvcfujDdFLjDoYpA9VEarx8tSzci8KF76UTk9zJSaCd0/zXoKmm
         7qPKRPk9ljIanB837jZ6mTRKugYuSSFpEGkV2PjPb66bgz6spS6uWXEhrnVwM/7aQ7pA
         kB9syVYMaA0uy/2FxAIUeRdNojRAmVCo9YRTmonu8VbcNIk+0yYMQ8OMMt6VSV7hMcOd
         5JpFWZ6bXvfQMjeVb3LnBsVtX00+LcpTcDq12+vUmsC7DQN2hsVmSI2SmdH7tlNi0c67
         AKE7xtwciWyPJl/A3Loj+0O/F+cBboH51Xo7xA06tbhSNewHh2hqPWO/zr48DnS46hzK
         a7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qRhACkl7Rv1uiFh8nGeVLLx0hitLFn3xGhjC9ZYYm2s=;
        b=c4F6lKLHV9H4FExI5KYeKpN9c3em8Q1s5/39etVx9tVInIa8uU541Bh1tIG7G5wQbU
         f/UuqfQgXejJCtXA/HrcVClwjRDB+A0zJRpXD8Z13fG2jBInH6zy6TcrzFHvxyrcCjRy
         BhA5a7KcDD9UxJECN4CMAfze0Lfdlm/pMDPBDluQyDsiKGXh9yLNpj3vNTEQo5HviY89
         I0jlPE6l6Wh/LoC4/4FuhdIXh96zMtshpr0CeUq2kTesUSW3m1QmYG07ybuABlkMfO/W
         gsvMAHvEpgthzqPlxhzodXEgZkIC2v6tyw53BwEnJtfR9xOsZkRlVMADjJykcEVfkz0z
         dQMw==
X-Gm-Message-State: AOAM531ueltSOp7D9eGwxv41uYP8Iu8maMY9Y5543By3b6vYJysRxPRH
        I+0F6S9OLz1Q9BDvSPFQ77E=
X-Google-Smtp-Source: ABdhPJyysChDwLc1e9sbiOMTb/IONSdknPwpSKenaAeO8j9mWeQXJWJ+8vzjQq2E0gRsbUGCVlnBaA==
X-Received: by 2002:a17:90a:5e43:: with SMTP id u3mr23657809pji.216.1606127310005;
        Mon, 23 Nov 2020 02:28:30 -0800 (PST)
Received: from localhost.localdomain ([2405:204:a68f:d31a:e4c8:22ff:b3cf:2a08])
        by smtp.googlemail.com with ESMTPSA id o9sm14030919pjr.2.2020.11.23.02.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 02:28:29 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7] checkpatch: add fix option for LOGICAL_CONTINUATIONS
Date:   Mon, 23 Nov 2020 15:58:18 +0530
Message-Id: <20201123102818.24364-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <afaa79a6d86a4184878595ced3f2de1a92a4058c.camel@perches.com>
References: <afaa79a6d86a4184878595ced3f2de1a92a4058c.camel@perches.com>
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

changes in v7: add an extra '$' symbol at '$fixed[$fixlinenr - 1]' regex substitution to ensure match at line end

 scripts/checkpatch.pl | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5b1a5a65e69a..fb3c50e0bde2 100755
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
+				$fixed[$fixlinenr - 1] =~ s/\Q$line_end\E$/ $operator$line_end/;
+				$fixed[$fixlinenr] =~ s/\Q$operator\E\s*//;
+			}
 		}
 
 # check indentation starts on a tab stop
-- 
2.17.1

