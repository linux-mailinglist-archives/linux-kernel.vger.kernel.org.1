Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADAA2850F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgJFRjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgJFRjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:39:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579DEC061755;
        Tue,  6 Oct 2020 10:39:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h6so9190563lfj.3;
        Tue, 06 Oct 2020 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0vKD9Sbj58wACeGPII4liFAA6/tmwznEhQFCDbkHo9A=;
        b=NFs+iHmKzq9vioBKRNctR9OioB5WO4Wm5thR/1mflIxivxNRna5qG5YOEvXLWzDIMp
         l/3FmvqhsV5iiQSNqL6Y2h8Ksi+RsP1Cqes+nJ549YeBpgjr5UYUpkjB81yb+v0zjS7I
         dFUw68YZ2EB2n1C5rGoklJLG0nKfw8Uxu8X0UI/g2f+bei7yYSspze+lMdOxpfMMBVK8
         b80n6UhuuxCM2X7qxCWhYrn+jI2zAvFAPHTR2uwBNSvEKD+8BkRiVb+95SUFOQGnX1ha
         JMH5Ayc28/TvpLnoLt/MN3i90bzQAaS2sU8ty4kGoW9osTlYxF5XC6APWv/+5Hq952FY
         c/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0vKD9Sbj58wACeGPII4liFAA6/tmwznEhQFCDbkHo9A=;
        b=eILBBOkpgqrxo8JHAkFIki98gahszoXBWkFHjTJ9a6odavObzyJp13wuHf1elziIoN
         Sd3UD80sJkL6aCLbtenAbCWDwdFhaGWGVr0wIO28uFi4ISbi8TonM9D2fSaNPsC8cZ4g
         3UN9ddoAG4n6MLI5/oYdAR9kvREixNq15HO9w1JdxaUPJKv9Gm1JNUMbCmPto2Zr0B82
         9+ECi7HSicwy2Dm3rWTYYnbendVsJSGHmEpATPzCORfmQpkDuLKFreoZquNyyx7gB6S3
         U+181HtYni4/mIjr5rHLgQiiKIu0xpb4cj7GPYXRDdr7LmoONrjZ2sDu2nFjOZ9pRoVN
         8K6w==
X-Gm-Message-State: AOAM531H3rjJUMhfx6kQFaLMC+HqliQHviewxH5cjUHSRzDkvuMR4PIr
        d0qnZvzVsElxWfnG8GE+69mo1exfXBJpc1cNk+R3CF7AWKEhrg==
X-Google-Smtp-Source: ABdhPJwUydoWqPWzw/Qv8RFKP45TKqjWloh+Y/W1b4tnNIfupe1NGjFRs72Mj+5J3ZfaiS0N3I/2LcvqNeAVe+uLGuM=
X-Received: by 2002:ac2:57c7:: with SMTP id k7mr938354lfo.20.1602005955584;
 Tue, 06 Oct 2020 10:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
 <20200902165713.GG56237@roeck-us.net> <CADiBU3_iHk4aoM8o6GcaTmWDZT4ymvb0Ff-XeLLZ0C9dhCnLZQ@mail.gmail.com>
 <fd2a33fc-2383-66cb-0fd7-d5aa0cc9111f@roeck-us.net> <CADiBU3_vYAmHDCONrExzyM+1CTfqJx_eS1hYG8aHkNWFzTcwfg@mail.gmail.com>
 <63c7f5e4-eff2-1420-30a5-a0b98a7815e0@roeck-us.net> <CADiBU3-83rVLqhVAqqSGc0qQ66PHsGVVcp_m3sm_4ZS5A+GXKQ@mail.gmail.com>
 <CADiBU3_c5O-yUac-ytp5WoQQ12edkU+4wn+WNBOVGRGM15NBJA@mail.gmail.com>
 <20201002133145.GA3384841@kroah.com> <c2d689eb-5538-6af2-614f-766521100273@roeck-us.net>
 <20201005110808.GA298743@kroah.com> <88586992-650f-a4a1-2fa0-8cef313380fb@roeck-us.net>
 <CADiBU38wk825SqtFRAiYqqV47Wwi43AuWKut19qeTbGBZFqPow@mail.gmail.com> <CAKgpwJWwyvUyVj+jQ0y2i_eK1XEN2g3NvR0zgrRLfcmtgn8DDg@mail.gmail.com>
In-Reply-To: <CAKgpwJWwyvUyVj+jQ0y2i_eK1XEN2g3NvR0zgrRLfcmtgn8DDg@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 7 Oct 2020 01:39:04 +0800
Message-ID: <CADiBU3_TADpGmV7-BXJd3YaPNiv8Eg8zmKUD_OoB9CG1MT12mg@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_reset_count
 not reset issue
To:     Jun Li <lijun.kernel@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>, Li Jun <jun.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jun Li <lijun.kernel@gmail.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> ChiYuan Huang <u0084500@gmail.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8812:38=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B410=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:30=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > > On 10/5/20 4:08 AM, Greg KH wrote:
> > > [ ... ]
> > > >>> What ever happened with this patch, is there still disagreement?
> > > >>>
> > > >>
> > > >> Yes, there is. I wouldn't have added the conditional without reaso=
n,
> > > >> and I am concerned that removing it entirely will open another pro=
blem.
> > > >> Feel free to apply, though - I can't prove that my concern is vali=
d,
> > > >> and after all we'll get reports from the field later if it is.
> > > >
> > > > Ok, can I get an ack so I know who to come back to in the future if
> > > > there are issues?  :)
> > > >
> > >
> > > Not from me, for the reasons I stated. I would be ok with something l=
ike:
> > >
> > > -       if (tcpm_port_is_disconnected(port))
> > > +       if (tcpm_port_is_disconnected(port) ||
> > > +           (tcpm_cc_is_open(port->cc1) && tcpm_cc_is_open(port->cc2)=
))
> > >
> > > to narrow down the condition.
> >
> > I have tried the above comment and It doesn't work.
> > How about to change the judgement like as below
> >
> > -       if (tcpm_port_is_disconnected(port))
> > +       if (tcpm_port_is_disconnected(port) || !port->vbus_present)
> >
> > The hard_reset_count not reset issue is following by the below order
> > 1. VBUS off ( at the same time, cc is still detected as attached)
> > port->attached become false and cc is not open
> > 2. After that, cc detached.
> > due to port->attached is false, tcpm_detach() directly return.
>
> If tcpm_detach() return directly, then how your patch can reset
> hard_reset_count?
>
Yes, it can. We know vbus_present change from true to false and cc
detach both trigger tcpm_detach.
My change is whenever tcpm_detach to be called, hard_reset_count will
be reset to zero.

> I am seeing the same issue on my platform, the proposed change:
> -       if (tcpm_port_is_disconnected(port))
> -               port->hard_reset_count =3D 0;
> +       port->hard_reset_count =3D 0;
> can't resolve it on my platform.
>
I'm not sure what's your condition. Could you directly paste the tcpm
log for the check?
> How about reset hard_reset_count in SNK_READY?
> @@ -3325,6 +3329,7 @@ static void run_state_machine(struct tcpm_port *por=
t)
>         case SNK_READY:
>                 port->try_snk_count =3D 0;
>                 port->update_sink_caps =3D false;
> +               port->hard_reset_count =3D 0;
>                 if (port->explicit_contract) {
>                         typec_set_pwr_opmode(port->typec_port,
>                                              TYPEC_PWR_MODE_PD);
>
> can this resolve your problem?
I'm not sure. It need to have a try, then I can answer you.
But from USBPD spec, the hard_reset_count need to reset zero only when
1. At src state, pe_src_send_cap and receive GoodCRC
2. At snk state, pe_snk_evaluate_cap need to reset hard_reset_count
>
> Li Jun
> >
> > And that's why hard_reset_count is not reset to 0.
> > >
> > > Guenter
