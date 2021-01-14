Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6312F6993
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbhANSbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:31:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44678 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbhANSbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:31:11 -0500
Received: from zn.tnic (p200300ec2f1aa900e8e9bea65a049b95.dip0.t-ipconnect.de [IPv6:2003:ec:2f1a:a900:e8e9:bea6:5a04:9b95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5BEDA1EC03CA;
        Thu, 14 Jan 2021 19:30:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610649030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=evMHSJs6OGwjgkwoX2qZJxB5+p4EsGCVCBCvs1NxTpo=;
        b=jNOZmutTqW+cfYEjryLRyzbm9kOBDQmgyb6h/iz8w29CoZH4xPBW+gUnTW51jZz/5yGtl6
        J4YSg7ufLzTupVUiP2CEfrcd7uJycHcUd1fC9rsuDksbfRgleMAN4Ov2XwpO/ALiMDCN2t
        D9TJSPp6xXwtf/ToITomTjAr8cVZZh8=
Date:   Thu, 14 Jan 2021 19:30:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 08/15] x86: add new features for paravirt patching
Message-ID: <20210114183024.GF12284@zn.tnic>
References: <20201217093133.1507-9-jgross@suse.com>
 <202012172021.VSDLPK5D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202012172021.VSDLPK5D-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 09:12:57PM +0800, kernel test robot wrote:
>    ld: arch/x86/kernel/alternative.o: in function `paravirt_set_cap':
> >> arch/x86/kernel/alternative.c:605: undefined reference to `pv_is_native_spin_unlock'
> >> ld: arch/x86/kernel/alternative.c:608: undefined reference to `pv_is_native_vcpu_is_preempted'

Looks like alternative.c needs #include <asm/paravirt.h>.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
