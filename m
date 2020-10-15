Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF09F28E9AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgJOBQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgJOBQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:16:42 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE70BC045708
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:16:41 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id w17so2210628ilg.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f+VQm+GCd77gKfnBI0U0A6ACRKwOlvYFJHxUn4tNp/4=;
        b=P9ulBwKRoZlgh0HWFIhUvODejuLfpzxhsEIQzmYOFGtAxJJ4Ux85/rE9uWQNAtDXsA
         /+PKDXt/tdp3KUU7NvURom0vbscyaZgfGd5GjWTfDxW3hD5wjFiKmFhDs79+qU0H1EpA
         IEALnopRBia8fscwf2YDtcf1BxEIidP8sWtYEns/ZPafDXuZRGIunQ3f0uJgrpsCKl7g
         YOyWtHXVm9suoFAoUNzJWcZhRp5k0sl0rvdRWzlbx0cqriecFsho6CQjCrwNyUtu3iRY
         by3FUBjV9qnpRUJBpZd0jkglfKnZUpmCH8d/0NZsa699HI9GdH4l/qgN1haCjDP4ufRx
         QgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f+VQm+GCd77gKfnBI0U0A6ACRKwOlvYFJHxUn4tNp/4=;
        b=Mb6jSU3NhpgH4nePmJNklS++13rsrRMauddsbK2+GkoVWoPtKNedJXBPvxHzaZl8w1
         NlTf6901O0nLnaku/eLUapYasLtDirH7OXE7Z7Po4PaIdiMwbVoozmVGPKr8/ZnDjjS/
         oJ1ZKTKie38aC9tGF1wUhN7Q4Bfx7PLLbFei2uAdbCYJzBm0J3D5WTJN52jPhkdtJ+pM
         UQl6ui25fH9P0skguxA469nfa9l7Ba8Hun7zQfYu4E5VEC+jaetI5BgpReo4ojgkPTKa
         3UyGp9UJEN46m3jo45R1i9janFcxZDzCYLVeP1zH9wIra4AhOHGss1kEXKISTuCKsiZr
         HbCg==
X-Gm-Message-State: AOAM532O0+Ww6lrvg6qoAUhIHJWWmq0vk1yBj53YgNx49ABC4W19PVHU
        JkClCFnbCcSBDd7Mp3xemQ==
X-Google-Smtp-Source: ABdhPJyrkoYD5xp/FDUz6oQftni3lYBv91fg4w/zk0ULRzN1QsQsl2aY6epo9iDiUgJNopfjmHkkzg==
X-Received: by 2002:a05:6e02:1073:: with SMTP id q19mr1411357ilj.55.1602724601411;
        Wed, 14 Oct 2020 18:16:41 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id v18sm1079595ilj.12.2020.10.14.18.16.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Oct 2020 18:16:37 -0700 (PDT)
Date:   Wed, 14 Oct 2020 21:16:34 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] arm64: smp: Allocate and setup IPI as NMI
Message-ID: <20201015011634.zz2tnbc7yvhzxddc@gabell>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-4-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602673931-28782-4-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 04:42:09PM +0530, Sumit Garg wrote:
> Allocate an unused IPI that can be turned as NMI using ipi_nmi framework.
> Also, invoke corresponding NMI setup/teardown APIs.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm64/kernel/smp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 82e75fc..129ebfb 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -43,6 +43,7 @@
>  #include <asm/daifflags.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/mmu_context.h>
> +#include <asm/nmi.h>
>  #include <asm/numa.h>
>  #include <asm/processor.h>
>  #include <asm/smp_plat.h>
> @@ -962,6 +963,8 @@ static void ipi_setup(int cpu)
>  
>  	for (i = 0; i < nr_ipi; i++)
>  		enable_percpu_irq(ipi_irq_base + i, 0);
> +
> +	ipi_nmi_setup(cpu);
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> @@ -974,6 +977,8 @@ static void ipi_teardown(int cpu)
>  
>  	for (i = 0; i < nr_ipi; i++)
>  		disable_percpu_irq(ipi_irq_base + i);
> +
> +	ipi_nmi_teardown(cpu);
>  }
>  #endif
>  
> @@ -995,6 +1000,9 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>  		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
>  	}
>  
> +	if (n > nr_ipi)
> +		set_smp_ipi_nmi(ipi_base + nr_ipi);
> +
>  	ipi_irq_base = ipi_base;
>  
>  	/* Setup the boot CPU immediately */
> -- 

Looks good to me. Please feel free to add:

        Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks!
Masa

