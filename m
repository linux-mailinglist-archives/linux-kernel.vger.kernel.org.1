Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54902FEDD0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbhAUO7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbhAUO6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:58:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B72C061786
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 06:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e8eyXWv9TNfB8rTh4a0YjdR85qyV5f8Yl1cBULzvB1A=; b=SirJxrLF4Q45UKXQW8vX2OaUoo
        dt5iIN9oMNbsr1xkkcMB3aVi8+ExgY6q1468WgnHos9mQ8nI3i4gQ8IifT2hTvBhUdlY8IEfRSp2K
        RSK7xY09cocu+8qT6oQShk9rnnf4Tioal6P0Msn73xKCmFvSudHZhW0Tpf7PTwWXy/zLFtFyrWWlG
        LdAfP1Kn5VsTXA3c7IXrjPa2AoPikecfz9IqJtO98JTMbMkqvwrwbHfyzRc82tvMrTKqfbzqiGi8B
        M9mUtMEoiDTGL/NRrXTM7OF0/MqkQImg3ZGbrfXUMgtgx7nce2j1U87OgW69H7uuErdxIktagIkFm
        TU+CwntA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2bOV-00HAtT-2v; Thu, 21 Jan 2021 14:57:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 293EF303A02;
        Thu, 21 Jan 2021 15:57:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E71BD2028F0C2; Thu, 21 Jan 2021 15:57:03 +0100 (CET)
Date:   Thu, 21 Jan 2021 15:57:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     vincent.donnefort@arm.com
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH 4/4] cpu/hotplug: Fix CPU down rollback
Message-ID: <YAmWP1vbLYFgl82n@hirez.programming.kicks-ass.net>
References: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
 <1610385047-92151-5-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610385047-92151-5-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 05:10:47PM +0000, vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> After the AP brought itself down to CPUHP_TEARDOWN_CPU, the BP will finish
> the job. The steps left are as followed:
> 
>    +--------------------+
>    | CPUHP_TEARDOWN_CPU |  -> If fails state is CPUHP_TEARDOWN_CPU
>    +--------------------+
>    |   ATOMIC STATES    |  -> Cannot Fail
>    +--------------------+
>    |  CPUHP_BRINGUP_CPU |  -> Cannot fail
>    +--------------------+
>    |        ...         |
>    |        ...         |  -> Can fail and rollback

These are the PREPARE/DEAD states, right? It would be _really_ daft for
a DEAD notifier to fail. But yeah, I suppose that if it does, it will
indeed end up in CPUHP_AP_ONLINE_IDLE.

Do we want to WARN when a DEAD notifier fails?


