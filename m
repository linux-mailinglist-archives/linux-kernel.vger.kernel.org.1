Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2952FD77A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbhATRsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391797AbhATRqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:46:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1613EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Br/9Jhb2pIM3jsWsK/El0R8bMfCO02TFGx7tgtozy24=; b=o9zGwF+gSmutoUV/+gfC9MMcA2
        h08w6Ph5gFFkkR2Ck2WC2PnWS8fPAg+9OD3qJBwKe5/mPTFcEi+q1Ke4yBBoMLcTUw0NkdymSly3/
        lJD0JWnWw+s8xQz5bllBCwMSyAh0FMEDJ6uwW3JzCFRg4AGPGKSPqnjBIlteq8KuSGSLWL5c211v4
        eD3J0dW6+WmLB3rWPi/WYUrHfFIYQWPR+7v85iuz/4gLCO6erZ/b5Sgq3i425AlHm3CdIBtbddqBK
        n2UIuDpZFEYnJhoVQgRvBJoz9aF8zAd1FYlzWzbN7Rq7/+H26KBPXxUCrLv7y4ZgB9T/8qzcyTFdK
        lWpVXVUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2HXk-0006d3-KB; Wed, 20 Jan 2021 17:45:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59D7F3012DF;
        Wed, 20 Jan 2021 18:45:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B58EB2CEAD191; Wed, 20 Jan 2021 18:45:16 +0100 (CET)
Date:   Wed, 20 Jan 2021 18:45:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     vincent.donnefort@arm.com
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH 3/4] cpu/hotplug: Add cpuhp_invoke_callback_range()
Message-ID: <YAhsLPLXg37fs/BA@hirez.programming.kicks-ass.net>
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
> @@ -475,6 +478,11 @@ cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
>  static inline void
>  cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
>  {
> +	st->target = prev_state;
> +
> +	if (st->rollback)
> +		return;

I'm thinking that if we call rollback while already rollback we're hosed
something fierce, no?

That like going up, failing, going back down again, also failing, giving
up in a fiery death.
