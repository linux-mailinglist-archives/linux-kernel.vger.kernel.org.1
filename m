Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3002B1D3EFF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 22:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgENUfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 16:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725975AbgENUfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:35:38 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776FBC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 13:35:38 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id u38so4981339qtc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 13:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9BiZrIIDw3M0g6PboTiYMY8t51GiXfniSm5hZD+98Oo=;
        b=EwY0yvygObLAQJwen3HSpuK/TwLQp37GPVqfKdjuth79tibyNGSbR51A2V8fJJSWlF
         lnm0DfnJlFiRYvY7h1cw2TpVpP7JH0A3okU0Et8/RTNYi5IhA300/rz5aEszLgdCQwOf
         ZcaB6Iez+PU+yEm6mvxF3dIPNwQHK1G2RNiE4QsroDGTy0Bj8+sCAKezhW8LgZrfrSRo
         1hf0cDrQ++vjZh/pLM7igbN1ArJgBqFY+Zi7+SEWZWjPT3iJuhEl+xukALmnoqJ/Kazf
         1cGbN5Xr5HK/VCNwpdGpZ2wpwQf58u/I/OaAYsY3GXeWNWif7htHJueSXPoUCWuDCZwp
         4vPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9BiZrIIDw3M0g6PboTiYMY8t51GiXfniSm5hZD+98Oo=;
        b=H+1iirLeZIRTQ16ah23bwQEL8cuJQLIdJ3BlgotEUkzGcQ6GrEPbc2vKdVoRLu94Kq
         EktmAZv24dQGd5ePP7ebf7rr0L0rqXxfY3OpIlqTYUsAn5TSrKmfnJhXMb5kke+/uFJm
         K0NgXArls2vheLCY8ZmxxLkP27ERh93qomFYdWMwGQ6nDsGk59lJG6HFj1MJS8Ixz3Hb
         zG2BS51cHNJZekqUoLtCL6ZCgbgCPjeJM7oo00JKrKwynWOTtWDWGBhSSoGzSUuF4xmZ
         aq3ysC3sOy+deFySc1wjGHPNAaDYxRELawRB7umniM601PsWlwjPWler6xLfP6HsKF58
         oAog==
X-Gm-Message-State: AOAM531ZfPVS+0p1MYbd04n4C7dwE6wathAEvocdm4EgBdmlQoyUCiX5
        TFyfw+lpLdqfx9sg5dN88Y36nymLJYCWV7rT
X-Google-Smtp-Source: ABdhPJzvf4EJtA2aien3OPVZDhyyMY/dMI2v7m8s7iY+rqrdouqJjQ7AjF3C8RswKPzEFY8is9MauS7O8ykCnK2O
X-Received: by 2002:a0c:b492:: with SMTP id c18mr264585qve.139.1589488537513;
 Thu, 14 May 2020 13:35:37 -0700 (PDT)
Date:   Thu, 14 May 2020 21:34:34 +0100
Message-Id: <20200514203434.22274-1-lihaoliang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH] doc: Update comment from rsp->rcu_gp_seq to rsp->gp_seq
From:   Lihao Liang <lihaoliang@google.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lihao Liang <lihaoliang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lihao Liang <lihaoliang@google.com>
---
 kernel/rcu/tree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2d7fcb9bdd34..508c46421eb3 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -41,7 +41,7 @@ struct rcu_node {
 	raw_spinlock_t __private lock;	/* Root rcu_node's lock protects */
 					/*  some rcu_state fields as well as */
 					/*  following. */
-	unsigned long gp_seq;	/* Track rsp->rcu_gp_seq. */
+	unsigned long gp_seq;	/* Track rsp->gp_seq. */
 	unsigned long gp_seq_needed; /* Track furthest future GP request. */
 	unsigned long completedqs; /* All QSes done for this node. */
 	unsigned long qsmask;	/* CPUs or groups that need to switch in */
@@ -149,7 +149,7 @@ union rcu_noqs {
 /* Per-CPU data for read-copy update. */
 struct rcu_data {
 	/* 1) quiescent-state and grace-period handling : */
-	unsigned long	gp_seq;		/* Track rsp->rcu_gp_seq counter. */
+	unsigned long	gp_seq;		/* Track rsp->gp_seq counter. */
 	unsigned long	gp_seq_needed;	/* Track furthest future GP request. */
 	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
 	bool		core_needs_qs;	/* Core waits for quiesc state. */
-- 
2.26.2.761.g0e0b3e54be-goog

