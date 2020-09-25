Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B62278557
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgIYKqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgIYKqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:46:21 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED33C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 03:46:21 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u24so2232173pgi.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 03:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r2m2fNR5WHwtA5YWHit6zaf0+8NfX0sJyGAS5hG86rA=;
        b=u+EuyiCB/2CJ9jHeCNYsa2cpAsqp41vvhK1KI/gqsW19HcWSvw94y7XIKLldfnkJXc
         SN60/RQABNJ2Ou4jF8UbK6/8k0mUTn7KTYZZDnXOm5uFfeWpgf3Np0rZkqeJhMLYZpcN
         t5F8G3smWGhZ30ww5cvI1s9RAI+AbohO2jqZfCRslCzQ8R0vf6s9Tvy8F1R6FU7iBsf5
         4s2xt8WmIAnLDbIeoi+ewS5Ado7YEns4bKkMGENMmEp9WcqjMqt4OUKa08sjh7N/r8KO
         iEhCPMQVjikLBQQVqUvlC5J/m+v3f7r8cgf9TzZXSiL5iRfTR23Vs/FjwK5WK5BtK7ps
         7aEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r2m2fNR5WHwtA5YWHit6zaf0+8NfX0sJyGAS5hG86rA=;
        b=BKSg/AjGJp55Ibl0kT0qcvQCOUY1DS/NDgY06SWohdG6h9dt2ajoRJ2mUmqsBXweem
         g4K6Newo+viD8m71295MUyYFJMterJuECKeHjxBUovH+b1fAD/DSmyhPd+OuTirhVMj4
         ka1V8jFTeYFlcU7GB/j61Qe7XGg8hIOE4DTdBE7JqQUvmq4qt7Phz1G/pMnPFGRPfBGv
         +iyX+2VhH5ZEcsisKs362DGNlBRIEh36wShH3qXF+EbblM5ngqrPfE0vD/XnEMdutWhp
         DoJtrkDsPyJ/u/6RG44DENwljLq9Xufz4NR70NBW9sGsp2Rdo3JXIysm1JtCJH1VA1Ny
         t4pg==
X-Gm-Message-State: AOAM532qXWsxkPN3oYCcYkNeFSRnHilTD3E/jUpSK2PnVG1VZ20qqBC5
        wO78DW3FiDBdj6U2/j7S3sd6PA==
X-Google-Smtp-Source: ABdhPJxyMQfXso10HYThHEqJcB8m3liy7B0/5KxZHW95BWOkIJoB6Zy8NqMYA6A7Yq6y0PUTQenTNA==
X-Received: by 2002:a17:902:8e85:b029:d2:42a6:bb6 with SMTP id bg5-20020a1709028e85b02900d242a60bb6mr3608618plb.72.1601030781327;
        Fri, 25 Sep 2020 03:46:21 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id q7sm1969018pgg.10.2020.09.25.03.46.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 03:46:20 -0700 (PDT)
Date:   Fri, 25 Sep 2020 16:16:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/4] cpufreq: stats: Defer stats update to
 cpufreq_stats_record_transition()
Message-ID: <20200925104612.ge27ptfbqzf3yrql@vireshk-i7>
References: <cover.1600238586.git.viresh.kumar@linaro.org>
 <31999d801bfb4d8063dc1ceec1234b6b80b4ae68.1600238586.git.viresh.kumar@linaro.org>
 <6f794935-a5d2-0f4d-70d7-de4705ba9511@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f794935-a5d2-0f4d-70d7-de4705ba9511@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-09-20, 09:21, Lukasz Luba wrote:
> 
> 
> On 9/16/20 7:45 AM, Viresh Kumar wrote:
> > In order to prepare for lock-less stats update, add support to defer any
> > updates to it until cpufreq_stats_record_transition() is called.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >   drivers/cpufreq/cpufreq_stats.c | 75 ++++++++++++++++++++++++---------
> >   1 file changed, 56 insertions(+), 19 deletions(-)
> > 
> 
> [snip]
> 
> > @@ -228,10 +264,11 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
> >   	struct cpufreq_stats *stats = policy->stats;
> >   	int old_index, new_index;
> > -	if (!stats) {
> > -		pr_debug("%s: No stats found\n", __func__);
> > +	if (!stats)
> >   		return;
> > -	}
> > +
> > +	if (READ_ONCE(stats->reset_pending))
> > +		cpufreq_stats_reset_table(stats);
> 
> This is in the hot path code, called from the scheduler. I wonder if we
> avoid it or make that branch 'unlikely'?
> 
> if (unlikely(READ_ONCE(stats->reset_pending)))
> 
> Probably the CPU (when it has good prefetcher) would realize about it,
> but maybe we can help a bit here.

Sure.

-- 
viresh
