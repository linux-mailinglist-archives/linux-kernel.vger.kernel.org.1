Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC134228004
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 14:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgGUMe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 08:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbgGUMe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:34:56 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 974CF2073A;
        Tue, 21 Jul 2020 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595334896;
        bh=vUe9hnCspzpvQ1bWYGN07vwyvC0xZtzQvZTo1mLVAIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ijCJhbR63KWX8tPErqmk1gCtsNWWuOkr8OwEYEYmyr8Kb6lHcuD1I7qPFWm2KIrFy
         TBRxDpKcu8I5ZQFaLD8vdkDsK6J8+viX25vym8+l5hb8XFd992FphImLJr8DfXVm4k
         NxK37gi0wK4rHF6nfdxvcKUCOlcDbHHUNoNKOQE4=
Date:   Tue, 21 Jul 2020 14:34:53 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V2 2/5] posix-cpu-timers: Convert the flags to a bitmap
Message-ID: <20200721123452.GA9290@lenoir>
References: <20200716201923.228696399@linutronix.de>
 <20200716202044.625081169@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716202044.625081169@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:19:25PM +0200, Thomas Gleixner wrote:
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -25,7 +25,7 @@ void posix_cputimers_group_init(struct p
>  	posix_cputimers_init(pct);
>  	if (cpu_limit != RLIM_INFINITY) {
>  		pct->bases[CPUCLOCK_PROF].nextevt = cpu_limit * NSEC_PER_SEC;
> -		pct->timers_active = true;
> +		set_bit(CPUTIMERS_ACTIVE, &pct->flags);

I guess this one could be __set_bit().

>  	}
>  }
