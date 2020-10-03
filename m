Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27CC2822A8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 10:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgJCIto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 04:49:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57056 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgJCIto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 04:49:44 -0400
Received: from zn.tnic (p200300ec2f1db40057382cf78206bf6d.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:b400:5738:2cf7:8206:bf6d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C2631EC046C;
        Sat,  3 Oct 2020 10:49:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601714983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8aK0fTH6/q1KJZHJYswOgg0ec7iKPfMyHMyRu4CPSP0=;
        b=JfEMjALMNN03rvQd6UQUkkAQe/eMe6fCN3kgA//lixqMg6xlYdUH3Ga129XnjdCEukrQgd
        FzI7FnUaW4N9rcdg3BXMWecDV73bOCwIYthKbFxeRuPrMBTfVcyXZxNxttEJeTUUPsxVxW
        RPXQig2/6LHLDit+sMjy4PkWA1SRlIk=
Date:   Sat, 3 Oct 2020 10:49:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] drivers core: Introduce CPU type sysfs interface
Message-ID: <20201003084934.GA14035@zn.tnic>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 06:17:41PM -0700, Ricardo Neri wrote:
> Patch 1 of the series proposes the generic interface, with hooks
> that architectures can override to suit their needs. The three patches
> patches implement such interface for x86 (as per request from Boris,
> I pulled patch 2 from a separate submission [1]).

So I ask you to show me the whole thing, how this is supposed to be used
in a *real* use case and you're sending me a couple of patches which
report these heterogeneous or whatever they're gonna be called CPUs.

Are you telling me that all this development effort was done so that
you can report heterogeneity in sysfs? Or you just had to come up with
*something*?

Let me try again: please show me the *big* *picture* with all the code
how this is supposed to be used. In the patches I read a bunch of "may"
formulations of what is possible and what userspace could do and so on.

Not that - show me the *full* and *real* use cases which you are
enabling and which justify all that churn. Instead of leaving it all to
userspace CPUID and the kernel not caring one bit.

Does that make more sense?

> [1]. https://lkml.org/lkml/2020/10/2/1013

For supplying links, we use lore.kernel.org/r/<message-id> solely.
Please use that from now on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
