Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63DB2901CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394978AbgJPJY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394577AbgJPJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:24:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060BFC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 02:24:58 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so1157353pfk.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 02:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zUCInfHS0mVdMXYgMLxUEzU7i2cHgkPuhsJxyPPWk3M=;
        b=wzdkmbDGJ8WM/c871lKIy/n2CWoGNITb8anKX9mwnSiMvz4uZA3Eu4AlN7gjQ1L0/P
         9xB4UOcUzt3iOXH3WVOZqVwNAz51/iSPqkhq4E9J6b968A1qYiWYmyXmItQttTZ2yyhf
         +9hCgHyO8tBxL1Mh9+x09CrWzs0+uARAs4r39zxxJwNOxxG1/YsSLzSGLm+C+2a1a3IE
         1kePFELYRzPMeuIEpVyF63dTjnGLxjfy/fzESSrHxRRi031uQv4mPfLSGAhhSjXGmjCN
         I+8zBDS8uCiwhLwOJ5cWoybMM0aZjOKgb2WZqL+ChN4gB8ysRXt1r05YyT/mAkmdA43w
         VRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zUCInfHS0mVdMXYgMLxUEzU7i2cHgkPuhsJxyPPWk3M=;
        b=qnobIoekrEqcBZBNqlE7VKfokwIFGQgBoGeeEKjFgvgjidX9LTo3sG4fvPZAtj7ziJ
         Z7a94Khh9YUsihcCKwVxNoI605hmUBlCdm/ONIlKQuofTgvV4ZEvZOOVVgV09nUPEQrj
         7rcpdj/Byk2gCJyxU9k1sYck+mpsA6fIt3Hs8cNJVGQpv4vIYCDYTvEqgrtUH0jx7qc7
         OZCoqj0iARw+0Z7SEWbwOg0nSiv9Z/153IK2KKxb2p979FikJJVPoKFfyZpvdRgiYb7W
         t6B8doQ1Smv5ZWiVTkZgXzawu9xwy0VHdXFgSObwycBjCQXhbH3uPL9Bkj7UItUTF6nh
         AP0w==
X-Gm-Message-State: AOAM531lBgxX/Zi17kw291HQ3HjASnAUybT5cpCywOBH/i7GJg7iZ1la
        rCpBHfeSKc1a+Xf3OIW5N+Kvcg==
X-Google-Smtp-Source: ABdhPJx9/QEdjE8/prY2e//ZI1Z6zzyHO7GWBJr4pvSy3DfYUsGiiAcutarYbBieWsmbOwEtb3g4iA==
X-Received: by 2002:a63:a51a:: with SMTP id n26mr2270647pgf.1.1602840297362;
        Fri, 16 Oct 2020 02:24:57 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id o15sm2447398pfp.91.2020.10.16.02.24.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Oct 2020 02:24:55 -0700 (PDT)
Date:   Fri, 16 Oct 2020 17:24:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Denis Nikitin <denik@chromium.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] coresight: etm4x: Add config to exclude kernel mode
 tracing
Message-ID: <20201016092450.GG4646@leoy-ThinkPad-X240s>
References: <20201015124522.1876-1-saiprakash.ranjan@codeaurora.org>
 <20201015160257.GA1450102@xps15>
 <CADDJ8CXS8gGuXL45vR6xiHwJhZNcUJPvHMVYSGR6LDETRPJFiQ@mail.gmail.com>
 <20201016072401.GC4646@leoy-ThinkPad-X240s>
 <f73ba98c345161f1835458182e6a0002@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f73ba98c345161f1835458182e6a0002@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

On Fri, Oct 16, 2020 at 02:10:47PM +0530, Sai Prakash Ranjan wrote:
> Hi Leo,
> 
> On 2020-10-16 12:54, Leo Yan wrote:
> > On Thu, Oct 15, 2020 at 11:40:05PM -0700, Denis Nikitin wrote:
> > > Hi Mathieu,
> > > 
> > > I think one of the use cases could be VMs.
> > > Is there isolation between EL1 guest kernels which we can control
> > > from perf
> > > in a system wide mode?
> > 
> > Sorry for suddenly jumping in.
> > 
> > For KVM, I think we need to implement mechanism for saving/restoring
> > CoreSight context for every guest OS, the CPU PMUs has implemented
> > related features [1].
> > 
> > Thanks,
> > Leo
> > 
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kvm/pmu.c
> > 
> 
> What happens to the sysfs mode of tracing? For that we would still
> need a config right to exclude kernel mode tracing completely.

IIUC, sysfs mode and perf mode both can apply the same approach, the
guest OS runs a thread context for the host, so when a guest OS is
switched in or out, the hypervisor can save/restore the context for
the guest OS; thus every guest OS will have its dedicated context and
trace data ideally.

Thanks,
Leo
