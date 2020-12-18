Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A024A2DE299
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 13:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgLRMM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 07:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbgLRMMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 07:12:53 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24905C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 04:11:45 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id c22so1186940pgg.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 04:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lir5dGRHwLjSomlPAkXb06BknP7+1ImyKhCDlWgaNdw=;
        b=PSR0j3LssWf3n590Kl/5HCRReDzxWwIkwGaewAN+IN3Yy+sxrJlRPXbRjbiC1s79za
         2UaABryTthjhSPMkjP5XonAQ7mZN+WDg/mIF02RrEldHCN0Uy1i+Z+++tdQEyvwYWA5m
         Vhu7B6D9mFTE2pMOy0hesGU4t3o9a5e2vcYvZvT4ptu5FqeXxx7BCBNJfqVFh4Jd6va7
         +ZkQSIKlYm91N8WMQzgcPkKN7Zev2lnxIONot5kOV6K4khpdcL9pMt5vQVAzNqbwjh0J
         DUmCEuFkFVK90GZYxhMawjGxumtnbd4nqM9Xy4cjqXd1LDo0JE0GQODzEExCTkrpLCYs
         qdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lir5dGRHwLjSomlPAkXb06BknP7+1ImyKhCDlWgaNdw=;
        b=rAth3vjnVq2vUFokDfPYU1GLesHRlIzHdwQiDYKUM7/9+D1KQQXYCT0+NoGL3xmpv1
         LLHp/SbVP3HJ8pNY9dxRlmftrsGVm4bajlF6mVij8QK/KZramuceTt46Jbaw5fP4R5RK
         LJU0nwJPW5cVMuNoBJD5rkHisP0KK0WkslK3F3uor0wL6rDrKti1BbofTXra+b5ZrHTV
         UWap+GR1WSJ6YisYWqgCvTY0OVigJga7zISpK3nDZC6aaG7NGtFGyG4hUxsxtkfqu2ft
         mIfEcOdzwVhelDHSPQNlR4EtIcXxk+VqKmiHhXha3z/MJwRAyTUJzHoITIQm4tpa3VYd
         qM7g==
X-Gm-Message-State: AOAM530CM/G8+xoJlTTGzUqM+wOyKgizxXb6yJqKJ73ddkIMEy94qwqw
        NYYe63XlorDZns5w7HtbQiWvIysfUwOYUQ==
X-Google-Smtp-Source: ABdhPJzBZdc9Bq2SaJxqCFnEuJzfYhbCSMGi9LhhyjhuoaYCDAAElnBYpnVoZTqOGoVfXCH27Z3ItQ==
X-Received: by 2002:a63:f745:: with SMTP id f5mr3818665pgk.119.1608293504443;
        Fri, 18 Dec 2020 04:11:44 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:40b:fec:bcbf:34af:77f4:28f0])
        by smtp.googlemail.com with ESMTPSA id x1sm8499834pfc.112.2020.12.18.04.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 04:11:43 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] checkpatch: fix false positive for COMMIT_LOG_LONG_LINE with URLs
Date:   Fri, 18 Dec 2020 17:41:33 +0530
Message-Id: <20201218121133.18614-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1ce4502a-d75a-7e27-5844-f195607c4c99@gmail.com>
References: <1ce4502a-d75a-7e27-5844-f195607c4c99@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently checkpatch warns for long line in commit messages even for
URL lines.

An evaluation over v4.13..v5.8 showed that out of 11729 warnings for
this class, around 299 are due to line starting with URL.

E.g., running checkpatch on commit 3cde818cd02b ("ASoC: topology:
Consolidate how dtexts and dvalues are freed") reports this warning:

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144761.html

Avoid giving users warning for character limit for such cases, instead
suggest them to prefix the URLs with "Link:"

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
changes in v2:
- Fix coding style ('} else {')
- Make the URL check follow RFC 3986 style
- Give warning only if the URL is first non-whitespace of the line
- Set $commit_log_long_line only for else case
- Fix the warning count with exact figures and according to first non-space char as URL

 scripts/checkpatch.pl | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index abd5a3d2e913..bf77bd0b22cf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3032,9 +3032,14 @@ sub process {
 		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
 					# A Fixes: or Link: line or signature tag line
 		      $commit_log_possible_stack_dump)) {
-			WARN("COMMIT_LOG_LONG_LINE",
-			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
-			$commit_log_long_line = 1;
+			if ($line =~ /^\s*\b[a-z][\w\.\+\-]*:\/\/\S+/i) {
+				WARN("COMMIT_LOG_LONG_LINE",
+				     "Consider prefixing the URL with 'Link:'\n" . $herecurr);
+			} else {
+				WARN("COMMIT_LOG_LONG_LINE",
+				     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
+				$commit_log_long_line = 1;
+			}
 		}
 
 # Reset possible stack dump if a blank line is found
-- 
2.17.1

