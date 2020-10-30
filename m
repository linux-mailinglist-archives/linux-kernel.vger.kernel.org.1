Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC1D2A049B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgJ3LpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgJ3Lo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:44:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43022C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:44:58 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 15so4964957pgd.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rAXM+9VMNaPbsfyoH/HWf0b+QAumMPRuShgqJW6Vef4=;
        b=l3FY7hEqq4Gy26gPUfe+oYIFkiOmx41+whEQvJIPdVAIGPtKmalOPVukJjlbxLMLA5
         chxvz6l2VhA+VqfKKA/A/7qd7kJ32RunmW1OcH4YSMyzUkMP4PQsqPL9xItJSTj8dhAg
         E3QMqvTzRJgd2pEYze+cdbrA8Vx8x9VSYzWgqe5/TcdgU/2R/vBVCJx6k0wimYorQG1/
         bK6JsDjM0MLJFgEiIskW7BehMEdmDsBhpe6HIwaF9VX6CQLdfmcNL1J+sdlocMotU0Uk
         drV0I42d8qLtnTjYF7lpWfOhKZoIGNV8N5zZyu+EHqSLDwGhtsGoPBYMkjrEUcS8EI2u
         1nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rAXM+9VMNaPbsfyoH/HWf0b+QAumMPRuShgqJW6Vef4=;
        b=E+XCgLmLe3lwaPWhHASotf7D33mEXAAFSawS5yniLHduB3x+4/Q9OGrEft/3+iJj+3
         6y7uSflxI14vEqeO5xszqB8EEoTXXaac0gV2o8KNKd26niVikesv+mTt6RMvfZ9Ge6af
         ufyzoEgTA3kBrKDzfpN4n0cAUXHa/JyXhS+7jkbIZZ6Nn2Y9S2h7NvQMkvCDJQom0fHM
         iyyEERrnSnn2LNNkR3PXuNuoJ4igbqMBcTvOLGi9lBZX//hN3lPvQPrqcFJmeUJjdrfw
         0yIAtaOqCa4WytkwBtlRccjRcXAyGz26/resNt0P7x/QuMiEp+eabRg2LmNBVmd1GpTM
         +oHw==
X-Gm-Message-State: AOAM530NH63BHJWTC07ZNH9ftniWCTe0/FfSuGsx9ilW0cm3fw6Q0PKm
        WzPpzBn6yXxJgeTnZGqxhdrLj3drlIup80EO
X-Google-Smtp-Source: ABdhPJwL8jWaZ6AzwkMA8y2syPtLZUqNZ9UrHMYgVcQVoPjgoUbsZ4ze4hdMYi9V0QOvo79rinkCDg==
X-Received: by 2002:a17:90b:378c:: with SMTP id mz12mr2449011pjb.137.1604058297578;
        Fri, 30 Oct 2020 04:44:57 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:43d:9a7f:2d51:fcbb:1c2a:666a])
        by smtp.googlemail.com with ESMTPSA id a10sm3135390pjq.17.2020.10.30.04.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:44:57 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, Aditya Srivastava <yashsri421@gmail.com>
Subject: [PATCH] checkpatch: add fix option for GERRIT_CHANGE_ID
Date:   Fri, 30 Oct 2020 17:14:47 +0530
Message-Id: <20201030114447.24199-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, whenever a Gerrit Change-Id is present in a commit,
checkpatch.pl warns to remove the Change-Id before submitting the patch.

E.g., running checkpatch on commit adc311a5bbf6 ("iwlwifi: bump FW
API to 53 for 22000 series") reports this error:

ERROR: Remove Gerrit Change-Id's before submitting upstream
Change-Id: I5725e46394f3f53c3069723fd513cc53c7df383d

Provide a simple fix option by simply deleting the indicated line.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/checkpatch.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7800a090e8fe..5329927fc1c1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2852,8 +2852,11 @@ sub process {
 
 # Check for Gerrit Change-Ids not in any patch context
 		if ($realfile eq '' && !$has_patch_separator && $line =~ /^\s*change-id:/i) {
-			ERROR("GERRIT_CHANGE_ID",
-			      "Remove Gerrit Change-Id's before submitting upstream\n" . $herecurr);
+			if (ERROR("GERRIT_CHANGE_ID",
+			          "Remove Gerrit Change-Id's before submitting upstream\n" . $herecurr) &&
+			    $fix) {
+                                fix_delete_line($fixlinenr, $rawline);
+                        }
 		}
 
 # Check if the commit log is in a possible stack dump
-- 
2.17.1

