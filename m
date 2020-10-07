Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8032728679A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgJGSoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgJGSoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:44:12 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEFAC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:44:12 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id b12so1968025qte.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8I3vIcrMV5Zu6Hhqx7rsCDTZKSKCCDLk+NRUTUtCArI=;
        b=EvHdwN6QEoSSTRp9Gx+IDUr0457JMOACZ6z4Kk1NaukYrw0zsHpHUsc0nTWng/QB+J
         8i3JP1kd2Rc81mBUzXF8p9kaB7vh+OKfpMqOiwmLTHse+HwcvZEtOmuV7GU7OqvEl2VH
         /8CckH/DkeDYJ4jxTYTYnVNGBpiq9gVO+hsgY4S8xGjETNvNtMk4hx8CBxcrAIahliMl
         wTiKf3N/GqmgBYUwfVPGgmg40m0xPAlUOINUu7PzAjaDxakVD5tK7m1abbcoPcmmbuYn
         RsLeEZk5ET1WFM4f1UqC7lVRpzdVO451wIIXirjs/U/I/OOQm+u25HqZS7OV8MjrtdGS
         14Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8I3vIcrMV5Zu6Hhqx7rsCDTZKSKCCDLk+NRUTUtCArI=;
        b=KFIU4zVOa/ybkNENJkmmn8Wcm0R1S7qDJEX6o0hoKGbPwkRv4Fhsv4Puw8XMPpIENw
         e0TzVBQSL+W5jkWj4YcOehf4v/+3cP1lhKXFwj80Egsp8Nu2YbiSqziggl8AMhNUpIXq
         3Iquc33MjAFR6yTs3f7A/OTcB9APQo1v7ZfQQAj1sVS6nN4bcBik1qF2W/f9tLur2g7L
         etKialI8qkmQK1v/V1jG56a9uyZ0pOWi5bNjKwc2NnYjkBr0gCn0iB3LHYpO0X26Xxr+
         FoR/pxHvLA0TK/OiSOZYHneAFURNAefcuQK7RRTYxkDWI7UqvQ12QF4R/QCmmfSbQTsx
         440g==
X-Gm-Message-State: AOAM530WFTe2mH2rg9vBn577cA14UVDWsgBxaRoko9ep4AwCuzWl5pj9
        1tR0MHElROIc16sYxaesyGoUS5Gd9Cj0ODrsOBwN
X-Google-Smtp-Source: ABdhPJzgcOpNapDJXobR6oBhvoqgjcOsqXNBjp7J045y+FXg+z5qRgJ31WJhxSOMgSjC1NJlcmv4bzgqELn9TzamQduA
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:42ae:: with SMTP id
 e14mr4498331qvr.44.1602096251082; Wed, 07 Oct 2020 11:44:11 -0700 (PDT)
Date:   Wed,  7 Oct 2020 11:44:02 -0700
In-Reply-To: <20201007184403.1902111-1-axelrasmussen@google.com>
Message-Id: <20201007184403.1902111-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20201007184403.1902111-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v2 1/2] tracing: support "bool" type in synthetic trace events
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's common [1] to define tracepoint fields as "bool" when they contain
a true / false value. Currently, defining a synthetic event with a
"bool" field yields EINVAL. It's possible to work around this by using
e.g. u8 (assuming sizeof(bool) is 1, and bool is unsigned; if either of
these properties don't match, you get EINVAL [2]).

Supporting "bool" explicitly makes hooking this up easier and more
portable for userspace.

[1]: grep -r "bool" include/trace/events/
[2]: check_synth_field() in kernel/trace/trace_events_hist.c

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 kernel/trace/trace_events_synth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 742ce5f62d6d..92eb530ec287 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -187,6 +187,8 @@ static int synth_field_size(char *type)
 		size = sizeof(long);
 	else if (strcmp(type, "unsigned long") == 0)
 		size = sizeof(unsigned long);
+	else if (strcmp(type, "bool") == 0)
+		size = sizeof(bool);
 	else if (strcmp(type, "pid_t") == 0)
 		size = sizeof(pid_t);
 	else if (strcmp(type, "gfp_t") == 0)
@@ -229,6 +231,8 @@ static const char *synth_field_fmt(char *type)
 		fmt = "%ld";
 	else if (strcmp(type, "unsigned long") == 0)
 		fmt = "%lu";
+	else if (strcmp(type, "bool") == 0)
+		fmt = "%d";
 	else if (strcmp(type, "pid_t") == 0)
 		fmt = "%d";
 	else if (strcmp(type, "gfp_t") == 0)
-- 
2.28.0.806.g8561365e88-goog

