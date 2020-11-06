Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C00B2A8B8E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 01:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbgKFArt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 19:47:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729162AbgKFArs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 19:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604623667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qyPnP4lF1Yi0XyDpJZZP5+UOnDqVjqVsDwjLlXmGNic=;
        b=J2l6QohYRr05Y4dYaT6txMFrxZahuftn0584OSmokXjF2Ix1tr54KEGfms8Nbek76F6UAr
        bivCcm/o/t61n5JvgXVpcR4HGISIe1h1sMFIP+p0Rn76GJEd3NxHAUvKdGKej5IGgGQvwc
        DEDW6Tab0THXEhJX5SI1sVOjBX5xSg0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-c0XE7geMMA6_DBUzvykbEg-1; Thu, 05 Nov 2020 19:47:46 -0500
X-MC-Unique: c0XE7geMMA6_DBUzvykbEg-1
Received: by mail-qv1-f71.google.com with SMTP id d41so2073505qvc.23
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 16:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qyPnP4lF1Yi0XyDpJZZP5+UOnDqVjqVsDwjLlXmGNic=;
        b=EYUdM/3+kW+37NXa1FDnKIcN9N1STcd/+XbZnWXSwxLYkKXQBTSthDtJQu0kHtsFJI
         kD7vWrGvZqFfT1BsL5gAt9dqSW3o378CqtzoFoByVQJlnkGanYDDioPcZgy1N0gC5tuG
         t4xxbpXiiTXlOL8njzJpfcdJN8bBn6/fu9Z3nhu392SIe9X8Hbvjf8PJ1cR3CI6vWFKI
         NbJp1cvTaazdZfaz0+yOXuKBOKE5ojkYtdIZNgOsxlVj6ThQ0doL/hCbW/yw3SjUOzz2
         eCFPuNd6wzGtSjzs+4d0BmBmRTjCz3eS1t82bEyzJOP9If6Aef97NP8tjkB/KTTbxBct
         9qrg==
X-Gm-Message-State: AOAM532RMiOEGSIGzLMOSzb0PP2QEEYcZVa4b7Vfbci5uY8nYuPoMvXk
        ZoskR9HCXWsawh6OkBIrIuCxNTCDLAtdckShD4Yk3H28n0LszwJoL45yh8nR1HqD3sSMElHjKkH
        waj5L++Vd3ZJKS0h+8cT57c0+
X-Received: by 2002:ac8:6d1:: with SMTP id j17mr4841439qth.230.1604623665166;
        Thu, 05 Nov 2020 16:47:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbRk7Wv/ie/4F9jx8fbSx+H1AvkziIsrSKBGbSjzVCO8ww8iY9yV90ttVKnnSFxemgsIHUZw==
X-Received: by 2002:ac8:6d1:: with SMTP id j17mr4841425qth.230.1604623664969;
        Thu, 05 Nov 2020 16:47:44 -0800 (PST)
Received: from tp-x1 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id d133sm2374130qke.106.2020.11.05.16.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:47:44 -0800 (PST)
Date:   Thu, 5 Nov 2020 19:47:43 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, dustymabe@redhat.com
Subject: Re: [PATCH] x86/xen: fix warning when running with nosmt mitigations
Message-ID: <20201106004743.GA380136@tp-x1>
References: <20201106003529.391649-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106003529.391649-1-bmasney@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 07:35:29PM -0500, Brian Masney wrote:
> diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
> index 799f4eba0a62..4a052459a08e 100644
> --- a/arch/x86/xen/spinlock.c
> +++ b/arch/x86/xen/spinlock.c
> @@ -93,9 +93,24 @@ void xen_init_lock_cpu(int cpu)
>  
>  void xen_uninit_lock_cpu(int cpu)
>  {
> +	int irq;
> +
>  	if (!xen_pvspin)
>  		return;
>  
> +	/*
> +	 * When booting the kernel with 'mitigations=auto,nosmt', the secondary
> +	 * CPUs are not activated and only the primary thread on each CPU core
> +	 * is used. In this situation, xen_hvm_smp_prepare_cpus(), and more
> +	 * importantly xen_init_lock_cpu(), is not called, so the
> +	 * lock_kicker_irq is not initialized for the secondary CPUs. Let's
> +	 * exit early if the irq is not set to avoid a warning in the console
> +	 * log.
> +	 */
> +	irq = per_cpu(lock_kicker_irq, cpu);
> +	if (irq == -1)
> +		return;
> +
>  	unbind_from_irqhandler(per_cpu(lock_kicker_irq, cpu), NULL);

As soon as I saw this on lore, I saw that I should have passed the irq
variable to unbind_from_irqhandler() rather than doing another per_cpu()
lookup. I'll wait for feedback about the general approach before posting
a v2.

Brian

