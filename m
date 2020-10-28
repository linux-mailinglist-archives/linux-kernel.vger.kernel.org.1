Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B5929D95D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389696AbgJ1WxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:53:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48808 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389676AbgJ1Ww7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CoaJ9tDmZ1LJ1BuhReYbI223NgdnurGa35yue6VMwt0=; b=JdjIYQD5o5Gr5PF7wWhzVBs1ry
        TzWm6U5+5uNJxiJkWa79hAbTX9XFrtYZV58iafOopQRCYInZYRrnVZlkszs8sXVJLr8Fo+Pv70bpv
        udfjNK531hpzdFeYERGEm9l22pSmXm2nxbXe5EDbfqv2lPk0HJ7FwQEhLjKtR1q2Ox34WgagEN0iQ
        QtQIV0LGsMVcdBCdengvWrngTVAoE2LP7cniC+wzzQb0B2i3CONOOxa1JU2zoQEjx79wGkPtMLy3b
        AGOvDj/TRbkFIkqGFCYYTS4C+eqyy8EEs0Tpiu4+lJueKOJSOi3ikXn5y1sIRcz42Be1J6dKBSNJj
        kiWAgIIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXmop-0005mh-Al; Wed, 28 Oct 2020 14:52:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0BE5B3006D0;
        Wed, 28 Oct 2020 15:52:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CE8F220F8C32; Wed, 28 Oct 2020 15:52:52 +0100 (CET)
Date:   Wed, 28 Oct 2020 15:52:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        paulmck@kernel.org, hch@lst.de, axboe@kernel.dk,
        chris@chris-wilson.co.uk, davem@davemloft.net, kuba@kernel.org,
        fweisbec@gmail.com, oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v3 4/6] irq_work: Unconditionally build on SMP
Message-ID: <20201028145252.GC2628@hirez.programming.kicks-ass.net>
References: <20201028110707.971887448@infradead.org>
 <20201028111221.464733855@infradead.org>
 <20201028133420.GD229044@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028133420.GD229044@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:34:20PM +0100, Frederic Weisbecker wrote:
> On Wed, Oct 28, 2020 at 12:07:11PM +0100, Peter Zijlstra wrote:
> 
> This may need a changelog :-)

Like so then?
---

Only (the local) irq_work_queue() relies on arch self-IPI bits,
prepare to have the remote queueing available on all SMP.

