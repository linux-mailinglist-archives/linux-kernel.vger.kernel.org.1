Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5794D2D3B09
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 06:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgLIFpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 00:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgLIFpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 00:45:47 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27E7C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 21:45:06 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 131so284881pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 21:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gkAVVTUigtx9djSLmC0VmKkWujGnySrPDSmbQuF+oss=;
        b=YDdKWGk4U83JFSsIfm8j7A6mUPCnx0lHl1appmGPhh6RVSCTo9RYy14ORXwdG3gq/7
         Q4suKpSuGUXXW2m8rW/cmSgQSCJDOPw05/AHxk15yaaIK8s0BlNhd6a4AMe+MgBH8/OL
         OmUbnqE4bWJ+fTWChBnbhkAGbywOa6EDqKkd75mfd/xpODvkiVF69x4cIpH9Px2bzZCt
         cjwPZukzbPi26EprAAGzndbaW3ptNSTgCwWw2QtwqK1B/4/nTnD9ReQ3JTbM1DdoJLPc
         9+0y1O631QwzqdlCl8wFi6nHS85CXn8cUrdUm8B8PVDYpUpzPAzi6tFmpkadMOBMO7ct
         i5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gkAVVTUigtx9djSLmC0VmKkWujGnySrPDSmbQuF+oss=;
        b=MIZ1Rp8UDQEAv4qSB/oeirYTsLvbK1be4nedXkswKs1I8WglS4KsGRNBJm7cwLXdGj
         C9rWdl300Wc/ABYypZ5bf0YJWcX9tAf1IN/IML37ABo73Sk0hzafVknynfSO7jOb70tC
         VDNdF/4ra7ApnZorNSszmjJrDP/AOoi/sdN2it96D2j1AkaYTm0SeodIiWoC8ACbT5DU
         CQq/y7HSovMXc0fKOnguWLUF5rf0yfpUF5N/81hoGhw17ewVEtjWJSvnsW5Oq62Yyl2e
         ZqwA2EMwpctCWJLcPTv7eCyjJEsWzMVhVy9Esw6/7IiP291ZkTqvR1UgsaKLX+OrrvJf
         7saw==
X-Gm-Message-State: AOAM531qIorsOev2MFmoPjCWHf8VhE3xiaCrwQwN6nynwUXtH6AFg+If
        OPXvVwOY4gavlw77GUqvuxxAI8nShSsoXg==
X-Google-Smtp-Source: ABdhPJxWx86juiJTf/9quW+T1YcP6CcrdYE27gVJoN8CrFUTzwsrytwDX48IHtIBjqHn0cJAEEDbfw==
X-Received: by 2002:a62:445:0:b029:19c:162b:bbef with SMTP id 66-20020a6204450000b029019c162bbbefmr893855pfe.40.1607492706206;
        Tue, 08 Dec 2020 21:45:06 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id fv22sm662181pjb.14.2020.12.08.21.45.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 21:45:05 -0800 (PST)
Date:   Wed, 9 Dec 2020 11:15:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        rjw@rjwysocki.net, vireshk@kernel.org, robh+dt@kernel.org,
        sboyd@kernel.org, nm@ti.com, daniel.lezcano@linaro.org,
        morten.rasmussen@arm.com, chris.redpath@arm.com
Subject: Re: [PATCH v4 3/4] scmi-cpufreq: get opp_shared_cpus from opp-v2 for
 EM
Message-ID: <20201209054502.ajomw6glcxx5hue2@vireshk-i7>
References: <20201202172356.10508-1-nicola.mazzucato@arm.com>
 <20201202172356.10508-4-nicola.mazzucato@arm.com>
 <20201208055053.kggxw26kxtnpneua@vireshk-i7>
 <0e4d3134-f9b2-31fa-b454-fb30265a80b5@arm.com>
 <20201208072611.ptsqupv4y2wybs6p@vireshk-i7>
 <20201208112008.niesjrunxq2jz3kt@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208112008.niesjrunxq2jz3kt@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-12-20, 11:20, Sudeep Holla wrote:
> It is because of per-CPU vs per domain drama here. Imagine a system with
> 4 CPUs which the firmware puts in individual domains while they all are
> in the same perf domain and hence OPP is marked shared in DT.
> 
> Since this probe gets called for all the cpus, we need to skip adding
> OPPs for the last 3(add only for 1st one and mark others as shared).

Okay and this wasn't happening before this series because the firmware
was only returning the current CPU from scmi_get_sharing_cpus() ?

Is this driver also used for the cases where we have multiple CPUs in
a policy ? Otherwise we won't be required to call
dev_pm_opp_set_sharing_cpus().

So I assume that we want to support both the cases here ?

> If we attempt to add OPPs on second cpu probe, it *will* shout as duplicate
> OPP as we would have already marked it as shared table with the first cpu.
> Am I missing anything ? I suggested this as Nicola saw OPP duplicate
> warnings when he was hacking up this patch.

The common stuff (for all the CPUs) is better moved to probe() in this
case, instead of the ->init() callback. Otherwise it will always be
messy. You can initialize the OPP and cpufreq tables in probe()
itself, save the pointer somewhere and then just use it here in
->init().

Also do EM registration from there.

> > > otherwise no need as they would be duplicated.
> > > > And we don't check the return value of
> > > > the below call anymore, moreover we have to call it twice now.
> 
> Yes, that looks wrong, we need to add the check for non zero values, but ....
> 
> > > 
> > > This second get_opp_count is required such that we register em with the correct
> > > opp number after having added them. Without this the opp_count would not be correct.
> >
> 
> ... I have a question here. Why do you need to call
> 
> em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, opp_shared_cpus..)
> 
> on each CPU ? Why can't that be done once for unique opp_shared_cpus ?
> 
> The whole drama of per-CPU vs perf domain is to have energy model and
> if feeding it opp_shared_cpus once is not sufficient, then something is
> wrong or simply duplicated or just not necessary IMO.
> 
> > What if the count is still 0 ? What about deferred probe we were doing earlier ?
> 
> OK, you made me think with that question. I think the check was original
> added for deferred probe but then scmi core was changed to add the cpufreq
> device only after everything needed is ready. So the condition must never
> occur now.

The deferred probe shall be handled in a different patch in that case.

Nicola, please break the patch into multiple patches, with one patch
dealing only with one task.

-- 
viresh
