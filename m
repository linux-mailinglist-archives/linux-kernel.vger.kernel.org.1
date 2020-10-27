Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1471E29C4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1823987AbgJ0SBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:01:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36162 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1823165AbgJ0R6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:58:00 -0400
Received: from zn.tnic (p200300ec2f0dae00bf53706700052072.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:ae00:bf53:7067:5:2072])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D73B1EC0212;
        Tue, 27 Oct 2020 18:57:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603821478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PcBBjvmUlrdDxr38KUZIhpPwMouOj8fg4OjrMu6hCbE=;
        b=EBE4rOX8RfY2fsRpCaNe3G86XjUmuTltaO2O/n2A64BIkpbqZ1bCEFwm2TjCf95Av0bHk9
        kuw8ydvgA2RMpHUsk3R4DNvN1UJl1VKKhgElrkWmoeSP909eBGm26u1CaPXqMcCZPrlpug
        R0rqsETg5TjhqSnqd+lvPK2YC/PIskU=
Date:   Tue, 27 Oct 2020 18:57:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 2/2] x86/resctrl: Correct MBM total and local values
Message-ID: <20201027175748.GJ15580@zn.tnic>
References: <20201014004927.1839452-1-fenghua.yu@intel.com>
 <20201014004927.1839452-3-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201014004927.1839452-3-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 12:49:27AM +0000, Fenghua Yu wrote:
> +static const struct mbm_correction_factor_table {
> +	u32 rmidthreshold;
> +	u64 cf;
> +} mbm_cf_table[] = {

That thing wants to be __initdata, AFAICT, since the only function
touching it is __init.

Made it so.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
