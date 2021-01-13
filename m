Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466422F4105
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 02:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbhAMBT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 20:19:58 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:21822 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbhAMBT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 20:19:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610500774; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=YSG/qQ1q1fMOG/Hav8fx9/REuPQIkzfFlEODaYgoTI8=; b=cKivp+E6eGYR/eqtFUaqJX2yvb4A5Fmr2gjvIDifga5TDoc2n6m1/ERzGkbmzG4rAmNgabLc
 Ih5KqmJezhWqyRWl+g1fHyeryCBYWy8BDJ+4WDzxyW2RuW2aZko5ujueeZ56DV1fzhBXmfQG
 cale23LQJqN0xK4D4CwPIDrfFUc=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ffe4a8a415a6293c5eb7b6a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 13 Jan 2021 01:19:06
 GMT
Sender: jjohnson=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B92C3C43461; Wed, 13 Jan 2021 01:19:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jjohnson)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7BDB5C433CA;
        Wed, 13 Jan 2021 01:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BDB5C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jjohnson@codeaurora.org
From:   Jeff Johnson <jjohnson@codeaurora.org>
To:     linux-kbuild@vger.kernel.org
Cc:     psodagud@quicinc.com, eberman@quicinc.com,
        Mahesh Kumar Kalikot Veetil <mkalikot@codeaurora.org>,
        Jeff Johnson <jjohnson@codeaurora.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kbuild: simplify cmd_mod
Date:   Tue, 12 Jan 2021 17:18:50 -0800
Message-Id: <1610500731-30960-1-git-send-email-jjohnson@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mahesh Kumar Kalikot Veetil <mkalikot@codeaurora.org>

Modules with a large number of compilation units can exceed execv
argument list resulting in E2BIG (Argument list too long) error.

Fix this by replacing shell 'echo > file' into a more native
$(file op filename[,text]) option.

Signed-off-by: Mahesh Kumar Kalikot Veetil <mkalikot@codeaurora.org>
Signed-off-by: Jeff Johnson <jjohnson@codeaurora.org>
---
 scripts/Makefile.build | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 4c058f1..252b7d2 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -279,10 +279,11 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
 	$(call if_changed_rule,cc_o_c)
 	$(call cmd,force_checksrc)
 
-cmd_mod = { \
-	echo $(if $($*-objs)$($*-y)$($*-m), $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)), $(@:.mod=.o)); \
-	$(undefined_syms) echo; \
-	} > $@
+cmd_mod = $(file >$@,\
+		$(if $($*-objs)$($*-y)$($*-m), \
+			$(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)), \
+			$(@:.mod=.o))) \
+	$(undefined_syms) echo >> $@
 
 $(obj)/%.mod: $(obj)/%.o FORCE
 	$(call if_changed,mod)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

