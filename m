Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07261CAFEB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 15:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbgEHNVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 09:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728633AbgEHNVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:21:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81118C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 06:21:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so1814350wrt.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 06:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EdCijOczIQMLs1X4cAiihh7qwIxfmO/FmCoXMHIAt4I=;
        b=QF9qhyvg3Qeb+YdknO2fao+XlPzsK19K/rtqFb+isyApE2gUA67kAJtCEbpFlaMbpL
         dcijhFnjRYwsGrSpYFEdti57I43KZ8UJ0e+M60tBa2Gbm3/cm8H7yiqCqG6EY0EgxY1C
         BeU3J+n0cXh29+FgY+fqG/ymytpuJWNTQHSnllJBQmDNb7rHv3lAlxjwr0etXAa2ptFB
         7g7oPs/+taioniIBI29hoil0gYL0DZVP0rgSC2ri1qjfbIcpf1DDmjD0eszCHTKT00WF
         k43oRpf8CYrDjieni9DUKpnnVMOxSLg06KLLhPJKXzpr0eyaH1TlvS1MwzQJLpAvAysn
         YYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EdCijOczIQMLs1X4cAiihh7qwIxfmO/FmCoXMHIAt4I=;
        b=fj+Z97ncHc466zoD5jhK6qoDDc7pBpA0jCmBfqdaC7OlPWPg8WFXNwYT5r1v9lyfGF
         1khaX12ECigGMOx7flC9SJdRtW1cPkmTrsIChvT5K+9WfCsXLtXRFdL4pL9WIn1lqdLk
         wUBMEq9Gl7Y9A/r/QJ251c+KY25PRIgVUTDYsAK/tAyR5oSlqlwijbXJlnPXnoU6kvcj
         IswUQFitkmy5DoQepXRa7M4OMcR+w4o7xmcyOfnv33JAc+JHMW5pJmr+U4p6WIiHxSx/
         qHM0LjLNu8viiwSHfTlVBVHUkaSio/zbF/QIaUfJDGRn+sJtU5WE/trsD0TBhM05N4Rx
         5BMg==
X-Gm-Message-State: AGi0PuZaiz6FAVLStuFq8T1T3NtzAOyrROfMAwaHFCgBFnMwNA7xEyHc
        huXgbl7e0Y06ELF4/HFSOyNXXA==
X-Google-Smtp-Source: APiQypI1o0GT8qsdRugAQfihzVy7cdudanFaAiRDCAYBqFxUeH6OF3tVH8JjYsz1IbNVzkpokawI1w==
X-Received: by 2002:a5d:5490:: with SMTP id h16mr2920378wrv.250.1588944093030;
        Fri, 08 May 2020 06:21:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id h6sm12871912wmf.31.2020.05.08.06.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 06:21:32 -0700 (PDT)
Date:   Fri, 8 May 2020 14:21:29 +0100
From:   Quentin Perret <qperret@google.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com
Subject: Re: [PATCH 13/14] sched: cpufreq: Use IS_ENABLED() for schedutil
Message-ID: <20200508132129.GE10541@google.com>
References: <20200507181012.29791-1-qperret@google.com>
 <20200507181012.29791-14-qperret@google.com>
 <20200508053053.GG19464@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508053053.GG19464@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 May 2020 at 11:00:53 (+0530), Pavan Kondeti wrote:
> > -#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> > +#if defined(CONFIG_ENERGY_MODEL) && IS_ENABLED(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> >  	/* Build perf. domains: */
> >  	for (i = 0; i < ndoms_new; i++) {
> >  		for (j = 0; j < n && !sched_energy_update; j++) {
> 
> Now that scheduler does not have any references to schedutil_gov and cpufreq
> has want_eas flag, do we need this CONFIG_CPU_FREQ_GOV_SCHEDUTIL checks here?

Right, they're not absolutely required, but given that sugov is the only
one to have 'want_eas' set I guess there is no need to compile that in
without it, no?

Cheers,
Quentin
