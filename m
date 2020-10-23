Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144DD297652
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754110AbgJWR7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754099AbgJWR7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:59:48 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED45C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 10:59:47 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id m65so1599333qte.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IDpHMieNXZZBIoI1fIHPCKIb5NTvidIxfCr8Im48pc4=;
        b=IDaJPA5bANTTSZhZyxYX2w2AIzGVuL3oCR2wpEGarXb7mxVjjtzPeh3NDdeE2f3PU2
         4dnwndVV3sHqykCR8NpRg/A+VjzGqwEB3VO1+m2LbzmrRdZ6nCE7b2XiuQY0oQptNdPh
         X4qPu5ewGRXHxffnYOZvUuYHpTsi80BTsfx5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IDpHMieNXZZBIoI1fIHPCKIb5NTvidIxfCr8Im48pc4=;
        b=aa8Zah72JK8XlnLELAf5yEFzC8j/L4O4uBXeNOMMcJgJE+pLZvOxgEayRPP9lcEjSY
         WFToRrHwnlMS6BA/vn1CMZoJePjGKrLnlppj8Lz4K1TUfHAZJGwHnK9jmq25Nmp+Er9Q
         IiohKty6UlKFsejXKvs3Nb3+AkO4+N4DKHmqoo6c/wLeltkgnVXLYJvb+ZVIxRh+ZeR9
         MzVuXlKgGHDluqAyEQh6JoIp+4WKT+KhComoTmoggNyeaLVY7g8yikB9rckMMcMDiYzo
         iqOPB9FktGJV9tIyPAktxHHOYD+yu9m3xJFPB4VaIagmrhh8oMKTkiLt4Jil/FbSJBk3
         KVlA==
X-Gm-Message-State: AOAM533idbrS7zux7oRWsq2IcgpDiZ22NJGFaLARZ/AlPTj866ormtyr
        5yACDdnUrCzX+Gxbuso/thJ+GQ==
X-Google-Smtp-Source: ABdhPJyYidiNXKL8OLdU3yRDOm0JPUlJrrdRLcon0lUBYOQbJ18fEWBB5VK02l2lBtZeJ0O9ig0xHw==
X-Received: by 2002:ac8:5141:: with SMTP id h1mr2008705qtn.139.1603475986754;
        Fri, 23 Oct 2020 10:59:46 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id z69sm1255839qkb.7.2020.10.23.10.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 10:59:46 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:59:45 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 06/26] sched: Add core wide task selection and
 scheduling.
Message-ID: <20201023175945.GB3563800@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-7-joel@joelfernandes.org>
 <20201023150544.GG2974@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023150544.GG2974@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 05:05:44PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 19, 2020 at 09:43:16PM -0400, Joel Fernandes (Google) wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Instead of only selecting a local task, select a task for all SMT
> > siblings for every reschedule on the core (irrespective which logical
> > CPU does the reschedule).
> 
> This:
> 
> > 
> > During a CPU hotplug event, schedule would be called with the hotplugged
> > CPU not in the cpumask. So use for_each_cpu(_wrap)_or to include the
> > current cpu in the task pick loop.
> > 
> > There are multiple loops in pick_next_task that iterate over CPUs in
> > smt_mask. During a hotplug event, sibling could be removed from the
> > smt_mask while pick_next_task is running. So we cannot trust the mask
> > across the different loops. This can confuse the logic. Add a retry logic
> > if smt_mask changes between the loops.
> 
> isn't entirely accurate anymore, is it?

Yes you are right, we need to delete this bit from the changelog. :-(. I'll
go do that.

thanks,

 - Joel

