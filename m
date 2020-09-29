Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B67C27D841
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgI2Ud0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI2Ud0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:33:26 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E15C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:33:25 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s205so5127040lja.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gvr9bkV9VfhnMW3HOHElqYjzyELtn3Escgba9Lv3wB4=;
        b=IvLWm6Sk3UDxYamWD+QC1RyoEtAKae8tmfxhPqQbyrTuf34rqKZa0ViaAfRMD59bZk
         Ym6BCTn3agicCeKMruKL7OwwJwm2Y26Sn6RfbpjjH6fT+0eIvBLMqzD9KbBcIeiiH593
         DpuU4kgLqzv4KONpx4ysc0wbR2sr0Rxq9d1jsFKXt58YIBIharjP+8ciForEt8nUYnh+
         jBQu5yLJZBE2LeOBh7e72y6DjKdt4rYzzLVz9X16YZ8UvpT0zLXypUhBrtzMlom5V7ji
         ppLSTj/yhNrMznispvI+1T29Uef2tOE9lJP2JUuTFHVTzMJtK9gVfKdO/RuYIHLT1pVb
         OKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gvr9bkV9VfhnMW3HOHElqYjzyELtn3Escgba9Lv3wB4=;
        b=tu8bjPcZ2ihT3VVc8RCAKbxPwNFlAVvy6RyXWS+tceHA6kntHY6wV97kWyP68YLdBD
         9HJ3LS4jRm/S6++TR4f9ahawLq8IHfgWDSrhrOqaiBNK80ww/5ljrQvZOoKykaqoXBrI
         9xzDm58ii0NhSOEaMQ7Rx0VUihDk7jooVDAqFUYUfi5Tr4T19rlfBiUiUHDgy65gbOno
         PG18KptEwxTI9Z1/GGk6ym1FhzI4o2Yn6qvwao1EN28toNkgeUR5QYJOe/9UwqLyLWKI
         zvSM38GbYjX9ng4KcEyXlY9ywoqD/eMiSqSH0AdHAv/IgNTZel/7TYEgpjvr4VuC/4b1
         yT+g==
X-Gm-Message-State: AOAM533tnEESl8J8h07XkCK0AEjvj+T+mUCAz0+rTROhYOFgql7jWbgo
        4Ck+VZNpQ+5RZw3zaq/yvYs=
X-Google-Smtp-Source: ABdhPJzPqsZ5eSYthSF22DsMeOge+/quUwD3O+Ai2KE63ENbwhBXjbmzt8P/gBihg+lcuf/rAIt8Aw==
X-Received: by 2002:a2e:3c04:: with SMTP id j4mr1773690lja.397.1601411604018;
        Tue, 29 Sep 2020 13:33:24 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id p27sm3388115lfo.272.2020.09.29.13.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:33:23 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 29 Sep 2020 22:33:21 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: clarify usage of GFP_ATOMIC in !preemptible contexts
Message-ID: <20200929203321.GA11583@pc636>
References: <20200929123010.5137-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929123010.5137-1-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 02:30:10PM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> There is a general understanding that GFP_ATOMIC/GFP_NOWAIT are
> to be used from atomic contexts. E.g. from within a spin lock or from
> the IRQ context. This is correct but there are some atomic contexts
> where the above doesn't hold. One of them would be an NMI context.
> Page allocator has never supported that and the general fear of this
> context didn't let anybody to actually even try to use the allocator
> there. Good, but let's be more specific about that.
> 
> Another such a context, and that is where people seem to be more daring,
> is raw_spin_lock. Mostly because it simply resembles regular spin lock
> which is supported by the allocator and there is not any implementation
> difference with !RT kernels in the first place. Be explicit that such
> a context is not supported by the allocator. The underlying reason is
> that zone->lock would have to become raw_spin_lock as well and that has
> turned out to be a problem for RT
> (http://lkml.kernel.org/r/87mu305c1w.fsf@nanos.tec.linutronix.de).
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/linux/gfp.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
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
> -- 
> 2.28.0
> 

Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
