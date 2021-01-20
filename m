Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985582FD783
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbhATRus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387672AbhATRty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:49:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8798C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y6ucevQqCCSFkQ4lpVVj7hWzqxFrN4WqZV9ERRep9/o=; b=CxL80HsF/MHgEvadkKwh2QBJZL
        PxkitZr3TY/UUv5RuC4ll1nPg2Vcz1sp0mH8FUphGQWz0Welt+PEwglmXCvF3soAGjn5TBeGzQAOi
        Tez+923CtOMmfujlmJ1Jd621V37jUg5+p4fUU4ENieP3Ga+l+Y9TXdYFhV+NDB5WKJsNvDkzosFIW
        Q+dyJ5/etrWlYJ9agwlqp52Z1rds+Kk0ghaKZlyrsnxHi7iGmZj/UO3hQzCoRQsbf6Y/qgWv9CjsZ
        JxseZv/FXcqTvmwbPUf1wJ2hjCfqoPWtT8sqNxQpAy8kF6kWB7jBBCzd2Nsfm7L9mugUyIMhEFI2d
        uufI793Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2HbL-00G0jQ-CO; Wed, 20 Jan 2021 17:49:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3F083012DF;
        Wed, 20 Jan 2021 18:49:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B11542CEAD18E; Wed, 20 Jan 2021 18:49:00 +0100 (CET)
Date:   Wed, 20 Jan 2021 18:49:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     vincent.donnefort@arm.com
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH 3/4] cpu/hotplug: Add cpuhp_invoke_callback_range()
Message-ID: <YAhtDKne2/x97YHj@hirez.programming.kicks-ass.net>
References: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
 <1610385047-92151-4-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610385047-92151-4-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 05:10:46PM +0000, vincent.donnefort@arm.com wrote:
> +		if (can_rollback_cpu(st))
> +			WARN_ON(cpuhp_invoke_callback_range(false, cpu, st,
> +							    prev_state));

> +	if (ret)
>  		/*
>  		 * DYING must not fail!
>  		 */
>  		WARN_ON_ONCE(ret);
> -	}

> +	if (ret) {
> +
> +		cpuhp_reset_state(st, prev_state);
> +
> +		if (st->state < prev_state)
> +			WARN_ON(cpuhp_invoke_callback_range(true, cpu, st,
> +							    prev_state));
>  	}

> +	if (ret)
>  		/*
>  		 * STARTING must not fail!
>  		 */
>  		WARN_ON_ONCE(ret);
> -	}

Stuff like that is CodingStyle fail.
