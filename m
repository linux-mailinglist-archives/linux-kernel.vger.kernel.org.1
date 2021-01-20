Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07A82FD26F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390388AbhATONL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388241AbhATNLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:11:39 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63040C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cWnQ4I32TIvpJOw8Q92cr9oKfPVoryLnq4TaPojC+IM=; b=wR1VoXSZvxClmwzOl5f02QBtBJ
        3c3l3FZ2PlENBI/LcsQlX64AxcZRFAUp41Xanw/Cgh8xvONaV1T93iv/jyKyMHP4gaYM7WcMAhcqw
        gd6hboyr/FhTYFmWmvVElN/qKACdNDK9A55xRk0lF589kvxJPVasfc3kz4G0HZsPHN3SzRCiU1dyV
        DQc/cgNx5iLZgbrZXP6iLEF+I/e+FEc4vt7NDhUH+DzkB8KSURoWNgXviYIth5iFoShzXLbUhVuKY
        fYu/IKgBGMO8xasoO+8yqSKkCc4G4yBXoILya73pHWMs9N9mt5irz6rm2z/NAzFUf5WrSyrFLDRM8
        J4+qKiag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2DGX-00071n-79; Wed, 20 Jan 2021 13:11:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47804301959;
        Wed, 20 Jan 2021 14:11:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07C05200E3598; Wed, 20 Jan 2021 14:11:14 +0100 (CET)
Date:   Wed, 20 Jan 2021 14:11:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     vincent.donnefort@arm.com
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH 3/4] cpu/hotplug: Add cpuhp_invoke_callback_range()
Message-ID: <YAgr8RQg6Cn66bvf@hirez.programming.kicks-ass.net>
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
> @@ -157,26 +162,24 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
>  
>  	if (st->fail == state) {
>  		st->fail = CPUHP_INVALID;
> -
> -		if (!(bringup ? step->startup.single : step->teardown.single))
> -			return 0;
> -
>  		return -EAGAIN;
>  	}
>  
> +	if (cpuhp_step_empty(bringup, step)) {
> +		WARN_ON_ONCE(1);
> +		return 0;
> +	}

This changes the behaviour of fail.. might be best to refactor without
changing behaviour.

Lemme continue reading.
