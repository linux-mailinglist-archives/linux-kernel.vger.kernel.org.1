Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8EA1A78FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 12:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438820AbgDNK6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 06:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438778AbgDNK5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:57:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D08C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ioUSb5eLCjLXsiwhi2nCGeKhCogbLivgMWTv1Ym13DM=; b=XlwuiYsTpfXR5BZDiAMMgWRHvN
        VsDPbUizxQZ61MEh3nK5Y/Had7WLD4cbUdzDNn2Jv2opvZMt968Ac7LT6O1BrApYqMguohLpf2qQB
        0HnjrwKL/ZCv6SJIdHGTf4CnxZYL+aA3u3rGMGa0vyEjx06akgcFZOLfaX8BtsAMd5fw2ySconUPs
        x22wUGf/dPhj74CcOQkEVA8ZrWWnRKafpyOlYyNlFdluvCoyblSOw91WHiRXNwtQcuE/yLhRgkNrx
        urY4JOBASJplVGfnP++ZJ6lPOJfXuw9vK2UkBt3vAvlBpzTU2Fl4ZOsAT6PrHRtT70W4eiZjdXCfz
        efoA8uSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOJFt-0003qB-FF; Tue, 14 Apr 2020 10:57:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CEF65305EEC;
        Tue, 14 Apr 2020 12:57:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B18832038BC55; Tue, 14 Apr 2020 12:57:23 +0200 (CEST)
Date:   Tue, 14 Apr 2020 12:57:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peng Wang <rocking@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>, uri.lelli@redhat.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Simplify the code of should_we_balance()
Message-ID: <20200414105723.GN20713@hirez.programming.kicks-ass.net>
References: <245c792f0e580b3ca342ad61257f4c066ee0f84f.1586594833.git.rocking@linux.alibaba.com>
 <CAKfTPtBLc7Y-a-nuXF-p8wEaJQLiQn4crOg6R0Z4NBJ64yMLBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBLc7Y-a-nuXF-p8wEaJQLiQn4crOg6R0Z4NBJ64yMLBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 09:25:00AM +0200, Vincent Guittot wrote:
> On Sat, 11 Apr 2020 at 11:21, Peng Wang <rocking@linux.alibaba.com> wrote:
> >
> > We only consider group_balance_cpu() after there is no idle
> > cpu. So, just do comparison before return at these two cases.
> >
> > Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
> 
> With the small fix in the comment below

Done

> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks Guys!
