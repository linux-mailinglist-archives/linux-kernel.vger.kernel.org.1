Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623C129DD0C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbgJ1WT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731761AbgJ1WRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:44 -0400
Received: from localhost (i15-lef02-th2-89-83-213-3.ft.lns.abo.bbox.fr [89.83.213.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4916B2417F;
        Wed, 28 Oct 2020 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603890084;
        bh=BaPFvorGv6k2JcdmJyhCKrgzQGDb9SDddIIaGqpkDA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1WHlICxfragRtb2Ebwt6oZtLLHLgcI0mQFxLIT8wTj+6BAMBjN1VZVr+q4wZpLjm
         DTN4O2KVKxmOtO4I2KGAZC1WS0Fuc7DVLL5VYR4N80sxSdPhFNixLei65MdD5AJZ5O
         SF5YJSI6oRYZe9NVCeKtlzm34ZQgWZe0B0O5AkYk=
Date:   Wed, 28 Oct 2020 14:01:21 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        paulmck@kernel.org, hch@lst.de, axboe@kernel.dk,
        chris@chris-wilson.co.uk, davem@davemloft.net, kuba@kernel.org,
        fweisbec@gmail.com, oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v3 1/6] irq_work: Cleanup
Message-ID: <20201028130121.GB229044@lothringen>
References: <20201028110707.971887448@infradead.org>
 <20201028111221.284588085@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028111221.284588085@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:07:08PM +0100, Peter Zijlstra wrote:
> +#define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
> +	.node = { .u_flags = (_flags), },			\

I guess, just for the sake of being conservative:

 +	.node = { .a_flags = ATOMIC_INIT(_flags), },


> +	.func = (_func),					\
> +}

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.
