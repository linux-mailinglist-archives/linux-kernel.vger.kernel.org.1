Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8DB2EF82C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbhAHTdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbhAHTdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:33:45 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADCAC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 11:33:05 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r7so10053139wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 11:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pHPN41hHFv+ZbGuu8jjfM3Gxxyuq3FlEqjuJ/4MteE=;
        b=ayiqZhbIA7heOAmgfEv425GUDNo65pWHCEe/o441GbMZbV/HY57wDg0PvV6K74fOzs
         tRu4fsD3S5MhMhKZOiijzPuus4y26RhXMqsVGS5cIhg5Il0Y99x0G7UDEy7FVv6VLF3w
         r6Z9qBNWBnkGJ0GVWhRAroGBsUY19PhZTQvmdAOjJk7w7Qp86jSJ95tdtb00XPkdqTGj
         ZLHc2HYSPFDN9REUrU7nKjVyl9AUeljJzvFNcICJR0mG2AG/eQB5JY1tYQKu3u2Zqcw2
         nwp9uZFO7BBj1Z9TDnF4ax/jx0sQdyZY0Jes8jGoq20zYT2huT3aSa6dqt/IsOYZBzHD
         R3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pHPN41hHFv+ZbGuu8jjfM3Gxxyuq3FlEqjuJ/4MteE=;
        b=VYKmAJjYT0p38b9saV7s4JwwZGo/33rz7byO18b3KsoJa3hOlXRKH2jBgIk+xfC86q
         urOdy0nG4eemLyHeb3/n/0b/sLkgFNBVlxBAhyXp/4OnGifYNWkYTvghiCqWZZbGtwwk
         sovQ3pFKpbRyZo/+zHfIHcdW+DuBBhQ/6+jDl90hsOnFF/JENmGKBOT5sb5coDYt7mkF
         ijcE8iVtNUDJ9E5Ae6sxpvrfNn4A4qsy7CDn2qubmdln9TyU44O/wd1yOg1KFHqwdypv
         IyF0ueNo8QNIwy+8Nyu4crFtlunBlHCWHzAT5AKlnWtWtIxOxZbWH/O66QkKFxR1vmX3
         EW1A==
X-Gm-Message-State: AOAM533rxeokGrOUPrqP1bK6tVarXpuXnWnTNyzRgxx+HkfM8t9zUxq3
        FouRSmjX7OZBMjFOOwPxKjOs7/G37uC3ssAo0XLrZA==
X-Google-Smtp-Source: ABdhPJw62Qpge4TfG851vXPECemI+JoPQ+D59xbHLgTFzKKvHiW2PtqjoAh2ltxSc12hd6fvI8jqAfA0rlqHxkh6Ls4=
X-Received: by 2002:adf:9dc4:: with SMTP id q4mr5042095wre.367.1610134383860;
 Fri, 08 Jan 2021 11:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20210108025107.1223487-1-baekhw@google.com> <20210108172049.GF4042@zn.tnic>
In-Reply-To: <20210108172049.GF4042@zn.tnic>
From:   "Hyunwook (Wooky) Baek" <baekhw@google.com>
Date:   Fri, 8 Jan 2021 11:32:52 -0800
Message-ID: <CABMWKFDTrZPpr=y6RWahU=XSnXkhP7MPotDQrRjyFmesGn9zEw@mail.gmail.com>
Subject: Re: [PATCH] x86/sev-es: Fix SEV-ES #VC handler for string port IO
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Rientjes <rientjes@google.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borisslav,

My sincere apologies for it.
We actually tested the patch but I made a bad mistake while generating
the patch file to email.
I will send a PATCH V2 after testing the email version patch file from
the scratch.

Regards,
Wooky

On Fri, Jan 8, 2021 at 9:20 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jan 07, 2021 at 06:51:07PM -0800, Hyunwook (Wooky) Baek wrote:
> > Don't assume dest/source buffers are userspace addresses when manually
> > copying data for string I/O or MOVS MMIO, as {get,put}_user() will fail
> > if handed a kernel address and ultimately lead to a kernel panic.
> >
> > Signed-off-by: Hyunwook (Wooky) Baek <baekhw@google.com>
> > Acked-by: David Rientjes <rientjes@google.com>
> > ---
> >  arch/x86/kernel/sev-es.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> > index 0bd1a0fc587e..812494d216ba 100644
> > --- a/arch/x86/kernel/sev-es.c
> > +++ b/arch/x86/kernel/sev-es.c
> > @@ -286,6 +286,12 @@ static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
> >       u16 d2;
> >       u8  d1;
> >
> > +     /* If instruction ran in kernel mode and the I/O buffer is in kernel space */
> > +     if (!user_mode(ctxt->regs) && !access_ok(s, size)) {
>                                                 ^^^
>
> Just by looking at this patch I know you haven't tested it before sending.
>
> :-(
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
