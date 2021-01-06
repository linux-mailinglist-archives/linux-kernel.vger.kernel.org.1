Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913562EB894
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 04:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbhAFDoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 22:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbhAFDoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 22:44:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B12C06134C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 19:43:39 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m5so1164850wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 19:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u/czdiKNojyMA+TTw0flYKF95IAUec7BunqTDcNSms0=;
        b=QkFRr852eHXKAupsrryQ1iIDCHXBvvzqKEMxnZoT2PVR5S1xW/EmLmPyaHp9oj0yGc
         CLbaOmbQSyg9NsruDhEx2LPq9NiwG5bRn3G0kw0wfFR1Ngrz6M+jhe9eEmUldf6ElCpw
         D9v1ypQj9o5n37hZAdH7foOYVn16fpKIxe/lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u/czdiKNojyMA+TTw0flYKF95IAUec7BunqTDcNSms0=;
        b=a+rZ03gixftQwtgzhCIm3L2ZanfiNhTYCjtxbNPw/q/wpKKO3k8wVzLjGeEUBS+fvk
         Y6nc9RUpXDGxEXzc1wLFsOuOL2wI/mIbWXhcJjqsP8dPvVml3fPbuULN98Ow1VpQa9pm
         r+7f4bXcttedGffvW9WrSBpz8sPEIsyN1E7uZcqr7AJ3kNxttMjGB2IShdWK3WwUjVg5
         i+IdxxQDVycDxgKKWsQIMud1phr91mdjDoEyubwWp0zuqdgcR2RNf2Ovu/fE1+KEauB7
         Ej9El7w+BIYKOP/eTYhZ7GtssWENu2GmHu9RcXsYvxcetOvfUkkmSNB/CbiZh1bIcZj9
         /9tw==
X-Gm-Message-State: AOAM532i3UEbagHZt+TbkEBxsxizxqqnl+6QE6ARZEPg2y5+phAoFsU3
        nsY4lu1upT2S76pJLFlnqCir7A==
X-Google-Smtp-Source: ABdhPJwQ4/I9PSedcEunc/IjrkfKU/ULk7zevwFO72rbrITk1oVQlhw3+U1gPmVNjux3/QNfoMK+Bg==
X-Received: by 2002:a5d:5005:: with SMTP id e5mr2168995wrt.279.1609904617803;
        Tue, 05 Jan 2021 19:43:37 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:5586])
        by smtp.gmail.com with ESMTPSA id q1sm1312427wrj.8.2021.01.05.19.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 19:43:37 -0800 (PST)
Date:   Wed, 6 Jan 2021 03:43:36 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, andi.kleen@intel.com,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Huang Ying <ying.huang@intel.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 2/2] mm: memcg: add a new MEMCG_UPDATE_BATCH
Message-ID: <X/Ux6CT6EsP+QQ8S@chrisdown.name>
References: <1609252514-27795-1-git-send-email-feng.tang@intel.com>
 <1609252514-27795-2-git-send-email-feng.tang@intel.com>
 <CALvZod5ir6F6BkJiVoXztNu6CancqJ2sNusg_hwTPcEssYkDdQ@mail.gmail.com>
 <20210106021213.GD101866@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210106021213.GD101866@shbuild999.sh.intel.com>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feng Tang writes:
>One further thought is, there are quite some "BATCH" number in
>kernel for perf-cpu/global data updating, maybe we can add a
>global flag 'sysctl_need_accurate_stats' for
>	if (sysctl_need_accurate_stats)
>		batch = SMALLER_BATCH
>	else
>		batch = BIGGER_BATCH

Moving decisions like this to the system administrator is not really a solution 
to the problem -- inclusion should at least be contingent on either having 
"correct-ish" stats exported to userspace. Displaying broken stats to the user 
-- even with a configuration knob -- is less than ideal and is likely to 
confuse and confound issues in future.

I would also like to see numbers from more real-world workloads.  
MEMCG_CHARGE_BATCH is certainly fairly arbitrary as-is, but if it is going to 
be changed, the reason for that change and its implications (positive and 
negative) for real-world workloads must be well understood, and I'm not sure 
we're there yet.
