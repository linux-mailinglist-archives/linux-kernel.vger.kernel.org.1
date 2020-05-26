Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F69E1CDB8B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 15:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgEKNn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 09:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729514AbgEKNn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:43:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB79C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:43:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h17so2137796wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0fpk5Xqv9Yro05H314xa5B77PsSpk1e22VGbukZepR0=;
        b=mEYRAbohHj9FT80QIN/XzGP0RK1RJdYQ+SPBVrhjGvEG1fo/b/wSbQUryrPWgltT0o
         IkcFU/TN3+CssRVyv7w9pbFo1Ao857ZUnI61mXnTixG4CNdUkxo1TqBtb+18gV/r0s9T
         PPmzLqaj4sRqLx9LKDx1ZKjj7S/l7K66pZ7BoueguIMGC7RkhcUpGCTxIqf80k1bRJMt
         K4r7mmsbyu5ERiD9qkW6VioEmXn0IV06q0wEgK46c748II6H/HGiqFskqR/x66mf2GeN
         X68E2XP0oEEZzqsVFopP+39+jSNN9eg9gI+iHo96H/QWJXde4g2p+s6l6KmyLM09APAS
         DDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0fpk5Xqv9Yro05H314xa5B77PsSpk1e22VGbukZepR0=;
        b=bYMnN5ZtRbhi6S2LOt01RwyNsaMf8xAzwYV0CYO6s/Ouq/8UjFZCUdys/qvgSlyOG1
         pD1gACVfYcGWJZloCtfOTbzbbE6fGClfwsi4shrFiEbGjg1vGHpBMYBdrJiMbAic0jlR
         qxvkqPAyrTHpXVogciVjZdOSXLZPAjoZoFlvaPP/0SeeazZWSdicBRqkcZcaApmkpeSY
         FPWhHEe5X/rGkx8g1BOaOjgYaeKitIuYRzuQfLwvkmhXLdZyNlKbA4zi1JCt8pi7nzOG
         +7mtxuWWgDkuAblCla5S5zIGJLy6S6tvLsMScF8d6VXR+EjyvXEDAWIjJO54hU6xDqwj
         YAOg==
X-Gm-Message-State: AGi0PuYbSRpD6tL6/Kra31ItWJFncsy+1hhALZEVxvvFuqr/FpF5Vl9p
        1XYqOA+7JNoKBiSppOLX/CVTPw==
X-Google-Smtp-Source: APiQypItJDTCfkEocXHWq2r5Ng7HfPcqePb/ZXsdjVC/ZzMJj4eOCaQ+uMUlRLgbkt8pygDOHi6PUw==
X-Received: by 2002:adf:eac6:: with SMTP id o6mr18960567wrn.297.1589204603437;
        Mon, 11 May 2020 06:43:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id q184sm27142122wma.25.2020.05.11.06.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:43:22 -0700 (PDT)
Date:   Mon, 11 May 2020 14:43:19 +0100
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
Subject: Re: [PATCH v7 04/15] PM / EM: add support for other devices than
 CPUs in Energy Model
Message-ID: <20200511134319.GA29112@google.com>
References: <20200511111912.3001-1-lukasz.luba@arm.com>
 <20200511111912.3001-5-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511111912.3001-5-lukasz.luba@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lukasz,

On Monday 11 May 2020 at 12:19:01 (+0100), Lukasz Luba wrote:
<snip>
> @@ -27,12 +29,15 @@ struct em_perf_state {
>   * em_perf_domain - Performance domain
>   * @table:		List of performance states, in ascending order
>   * @nr_perf_states:	Number of performance states
> - * @cpus:		Cpumask covering the CPUs of the domain
> + * @cpus:		Cpumask covering the CPUs of the domain. It's here
> + *			for performance reasons to avoid potential cache
> + *			misses during energy calculations in the scheduler

And because that saves a pointer, and simplifies allocating/freeing that
memory region :)

<snip>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 5b8a1566526a..9cc7f2973600 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -2,8 +2,9 @@
>  /*
>   * Energy Model of CPUs

Should this comment change too?

<snip>
> -static void em_debug_create_pd(struct em_perf_domain *pd, int cpu)
> +static void em_debug_create_pd(struct device *dev)
>  {
>  	struct dentry *d;
> -	char name[8];
>  	int i;
>  
> -	snprintf(name, sizeof(name), "pd%d", cpu);
> -
>  	/* Create the directory of the performance domain */
> -	d = debugfs_create_dir(name, rootdir);
> +	d = debugfs_create_dir(dev_name(dev), rootdir);

So what will be the name for the perf domain of CPUs now? cpuX?

<snip>
> @@ -142,8 +149,8 @@ em_create_pd(struct device *dev, int nr_states, struct em_data_callback *cb,
>  		 */
>  		opp_eff = freq / power;
>  		if (opp_eff >= prev_opp_eff)
> -			pr_warn("pd%d: hertz/watts ratio non-monotonically decreasing: em_perf_state %d >= em_perf_state%d\n",
> -					cpu, i, i - 1);
> +			dev_dbg(dev, "EM: hertz/watts ratio non-monotonically decreasing: em_perf_state %d >= em_perf_state%d\n",
> +					i, i - 1);

It feels like changing from warn to debug doesn't really belong to this
patch no?

<snip>
> @@ -216,47 +274,50 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>  	 */
>  	mutex_lock(&em_pd_mutex);
>  
> -	for_each_cpu(cpu, span) {
> -		/* Make sure we don't register again an existing domain. */
> -		if (READ_ONCE(per_cpu(em_data, cpu))) {
> -			ret = -EEXIST;
> -			goto unlock;
> -		}
> +	if (dev->em_pd) {
> +		ret = -EEXIST;
> +		goto unlock;
> +	}
>  
> -		/*
> -		 * All CPUs of a domain must have the same micro-architecture
> -		 * since they all share the same table.
> -		 */
> -		cap = arch_scale_cpu_capacity(cpu);
> -		if (prev_cap && prev_cap != cap) {
> -			pr_err("CPUs of %*pbl must have the same capacity\n",
> -							cpumask_pr_args(span));
> +	if (_is_cpu_device(dev)) {

Something like

	if (!_is_cpu_device(dev))
		goto device;

would limit the diff a bit, but that may just be personal taste.

But appart from these nits, the patch LGTM.

Thanks,
Quentin
