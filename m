Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72FC294F66
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443883AbgJUPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443593AbgJUPBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:01:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECFEC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 08:01:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t4so1328264plq.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 08:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pxAcdVZl/YIRZ+Db6rT1ciQ/orlo2DSt1cDHO2mvbz8=;
        b=e0dSn7gNlfWmZ9NcZPlkwENydhaAtKyX+pH/ejlCnrg9uqUxmzzG6mcxcCQ6661BVU
         nU9jMfImnZXM7l0YzUlT8wk71a6UwM9iwgaVQX3SPgFgBdNVYdi/ztBokj0OH3qyCpZq
         c5/ZNRfpnvglJjcwoVWhelr+rnfN++WsmT2p188Su45BuK0uwPnoNLi/0tdxBWAyoWQL
         pKy+F4+opiQ8Zy6IdJv9uPl2bLfqCx05+QB5Q3SQqd8B4VLoUMLQSfpcsiUxODAy0RYV
         R8jDudapt/HHYG+NKGPcQoHfztq88x9IEPBjScVUxtKL0dGIb3D97dEYzjO7TE25wkjS
         oswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pxAcdVZl/YIRZ+Db6rT1ciQ/orlo2DSt1cDHO2mvbz8=;
        b=GPWAQIdBgeMeVZvS9uTE8hxcQGnt6PdFhWfLRdPtjDfbbJBQE4ahmlG1NztjEixzRc
         VL2BdeWALrzjJbv+eZGaKdZcoXz6n4nr207eslkrFmDiOhFeZwqtcct/DH8/bwyld6Zc
         4R3YnWB+mvMYksU7uICxL4OzbhaJfmglfBYh9akkc5FkccT+XdWvWhxgg9Op0I70LjgV
         TxwrDx29adcFzS3mKGXLp4le3rr6sIdAkLdfHdYsn3dbIMc16Yo4S8DJtx8Oulg8NTlT
         U7w6zaL68oUWBaQZh9MV+JpSEiGM2Ac9G1tiByM0XOzRaiyIReMkWs3TfJfAzOyjSoz2
         fXBw==
X-Gm-Message-State: AOAM531mul81yOMFU46d5ItAsCB/iLPcmbdzLRW5dt9nvKZbgXCa6/23
        uu6gykLrHrcpuX4+RnAfG2M=
X-Google-Smtp-Source: ABdhPJxyTGlPAOtFsyfXgAseCi6vB1MeM10HqBS/vG88cAZG3ZrU3MsuVzH1rNxjQauAGm+xUa9GJQ==
X-Received: by 2002:a17:90a:c28d:: with SMTP id f13mr3647088pjt.145.1603292503614;
        Wed, 21 Oct 2020 08:01:43 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:41d:60ec:8cb2:c45f:197:35d9])
        by smtp.googlemail.com with ESMTPSA id z6sm2776437pfg.12.2020.10.21.08.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 08:01:42 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, Aditya Srivastava <yashsri421@gmail.com>
Subject: [PATCH] checkpatch: fix false positive for REPEATED_WORD warning
Date:   Wed, 21 Oct 2020 20:31:20 +0530
Message-Id: <20201021150120.29920-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presence of hexadecimal address or symbol results in false warning
message by checkpatch.pl.

For example, running checkpatch on commit b8ad540dd4e4 ("mptcp: fix
memory leak in mptcp_subflow_create_socket()") results in warning:

WARNING:REPEATED_WORD: Possible repeated word: 'ff'
    00 00 00 00 00 00 00 00 00 2f 30 0a 81 88 ff ff  ........./0.....

Here, it reports 'ff' to be repeated, but it is in fact part of some
address or code, where it has to be repeated.
In this case, the intent of the warning to find stylistic issues in
commit messages is not met and the warning is just completely wrong in
this case.

To avoid all such reports, add an additional regex check for a repeating
pattern of 4 or more 2-lettered words separated by space in a line.

A quick evaluation on v5.6..v5.8 showed that this fix reduces
REPEATED_WORD warnings from 2797 to 1043.

A quick manual check found all cases are related to hex output in
commit messages.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/checkpatch.pl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9b9ffd876e8a..78aeb7a3ca3d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3050,8 +3050,10 @@ sub process {
 			}
 		}
 
-# check for repeated words separated by a single space
-		if ($rawline =~ /^\+/ || $in_commit_log) {
+# check for repeated words separated by a single space and
+# avoid repeating hex occurrences like 'ff ff fe 09 ...'
+		if (($rawline =~ /^\+/ || $in_commit_log) &&
+		$rawline !~ /(\b[0-9a-f]{2}( )+){4,}/) {
 			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
 
 				my $first = $1;
-- 
2.17.1

