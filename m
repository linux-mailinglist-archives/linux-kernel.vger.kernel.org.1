Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854C5272509
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgIUNKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgIUNKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813FBC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 06:10:08 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07e300be7bcf3e7fc25083.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:e300:be7b:cf3e:7fc2:5083])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D391A1EC03CE;
        Mon, 21 Sep 2020 15:10:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600693807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9/ujxYY+aQO9o6gv67WT5My/XdaKCAJBq6gZzzqrh60=;
        b=S+7d7u/sq7HYFYv57bZLJtkf5+lw8JXx+Tr2DS5AXYBgLA1UEzN1klkOBnj1H6AdjyCcGP
        kNxwsIAYIQ7uFjZid0CFoLqeHpJ63FSZ4p7snqa747CyatgmbPAti5bUoHZ6dAib1qtB5M
        ANRtao6sCCyHy2SVWy8tyVS1Rifl6lA=
Date:   Mon, 21 Sep 2020 15:10:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Hommey <mh@glandium.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/boot: Handle fpu-related and clearcpuid command
 line arguments earlier
Message-ID: <20200921131005.GF5901@zn.tnic>
References: <20200920083626.GA7473@zn.tnic>
 <20200920220036.7469-1-mh@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200920220036.7469-1-mh@glandium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 07:00:36AM +0900, Mike Hommey wrote:
> FPU initialization handles them currently. However, in the case of
> clearcpuid, some other early initialization code may check for features
> before the FPU initialization code is called. Handling the argument
> earlier allows the command line to influence those early
> initializations.
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  arch/x86/kernel/cpu/common.c | 41 ++++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/fpu/init.c   | 41 ------------------------------------
>  2 files changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index c5d6f17d9b9d..5e2e4d3621bd 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -23,6 +23,7 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/pgtable.h>
>  
> +#include <asm/cmdline.h>
>  #include <asm/stackprotector.h>
>  #include <asm/perf_event.h>
>  #include <asm/mmu_context.h>
> @@ -1220,6 +1221,45 @@ static void detect_nopl(void)
>  #endif
>  }
>  
> +/*
> + * We parse cpu parameters early because early_identify_cpu() is executed
> + * before parse_early_param().
> + */
> +static void __init cpu__init_parse_early_param(void)

Yeah, let's call it simply "cpu_parse_early_param".

Also, I forgot to says this, sorry about that, but can you pls do your
patch ontop of tip/master:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/

because there are other changes in that area and your patch as is,
doesn't apply.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
