Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA2B2F69C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbhANSlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbhANSlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:41:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBABC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:40:24 -0800 (PST)
Received: from zn.tnic (p200300ec2f1aa900e8e9bea65a049b95.dip0.t-ipconnect.de [IPv6:2003:ec:2f1a:a900:e8e9:bea6:5a04:9b95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B5AAB1EC026D;
        Thu, 14 Jan 2021 19:40:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610649621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F2/CB4ABPbBP1pW0IHsNbg4sOTm1wt6DrSPmMYPRbnU=;
        b=n0DECMJBD+hRD5D+iJkaXzpobjvEpELqD0R/Fz0hEUw8JJh9zA2jL0CgOSJX/ORDYzl91p
        9AXA5RNhHacP4LLsbnYYjiwDc+fVe8HmSOJiaAztxeCiAfb3JsfcsV5PvAdpc0ztuyQb+C
        IxHDnh6e6d/SVResNuJ0O4cx+Eo3tQg=
Date:   Thu, 14 Jan 2021 19:40:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     kernel test robot <lkp@intel.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 08/15] x86: add new features for paravirt patching
Message-ID: <20210114184021.GG12284@zn.tnic>
References: <20201217093133.1507-9-jgross@suse.com>
 <202012172021.VSDLPK5D-lkp@intel.com>
 <20210114183024.GF12284@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114183024.GF12284@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 07:30:24PM +0100, Borislav Petkov wrote:
> On Thu, Dec 17, 2020 at 09:12:57PM +0800, kernel test robot wrote:
> >    ld: arch/x86/kernel/alternative.o: in function `paravirt_set_cap':
> > >> arch/x86/kernel/alternative.c:605: undefined reference to `pv_is_native_spin_unlock'
> > >> ld: arch/x86/kernel/alternative.c:608: undefined reference to `pv_is_native_vcpu_is_preempted'
> 
> Looks like alternative.c needs #include <asm/paravirt.h>.

Nah, that needs paravirt_set_cap() to be inside
CONFIG_PARAVIRT_SPINLOCKS-enabled ifdeffery.

Jürgen, why don't you move it to arch/x86/kernel/paravirt.c? That
should keep the ifdeffery low.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
