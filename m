Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE9D28E40E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387395AbgJNQKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgJNQKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:10:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD50C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:10:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e23so109104wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xqRVELzKb5irMYxEbbCQBaCZ0+t2Ow3D9tlphRjrhI=;
        b=BireJ8H/7RcSNgCNA/FNhml69SXPspizGWl6pVoDfFlq3gkoeK8nbeBessZxcePigR
         eJ6CRF4QsgrxQzLiDVn8iogshTJ07gGz2qu/I/eSkc8PyaVU9f3Dc0K2X/t5jLCCsgZx
         Xn9JONq17zf+6EjOhqlklOpoVjka5JXc8mlvLeRpOF+HzdiNNihaCBBlcqrkgR+QP+Wp
         EE6gh8CX3V2ofG/iukW/wh4c97ImDcRsQbHYS7OctQOZSDYW1uX4zHRMPmTxffDmxMiC
         s6el30bjUHADZfxcOVHfj3XWkjNafqbgNvtJzdtzV+ZEtLkmGID4tX/eNXz9Scll8sfY
         p4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xqRVELzKb5irMYxEbbCQBaCZ0+t2Ow3D9tlphRjrhI=;
        b=P3yXhzLgewsce+r0uzxulqLtSJ6O+51bVRF56UuXJRT1eqd33HtIcJociQZWip0tu8
         RgSOsXs92+3MGOJJicUizpec3JVBMx5dOZ4wCDxTjXc5kwS0SP7GtngVGS2cAA/u/vb+
         jw9qrEI8x/xMJ6lh7kIDpinyXJ3PGSKn0pN/hb2dZL6f/5CCPzFwBKz8GQMyF2/UFyjC
         HJu+NgQF2QYCxX2VM4KZLtYAFKQzHS8FDr3V913wgYhM6GgSivb9gM/cSykwLPp7d3sg
         bsFaUo7IG8zyGjUg6eFBOIJK3I3IvCv9b4h9z5lDfvyr/mlfWjn/Cc+ZwMmsl2vDa8/z
         +hEw==
X-Gm-Message-State: AOAM531vnI93hd7EwKKviqz4UGr46twhhFVBsKP2lg5YAusJTLn3SjgT
        QHVJFws22gM5phWohVY/ZQMJJr3wTyBR42NT7lFQ6w==
X-Google-Smtp-Source: ABdhPJzy2rOSeLBCouyAVya35YY1u31e5BvfWO1mI2FlWxxCwFawnPz/2m53aMPV3mSX0iRIgdciGyGkJGI7fpdLtNk=
X-Received: by 2002:a1c:238e:: with SMTP id j136mr169706wmj.176.1602691836398;
 Wed, 14 Oct 2020 09:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <c4669d5f-11b8-3879-562c-78a791b86229@intel.com>
 <78F221DB-CB61-40DB-9C6F-6C86D0F1BCDF@amacapital.net> <226772b9-7109-c632-2e9a-372df38b81a0@intel.com>
In-Reply-To: <226772b9-7109-c632-2e9a-372df38b81a0@intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 14 Oct 2020 09:10:24 -0700
Message-ID: <CALCETrW8u5rUsZvoo5t4YtC+4boBVcK__-srtA1+-YX06QYD1w@mail.gmail.com>
Subject: Re: [RFC PATCH 13/22] x86/fpu/xstate: Expand dynamic user state area
 on first use
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Brown, Len" <len.brown@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>, "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 11:03 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/13/20 6:11 PM, Andy Lutomirski wrote:
> > I have no problem with vmalloc(), but I do have a problem with
> > vfree() due to the IPIs that result. We need a cache or something.
>
> This sounds like the kind of thing we should just build into vmalloc()
> instead of having a bunch of callers implement their own caches.  It
> shouldn't be too much of a challenge to have vmalloc() keep a cacheline
> or two of stats about common vmalloc() sizes and keep some pools around.
>
> It's not going to be hard to implement caches to reduce vfree()-induced
> churn, but I'm having a hard time imaging that it'll have anywhere near
> the benefits that it did for stacks.  Tasks fundamentally come and go a
> *lot*, and those paths are hot.
>
> Tasks who go to the trouble to populate 8k or 64k of register state
> fundamentally *can't* come and go frequently.  We also (probably) don't
> have to worry about AMX tasks doing fork()/exec() pairs and putting
> pressure on vmalloc().  Before an app can call out to library functions
> to do the fork, they've got to save the state off themselves and likely
> get it back to the init state.  The fork() code can tell AMX is in the
> init state and decline to allocate actual space for the child.
>
> > I have to say: this mechanism is awful. Can we get away with skipping
> > the dynamic XSAVES mess entirely?  What if we instead allocate
> > however much space we need as an array of pages and have one percpu
> > contiguous region. To save, we XSAVE(S or C) just the AMX state to
> > the percpu area and then copy it.  To restore, we do the inverse.  Or
> > would this kill the modified optimization and thus be horrible?
>
> Actually, I think the modified optimization would survive such a scheme:
>
>  * copy page array into percpu area
>  * XRSTORS from percpu area, modified optimization tuple is saved
>  * run userspace
>  * XSAVES back to percpu area.  tuple matches, modified optimization
>    is still in play
>  * copy percpu area back to page array
>
> Since the XRSTORS->XSAVES pair is both done to the percpu area, the
> XSAVE tracking hardware never knows it isn't working on the "canonical"
> buffer (the page array).

I was suggesting something a little bit different.  We'd keep XMM,
YMM, ZMM, etc state stored exactly the way we do now and, for
AMX-using tasks, we would save the AMX state in an entirely separate
buffer.  This way the pain of having a variable xstate layout is
confined just to AMX tasks.

I'm okay with vmalloc() too, but I do think we need to deal with the
various corner cases like allocation failing.
