Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC0D304F88
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhA0DOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392815AbhAZTfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:35:41 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B88CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 11:35:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d38so18828874ybe.15
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 11:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ke7D9fXE7/oLwOCbqTBGeYbqS4lbEeFQkH3yQTesliQ=;
        b=GxUyfSKf6X+eCnNOTCNqbt7fF0THOqw0EZfmo1AwBPED6AgyT9cC7vEPm+sZQN4hbx
         tg7k+edySCoSdyyfQBDJxolUV4psqBe4xuez//mEUjWpngMTkIRL5FFQHuUENERbyFAP
         smk26teuC9MzXdqzuhiyguxQn9dXrFtnpcQEPykDR7E6E1czPN2zVHTH/PHuji0nO+20
         wOvkkmxgGBO0mQOWxQtfK5R29KZ9fLjJyh1WiRMAuojk9bRs1iBmb93dFiFYcN7S7evl
         HQOniSWr5kDJPSFLWzYJx2W5ed17IE3p3tPCScLcQznCqhTlDs1iYwomD1e0t4cP6ktG
         DLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ke7D9fXE7/oLwOCbqTBGeYbqS4lbEeFQkH3yQTesliQ=;
        b=HKWQOziGTDsmtYpyFGcE6jETU/rjqWZUaP5M82IYTjk8rzd+zNsRLzYF2O0x+MBrzz
         7R/3j3X7xITKLOjFXVl+ikfekgnSeLh89wf2Z0CBnTwS3497KzPsOrxPO10Bfs4G5SVs
         sOaaMmZ4HsJI4AYko5Mqd9myg5vHiaOvQvaGlziviKbFI0V74UtQeF7cev6rzE2It5Uk
         m/QJ0g9JVNzICwlioeEYnmZvrvEoap1ziwBCxk8d0jUN4KRHjMq/5kbgt0t+9uo5IU7b
         xY9Eaf6W5ZhcTlzRrTjjyna3KrSGESZYvtVMBvn+Wur4sNChrwsdD/WBrKM/1XqLc5Y1
         VJJA==
X-Gm-Message-State: AOAM5315stP4cmVYrtELU1DIDMQZa3/1c/S/qhvSvg070vBNr5SCJRX5
        nJuA554mDtOPTPEe/usmMVdo1W/l
X-Google-Smtp-Source: ABdhPJy1eVlCwQrd8HFYEMK4p1ByZaM3O5ENx+34QFkVuggGjxYFfYqT1LWFkO+lkfWOU2FzEi9f3F72
Sender: "posk via sendgmr" <posk@posk.svl.corp.google.com>
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:4550:d22f:33f9:3709])
 (user=posk job=sendgmr) by 2002:a25:a125:: with SMTP id z34mr10409570ybh.22.1611689699345;
 Tue, 26 Jan 2021 11:34:59 -0800 (PST)
Date:   Tue, 26 Jan 2021 11:34:49 -0800
Message-Id: <20210126193449.487547-1-posk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH] sched: a very minor refactoring.
From:   Peter Oskolkov <posk@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Oskolkov <posk@posk.io>, Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment says:
  /* task_struct member predeclarations (sorted alphabetically): */

So move io_uring_task where it belongs (alphabetically).

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 31169e70476a..e1152227bb79 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -47,6 +47,7 @@ struct cfs_rq;
 struct fs_struct;
 struct futex_pi_state;
 struct io_context;
+struct io_uring_task;
 struct mempolicy;
 struct nameidata;
 struct nsproxy;
@@ -65,7 +66,6 @@ struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
-struct io_uring_task;
 
 /*
  * Task state bitmask. NOTE! These bits are also
-- 
2.30.0.365.g02bc693789-goog

