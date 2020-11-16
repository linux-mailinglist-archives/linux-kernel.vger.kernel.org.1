Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967B72B3EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbgKPIiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgKPIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:38:07 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FABEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 00:38:06 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id d3so8055597plo.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 00:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WiKXLY/e64nqLzEROzawOCPF5yuNSt2KsJE3wDL+hG0=;
        b=UlieRbSsJkdSMHAShiwmqv0g2mVeEvRzppJZpDLhEbmemUYktcQl0yNFkC0lW9aoLS
         i0M1Yjz2tLMt1Og2tnqqhw/Ch2ZoCM3H+/byU1ZUVzkvOpE0aEww2uVapxz+6lJcysDp
         PtrW23oa3DMGz/80Or22ywSi7ntEubOIufEWqmYY08g0WkkMWSEcHeQE3AskFNLkwuiV
         BhJhPo6soXewSOIAj//g3rJ2FX0trATpEfIIqIxFQS+VKdawsEXlWWSYDSYgTI0OQjfO
         EZskMYDqPVdFX32eVzPQWQvco1NJW0He7ICXogaQxarNNC9dryjjaKNSKVxV08m1Q8Wc
         OWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WiKXLY/e64nqLzEROzawOCPF5yuNSt2KsJE3wDL+hG0=;
        b=iTbG3B4ETArkMF/Z2qs5QH5d1tfhE902OC52AIW5kKp946fI2E/ujXM6NBP5f9lBlP
         jJ/8IL0DHe+tJCFDmuzfZyZN8Zw7MKReNy7T1qVRbxbjlKwfp19MiBLZAhjbJuN3bYLi
         qNbsEdqC4czpsl4vtwWz5v6qRAtRylnYCTVOQTAzHe3C6dD0Sbb+agKgRJQK/f/tvQGK
         0c+64HBXN5YENdvSIjEDWxGwMAhPTsGz9daQi4CffTEdbFuPO5/jGdIm8UBaG53jd9s8
         m6uD3yxKSXBpgIQvlZw+ESbiLhW/JRZm88Zwfc5JkqdoCC1UHkcW65r/z6zWCOLMt5fh
         tACg==
X-Gm-Message-State: AOAM532HDkAPJXdi1FTaykH0b+rsahS2unLLryGImLkqGXYRcltXoWli
        b9bSDUfNDXfiJnT97c0gUbgplqikqqdfzw==
X-Google-Smtp-Source: ABdhPJwELoBVlXDHbxY3wpR7gBLoCAH3kJJmwacUVPeq2NFAi1ZqUbuX53Wu2dHHQIhrVQ7KtOJDIA==
X-Received: by 2002:a17:902:b688:b029:d6:ad52:ffab with SMTP id c8-20020a170902b688b02900d6ad52ffabmr12026353pls.61.1605515885866;
        Mon, 16 Nov 2020 00:38:05 -0800 (PST)
Received: from localhost.localdomain ([42.111.137.21])
        by smtp.googlemail.com with ESMTPSA id p19sm17417034pjv.32.2020.11.16.00.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 00:38:05 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] checkpatch: avoid COMMIT_LOG_LONG_LINE warning for signature tags
Date:   Mon, 16 Nov 2020 14:07:54 +0530
Message-Id: <20201116083754.10629-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently checkpatch warns us for long lines in commits even for
signature tag lines.

Generally these lines exceed the 75-character limit because of:
1) long names and long email address
2) some comments on scoped review and acknowledgement, i.e., for a
dedicated pointer on what was reported by the identity in 'Reported-by'
3) some additional comments on CC: stable@vger.org tags

Exclude signature tag lines from this class of warning.

There were 1896 COMMIT_LOG_LONG_LINE warnings in v5.6..v5.8 before this
patch application and 1879 afterwards.

A quick manual check found all the dropped warnings related to signature
tags.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
Changes in v2:
modify commit message: remove specific commit example, add cause of the warning instead

Changes in v3:
modify commit message: minor english fix; remove difference count, add relative counts instead

 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ac7e5ac80b58..f2369ac29d50 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2961,8 +2961,8 @@ sub process {
 					# file delta changes
 		      $line =~ /^\s*(?:[\w\.\-]+\/)++[\w\.\-]+:/ ||
 					# filename then :
-		      $line =~ /^\s*(?:Fixes:|Link:)/i ||
-					# A Fixes: or Link: line
+		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
+					# A Fixes: or Link: line or signature tag line
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
 			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
-- 
2.17.1

