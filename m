Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FD32F0BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 05:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbhAKEr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 23:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbhAKErZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 23:47:25 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2773EC061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 20:46:45 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id i5so11826634pgo.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 20:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZmYHYVSE+wijAXrMkpVFBYT02fsk0rSX0i+WknLcUdM=;
        b=hHk/rjvkIFk1uf5mcTgifNX16JP3AM6kobxRAsYo390jv4AaydoLoZqbrfnOpESAFg
         NzQ4CzzzuEPBswWeimK0YwPEClgwCx/5/EXdD2H4gwamPVt8lMl/BUMv6wsy1Zt1ZpYD
         LHLXSEpjnLP1iALJhwd/cB9FzEE7btZoMfzF5Wk2oDbCGobJprcMQfy1BljdYUPL9cXj
         tTfCV+gt++WZOKDJVfCkZK6dEibZCeE2oG8lHJ15yVA9DbqiN4I6avBNsTqTTKLV/rpa
         rQmwplU04ilcQBsGBgbRsPIFPc0uaQCUYeQUzH8vFqxzKdJ1KxYaqgSCPkZXC973xyO6
         FXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZmYHYVSE+wijAXrMkpVFBYT02fsk0rSX0i+WknLcUdM=;
        b=b0ntnDzOvFeCIckJbtx/xjbyTG/nLAI1VzxgRbUXvP2DjHnPMXAYfaorte+B44uSiS
         bePjUH+XqQFUcvM5HpAJ1AwUrVjnt4nFqcvp6Rvo95eX7J33cSJfu34MpyAzBxYuxcIu
         hDtxu55FClmGxa/5EqeTRxl0oRf873OuXEz8H5fYRPVcqoV+xkPmLgLpvrW/vm+Lb8VJ
         KAQtksHlRKJL5G4cR4kIJUww04mCX2As/D4kcol5e2Vu0Qlqsg+UURcEfOhs1VXBXSzs
         /A4/1UUf6edJFsbwcE4s5cYv7uFU2yPosxTG2dO7rY6kkfaZZmRzANCC89FYuaZRhOJ6
         crrw==
X-Gm-Message-State: AOAM532tBW/ADi+mgi33Nwiew2e9Kn5y7ZMX2OV0OQpdm3nUldFRVvgA
        FcA60Gee5kQ49AI1R2uHOhNbwA==
X-Google-Smtp-Source: ABdhPJxFzrPuUbpd6T5Suw/b1ZuegdHwIQdjQ3Z3Fu7xYKu/ud7f4qYffzZq/oAYXXuCJWSXGrzb7w==
X-Received: by 2002:aa7:954c:0:b029:1a6:2130:db4f with SMTP id w12-20020aa7954c0000b02901a62130db4fmr14363237pfq.68.1610340404684;
        Sun, 10 Jan 2021 20:46:44 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id f7sm13172935pjs.25.2021.01.10.20.46.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 20:46:43 -0800 (PST)
Date:   Mon, 11 Jan 2021 10:16:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 0/3] arm64: topology: improvements
Message-ID: <20210111044641.zmv3mw73hvq23367@vireshk-i7>
References: <cover.1610104461.git.viresh.kumar@linaro.org>
 <20210108155334.GA21679@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108155334.GA21679@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-21, 15:53, Ionela Voinescu wrote:
> On Friday 08 Jan 2021 at 16:46:50 (+0530), Viresh Kumar wrote:
> > Hi,
> > 
> > Here is the V4 with the general improvements for topology stuff. This
> > cleans up the code and makes it work with cpufreq modules.
> > 
> > V4:
> > - Added Rby from Ionela.
> > - In 3/3, Print cpus instead of amu_fie_cpus and make it pr_debug
> >   instead.
> > 
> > Viresh Kumar (3):
> >   arm64: topology: Avoid the have_policy check
> >   arm64: topology: Reorder init_amu_fie() a bit
> >   arm64: topology: Make AMUs work with modular cpufreq drivers
> > 
> >  arch/arm64/kernel/topology.c | 115 +++++++++++++++++------------------
> >  1 file changed, 56 insertions(+), 59 deletions(-)
> > 
> 
> Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> 
> ..for the full set.

Thanks, Ionela.

-- 
viresh
