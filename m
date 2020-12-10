Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE0E2D5D87
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390031AbgLJO0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbgLJO0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:26:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF396C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zAdSc9CCJ97ovr3hMYt96581NCmMZNYJU/oAeSfKb+0=; b=Cy2/EfP1QNjdDQTl5UFS1vbpIb
        oSJaYYfSC7DnAVQTUJi0ImK4X9VLl46JG2quL6Ldytl7KKOeLDRjZd83Qvlxut4KTZPhU+7C7cl8t
        ffq3Hf4OMXj9Yf1ZQeZwwdPhS+uqNbvOTUUe9pCbOZzIJ4AMdAk4lgnuu60VvrXKRWyuNmGocd2L0
        5p9Ru4L2p9rWW31TRxzLnXgQzNISnPByaL2jUzpH2AOju2IMx5z/ymEuL2eerNgKXL+x7VK6IxsEU
        +IhVZqYTgux5luGCqlfCcKFJtXkjZIn2k8Ffdq35297nskNy3sley6snqVnBlTQd2LIq64v6AaKJb
        wdfGjirQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knMsh-0002B8-Ay; Thu, 10 Dec 2020 14:25:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13BE03059C6;
        Thu, 10 Dec 2020 15:25:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF405209B20D9; Thu, 10 Dec 2020 15:25:15 +0100 (CET)
Date:   Thu, 10 Dec 2020 15:25:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Gabriel Marin <gmx@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V2 3/3] perf: Optimize sched_task() in a context switch
Message-ID: <20201210142515.GR2414@hirez.programming.kicks-ass.net>
References: <20201130193842.10569-1-kan.liang@linux.intel.com>
 <20201130193842.10569-3-kan.liang@linux.intel.com>
 <20201201172903.GT3040@hirez.programming.kicks-ass.net>
 <CAM9d7ciukm4RAH+44YWhZRummKzk1HTbnZ0Sc4Xd5ZyCo=x0xQ@mail.gmail.com>
 <CAM9d7ciBO=cmgnBVJWpyJ75VHjoxuEA=ck=V1+k8KRBkh23+nw@mail.gmail.com>
 <c868c6f7-c89f-ecc5-b771-2701b6029788@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c868c6f7-c89f-ecc5-b771-2701b6029788@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 08:52:55AM -0500, Liang, Kan wrote:
> 
> 
> On 12/10/2020 2:13 AM, Namhyung Kim wrote:
> > Hi Peter and Kan,
> > 
> > How can we move this forward?
> 
> Hi Namhyung,
> 
> Thanks for the test. The changes look good to me.
> 
> Hi Peter,
> 
> Should we resend the patch set for further review?

I've not yet seen a coherent replacement of #3, what I send was just a
PoC.
