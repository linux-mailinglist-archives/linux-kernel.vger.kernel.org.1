Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048002792CC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgIYU6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgIYU57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:57:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8192CC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:57:59 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b3a00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0CA0A1EC026D;
        Fri, 25 Sep 2020 22:57:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601067478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LCnPz9m8MV/XyMH/TOF98vhD++WJdzg7Jyu26mIxFvQ=;
        b=K2KOs+TtWN8d4YzCwVflQDKJyl85ZR0I8fEHqHg2jn0VXfsK4ZZeTOaGKYuRcYj0ULaYH2
        i95EWM8Jcox95gbEb1XJ5P9wsPbE5UDYD13EAoTU48/GR837awWPGk+oIYkXq+Xf1P1Y/U
        E1ev1L6vfJ0x4jcFGJzRSZwdj+bGFwU=
Date:   Fri, 25 Sep 2020 22:57:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Feng Tang <feng.tang@intel.com>,
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
Message-ID: <20200925205751.GR16872@zn.tnic>
References: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
 <20200922201024.GS22660@zn.tnic>
 <20200922221523.GA1185357@rani.riverdale.lan>
 <20200923024529.GA15894@shbuild999.sh.intel.com>
 <20200925171631.GL16872@zn.tnic>
 <20200925194804.GA757220@rani.riverdale.lan>
 <20200925201707.GQ16872@zn.tnic>
 <20200925204047.GA769219@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925204047.GA769219@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 04:40:47PM -0400, Arvind Sankar wrote:
> They're not the same, but aren't there going to be quite a few common
> flags between the definitions in cpufeatures.h and the definitions in
> cpuid.txt? If they're both living in the kernel repo, it would be nice
> for them to not duplicate what's common between them, no?

You will generate cpuid.txt exactly once and shortly after cpufeatures.h
will already be ancient in comparison to it. So there would be no point
to share.

Also, have a look at which leafs are in cpufeatures.h, which of those
leafs are synthetic and how many leafs are in an actual CPUID hw
implementation.

Then, some of the bits in cpufeatures.h are not present while the leafs
in CPUID have them for the above reason.

And so on...

> This shouldn't affect how easy it is to update, I think. The kernel
> build will use whatever version is in the source tree, the tool will use
> whatever version is installed under /usr/share, so the latter can be
> updated without needing a new kernel.

And I believe that keeping those apart because there are differences,
would cause more confusion vs having the two things completely separate.

So I actually think that sharing between the two is not even worth the
effort.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
