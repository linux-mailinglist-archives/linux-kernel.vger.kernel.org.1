Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31182F69E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbhANSrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbhANSrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:47:07 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB3AC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:46:27 -0800 (PST)
Received: from zn.tnic (p200300ec2f1aa900e8e9bea65a049b95.dip0.t-ipconnect.de [IPv6:2003:ec:2f1a:a900:e8e9:bea6:5a04:9b95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB39F1EC04C2;
        Thu, 14 Jan 2021 19:46:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610649986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=92+CoPH81tRwxks5KvKIwQwhzmFRgZJXUdlU+3LKIYo=;
        b=NrNqLtcCv+CXkNf+1k/00bIXwTXmq6iAicsRIBmVhtHt+pEAZhK+6+cGd7wtudLp3sXV8v
        AKuHzbcMLoLzkb/jE/JYtDusY0E/bLEivLOLL+WHUqbeZgOMCWyaYlwfConEuPzl5awgvl
        db5B76ya9i7Hm/1LOsavHnfDBa1rObU=
Date:   Thu, 14 Jan 2021 19:46:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     trix@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        ying-tsun.huang@amd.com, peterz@infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm/mtrr: remove definition of DEBUG
Message-ID: <20210114184626.GH12284@zn.tnic>
References: <20210114162743.20737-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210114162743.20737-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 08:27:43AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Defining DEBUG should only be done in development.
> So remove DEBUG.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  arch/x86/kernel/cpu/mtrr/generic.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
> index a29997e6cf9e..b90f3f437765 100644
> --- a/arch/x86/kernel/cpu/mtrr/generic.c
> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
> @@ -3,7 +3,6 @@
>   * This only handles 32bit MTRR on 32bit hosts. This is strictly wrong
>   * because MTRRs can span up to 40 bits (36bits on most modern x86)
>   */
> -#define DEBUG
>  
>  #include <linux/export.h>
>  #include <linux/init.h>

Wanna merge all 4 in arch/x86/

arch/x86/kernel/cpu/mtrr/generic.c:6:#define DEBUG
arch/x86/kernel/cpu/mtrr/mtrr.c:34:#define DEBUG
arch/x86/kernel/pci-iommu_table.c:8:#define DEBUG 1
arch/x86/mm/mmio-mod.c:13:#define DEBUG 1

into a single patch?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
