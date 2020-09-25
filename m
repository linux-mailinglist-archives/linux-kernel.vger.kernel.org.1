Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B17278F11
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgIYQuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:50:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgIYQuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:50:50 -0400
Date:   Fri, 25 Sep 2020 18:50:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601052648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IBNjgF3/8mqHiQSTsgCIa+Fre0RfhFizyGjmkQ5YAOw=;
        b=bOjPC+emUWcrAp4F8ySfGk93fW74piiWa9Iw4XcHQEBiSTsRAC1vqj5bedu9BHxnoi8KG8
        D7U1eeimp2KzjwK4ezd3bZ/1gnCloqIjlcVdXsYlNmR7JEGPk0ZQLwQHgK3/pju7h6xzDO
        UGuG0S/u+5BNXhAp1OAS3RezlLAA2PWSvUI3cj5P9wT9JarEtSIbGYR8IgyHXU8BQ5Xetb
        jfNm/KDOixOKpQS0Xyru0S8+T7c7+Jmyz31Hu3SwSTeaAwcS7OxvbrBa5YKNoPkJ5KPlYN
        j7NPH8cKqK7K4GipD9lVBgQmD60pXGo5v17o8sMIT2XP0NSJEnIzHSS8jDoYzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601052648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IBNjgF3/8mqHiQSTsgCIa+Fre0RfhFizyGjmkQ5YAOw=;
        b=4PqZ4DNBiHs7NWi5KsUQ8cXS8O2FiJQvYNwB3StPlyRn6O7pc827MdOTHa6pAUQ4QUAhu9
        P9JcAUjDgFQqa+AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, swood@redhat.com, valentin.schneider@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 7/9] sched: Add migrate_disable()
Message-ID: <20200925165047.iey2dlcdn4im2vv4@linutronix.de>
References: <20200921163557.234036895@infradead.org>
 <20200921163845.769861942@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200921163845.769861942@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-21 18:36:04 [+0200], Peter Zijlstra wrote:
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1700,6 +1700,68 @@ void check_preempt_curr(struct rq *rq, s
> =20
>  #ifdef CONFIG_SMP
> =20
> +#ifdef CONFIG_PREEMPT_RT
=E2=80=A6
> +static inline bool is_migration_disabled(struct task_struct *p)
> +{
> +	return p->migration_disabled;
> +}

Just a thought: having this with int as return type and defined in a
header file then it could be used in check_preemption_disabled() and in
the tracing output.

> +#else
> +
> +static inline void migrate_disable_switch(struct rq *rq, struct task_str=
uct *p) { }
> +
> +static inline bool is_migration_disabled(struct task_struct *p)
> +{
> +	return false;
> +}
> +
> +#endif

Sebastian
