Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DA0261994
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 20:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbgIHSVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 14:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731513AbgIHSQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:16:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78858C061756
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:16:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z1so215781wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=date:in-reply-to:references:mime-version:content-transfer-encoding
         :subject:to:cc:from:message-id;
        bh=N8TtjF7op38Ipqdy8ruAYnD1+q0nv/cwpgUpeRIlsl4=;
        b=CHlchrubAIs2/TXBCYJlGSccVe9N3WapZsFSCeBRMAT5eqVJ1Sto6lGc1Qm4aHLvKZ
         77fyP2eOqYSrVurkxn6cJ1AGLN6eCJ8cSO+zNkLYiiUhwyHLQZHhgEVOMvYdGm8G0ZMC
         BI4fdF9wJLg03IznD6Fq0zC8BqWjXhU8LP+yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=N8TtjF7op38Ipqdy8ruAYnD1+q0nv/cwpgUpeRIlsl4=;
        b=qQhfnUiFKedRx7mfAbJMV+PktilpgJ/ZY8dR/wDQCQ9+lg8tMCrvAaHe5hRAOq8eig
         wpXXrYWfwACFKA6xCPD3gb3n+w5BaOL+6Gruu/XzVKcTjIhEwbZlR3BMmz9D7PnPJAz5
         zW3elJRvBPulvQ1JeK3rYOMVSfh2zn9d8jkV4jTTe4ScSiGDqfKWqGGaVf/NXM//yDCS
         PAcsIxCkPvwecAPuoTmMLzYb6JatDJ/UjpCOP+naAmvWNGNbDJruX5AWF0OgMndw1nyS
         vAZwPYwV1GoPnZVmY8IfpW05Ta3/61nl9npJisMHlf77OtJ1rSqVd2J3BiDgTENqwEXL
         737g==
X-Gm-Message-State: AOAM530jmFM7NZuJY8gu9D1ycP8b2fEhe9TbcUetqZPU2DN2IbyhYA95
        O8idL05Eg2Q5KmPCNcuhClzh/w==
X-Google-Smtp-Source: ABdhPJzbN47yDdBOPE080tCOdGXZ05JHWTv5GvJlEr+LWJF2CDWB4rLzZDRfY9ynGEmyFVzR+kbsNQ==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr877997wrp.298.1599588960755;
        Tue, 08 Sep 2020 11:16:00 -0700 (PDT)
Received: from localhost ([149.62.205.110])
        by smtp.gmail.com with ESMTPSA id p11sm262199wma.11.2020.09.08.11.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 11:16:00 -0700 (PDT)
Date:   Tue, 08 Sep 2020 21:15:56 +0300
In-Reply-To: <20200908173624.160024-1-kuba@kernel.org>
References: <20200908090049.7e528e7f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <20200908173624.160024-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] rcu: prevent RCU_LOCKDEP_WARN() from swallowing the condition
To:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
CC:     netdev@vger.kernel.org, paulmck@kernel.org, joel@joelfernandes.org,
        josh@joshtriplett.org, peterz@infradead.org,
        christian.brauner@ubuntu.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        roopa@nvidia.com
From:   nikolay@cumulusnetworks.com
Message-ID: <5ABC15D5-3709-4CA4-A747-6A7812BB12DD@cumulusnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 September 2020 20:36:24 EEST, Jakub Kicinski <kuba@kernel=2Eorg> wrote=
:
>We run into a unused variable warning in bridge code when
>variable is only used inside the condition of
>rcu_dereference_protected()=2E
>
> #define mlock_dereference(X, br) \
>	rcu_dereference_protected(X, lockdep_is_held(&br->multicast_lock))
>
>Since on builds with CONFIG_PROVE_RCU=3Dn rcu_dereference_protected()
>compiles to nothing the compiler doesn't see the variable use=2E
>
>Prevent the warning by adding the condition as dead code=2E
>We need to un-hide the declaration of lockdep_tasklist_lock_is_held()
>and fix a bug the crept into a net/sched header=2E
>
>Signed-off-by: Jakub Kicinski <kuba@kernel=2Eorg>
>---
> include/linux/rcupdate=2Eh   | 2 +-
> include/linux/sched/task=2Eh | 2 --
> include/net/sch_generic=2Eh  | 2 +-
> 3 files changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/include/linux/rcupdate=2Eh b/include/linux/rcupdate=2Eh
>index d15d46db61f7=2E=2Ecf3d3ba3f3e4 100644
>--- a/include/linux/rcupdate=2Eh
>+++ b/include/linux/rcupdate=2Eh
>@@ -320,7 +320,7 @@ static inline void rcu_preempt_sleep_check(void) {
>}
>=20
> #else /* #ifdef CONFIG_PROVE_RCU */
>=20
>-#define RCU_LOCKDEP_WARN(c, s) do { } while (0)
>+#define RCU_LOCKDEP_WARN(c, s) do { } while (0 && (c))
> #define rcu_sleep_check() do { } while (0)
>=20
> #endif /* #else #ifdef CONFIG_PROVE_RCU */
>diff --git a/include/linux/sched/task=2Eh b/include/linux/sched/task=2Eh
>index a98965007eef=2E=2E9f943c391df9 100644
>--- a/include/linux/sched/task=2Eh
>+++ b/include/linux/sched/task=2Eh
>@@ -47,9 +47,7 @@ extern spinlock_t mmlist_lock;
> extern union thread_union init_thread_union;
> extern struct task_struct init_task;
>=20
>-#ifdef CONFIG_PROVE_RCU
> extern int lockdep_tasklist_lock_is_held(void);
>-#endif /* #ifdef CONFIG_PROVE_RCU */
>=20
> extern asmlinkage void schedule_tail(struct task_struct *prev);
> extern void init_idle(struct task_struct *idle, int cpu);
>diff --git a/include/net/sch_generic=2Eh b/include/net/sch_generic=2Eh
>index d60e7c39d60c=2E=2Eeb68cc6e4e79 100644
>--- a/include/net/sch_generic=2Eh
>+++ b/include/net/sch_generic=2Eh
>@@ -443,7 +443,7 @@ static inline bool
>lockdep_tcf_proto_is_locked(struct tcf_proto *tp)
> 	return lockdep_is_held(&tp->lock);
> }
> #else
>-static inline bool lockdep_tcf_chain_is_locked(struct tcf_block
>*chain)
>+static inline bool lockdep_tcf_chain_is_locked(struct tcf_chain
>*chain)
> {
> 	return true;
> }

Ah, you want to solve it for all=2E :)=20
Looks and sounds good to me,=20
Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks=2Ecom>

