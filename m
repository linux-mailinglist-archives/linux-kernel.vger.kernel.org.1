Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796952EB2A4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbhAESdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbhAESdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:33:41 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF87C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:33:00 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id s21so215240pfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sX+Z5cinaGEHb+Rg680GNmulVNTwsny/hFmafIxttB0=;
        b=cdYSFuaDv6z15vOKJG8UTD8B2nE6uiN1THjKL+OP7indqdfspz63FI4KPq0gb8rHmc
         7lLzJbw+dHqcZbTaBloV0uVkJVS4mYL4Hb9bmL4RtLI7PxLYzjYfHfs47THpHI+ne7eb
         sTeOsFkib02LmlglFpXuQIgDjFuBUHss+0A6ZfXJWnCc/t+X0XHvonF+npQmIJyQuwPC
         Pd9sUxUNt+dFGcJiXFU76Pn8jOmj8e6o1eV2ezmLt8EyOP3bPR2hRcUnd2URvbpvMgq1
         qa15eTZANrNsTFYb5QyRfPpkbhaDGYJ59/OXNEuqGjMTPU06wV58LFtDuSFOG+vaz1XG
         qMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sX+Z5cinaGEHb+Rg680GNmulVNTwsny/hFmafIxttB0=;
        b=oqDOIv15r/x/zow36V2cHf6JWwBCXwEcc4kPeay8Uz8+it+YjMdK2Mu+chwkz2fQOt
         Xxh4kPdjAj3sM/bfrEIW8QQEZCbvnLKJpV3/2z7WPHun4WsGfL1iSGi+RcSB95s+aojd
         yGp1wn8M08F2dOY7r3jUWhW73eImxj/xUoE6vp5NVswl2haE3rKUcXAeVZs6n5QfSOGr
         LpO3il+vfM+G09IZw5sLev5QQe8OKDvdzlBsMy7KZ7pgkG0X5JrOj5HqDAr9dSpMvOIu
         NjBKB8npyvs6kNGmvFubLVsORAAsfPKJymPFjIExvCxsMr5jua7F2DnW/D5XpZySuR6Y
         l83Q==
X-Gm-Message-State: AOAM531OLgykX9VJ/h6dlkJ7ZnX8RVOo+phzcKli5UJ09bNt8Y8M3Gxj
        hel10RIsPcA6Z2hlJ/ZwcszUGRNSc8kSvWDRCoM=
X-Google-Smtp-Source: ABdhPJwxfiYXu8hgfCeL3Zsj4doaK0V6kvYxGc2L283ZS6KyDxscXZzpU1X0DtH1fVuL5V/6Uh8Itwqa95NM5ClGV80=
X-Received: by 2002:a63:1f10:: with SMTP id f16mr584229pgf.111.1609871580342;
 Tue, 05 Jan 2021 10:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20201222145603.40192-1-jim2101024@gmail.com> <20201222145603.40192-3-jim2101024@gmail.com>
 <e37cb2fc-14a3-b658-9df7-6f67a2c4d755@gmail.com> <20210105173526.yvjh2bxnofjzmc6n@bogus>
 <CA+-6iNwnA+3kaHom3XRpTLOu_4QsHOmFiZ2M2=sA7Go-uADe1g@mail.gmail.com>
In-Reply-To: <CA+-6iNwnA+3kaHom3XRpTLOu_4QsHOmFiZ2M2=sA7Go-uADe1g@mail.gmail.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Tue, 5 Jan 2021 13:32:49 -0500
Message-ID: <CANCKTBukX33YxVh8uuashC3grRVa1oZBig+-UD90YKgVUgSS=A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional interrupt
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE Mes..." 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Sudeep Holla <sudeep.holla@arm.com>
> Date: Tue, Jan 5, 2021 at 12:35 PM
> Subject: Re: [PATCH v4 2/2] firmware: arm_scmi: Augment SMC/HVC to allow =
optional interrupt
> To: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Jim Quinlan <jim2101024@gmail.com>, Sudeep Holla <sudeep.holla@arm.co=
m>, <bcm-kernel-feedback-list@broadcom.com>, <james.quinlan@broadcom.com>, =
open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE Mes... <linux-arm-ker=
nel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
>
>
> On Tue, Dec 22, 2020 at 07:37:22PM -0800, Florian Fainelli wrote:
> >
> >
> > On 12/22/2020 6:56 AM, Jim Quinlan wrote:
> > > The SMC/HVC SCMI transport is modified to allow the completion of an =
SCMI
> > > message to be indicated by an interrupt rather than the return of the=
 smc
> > > call.  This accommodates the existing behavior of the BrcmSTB SCMI
> > > "platform" whose SW is already out in the field and cannot be changed=
.
> > >
> > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> >
> > This looks good to me, just one question below:
> >
> > [snip]
> >
> > > @@ -111,6 +145,8 @@ static int smc_send_message(struct scmi_chan_info=
 *cinfo,
> > >     shmem_tx_prepare(scmi_info->shmem, xfer);
> > >
> > >     arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &re=
s);
> > > +   if (scmi_info->irq)
> > > +           wait_for_completion(&scmi_info->tx_complete);
> >
> > Do we need this to have a preceding call to reinit_completion()? It doe=
s
> > not look like this is going to make any practical difference but there
> > are drivers doing that for correctness.
>
> Why do you think that might not cause any issue ? After first message
> is completed and ISR is executed, the completion flag remains done for
> ever.
Hi Sudeep,

I don't think that is the case;  the bottom routine,
do_wait_for_common(), decrements the x->done after a completion (which
does an increment).  Regardless, I think it is prudent to add the
reinit patch you've provided below.

BTW, one thing I could have done was incorporate the timeout value but
I thought that since this is the "fast" call we shouldn't be timing
out at all.

Thanks much,
Jim Quinlan
Broadcom STB



So practically 2nd message onwards won't block in wait_for_completion
> which means return from smc/hvc is actually completion too which is clear=
ly
> wrong or am I missing something ?
>
> Jim, please confirm either way. If you agree I can add the below snippet,
> no need to repost.
>
> Regards,
> Sudeep
>
> --
> diff --git i/drivers/firmware/arm_scmi/smc.c w/drivers/firmware/arm_scmi/=
smc.c
> index fd41d436e34b..86eac0831d3c 100644
> --- i/drivers/firmware/arm_scmi/smc.c
> +++ w/drivers/firmware/arm_scmi/smc.c
> @@ -144,6 +145,8 @@ static int smc_send_message(struct scmi_chan_info *ci=
nfo,
>
>         shmem_tx_prepare(scmi_info->shmem, xfer);
>
> +       if (scmi_info->irq)
> +               reinit_completion(&scmi_info->tx_complete);
>         arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &re=
s);
>         if (scmi_info->irq)
>                 wait_for_completion(&scmi_info->tx_complete);
>
>
> This electronic communication and the information and any files transmitt=
ed with it, or attached to it, are confidential and are intended solely for=
 the use of the individual or entity to whom it is addressed and may contai=
n information that is confidential, legally privileged, protected by privac=
y laws, or otherwise restricted from disclosure to anyone else. If you are =
not the intended recipient or the person responsible for delivering the e-m=
ail to the intended recipient, you are hereby notified that any use, copyin=
g, distributing, dissemination, forwarding, printing, or copying of this e-=
mail is strictly prohibited. If you received this e-mail in error, please r=
eturn the e-mail to the sender, delete it from your computer, and destroy a=
ny printed copy of it.
