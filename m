Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3720C2D2864
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgLHKFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:05:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38465 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgLHKFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:05:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id w13so9522952lfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 02:05:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+8c2coVkKUv4qWbmmSD/ogXb83OHwIb/Y+UGiW8xsgk=;
        b=HsQ3tAS6HcHe8bLZ6fO97NayH7NJZpBspHSS2LCm+XeaaSdUp33/UH3REYRJMu0wYK
         wUwe+Lzo0aecNfx4lEaWicwfdeQm2TZbh5t520/PSQjtsDdqFWzlzMRT7Y653cmKC38b
         x+KiZYhdWrYPM/yFT3s0na2kTeOTdKib7rcHKJFgiC5K80czmA887udqg8Do5WXnFEfF
         Bv36e6jwMlyNKs5lhtBLAqbruIYEAx7l/UtXORP/sYGCB75wKyiKIbGuoObBK0Abvt2u
         UWwdX3M1bLUbkpXkChd9MI6fgkttrJoaHZLpVvhUZcFN24mUrXLXwahUbIDYWmMlogij
         yreA==
X-Gm-Message-State: AOAM532aaxIZOIm3ToaFyFaJo3phK/HST0kqrgr1MPgRHeI1JrGjOW3r
        AG1fRFRCmfxq8W77xRqAk7s=
X-Google-Smtp-Source: ABdhPJzpel3aaqTwyCUke3uxySPwIgx/XYdjc2iP+LARC38hryKtfsLkCrh0b1xHUiccsCej2V88hQ==
X-Received: by 2002:a19:3f12:: with SMTP id m18mr3378305lfa.519.1607421896048;
        Tue, 08 Dec 2020 02:04:56 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id u7sm3170758lfu.244.2020.12.08.02.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 02:04:55 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kmZsC-0002bL-FD; Tue, 08 Dec 2020 11:05:33 +0100
Date:   Tue, 8 Dec 2020 11:05:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] x86/apic: Fix CPU devicetree-node lookups
Message-ID: <X89P7Bnw4x9i0y4Q@localhost>
References: <20201124134247.2668-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124134247.2668-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:42:47PM +0100, Johan Hovold wrote:
> Fix CPU devicetree-node lookups by implementing
> arch_match_cpu_phys_id().
> 
> This allows using of_get_cpu_node() and of_cpu_device_node_get() to look
> up CPU devicetree nodes and specifically makes sure that CPU struct
> devices are linked to the correct devicetree nodes.
> 
> Note that CPUs are described in devicetree using their APIC ids and
> that those do not generally coincide with the logical ids (e.g. used by
> the default arch_match_cpu_phys_id() implementation).
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  arch/x86/kernel/apic/apic.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index b3eef1d5c903..19c0119892dd 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2311,6 +2311,11 @@ static int cpuid_to_apicid[] = {
>  	[0 ... NR_CPUS - 1] = -1,
>  };
>  
> +bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
> +{
> +	return phys_id == cpuid_to_apicid[cpu];
> +}
> +
>  #ifdef CONFIG_SMP
>  /**
>   * apic_id_is_primary_thread - Check whether APIC ID belongs to a primary thread

Any comments to this one? Can it be picked up for 5.11?

Johan
