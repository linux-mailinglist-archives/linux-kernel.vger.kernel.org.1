Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1A327D75B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgI2Tzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgI2Tzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:55:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA975C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:55:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601409346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K3Ljcj9XHfAayChRM36o6HkpqXb+KiKhvnlC4UjmKDw=;
        b=htpCqoW1pTAvYF2/rHNeySQw/+A65S9f1/VTBJ8SlduZC1yENqWKCjnXZmvFI+gmCMhOVK
        VAC29Ec4N2DONDwgIzmsuvyueLimykBXiOw839xw055N39t4aGLRHBSAPmjafz4RhwCj9k
        kmxp+KoUdlWDWmW807RuO0pwk4LqGmmQxg+pgkXtQG59WJYXzCy6KdehrNVVVj2+RK1+D8
        t4lk6ZP0CAJI37PpAjtIpAhSO6iT1ozSoGaTismGOItChhRhZlIPl++uJ9rNaRDEImrrK4
        o2U1R2hP+Z1UwpA8P5A814frmzmDuP4POFzgqvDqW26Vc/U3SBpSkJlHaLoxRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601409346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K3Ljcj9XHfAayChRM36o6HkpqXb+KiKhvnlC4UjmKDw=;
        b=++EMBmuhKlRGdEM+1uo9+ZxjZyB54yKCQQM/ctHdAL0cnmfeKzxDnW43EQ89BcXhfNeOii
        G1xXOYz6s3T4zUDQ==
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Uladzislau Rezki \(Sony\)" <urezki@gmail.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: clarify usage of GFP_ATOMIC in !preemptible contexts
In-Reply-To: <20200929123010.5137-1-mhocko@kernel.org>
References: <20200929123010.5137-1-mhocko@kernel.org>
Date:   Tue, 29 Sep 2020 21:55:45 +0200
Message-ID: <875z7wjr26.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29 2020 at 14:30, Michal Hocko wrote:
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 67a0774e080b..2e8370cf60c7 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -238,7 +238,9 @@ struct vm_area_struct;
>   * %__GFP_FOO flags as necessary.
>   *
>   * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
> - * watermark is applied to allow access to "atomic reserves"
> + * watermark is applied to allow access to "atomic reserves".
> + * The current implementation doesn't support NMI and few other strict
> + * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_NOWAIT.
>   *
>   * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
>   * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
