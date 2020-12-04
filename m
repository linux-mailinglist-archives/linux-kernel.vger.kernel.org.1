Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C3A2CEFE3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgLDOkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbgLDOku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:40:50 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1DAC061A52
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 06:40:10 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z12so3190971pjn.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 06:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QbGG+QSHQ3ZiuhAQdumnEcGwmaXAKMHyqeMSedOarG8=;
        b=pCdeO8ca1BLD8/+3MrfyO1Oaf0o02KRsUH5zSuWitu5IAXiq09fT7hetTlPVAhu78m
         UkAa+0hmWkUOcjGK6uS6M7wv9/yr5RTAUh8eoK294muZY44AXcWQAb2eAx7C+XxEbev4
         B0Ris1Hf5ZpeC/bV/Yy4vHxqYsDiCFQqjwGCUDKYNFmsJKvvonzq9X0o9ZZZnMJHIYsj
         Ifcz5vjSBevjTC4i0GRX6yE90mIhXMIZG8CiYhzJoEEyABVEVbDK1CT9ZkgQ5ADpSLUs
         l4b7J8QeNCZyVVdPJ7xChghuZyEEcO73WEhovoanHmE+k5sJX+3DJkk8lyu5MR0zdYzj
         bKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QbGG+QSHQ3ZiuhAQdumnEcGwmaXAKMHyqeMSedOarG8=;
        b=qE5Zp9wtkHTBUo1jsnK1kQJZyAb23sW3MsWxnoL6urg0sr8OrVZVqiszvCnSm7te5A
         Wt53egh1MuyjLIVo1GIfkCeOckhMliYKR6Ro22moa604cyOZMRO5bqegw5W7T6DAkqS8
         EoTfFQ3B7Vk8Vsn9tGpH2AhlBiijrIE4GFqe8OUKigzVLwpFAGFK85fKaMpEtBWcC2SU
         WEf1Q08bB9kdsZVgc8j8wEBPWS2hhA720ZV9R54lkNTtbWp2IZRbGD3mgkwtRCGvZtOd
         QXgVKjWAvEYP8p0GInqroat+FongVgnMUqyUAIQ9YsWggIalkOtwTvT2gGJJf/AMT3n/
         aKvQ==
X-Gm-Message-State: AOAM533d7F9eUXcLZZVQTvTE4g2kUNKdVbsdn/YAFop2sFWfaezXh4Qp
        nmqiN2+qeT1FWxxfCAlGFWSf8doBppgq4w==
X-Google-Smtp-Source: ABdhPJwX7nzTsLtA7yQjhbEF6V6IBUFuFwSQNYLS1ZauHkXgYQ4viF1Zz/SNOraBkisdVNmarie8QA==
X-Received: by 2002:a17:902:76c1:b029:da:2f5:ed5d with SMTP id j1-20020a17090276c1b02900da02f5ed5dmr4231470plt.25.1607092809768;
        Fri, 04 Dec 2020 06:40:09 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:43f:b9bb:d059:d26:c75b:b30a])
        by smtp.googlemail.com with ESMTPSA id y69sm2435140pfg.75.2020.12.04.06.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 06:40:09 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v6] checkpatch: add fix for non-standard signature - co-authored-by
Date:   Fri,  4 Dec 2020 20:10:00 +0530
Message-Id: <20201204144000.21734-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <a2c74693-93ae-cd5a-7836-4ffff643fc09@gmail.com>
References: <a2c74693-93ae-cd5a-7836-4ffff643fc09@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, checkpatch.pl warns us for BAD_SIGN_OFF on the usage of
non-standard signatures.

An evaluation on v4.13..v5.8 showed that out of 539 warnings due to
non-standard signatures, 43 are due to the use of 'Co-authored-by'
tag, which may seem correct, but is not standard.

The standard signature equivalent for 'Co-authored-by' is
'Co-developed-by'.

Provide a fix by suggesting users with this signature alternative and
replacing.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
applies perfectly on the latest next-20201204 branch

changes in v2: replace commit specific example with brief evaluation

changes in v3: provide rationale to users for every signature tag suggestion;
modify commit message describing arrival to conclusion in a structured way

changes in v4: modify rationale for certain suggestions

changes in v5: remove the tag deletion suggestions, ie "Generated-by" and "Celebrated-by"; rebase on last accepted changes; modify commit message

changes in v6: reduce tag suggestions to only "Co-authored-by"; modify commit message accordingly; include complete version changelog

 scripts/checkpatch.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4a026926139f..fc036d545d2d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2832,6 +2832,9 @@ sub process {
 
 			if ($sign_off !~ /$signature_tags/) {
 				my $suggested_signature = find_standard_signature($sign_off);
+				if ($sign_off =~ /co-authored-by:/i) {
+					$suggested_signature = "Co-developed-by:";
+				}
 				if ($suggested_signature eq "") {
 					WARN("BAD_SIGN_OFF",
 					     "Non-standard signature: $sign_off\n" . $herecurr);
-- 
2.17.1

