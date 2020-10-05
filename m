Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEA32830A3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgJEHMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEHMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:12:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8762DC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 00:12:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id p15so2096809ljj.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 00:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s0vfflwrEayo2u9kyCaw6oJScvExNNpNO92iI4ntapU=;
        b=LlqX0qIbIj+h9jiBsIPme6+CEDD4iZ3Ga1DJinaKQ6T79iiShrphsFJx68uzTRut9x
         ps4BiG0Y+pFOXzkkZYvlwt1XAjLvTHqlo4zn6vpjdkcP6rXpfnHwZiEAK0KUBp5xxO4Q
         03Llzd2BARNjIJcnN0cZY6kvZLRE5zyjJvIbLMBwaKCo/mQPdd2PL9IbfIXnrMBiDl4j
         S08NgCURfJkt7PdJ7rfIsZlRpuJCdboOM0f4hGEVsR77SLInJRa6NjDz3DmRJDptnotf
         cBuO2jTmk0TfYlvCIVyu3FM2bSCaZmnnYDEd5pKutFY73VCi/ObjLLE9mMHOJPSHYspl
         YvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0vfflwrEayo2u9kyCaw6oJScvExNNpNO92iI4ntapU=;
        b=ufMq8FkCxZ4PFixFTn6eGJ/abya4OcVvuFR2UKx3fUjZP/RtKSMNo0r90Mbq6xA9Eh
         tziW0A0WBVwDlya4Mc48mQ/rGHweaSyhJ59eY38sjm8YLRd5M7/4aChLOJEPwFRvKo4D
         hYTzuyTg3IsGFVhQnc0RMmn7mZ+jskzEAiYEp3uiohGfzPgwMAHCKxhaS7lv0AuqCTZp
         K5wXqiLZ+UOXxhx0wctrPJpsPlKlWRUn59mhdNj4A4m833m3vsHfoQxF5fOn8hsaKeOK
         ZEsJTmhxzSwvYA9u6YuEYIrXewEuQH6wodB6KQ/LEbjBD6tBqiApzJPAI4XpBrNG6qyc
         fc5A==
X-Gm-Message-State: AOAM532zTk6+GORZQHeIAUnZdKC/XM/193RHfH2WJ8W0zx+VwspYTnRd
        Etu8VWbVoFeu65b9rae5AMTUDxfIuTBvBDwZxPUvIQ==
X-Google-Smtp-Source: ABdhPJxRhZVsFTGWvCNnc8j9FJ7pg05Nk/Zbu9r9M9/nL1PXWhGoCcBoP5oQJavxaxJgGxfkxhqq9Vz2y9fdnwxaLSE=
X-Received: by 2002:a05:651c:505:: with SMTP id o5mr4231000ljp.177.1601881968820;
 Mon, 05 Oct 2020 00:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201004132716.GS393@shao2-debian> <20201005064959.GD2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20201005064959.GD2628@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 5 Oct 2020 09:12:37 +0200
Message-ID: <CAKfTPtBTaP+Gez+U2SwN_qi_nwBBWCf5qF8bcb9KTQ6J=PwX3A@mail.gmail.com>
Subject: Re: [sched/fair] fcf0553db6: netperf.Throughput_Mbps -30.8% regression
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Mike Galbraith <efault@gmx.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>, zhengjun.xing@intel.com,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Oct 2020 at 08:50, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Oct 04, 2020 at 09:27:16PM +0800, kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed a -30.8% regression of netperf.Throughput_Mbps due to commit:
> >
> >
> > commit: fcf0553db6f4c79387864f6e4ab4a891601f395e ("sched/fair: Remove meaningless imbalance calculation")
>
> This is the middle of a series that reworks the load balancer. Does this
> regression still exist at the end of it?
>
> Which would be around:
>
>   57abff067a08 ("sched/fair: Rework find_idlest_group()")
>
> or possible a little later, Vincent?

I would consider 6cf82d559e1a ("sched/cfs: fix spurious active migration")

But even then, some fixes have been added. Mel perfectly described that
