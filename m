Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB65928D239
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgJMQ1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgJMQ1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:27:38 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.215])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1DAF2528D;
        Tue, 13 Oct 2020 16:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602606458;
        bh=VvLg4BA2aipE7sAR/9VqpuKo0exxf/6qnWtsALjJAAk=;
        h=From:To:Cc:Subject:Date:From;
        b=ccb1L7d9SJUsDicsDXD8L1jwkztthC/sBGsgG08+oDGy8Ya+oBbOJFsCnVaiKmPmX
         WLo3v6bjV/KT7Chsutge3hhLnrT+n+8ivyWDPBHVZh08I7CMro0rwZ5fylWpXEKrnE
         k4dvDxqLLwXH3omvUkFr1DACZ9ZF1MXazQIxcir4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] docs: submitting-patches: describe preserving review/test tags
Date:   Tue, 13 Oct 2020 18:27:25 +0200
Message-Id: <20201013162725.13572-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From time to time, the novice kernel contributors do not add Reviewed-by
or Tested-by tags to the next versions of the patches.  Mostly because
they are unaware that responsibility of adding these tags in next
version is on submitter, not maintainer.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Reword, following Jonathan suggestions.
---
 Documentation/process/submitting-patches.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 58586ffe2808..83d9a82055a7 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -527,6 +527,13 @@ done on the patch.  Reviewed-by: tags, when supplied by reviewers known to
 understand the subject area and to perform thorough reviews, will normally
 increase the likelihood of your patch getting into the kernel.
 
+Both Tested-by and Reviewed-by tags, once received on mailing list from tester
+or reviewer, should be added by author to the applicable patches when sending
+next versions.  However if the patch has changed substantially in following
+version, these tags might not be applicable anymore and thus should be removed.
+Usually removal of someone's Tested-by or Reviewed-by tags should be mentioned
+in the patch changelog (after the '---' separator).
+
 A Suggested-by: tag indicates that the patch idea is suggested by the person
 named and ensures credit to the person for the idea. Please note that this
 tag should not be added without the reporter's permission, especially if the
-- 
2.17.1

