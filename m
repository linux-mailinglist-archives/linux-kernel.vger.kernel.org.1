Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8313B2FAF39
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 04:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbhASDsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 22:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbhASDpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 22:45:31 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFE6C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 19:44:31 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id r4so9723270pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 19:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uEYeDZRMc+h9WRG4pAvK1/KcPM+2OYyPYOz9DIXty1Q=;
        b=pWBSJZSmcZMj2pZhxcvM90w618YnoqlP/e2ZsPvqSU31lhhwC6KzS14A0v4I3iwXWA
         ekzUq8zkMfFfYzwOFQzMBiDl8bhV+F0bO5QuWbQHXNP3VMPzbxMqzhjZUCoEa5xMcNg2
         8eBptoGSqwkGEP3T2nJcJJW6tcVsqegpmLCMQ2hua7B6+ZXTzpVI3bbxKqAa0VRoxddH
         w5pA1R/yjbZNOV36eYKnnafT9iKxQRZKwYHu/vPUB588FIWjo/HEcgMnWxdb8gRqt0LZ
         9XY7cqo1F/BA46hPSb9Cj6ODBYSClTy832K8agVMz9krtlmkF/4G/+72Jks6XYPhufFI
         q3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uEYeDZRMc+h9WRG4pAvK1/KcPM+2OYyPYOz9DIXty1Q=;
        b=RL+SnWZs3+3M0VdrxJVL11sk3uC7jrBFt7OUsgbX/IuuZ6O89/3ze2SyYE4VzpLCbg
         1Ku6HyFMowkP/i/ktCUPFlqf0wKoBLjAs/WaIBpOKEZqmD6WQs2jy48BaHBptGMVz01x
         snHYDRkGb9OomVCJoAhv63MkyzOL5X8TWgH3sdZMGBk5SbbWXdzZVZI0RmZqsoT/Kny1
         HhLLb72DMH6ZSX6OMMAw/vgOmie4Yct3TMRC46cD1xZvceCDxlj2fs9zzR6vdElksREQ
         BoEjCJFDFhuleeQL79tqyPyHsAjU4l0Bs0RYXA3Z/7PeGDAaswHtzKGJWhwpXEwKnkXP
         1vsQ==
X-Gm-Message-State: AOAM533RAzr1IxUguQ/v7l5etLuBCk/JOs8/OU/Ap5bsDLhqdzCUqd+l
        8gZK0l7v+kebmu8gouoWvvKyvw==
X-Google-Smtp-Source: ABdhPJx0/lt81SpGGHqSKLnBKJV7JMtFB7qIvoG67P7dnCkZfjz67sgzJDc44bJDxE5UqZMJqbPhPw==
X-Received: by 2002:a17:902:9009:b029:dc:52a6:575 with SMTP id a9-20020a1709029009b02900dc52a60575mr2539734plp.57.1611027871154;
        Mon, 18 Jan 2021 19:44:31 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id b62sm6424022pfg.58.2021.01.18.19.44.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 19:44:30 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:14:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] PM: domains: Make set_performance_state()
 callback optional
Message-ID: <20210119034428.qgjjlvti6sirsnzy@vireshk-i7>
References: <20210118011330.4145-1-digetx@gmail.com>
 <20210118011330.4145-2-digetx@gmail.com>
 <20210118072855.anncyl6z3e5uznvd@vireshk-i7>
 <CAPDyKFquCGUSTvcCpmN0vm1eGEz9B_hYSNm7wojhgwuXT=jkEQ@mail.gmail.com>
 <20210118110506.linvsoca7jbl42iq@vireshk-i7>
 <CAPDyKFr7SD_A9sKD2+90XfjP09T+PCLE=8qvn=M-yPEPXvBhsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr7SD_A9sKD2+90XfjP09T+PCLE=8qvn=M-yPEPXvBhsg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-21, 13:46, Ulf Hansson wrote:
> You seem to be worried about latency/overhead while doing the
> propagation upwards in the hierarchy. That seems like a reasonable
> concern to me, especially as the genpd lock is taken at each level.

I am not sure how many levels of domains we have normally, but unless the number
is big it won't be a very big problem.

> However, to mitigate this can be rather messy. In principle, we would
> need to walk the hierarchy upwards, each time a new subdomain is added
> in genpd_add_subdomain(). While doing this, we would also need to keep
> track on what level we set to continue the propagation of the
> performance states for. Even if this can be done in non-latency
> sensitive paths, I don't think it's worth it because of complexity (I
> haven't even thought of what happens when removing a subdomain).

What about a new field in the domain structure like 'can-handle-pstates', and
then whenever sub-domain gets added it just needs to check its parent's field
and set his own.

> So, maybe we should simply just stick to the existing code, forcing
> the parent to have a ->set_performance() callback assigned if
> propagation should continue?

I think it would be better to fix the issue even if we aren't fully optimized
and making the change to make sure we keep propagating is rather important.

-- 
viresh
