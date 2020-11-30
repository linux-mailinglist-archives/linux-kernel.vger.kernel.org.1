Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177682C870D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgK3Oqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgK3Oq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:46:28 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF6CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:45:48 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b63so10519300pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0o+iVkGkhtW/JsLRW2aT613wTEd5WF5NdfyQyW4sAW0=;
        b=k2AufPqIo2BSbBECgdgXaaIiMHQNIqq4alWPXBAR6n6tzaXjiSREKjdREnPMTHpCZP
         zqv7pTdTkKllAeYS3nZupgxFAsBZHA71++zPXENwklQd1ofhMEnVnBV1WZCzo3Zxn5hx
         EiU5Pqm0NKixQmCGyx5gsV5ESxVvgpp+pTqAI3B24BG3m6zvPGnaSi23XEyrm09rjJKq
         W9FxPn6oAUgUnqVB5MQ5GmVxzPrtxQ76q0eCWKmJo2+iInUAj2P5ZjLo5hPKb7IvSifv
         yWJ8DsZ9qn4X3CE5rxVAy9GECGI9/1/XnlC1UuNAqxR55WyObkzxURhaJy+pXT56Axdc
         NMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0o+iVkGkhtW/JsLRW2aT613wTEd5WF5NdfyQyW4sAW0=;
        b=UdCHLYt1BUM5FoHLm7w7JDGCYL4eRxqPM/sUU42MLKpoI69gjLNKn+7brMKBCQREt0
         5XoKvARK17B0oPaFPTmiBw5JqqeFhjcF4/s2Jeq6VW+A8Ll34NSy0mCbThHgRbFlzsHD
         FZ2+9GuFMeKZLWMnW7G6TWhS2PB91PAp/zllelVd5jLFCdHAX13nERqBHI/qcq64p6Ix
         SlndEEFhZmW8/Brl5XpvhFJgMVNkaYz9ufLyyAV+xfJ+RVQZ+CS9O+i0oT5CdckW4cRO
         gHK8Kn2+NSDa7ohYiMwdIGXxWH+o2QgfEcpSOCY5xGZjW+nsCAVIKVWSTflFzVGqVRiM
         N5zA==
X-Gm-Message-State: AOAM531Io/1QYrJaORu4nYpCWL2EKkVdtc32j5DvQuZ8ibAIZs8aFC2T
        BPhYFCen2lNRbqnc5za8wHY=
X-Google-Smtp-Source: ABdhPJzYL1YzKkVrRoBDuApEp6dCP2TNK2FVpUPRoSRuAvqj0QtgFp6AmNa9w6bRMzAQ3yKgQRtJNA==
X-Received: by 2002:a62:7f4c:0:b029:198:bfe:96f6 with SMTP id a73-20020a627f4c0000b02901980bfe96f6mr19200149pfd.23.1606747547541;
        Mon, 30 Nov 2020 06:45:47 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:60e4:5627:76c2:b847:1df3])
        by smtp.gmail.com with ESMTPSA id z19sm16888333pfa.122.2020.11.30.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 06:45:45 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH] checkpatch: fix TYPO_SPELLING check for words with apostrophe
Date:   Mon, 30 Nov 2020 20:15:15 +0530
Message-Id: <20201130144515.8320-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch reports a false TYPO_SPELLING warning for some words
containing an apostrophe.

A false positive is "doesn't". Occurrence of the word causes
checkpatch to emit the following warning:

"WARNING: 'doesn'' may be misspelled - perhaps 'doesn't'?"

Check the word boundary for such cases so that words like
"doesn't", "zig-zag", etc. aren't misinterpreted due to wrong
splitting of the word by the \b regex metacharacter.

Reported-by: Peilin Ye <yepeilin.cs@gmail.com>
Tested-by: Peilin Ye <yepeilin.cs@gmail.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3c86ea737e9c..be6d09929941 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3106,7 +3106,7 @@ sub process {
 # Check for various typo / spelling mistakes
 		if (defined($misspellings) &&
 		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
-			while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
+			while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b(?![^\w]?[a-z@]+)|$|[^a-z@])/gi) {
 				my $typo = $1;
 				my $typo_fix = $spelling_fix{lc($typo)};
 				$typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);
-- 
2.27.0

