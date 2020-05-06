Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019721C78DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 20:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbgEFSDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 14:03:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50170 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgEFSDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:03:45 -0400
Received: from zn.tnic (p200300EC2F069600311A41E22EFEB62B.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9600:311a:41e2:2efe:b62b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB6D81EC0333;
        Wed,  6 May 2020 20:03:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588788223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fJ/fZco1UMCjYYs0wb4UMDe1Jh8bBMMciwfrwgZhT7g=;
        b=h4qMa/ghxjV1mLSXRrtgrXkkwyFXYF9CtX4vtWR745SSTADbgLoX4FgqTeCeJ8iOLfDoDK
        rZEju91ENqeg8dMkvEzi25LZ2Tctfq5oqP8Maxn4DA1z6/iDIO9sL9Pbc6xpP8xC8d6Ooa
        3/A+UQzhPZyK+LJSjSX8CYjmq4DN86Y=
Date:   Wed, 6 May 2020 20:03:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/7] x86/resctrl: Support wider MBM counters
Message-ID: <20200506180338.GG25532@zn.tnic>
References: <cover.1588715690.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588715690.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:36:11PM -0700, Reinette Chatre wrote:
> Reinette Chatre (7):
>   x86/resctrl: Rename asm/resctrl_sched.h to asm/resctrl.h
>   x86/cpu: Move resctrl CPUID code to resctrl
>   x86/resctrl: Remove unnecessary RMID checks
>   x86/resctrl: Query LLC monitoring properties once during boot
>   x86/resctrl: Maintain MBM counter width per resource
>   x86/resctrl: Support CPUID enumeration of MBM counter width
>   x86/resctrl: Support wider MBM counters
> 
>  MAINTAINERS                                   |  2 +-
>  arch/x86/include/asm/processor.h              |  3 +-
>  .../asm/{resctrl_sched.h => resctrl.h}        |  9 +++--
>  arch/x86/kernel/cpu/amd.c                     |  3 ++
>  arch/x86/kernel/cpu/common.c                  | 40 -------------------
>  arch/x86/kernel/cpu/intel.c                   |  7 ++++
>  arch/x86/kernel/cpu/resctrl/core.c            | 32 ++++++++++++++-
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  8 ++--
>  arch/x86/kernel/cpu/resctrl/internal.h        | 15 +++++--
>  arch/x86/kernel/cpu/resctrl/monitor.c         | 27 +++++++++----
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c        |  4 +-
>  arch/x86/kernel/process_32.c                  |  2 +-
>  arch/x86/kernel/process_64.c                  |  2 +-
>  14 files changed, 91 insertions(+), 65 deletions(-)
>  rename arch/x86/include/asm/{resctrl_sched.h => resctrl.h} (92%)

It all looks very good, thanks for the good work!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
