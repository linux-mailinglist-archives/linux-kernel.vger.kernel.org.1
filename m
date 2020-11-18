Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393FA2B75A0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 06:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKRFQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 00:16:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:48882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbgKRFQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 00:16:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E22DBABDE;
        Wed, 18 Nov 2020 05:16:51 +0000 (UTC)
Date:   Tue, 17 Nov 2020 20:53:45 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH 4/5] locking/rwsem: Wake up all waiting readers if
 RWSEM_WAKE_READ_OWNED
Message-ID: <20201118045345.hpw2fjmd247xpnwl@linux-p48b.lan>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201118030429.23017-5-longman@redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020, Waiman Long wrote:

>The rwsem wakeup logic has been modified by commit d3681e269fff
>("locking/rwsem: Wake up almost all readers in wait queue") to wake up
>all readers in the wait queue if the first waiter is a reader. In the
>case of RWSEM_WAKE_READ_OWNED, not all readers can be woken up if the
>first waiter happens to be a writer. Complete the logic by waking up
>all readers even for this case.

While rwsems are certainly not fifo, I'm concerned this would give too
much priority to the readers by having the reader owned lock just skip
over the first waiter. And I'd say most users are more concerned about
the writer side. Basically this would affect the phase-fair properties.

Thanks,
Davidlohr
