Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979982DC163
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgLPNf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgLPNf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:35:28 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D06FC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 05:34:48 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id y15so17126631qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 05:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XoIaV6odiC5xPrOJdS4RLzvLrpDfW3a+fft5FJro9xg=;
        b=DxXnFE3iCqSEMh1hNO8NxPPdVmSf5JZ9ON4gvuOFecmy0ISZHcr0TA3hUUhll15+Hr
         qyjJkFx1tyqYMMSFkdTfxROJoTJbSnatSJokfn8MNCUkW7a0ziKFv7wJLP5oRTKqYiT0
         B0h6R7aFe6giOsjf8mNj7+MlwUE6ktjDOm+Nym9r9dk+5rZcs1h+oMxMjcXcDNWcgpi/
         ufMcGc2LT4VZqskmoKwe7Ya35i23DcaiOfnqcF5S2PlJT6+xtHxe8KnjhQcegUIyUt4u
         I/ed3WhfYAgxCEPmEGanra3A/M/3Ybwv63Gz4oP2Am/Q8u9KQ6uSJaHD2A4lhbajXIuo
         rpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XoIaV6odiC5xPrOJdS4RLzvLrpDfW3a+fft5FJro9xg=;
        b=DyfbLVys5otdjvB+Ei1ur3tuZLUbyTBM14YFVEstN7JyTlV5Q4iben3uTg3wQ/BVeL
         YZz/bW801YZ/AduOgq3VXOo8aiIRj2mRrhL+qHxAH0pTuQ23gXkD5OVo+cOu20Ypik5w
         q0j3zHzX5Q+3U7fEKUwy4NaXrKCsv9RgRnP4sGonoB0ldWnk5jZEYUwDvwRV9t7nqfNc
         9vjOf68Gey/8rEtYqfNa4/ZIOt2DaFGR25sEogmvfg2SlrdqJZs0aEUWiwI56mwkUp35
         G3BLOVw+12PuojcrbfiOP/5sLJnV11TPd9N6ZB3ze5Zgg0kXJsNpzK81vSVdtcTpg/e7
         hZZw==
X-Gm-Message-State: AOAM5338iXszkL9D39aIYhvToSHnIfnWDoajQk0IIua3QIlF8DuOGnI0
        brNuxF0+Sh49L8sH+YJ8j+512EpHusBBKiRjZl+LkA==
X-Google-Smtp-Source: ABdhPJxTf1i+g2S7FqBq0SsOXHLphV7fTi+j+xmG4Ms/sRUwdDPhJP83oC3sJlmJoeeqWn2guLVMtQ5j5CeEhfFaLs0=
X-Received: by 2002:ac8:7111:: with SMTP id z17mr42932391qto.369.1608125687568;
 Wed, 16 Dec 2020 05:34:47 -0800 (PST)
MIME-Version: 1.0
References: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org>
 <CAG_fn=VKsrYx+YOGPnZw_Q5t6Fx7B59FSUuphj7Ou+DDFKQ+8Q@mail.gmail.com>
 <77e98f0b-c9c3-9380-9a57-ff1cd4022502@codeaurora.org> <CAG_fn=WbN6unD3ASkLUcEmZvALOj=dvC0yp6CcJFkV+3mmhwxw@mail.gmail.com>
 <6cc89f7b-bf40-2fd3-96ce-2a02d7535c91@codeaurora.org> <CAG_fn=VOHag5AUwFbOj_cV+7RDAk8UnjjqEtv2xmkSDb_iTYcQ@mail.gmail.com>
 <255400db-67d5-7f42-8dcb-9a440e006b9d@codeaurora.org> <f901afa5-7c46-ceba-2ae9-6186afdd99c0@codeaurora.org>
 <CAG_fn=UjJQP_gfDm3eJTPY371QTwyDJKXBCN2gs4DvnLP2pbyQ@mail.gmail.com>
 <7f2e171f-fa44-ef96-6cc6-14e615e3e457@codeaurora.org> <CAG_fn=VihkHLx7nHRrzQRuHeL-UYRezcyGLDQMJY+d1O5AkJfA@mail.gmail.com>
 <601d4b1a-8526-f7ad-d0f3-305894682109@codeaurora.org>
In-Reply-To: <601d4b1a-8526-f7ad-d0f3-305894682109@codeaurora.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 16 Dec 2020 14:34:36 +0100
Message-ID: <CAG_fn=V8e8y1fbOaYUD5SfDSQ9+Tc3r7w6ZSoJ-ZNFJvvq-Aeg@mail.gmail.com>
Subject: Re: [PATCH v3] lib: stackdepot: Add support to configure STACK_HASH_SIZE
To:     Vijayanand Jitta <vjitta@codeaurora.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        dan.j.williams@intel.com, broonie@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, qcai@redhat.com,
        ylal@codeaurora.org, vinmenon@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > To reiterate, I think you don't need a tunable stack_hash_order
> > parameter if the only use case is to disable the stack depot.
> > Maybe it is enough to just add a boolean flag?
>
> There are multiple users of stackdepot they might still want to use
> stack depot but with a lower memory footprint instead of MAX_SIZE
> so, a configurable size might help here ?

Can you provide an example of a use case in which the user wants to
use the stack depot of a smaller size without disabling it completely,
and that size cannot be configured statically?
As far as I understand, for the page owner example you gave it's
sufficient to provide a switch that can disable the stack depot if
page_owner=3Doff.

> > Or even go further and disable the stack depot in the same place that
> > disables page owner, as the user probably doesn't want to set two
> > flags instead of one?
> >
>
> Since, page owner is not the only user of stack depot we can't take that
> decision of disabling stack depot if page owner is disabled.

Agreed, but if multiple subsystems want to use stackdepot together, it
is even harder to estimate the total memory consumption.
How likely is it that none of them will need MAX_SIZE?

> >> Minchan,
> >> This should be fine right ? Do you see any issue with disabling
> >> stack depot completely ?
> >>
> >> Thanks,
> >> Vijay
> >>
> >>>> Thanks,
> >>>> Vijay
> >>>>
> >>>>>>> Thanks,
> >>>>>>> Vijay
> >>>>>>>
> >>>>>>>>> Thanks,
> >>>>>>>>> Vijay
> >>>>>>>>>
> >>>>>>>>> --
> >>>>>>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. i=
s a
> >>>>>>>>> member of Code Aurora Forum, hosted by The Linux Foundation
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>
> >>>>>>> --
> >>>>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is =
a
> >>>>>>> member of Code Aurora Forum, hosted by The Linux Foundation
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>>> --
> >>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> >>>> member of Code Aurora Forum, hosted by The Linux Foundation
> >>>
> >>>
> >>>
> >>
> >> --
> >> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> >> member of Code Aurora Forum, hosted by The Linux Foundation
> >
> >
> >
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of Code Aurora Forum, hosted by The Linux Foundation



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
