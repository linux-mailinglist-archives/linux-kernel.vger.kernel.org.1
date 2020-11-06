Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3FC2A8D89
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 04:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgKFDdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 22:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFDdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 22:33:05 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE105C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 19:33:03 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id v12so27059pfm.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 19:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Dyl+aTlvkkG8uUCOXZSdQCJboMpohOISJ8TcxUwnALo=;
        b=hrqFGTorrRN2Rmv+VraBptDd1q30z9D6uKUq4YsL64UYjmtklSm9oj33KT1eKVayGr
         NFkuLHxXlzurrwpXEd3jSye/we4nG99FII+B15j6kPK96kHNEC3sZW8HuQ9BaUeYvrfY
         jXMsM2Lp8x3UtftEHlNAFMavCD1sIlUGv2Ud5/2X5lq0XmwQWdA/GSpiW5Qz9IKmQM4/
         h0nD+I2PvglyQnt9gNIqC0FmjUxqcelwWsZeRDYTfi5j3oMikLbbm7T+z3daGAponBuK
         ZKVFnL3np+dqKTaDY479ZeGMTXdH1IqUUDEWQ0ZEEwyDWo1FbvvT5kYylhirqvQNBbVl
         oByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dyl+aTlvkkG8uUCOXZSdQCJboMpohOISJ8TcxUwnALo=;
        b=ouivobHtZoBdMCyGO6bIMP2YrVdWTpksJ7GIlk+cxdBHeeOSxqAEKU9zZCq356Z8ZJ
         /1hfl/Ugd96YIu7vvBifZ3VcG+p49l1J5U+VVBTuE+i/yzYQiBsfwLWxiSmu565+kVpf
         sYZbL7WhcIBbJpVZ3VwcQlxcLGDIZTD5kwVD3LR/lCZNj1CJouOZ/y/uS3sSCrfS3nKV
         CmATwcFXDHpsq6q48eLzYiFGMmY/HmmNE5FoTE7+gv4KlD+W4+btBq73qa/2mBGeKhYV
         pHbOo/vwtngHHX4K2JqWeagL7U3Ossartqqj3DP9dkZy/EG6t6Pjmx39DoNJin7aHPR4
         MuSA==
X-Gm-Message-State: AOAM533oQNUIe3D2u++d49xiXrHQweaQLlhn9ykDHG/Zesoqk2hsinlA
        x2g55UKBZVw++XA9z3eU6g==
X-Google-Smtp-Source: ABdhPJzXEWNpHGyf8ud/1PFvDU2vRKSzbpp4pCL+fq55ats6/HNexmXKnmn82/e5SfMFkl7ZtcS4Gg==
X-Received: by 2002:a62:7e44:0:b029:163:f1c3:3b32 with SMTP id z65-20020a627e440000b0290163f1c33b32mr140174pfc.62.1604633583470;
        Thu, 05 Nov 2020 19:33:03 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id a10sm110884pjq.17.2020.11.05.19.33.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 19:33:01 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] perf script: Remove unnecessary conversion to bool
Date:   Fri,  6 Nov 2020 11:32:56 +0800
Message-Id: <1604633576-32450-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Here we could use the '!=' expression to fix the following coccicheck
warning:

./tools/perf/builtin-script.c:3209:48-53: WARNING: conversion to bool not needed here
./tools/perf/builtin-script.c:2761:36-41: WARNING: conversion to bool not needed here

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 tools/perf/builtin-script.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 48588ccf902e..b5a6fd63ca5f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2758,7 +2758,7 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 				break;
 		}
 		if (i == imax && strcmp(tok, "flags") == 0) {
-			print_flags = change == REMOVE ? false : true;
+			print_flags = change != REMOVE;
 			continue;
 		}
 		if (i == imax) {
@@ -3206,7 +3206,7 @@ static char *get_script_path(const char *script_root, const char *suffix)
 
 static bool is_top_script(const char *script_path)
 {
-	return ends_with(script_path, "top") == NULL ? false : true;
+	return ends_with(script_path, "top") != NULL;
 }
 
 static int has_required_arg(char *script_path)
-- 
2.20.0

