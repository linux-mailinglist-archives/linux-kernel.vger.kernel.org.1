Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C5A281D4D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgJBVDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:03:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44984 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBVDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:03:16 -0400
Received: from zn.tnic (p200300ec2f0d6300a6f76f26514807a6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6300:a6f7:6f26:5148:7a6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AAA451EC04D6;
        Fri,  2 Oct 2020 23:03:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601672595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PWMJw2C0QQWgVlcW5dCD9Vqx62TxOjJmcHwWTTsp5hk=;
        b=Su7hXESJVNHaabqV6Xn/KSatT8CNAArOFoJCvPsdEbXi+DXvYjhPBDfOxUbtaH68LVpjMH
        Qn8GRviX4da2wSIPQUL5JY0c36qY8SD6SJLm2oYcl+rSHaPjEQ9ZdBiY+7ih1drnqzlUI5
        GqA5kVrRpiBA1oh0g+QK3jbGOw36KKo=
Date:   Fri, 2 Oct 2020 23:03:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/3] x86/cpu: Describe hybrid CPUs in cpuinfo_x86
Message-ID: <20201002210306.GF17436@zn.tnic>
References: <20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com>
 <20201002201931.2826-3-ricardo.neri-calderon@linux.intel.com>
 <20201002203452.GE17436@zn.tnic>
 <20201002210231.GA3222@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201002210231.GA3222@ranerica-svr.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 02:02:31PM -0700, Ricardo Neri wrote:
> What about patches 1 and 3? Should I resubmit the series with only
> those?

Why would you need to resubmit? They're good to go as is, AFAICT.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
