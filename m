Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011122A2276
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 00:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgKAX56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 18:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgKAX56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 18:57:58 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E515FC0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 15:57:57 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id r9so13218609ioo.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 15:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m69561C9I5KPBMi/2a3YxK4CcxSHA6iGByAsvC0vwcQ=;
        b=l0MtDQqCEdZ8dwvBhVz1R4TpTsIkw0/LTUxti8AH8UwfU5cstZsiV4WFEWGqvVBplQ
         VEw9EDcMP5RjJmdaNyKraLnhfAkQlnfB5HdXwEa100rzHhgWDfOggsnNxUWXdrH9C3D7
         v2jXS0vI3xwo32mJ8zGqw75p/FgktWOaSVZMl1CWrTNd/pkkZFTxAxPpTsa1bp4EScRM
         Hlz2NntY+o8aUbLG7ZhIMZHlew+NbAPbYxIHJIl93MPar6afXzkg6Kj0dkkP+5QS3r1g
         jwb5iu8yviZTGpYkCn7/llpWJYnvMIioHBTs8uTGcfdtKYtgfo+btzvFtZK04HiYAp9P
         QtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m69561C9I5KPBMi/2a3YxK4CcxSHA6iGByAsvC0vwcQ=;
        b=Nb19x6vhyy9sHPhT42zoD7dSoB0rbnk6VsOJUxuOIPqzABdf+2pbTIz+bQv9bJ8Y6v
         Y1Zdb0VedW92HC1CoypmMDovYvAaL7GPhj3AAoW/Bi9nOSh0SWKhQDrlQbTTAeD8nOvc
         YdQbmDRGV11OR37cIDoS1BNDsM9Xsq+yZsiFNaU+LKa8J8RwBZiC9s0TbGFFWqd+ppmB
         4Easd2CpGliCqetC093JmxsJOk+b5KkTGBl5DQXGSCOPma/xHH3aDo+4tp2bLbqBSG/+
         rWe6kPYPcJv02RhDNuS8IP7pPc/6wOCPFluCyXCmVZQHvwEZb3JJzgynQUGKjL/7Z4q3
         Tkkg==
X-Gm-Message-State: AOAM530XalKGkhqC0j2gwUirr5CpbKiu/Pb+TT4BT1KRZHsjRJe+KF1y
        B/fO9fTjhyEfxRs+ARhyz5m3UbC1aFVHk75e+8Wn3A==
X-Google-Smtp-Source: ABdhPJxDSygLgQreYZuaIDgD767q/xJw3mBYKohdhOb9r657mDHHjxA32e48JpMqTKz74/pHn4FgB0953Hk8QwNC4L4=
X-Received: by 2002:a6b:cf18:: with SMTP id o24mr8726854ioa.57.1604275076944;
 Sun, 01 Nov 2020 15:57:56 -0800 (PST)
MIME-Version: 1.0
References: <20201029065133.3027749-1-amistry@google.com> <50f3e115-f169-db02-505a-71c42bab6fb6@amd.com>
In-Reply-To: <50f3e115-f169-db02-505a-71c42bab6fb6@amd.com>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Mon, 2 Nov 2020 10:57:41 +1100
Message-ID: <CAATStaP8bQvz4yDQYzJN-3ZD3x=zGZobWr6J6oWoT_wuA87euw@mail.gmail.com>
Subject: Re: [PATCH 0/1] x86/speculation: Allow IBPB to be conditionally
 enabled on CPUs with always-on STIBP
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     x86@kernel.org, Joel Fernandes <joelaf@google.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        tglx@linutronix.de, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Nov 2020 at 01:50, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 10/29/20 1:51 AM, Anand K Mistry wrote:
> > When attempting to do some performance testing of IBPB on and AMD
> > platform, I noticed the IBPB instruction was never being issued, even
> > though it was conditionally on and various seccomp protected processes
> > were force enabling it. Turns out, on those AMD CPUs, STIBP is set to
> > always-on and this was causing an early-out on the prctl() which turns
> > off IB speculation. Here is my attempt to fix it.
> >
> > I'm hoping someone that understands this better than me can explain why
> > I'm wrong.
>
> It all looks reasonable to me (some comments in the patch to follow). The
> thing that makes this tough is the command line option of being able to
> force IBPB using the "prctl,ibpb" or "seccomp,ibpb" while STIBP is prctl
> or seccomp controlled. There's an inherent quality that is assumed that if
> STIBP is forced then IBPB must be forced and it looks like 21998a351512
> ("x86/speculation: Avoid force-disabling IBPB based on STIBP and enhanced
> IBRS.") used that. However, with the STIBP always on support, that doesn't
> hold true.

Yeah, and this is what I found confusing. With that commit, the number
of combinations
of IBPB and STIBP is 25, but only a small subset is possible. For example:
- (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT &&
spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT)
- (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT &&
spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
are the only possible combinations of STRICT.

But also, if 'spectre_v2_user=seccomp,ibpb' (or prctl,ibpb), then
spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP even though it is
logically SPECTRE_V2_USER_STRICT.

It took a bit of time to wrap my head around this, hence I'm a bit
hesitant about this change (even though I think it's right).

>
> Thanks,
> Tom
>
> >
> >
> > Anand K Mistry (1):
> >    x86/speculation: Allow IBPB to be conditionally enabled on CPUs with
> >      always-on STIBP
> >
> >   arch/x86/kernel/cpu/bugs.c | 41 +++++++++++++++++++++-----------------
> >   1 file changed, 23 insertions(+), 18 deletions(-)
> >
