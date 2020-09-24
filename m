Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2CF276C14
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgIXIgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:36:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44130 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgIXIgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:36:04 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600936563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TDxJccgKr/pqF0i8iVp/rre3jVO7uhvMIYmZMnvVvZU=;
        b=SyZdciegcKpPV0jjV9bRo7+vUSCKycz9MgFEb9oTm6uwrf3OSk8uq2hYmxa/8CocuFkL1x
        4Pd6h8RV0R6hyGzlxiXwtyQzwo7vO4Ht6O/NcntsACRqThO4QO9GQW3DDb7jJhd6Gg2sei
        sYKVTtvpjEIeaQ9VICZcCwqjIbx2Esg/A7aSUfZN7CO43O4Do3tlFHxYIFk101FjNkOYAC
        xlH/REP186S6g/9iPvvKKdv21WS6xvP81kjtMg6fFm8rvmcCHwt9mIXRY46eihHDm2Lt5O
        pUCQQx1Cy+oElJln7Poo0i52iAL80S/YDqzpjAY1VlUCYTMyPmvxzD5RKdpojA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600936563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TDxJccgKr/pqF0i8iVp/rre3jVO7uhvMIYmZMnvVvZU=;
        b=T9nd67LCewMGjblbiZmewyerC19x+1DjMLYUzTl3K8oD1lOpWuJupJC/YoXUZZ/CzaPVGc
        DYG+qCSYzGYdg2CQ==
To:     qianjun.kernel@gmail.com, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Cc:     laoar.shao@gmail.com, qais.yousef@arm.com, urezki@gmail.com,
        jun qian <qianjun.kernel@gmail.com>
Subject: Re: [PATCH V7 2/4] softirq: Factor loop termination condition
In-Reply-To: <20200915115609.85106-3-qianjun.kernel@gmail.com>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com> <20200915115609.85106-3-qianjun.kernel@gmail.com>
Date:   Thu, 24 Sep 2020 10:36:03 +0200
Message-ID: <87v9g38tcc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15 2020 at 19:56, qianjun kernel wrote:
>  asmlinkage __visible void __softirq_entry __do_softirq(void)
>  {
>  	u64 start = sched_clock();
>  	unsigned long old_flags = current->flags;
> -	int max_restart = MAX_SOFTIRQ_RESTART;
> +	unsigned int max_restart = MAX_SOFTIRQ_RESTART;

And this change is related to making the timeout check a function in
which way?

Thanks,

        tglx
