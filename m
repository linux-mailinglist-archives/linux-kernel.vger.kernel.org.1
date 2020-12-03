Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1858E2CCFB0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgLCGmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbgLCGmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:42:43 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31490C061A4F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 22:42:03 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n7so825718pgg.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 22:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fjhcv6RFP/GUwmukcAhw/NTkSL23rOfX91aQcDsRbok=;
        b=kgxpaOnsST0YHmPUrZ6KCzDTi638kpNhRLe7BUNLNHBfIKxEia0PEaHVKSlAqXdKQX
         7ZuO5LDCjmCTunKLx+O1yV5b5kCZoSUEFBhSplhFAceFDnljTvBg93Hgi4wuJDno0ncP
         55BP99NhLVACNViHaqMLh62fF+qcJCYLZpVRv0T84qc6BaXkbiIB5ysCzL/EJPQ7ub1V
         03jxqpUSiqqUEZRc4Av7p5VlWGVYG5c8CG28/Nl0mcCIibJe2HfLPQsRZWl9wEteLZg0
         IVRz6UoaGeWGXvRYzrL/ZQv/Mt67jSxX40559f0extLbK/xL6lelD9Oh7ETJPbVpiPri
         LbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fjhcv6RFP/GUwmukcAhw/NTkSL23rOfX91aQcDsRbok=;
        b=eC2iJMkGduCWwmJdOZlSboh/zhf4NdKS+g9nEDlX9OGeTvoMEjxyqlk/XiDdKTmEb8
         AzkuoIlFTvgUjdZUK/MBlgwoi6TG13TSPHQTGJsck0Toxst2ILAhW+mviKhRWwTD3Mvc
         ch1ZP2uUc0I/Yz1a1f5C6KjbmjlYRv/ilKRsBKH0m5pb1s/1ks1IdMWAlG5RW0luJjiA
         VOG8VOSL52RXt5aN+OxT8M6M3uVUA941WaQkVVmD2J7noRfPfERrstTiCbRnekYMRDDR
         5kv4OAttViDVLjYYM0CwQ0991+c0x9Lu4xHeyWCffsv0M9iswya2+wzVTnqPKAohykFI
         QpoA==
X-Gm-Message-State: AOAM5324jWxddupYgshECSAXfhE+8S55lgdvQiTe7TjtWSFfbwWnFJrC
        Rd+KHjSk8Jmk8wfJoK4ab/PAzg==
X-Google-Smtp-Source: ABdhPJxXeRSBVsO+UeuhLh5avxTnY3X0SrcIbPxswt3/8g7/sun3+w7roRua3kUheQQDAoUzZCmmYg==
X-Received: by 2002:a63:7cf:: with SMTP id 198mr1830564pgh.453.1606977722392;
        Wed, 02 Dec 2020 22:42:02 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.131.71.236])
        by smtp.gmail.com with ESMTPSA id q19sm498218pff.101.2020.12.02.22.41.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 22:42:01 -0800 (PST)
Date:   Thu, 3 Dec 2020 14:41:57 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Al Grant <al.grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] drivers/perf: Enable PID_IN_CONTEXTIDR with SPE
Message-ID: <20201203064157.GF28939@leoy-ThinkPad-X240s>
References: <20201130162454.28255-1-james.clark@arm.com>
 <20201130164650.GA25187@willie-the-truck>
 <20201201041040.GC28939@leoy-ThinkPad-X240s>
 <20201201230935.GD28496@willie-the-truck>
 <20201203063941.GE28939@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203063941.GE28939@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looping in Mathieu at this time.

On Thu, Dec 03, 2020 at 02:39:41PM +0800, Leo Yan wrote:
> Hi Will,
> 
> [ + Mathieu ]
> 
> On Tue, Dec 01, 2020 at 11:09:36PM +0000, Will Deacon wrote:
> > On Tue, Dec 01, 2020 at 12:10:40PM +0800, Leo Yan wrote:
> > > On Mon, Nov 30, 2020 at 04:46:51PM +0000, Will Deacon wrote:
> > > > On Mon, Nov 30, 2020 at 06:24:54PM +0200, James Clark wrote:
> > > > > Enable PID_IN_CONTEXTIDR by default when Arm SPE is enabled.
> > > > > This flag is required to get PID data in the SPE trace. Without
> > > > > it the perf tool will report 0 for PID which isn't very useful,
> > > > > especially when doing system wide profiling or profiling
> > > > > applications that fork.
> > > > 
> > > > Can perf not figure out the pid some other way? (e.g. by tracing context
> > > > switches and correlating that with the SPE data?).
> > > 
> > > For perf 'per-thread' mode, we can use context switch trace event as
> > > assisted info to select thread context.  But for "system wide" mode and
> > > "snapshot" mode in perf tool, since the trace data is continuous, I
> > > think we cannot use context switch trace event to correlate the SPE
> > > trace data.
> > 
> > Is there no way to correlate them with something like CNTVCT?
> 
> Good point.  Yes, we can convert CNTVCT to system time; I read the
> code in the perf's intel-pt.c and found the timestamp is used to
> correlate the auxtrace heap.  I think it's better to dig more for
> detailed implementation.
> 
> > > > Also, how does this work with pid namespaces?
> > > 
> > > Here we are studying the implemetation of Intel-PT and Arm CoreSight.
> > > 
> > > The context ID is stored into the hardware trace data when record;
> > > afterwards when perf tool decodes the trace data and detects the
> > > packet for context ID, it will select the machine's thread context in
> > > perf [1].  Since the perf tool gathers all the threads infomation in
> > > perf data file, based on the context ID, it can find the corresponding
> > > thread pointer with function machine__find_thread() [2].
> > > 
> > > Since your question is for "pid namespace", to be honest, I don't know
> > > how perf tool to handle any confliction for differrent processes share
> > > the same PID, and I am not sure if you are asking CGroup related stuff
> > > or not.  If this cannot answer your question, please let me know.
> > 
> > My point was that the pid value written to CONTEXTIDR is a global pid
> > and does not take namespacing into account. If perf is run inside a pid
> > namespace, it will therefore not work.
> 
> Understand now.
> 
> The perf events PERF_RECORD_ITRACE_START/PERF_RECORD_SWITCH/
> PERF_RECORD_SWITCH_CPU_WIDE can be used to set pid/tid in perf.  So this
> would be a safe way for perf tool running in pid namespace.
> 
> Loop in Mathieu, this is a common issue for both Arm SPE and CoreSight
> (IIRC, though CoreSight's timestamp is not strictly attaching to Arm arch
> timer counter, the trend is to unify this for using arch timer
> counter).
> 
> I think James could continue to upstream a new patch by following your
> suggestion for enabling PID_IN_CONTEXTIDR, eventually, it's a feature
> for Arm SPE to record CONTEXTIDR in its packet.
> 
> Your questions inspired me, thanks!
> 
> Leo
