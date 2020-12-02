Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970022CC533
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbgLBSbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgLBSbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:31:43 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8423FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:30:57 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x24so1782607pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dhu0y36YrMVMaqCIBmDd4/g2nz0PBTxsfK5aIIP2g1A=;
        b=VtPTQMR4jtXGflrx3/rVw/rmlMSkFDj4rjwbT6YMTGzrW7pCU2q4OI7w/xrwqe+RQx
         DKjcdYwi6VHJwWPtd9imSRe3lBgkrIMcUcQ2QADBVJ31NrOkpiZCZITF/0aFOsJwo7CJ
         uGHSNbB6ReRY4qsqcfBgXknpaJe+IA/K767VioWXHBUESkEUHqiB/zzRQcq70eFk5+Cc
         Xop2y5Fq4geLedJWZ/lmiMdHS7fcW0fYhAoDdv4S0XKmyYhcQP8WBLUpiVSfbF5VFcg+
         1AwuVXdz/AGNDQW55vOQkaNRQzc5lBo1tWx6VPRfznux6FpNwmHF56aIixADB5Rfx6zP
         kGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dhu0y36YrMVMaqCIBmDd4/g2nz0PBTxsfK5aIIP2g1A=;
        b=XcpDxwtoElE/PIf/XWYRCrzT2kQsUAbUBmuZYm3+94g176Drlecp4JMPZfcQElRRTT
         WPPnUOP5zLOl8G3WX0Qq2fUE3s3Lm6KvQ5Wc2+vsoN//LRK8jBzingpJ/WjC1SrAlAhD
         8EGmyxtV2ujwg697w50veL8gWXM8OxuNyeSfmkH/Ry+9WrugI9ElR6Qd2IItJLu/+vxg
         FzvMneJarYG2WfmzKUe3yjB9KCr4psqp6A9RZ7gBpP3fLT3r+yT+GLbS9M4VF61OXLZv
         ZkqV4FX9B6U30Xy/MzQXwgAIN0Sy+MvHBpF5BxDEAO7K44LhoS0ieuUrG6OsCsJmTYvn
         GgVA==
X-Gm-Message-State: AOAM533fbGizqHww4KoyzDqPBX8fq9fRR85gcRPSu3M7Oq+A4+w5ohbY
        w1PuGASRiu3WC1PHqehEDqI=
X-Google-Smtp-Source: ABdhPJxyuChm6ZlTgOgmUuuyWGzkTc4HRQKmNPb6bwVEDKEX6dVavLARWsOHOWBkyAUZQyAZLb0m0A==
X-Received: by 2002:a63:f60e:: with SMTP id m14mr1076364pgh.148.1606933856979;
        Wed, 02 Dec 2020 10:30:56 -0800 (PST)
Received: from localhost.localdomain ([2409:4063:4e14:4867:9984:8aed:2f75:bf22])
        by smtp.googlemail.com with ESMTPSA id s17sm429716pge.37.2020.12.02.10.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:30:56 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH -mmots] checkpatch: add fix for non-standard signature - co-authored-by
Date:   Thu,  3 Dec 2020 00:00:45 +0530
Message-Id: <20201202183045.9309-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <280235acc0e91365f3fd3b5be5a5244eced1ff61.camel@perches.com>
References: <280235acc0e91365f3fd3b5be5a5244eced1ff61.camel@perches.com>
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

