Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B363528CA40
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403869AbgJMI2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:28:15 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:37181 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390865AbgJMI2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:28:14 -0400
Received: by mail-ej1-f67.google.com with SMTP id e22so27063322ejr.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 01:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=kw2y1tn3qMQ3M1L5/KeGxNG3Ai4ey0qUVTHCYUpdUC0=;
        b=rHonCHq1TVe6BTihbB2RQ37HD7SamrJUtzwCvmXoukiNvoOu8/+9FbwhzZzBBNFo3M
         Z2xPxxOIQlg8trb0uTxgKBbjgygUzovvHW/kmWogeXfsM+fNR4ealHXBkAdNS61BLH3w
         oOUBmF0+D/rP5NeLoG6SP7cUXzi3xOYvZniBiFkV+tBVBN+v+/Tn3zW7nPS2Gcva/NeP
         YfLC71PbDGZLc0v2jVoot2wfp3pMavv5tOixBsh+mFFfSDm9R4CdKTBqBUr+uXNUi6s8
         IXjvFmwC8/8S2Q6Glf/gaAXDgic92NgQ8HN5NjrPiSuVxi5G1SXWJj2p7lAfrxbj89mo
         r+HA==
X-Gm-Message-State: AOAM533Dp4yiZwnxYfjB9wC9JfcLtzzDwiNU2GUSspSh9lDJEXIK7TPV
        vPf0ZNmgC/HMJd3Qu/1zJ7Y=
X-Google-Smtp-Source: ABdhPJxorbOl/ZJY9fbiErIphkjkv9tnlAClXWMbkVtM+G9C4h/ZSiTllneXNuoXq38bbvTLPOSRig==
X-Received: by 2002:a17:906:d8a3:: with SMTP id qc3mr32967568ejb.183.1602577692695;
        Tue, 13 Oct 2020 01:28:12 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id l9sm6414695edn.75.2020.10.13.01.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 01:28:12 -0700 (PDT)
References: <20201013053114.160628-1-juri.lelli@redhat.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        chris.redpath@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/features: Fix !CONFIG_JUMP_LABEL case
In-reply-to: <20201013053114.160628-1-juri.lelli@redhat.com>
Message-ID: <878scail9o.derkling@matbug.net>
Date:   Tue, 13 Oct 2020 10:26:59 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Oct 13, 2020 at 07:31:14 +0200, Juri Lelli <juri.lelli@redhat.com> wrote...

> Commit 765cc3a4b224e ("sched/core: Optimize sched_feat() for
> !CONFIG_SCHED_DEBUG builds") made sched features static for
> !CONFIG_SCHED_DEBUG configurations, but overlooked the CONFIG_
> SCHED_DEBUG enabled and !CONFIG_JUMP_LABEL cases. For the latter echoing
> changes to /sys/kernel/debug/sched_features has the nasty effect of
> effectively changing what sched_features reports, but without actually
> changing the scheduler behaviour (since different translation units get
> different sysctl_sched_features).

Hops, yes, I think I missed to properly check that config :/
Good spot!

> Fix CONFIG_SCHED_DEBUG and !CONFIG_JUMP_LABEL configurations by properly
> restructuring ifdefs.
>
> Fixes: 765cc3a4b224e ("sched/core: Optimize sched_feat() for !CONFIG_SCHED_DEBUG builds")
> Co-developed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

(did you get some wrong formatting for the changelog above?)

> ---
> v1->v2
>  - use CONFIG_JUMP_LABEL (and not the old HAVE_JUMP_LABEL) [Valentin]
> ---
>  kernel/sched/core.c  |  2 +-
>  kernel/sched/sched.h | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3dc415f58bd7..a7949e3ed7e7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -44,7 +44,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>  
> -#if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
> +#ifdef CONFIG_SCHED_DEBUG
>  /*
>   * Debugging: various feature bits
>   *
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 28709f6b0975..8d1ca65db3b0 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1629,7 +1629,7 @@ enum {
>  
>  #undef SCHED_FEAT
>  
> -#if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
> +#ifdef CONFIG_SCHED_DEBUG
>  
>  /*
>   * To support run-time toggling of sched features, all the translation units
> @@ -1637,6 +1637,7 @@ enum {
>   */
>  extern const_debug unsigned int sysctl_sched_features;
>  
> +#ifdef CONFIG_JUMP_LABEL
>  #define SCHED_FEAT(name, enabled)					\
>  static __always_inline bool static_branch_##name(struct static_key *key) \
>  {									\
> @@ -1649,7 +1650,13 @@ static __always_inline bool static_branch_##name(struct static_key *key) \
>  extern struct static_key sched_feat_keys[__SCHED_FEAT_NR];
>  #define sched_feat(x) (static_branch_##x(&sched_feat_keys[__SCHED_FEAT_##x]))
>  
> -#else /* !(SCHED_DEBUG && CONFIG_JUMP_LABEL) */
> +#else /* !CONFIG_JUMP_LABEL */
> +
> +#define sched_feat(x) (sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
> +
> +#endif /* CONFIG_JUMP_LABEL */
> +
> +#else /* !SCHED_DEBUG */
>  
>  /*
>   * Each translation unit has its own copy of sysctl_sched_features to allow
> @@ -1665,7 +1672,7 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
>  
>  #define sched_feat(x) !!(sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
>  
> -#endif /* SCHED_DEBUG && CONFIG_JUMP_LABEL */
> +#endif /* SCHED_DEBUG */
>  
>  extern struct static_key_false sched_numa_balancing;
>  extern struct static_key_false sched_schedstats;

