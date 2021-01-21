Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F062FF14C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbhAURDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:03:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388150AbhAURCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:02:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C56BF23A5C;
        Thu, 21 Jan 2021 17:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611248482;
        bh=Rsolv4KdEYj4ujTQyobUo1FspLsrRH9/cauERyP2Qnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Zstw+F6NbXBuncTqcy9HbAXBjLVR6LohHdQUb8E9KIdSj6INCTsRLfwJBj+HDdRNB
         1hsA6ThoZS5CtDV/g4EGI6lv5gad7KEPZpSU7sF1rBq3stnLCmI+Src0KJo+nM5ZEE
         N17lSciZWqAXljTmrigkLhMbjsyiO/dy90eTmVahrLtejkuxd4MgugMb7KJhdLwIt8
         BsUIjLz9KU9UYUCF1iuUd4z4y4wT5ZUBk4XdRP831qRV4KCUkdqcH4+GXxxjXZNdhe
         Fm5n2c59NGwV8RnYIBd1DWjQ7ifH4ofeSdE6tcS6rEv6gDFAcxf3IaxKoEaEBTepg3
         swBAcPMoe8x4Q==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/6] selftests/ftrace: Add '!event' synthetic event syntax check
Date:   Thu, 21 Jan 2021 11:01:09 -0600
Message-Id: <b6b6d432163a253dfa42a27cf7905257662abdba.1611243025.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1611243025.git.zanussi@kernel.org>
References: <cover.1611243025.git.zanussi@kernel.org>
In-Reply-To: <cover.1611243025.git.zanussi@kernel.org>
References: <cover.1611243025.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check confirming that '!event' alone will remove a synthetic
event.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 .../trigger/inter-event/trigger-synthetic-event-syntax.tc     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
index 59216f3cfb12..2968cdc7df30 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
@@ -32,6 +32,10 @@ grep "myevent[[:space:]]u64 var1" synthetic_events
 # it is not possible to add same name event
 ! echo "myevent u64 var2" >> synthetic_events
 
+# make sure !synthetic event doesn't require a field
+echo "!myevent" >> synthetic_events
+echo "myevent u64 var1" >> synthetic_events
+
 # Non-append open will cleanup all events and add new one
 echo "myevent u64 var2" > synthetic_events
 
-- 
2.17.1

