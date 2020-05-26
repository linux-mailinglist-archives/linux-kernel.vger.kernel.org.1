Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123E11C2984
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 05:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgECD3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 23:29:24 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:25073 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726746AbgECD3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 23:29:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588476562; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=MBHX7i94PSsUI1O3uRcgxREs2POitRI7x1o3BXdkHuQ=; b=li59VrNJRPA0TPVhvLDTu2UdZKQsEP5L87XmPeISglbT4DXLI04s65qXJyzeiuRot+MfjAEk
 SmedzGtvUekb9ya+ciUYqxnSerJr4ExfhBIIfTvR3MOvtSyEKvzaWZ8txbRkryzzF2sMLr0b
 X99lfjpwPlW1u4F0gsEQrnGPsvc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eae3a8d.7feb2474e5a8-smtp-out-n02;
 Sun, 03 May 2020 03:29:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C0550C432C2; Sun,  3 May 2020 03:29:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from sidgup-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01143C433D2;
        Sun,  3 May 2020 03:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01143C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sidgup@codeaurora.org
From:   Siddharth Gupta <sidgup@codeaurora.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts: headers_install: Exit with error on config leak
Date:   Sat,  2 May 2020 20:29:05 -0700
Message-Id: <1588476545-21082-1-git-send-email-sidgup@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Misuse of CONFIG_* in UAPI headers should result in an error as it exposes
configuration of different targets to userspace.

Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
---
 scripts/headers_install.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index a07668a..94a8335 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -64,7 +64,7 @@ configs=$(sed -e '
 	d
 ' $OUTFILE)
 
-# The entries in the following list are not warned.
+# The entries in the following list do not result in an error.
 # Please do not add a new entry. This list is only for existing ones.
 # The list will be reduced gradually, and deleted eventually. (hopefully)
 #
@@ -98,18 +98,19 @@ include/uapi/linux/raw.h:CONFIG_MAX_RAW_DEVS
 
 for c in $configs
 do
-	warn=1
+	leak_error=1
 
 	for ignore in $config_leak_ignores
 	do
 		if echo "$INFILE:$c" | grep -q "$ignore$"; then
-			warn=
+			leak_error=
 			break
 		fi
 	done
 
-	if [ "$warn" = 1 ]; then
-		echo "warning: $INFILE: leak $c to user-space" >&2
+	if [ "$leak_error" = 1 ]; then
+		echo "error: $INFILE: leak $c to user-space" >&2
+		exit 1
 	fi
 done
 
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
