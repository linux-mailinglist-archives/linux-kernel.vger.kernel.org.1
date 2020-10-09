Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A49289B95
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 00:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389992AbgJIWFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 18:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgJIWFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 18:05:31 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C2AC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 15:05:31 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id n8so7698610pgv.14
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 15:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=P3zh56605aw3etCHRqEnAMV5pM6KCjNDIRD7NDvRgXI=;
        b=t0+NyCh6jdjxgRPAZG6P+/ltegNieLG9x+vuVTY4RBmE9jAZDh3fHF9zAEpaLn+o0Z
         F9Ur8Y9cwDZ/TteieT8YZF48CawXHH2kXf9cc3CDCKuNEMYIlL8Ff2QFHZpp28daOsgK
         pm1IF0D9k4kW/k+dlf8ezx2dfyGqqoDjAhgXvRQwH+aLOBw/b6VT0QTv87fDOFpmbkBL
         GR0NuuRQy6UZzYEJMOx5E+ahPBW+UkfYtBM7zqan4Fty3jvjCnfZW0eMAoMqYkw0Ypr6
         Ol2VLRIi8qPzvovHeAXHuVCp+0zF0X10+oJNmXycEkv1k1YY40IJkgXvFZlImwyx8LjI
         pbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P3zh56605aw3etCHRqEnAMV5pM6KCjNDIRD7NDvRgXI=;
        b=PhiSG6xUZBbrH5fHMWL3AkWBVEeoh2FkbyfJBgfeSIMk7X9FlB027jQ5WEIlJpcQHo
         Isa/CqABrJ4lUlCo7kNateHFK3s8QHS1IkVTCCfH/sdytVSTBHREXXGM+cy4vvuD59u/
         BzKmbPNv6QFvUPTgTdj7pFwOMLEismG/BD/sK8DZSvuSL+VY0+hq94S0TyNKgPQCbhoW
         qXoIHH2FwGcZ1AEysvSUWj+fWtspBbYCLWWNtT8BD/0b2KH3yOjDFg2LqSa8NrbnaQEH
         aPbT3WtvLpUBAN/yi8CECASNV3hiE8Sbw3tIxDgM/9zGBESQYoZq6hYzh0w1ih88Yib2
         Ccqg==
X-Gm-Message-State: AOAM530avYwkgfCuNw/eIC3Cn4a5r/HF2dS0Q283uqIc557pLoIdEl+p
        wsOeIBdgK63suUn6oj+2ghINqANwcJEG4TupYiXD
X-Google-Smtp-Source: ABdhPJy9z+/rA1j7Repb1JxRjQy2PvR0s/646IIzv9KPrPXcBJo38uYMWZ7o4gIo0ScfSy/L1jQh+IwgU4G9nrr3AD1m
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a65:5b48:: with SMTP id
 y8mr4907900pgr.67.1602281130575; Fri, 09 Oct 2020 15:05:30 -0700 (PDT)
Date:   Fri,  9 Oct 2020 15:05:23 -0700
In-Reply-To: <20201009220524.485102-1-axelrasmussen@google.com>
Message-Id: <20201009220524.485102-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20201009220524.485102-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v3 1/2] tracing: support "bool" type in synthetic trace events
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

Acked-by: Michel Lespinasse <walken@google.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 kernel/trace/trace_events_synth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 8e1974fbad0e..8f94c84349a6 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -234,6 +234,8 @@ static int synth_field_size(char *type)
 		size = sizeof(long);
 	else if (strcmp(type, "unsigned long") == 0)
 		size = sizeof(unsigned long);
+	else if (strcmp(type, "bool") == 0)
+		size = sizeof(bool);
 	else if (strcmp(type, "pid_t") == 0)
 		size = sizeof(pid_t);
 	else if (strcmp(type, "gfp_t") == 0)
@@ -276,6 +278,8 @@ static const char *synth_field_fmt(char *type)
 		fmt = "%ld";
 	else if (strcmp(type, "unsigned long") == 0)
 		fmt = "%lu";
+	else if (strcmp(type, "bool") == 0)
+		fmt = "%d";
 	else if (strcmp(type, "pid_t") == 0)
 		fmt = "%d";
 	else if (strcmp(type, "gfp_t") == 0)
--
2.28.0.1011.ga647a8990f-goog

