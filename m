Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EE6278F73
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgIYRQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYRQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:16:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8D9C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 10:16:39 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b3a00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C40B1EC0284;
        Fri, 25 Sep 2020 19:16:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601054198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tIdBivz8rcuMFe6e/96xlA8vrhil0LScKdn73yjlhIQ=;
        b=EW5dXmAQGeqy1/wQOkkHMggJ2LbhaCz8jjhMGbIwrCwNLeYZ/a6egoV4AA5fNLm9cVv1oO
        7T8smdJn6iRZyFHMZ4W5Fet8vu5i0iXwCTYlD36KiYvGaSJqyTpNCkb7DI4XGS1Oq7g/c3
        bmr0qa/jPJGpXqeiX5ksaog7FTBmFUc=
Date:   Fri, 25 Sep 2020 19:16:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20200925171631.GL16872@zn.tnic>
References: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
 <20200922201024.GS22660@zn.tnic>
 <20200922221523.GA1185357@rani.riverdale.lan>
 <20200923024529.GA15894@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200923024529.GA15894@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:45:29AM +0800, Feng Tang wrote:
> > Rather than a tool, would additional file(s) in, say,
> > /sys/devices/system/cpu/cpu<n> be nicer? They could show the raw CPUID
> > features, one file per leaf or sub-leaf, maybe even along with whether
> > they were disabled at boot-time.
> 
> My thought is we already have in-kernel powerful /proc/cpuinfo, while 
> a user space tool could be more flexible for text parsing/layout, and
> show different info on user's demand/options.

The important thing here is that a separate tool would be decoupled from
the kernel and thus will be independent from it, i.e., you can get the
tool and run it without having to install a new kernel.

And with the CPUID leafs specified in a text file, you won't even need
to update the tool even - just cpuid.txt. It can't get any better than
that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
