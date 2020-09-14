Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9AD268A51
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 13:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgINLr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 07:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgINLmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:42:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF44C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hVctvVnEQDm46Jm3XKV/WTVkUbioAqpNFIq60oMOVeU=; b=QGZghH66ot7xadcJLkzNIDQbja
        0eLsXJVvZkEgQf3dwziAR/kFj3tfsQ8sheRuGVDDdkpYWzZw8Ch6PBP8J8A8GlpWWd5yQyDSd9s+b
        ObsQuph448tK15VqNmZnkI6+TtnM5+zIxDkm/pYI8Uo+Jc9cmILJIwj6jkupL36nMNHMvAkdqxs6S
        jduuRmOz9us1eWnF1Zxx/qFJ5lsT+0WMZX2IlwpmlnU5T4JUqHwj4Vx9VONLs4pP2TTXn7FSbeGWJ
        oDW1mymXyMlye6RHiFfGA0TxtgtYGrzQQqOic+6PFLUBthhzyrcWcvWN7hlpcB33UlQfWDqdQ1AGl
        OBaXVIag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHmrz-0006dy-Vw; Mon, 14 Sep 2020 11:42:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E35C7303A02;
        Mon, 14 Sep 2020 13:42:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D3C962B09E055; Mon, 14 Sep 2020 13:42:02 +0200 (CEST)
Date:   Mon, 14 Sep 2020 13:42:02 +0200
From:   peterz@infradead.org
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        pauld@redhat.com
Subject: Re: [PATCH 0/4] sched/fair: Improve fairness between cfs tasks
Message-ID: <20200914114202.GQ1362448@hirez.programming.kicks-ass.net>
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914100340.17608-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 12:03:36PM +0200, Vincent Guittot wrote:
> Vincent Guittot (4):
>   sched/fair: relax constraint on task's load during load balance
>   sched/fair: reduce minimal imbalance threshold
>   sched/fair: minimize concurrent LBs between domain level
>   sched/fair: reduce busy load balance interval

I see nothing objectionable there, a little more testing can't hurt, but
I'm tempted to apply them.

Phil, Mel, any chance you can run them through your respective setups?
