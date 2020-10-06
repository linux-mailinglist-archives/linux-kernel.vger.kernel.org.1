Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12EA28502B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgJFQwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgJFQwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:52:20 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7EAC061755;
        Tue,  6 Oct 2020 09:52:20 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id h2so1108564vso.10;
        Tue, 06 Oct 2020 09:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZlWssifEIrpKn1sg82iA+1KjgH/wynp2+hKG5BTZvIA=;
        b=E9IAdKkfATAe/vg4RskqA9uAX8qQKCkO48Xi6rXPflGgaWL4KGcBbEEuUDMrbpbEhK
         NBmIA5SJeV46HBv9ztCQyUxP0ILlwHehJxhD+Oeo+VZ8LyLnaj6WjzT0uBtMkGhPZdFj
         Wj9BdsGZmlzhHu2+Ix/PiGRZzJqgiHgTHMZTCBndlTUIcybYjHIsPJk/WJCMGUDTujRp
         X3AxVJArYB+2Tq38YfRJh9xmrcnpldlBhkWdSXB8IVGGUbxg/Sssfj52sdQddSZTGNGd
         H88gJJB+N55gC/HKNLX+svDwE8ubRtVyrypliIuB1nkDS3l2FjEN6jkq+gHfhnYmqEEH
         bubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZlWssifEIrpKn1sg82iA+1KjgH/wynp2+hKG5BTZvIA=;
        b=IGhriERpaC5quu2JlxPb5JpCDF19davPNBpgdEeWQRoL91/4e+jdouw/Ce80E2seTH
         Xi+XaOYTRg3CJCS1Gq5ALTRxi54oAx0lG3eWuftEsvzvXBidL756gI2sovozQlLdHNJj
         GmFpQHjqTZfpLWkaPuR7aVXtmP924EP349x5bmtv38lFEbfCiy6BoAB4RQcW1NV3iHEQ
         rq2xDi7ZfS4QUfN/sMvIKAdokXX4J69GC0Sfv7ghz6t+rN4T0X4MgLM35bDweJoPCidI
         CQ/qO210+AIvCphH0039ZeBOS6SoHXTc3OQPsgUMEBnQTNxV7BeuOXIrZl25IjiBc2c4
         i2zQ==
X-Gm-Message-State: AOAM533H1Xe1a6udUlMA9ARMw2OB8JLX0n3yq3raL+WuAQyDPE/3q08t
        w37NXYGMgNRQ78K0WG/4/Qig++IHIJwp4bfU0y8=
X-Google-Smtp-Source: ABdhPJz/VsnqswOHidC+qzyqtcXIsOzX8FKiVxvp8py189+Jma1GHuknJsFhS1PretFAIoBIkHbujcspGCHdJQEy5j4=
X-Received: by 2002:a67:7dcb:: with SMTP id y194mr4152434vsc.26.1602003138907;
 Tue, 06 Oct 2020 09:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
 <20200902165713.GG56237@roeck-us.net> <CADiBU3_iHk4aoM8o6GcaTmWDZT4ymvb0Ff-XeLLZ0C9dhCnLZQ@mail.gmail.com>
 <fd2a33fc-2383-66cb-0fd7-d5aa0cc9111f@roeck-us.net> <CADiBU3_vYAmHDCONrExzyM+1CTfqJx_eS1hYG8aHkNWFzTcwfg@mail.gmail.com>
 <63c7f5e4-eff2-1420-30a5-a0b98a7815e0@roeck-us.net> <CADiBU3-83rVLqhVAqqSGc0qQ66PHsGVVcp_m3sm_4ZS5A+GXKQ@mail.gmail.com>
 <CADiBU3_c5O-yUac-ytp5WoQQ12edkU+4wn+WNBOVGRGM15NBJA@mail.gmail.com>
 <20201002133145.GA3384841@kroah.com> <c2d689eb-5538-6af2-614f-766521100273@roeck-us.net>
 <20201005110808.GA298743@kroah.com> <88586992-650f-a4a1-2fa0-8cef313380fb@roeck-us.net>
 <CADiBU38wk825SqtFRAiYqqV47Wwi43AuWKut19qeTbGBZFqPow@mail.gmail.com>
In-Reply-To: <CADiBU38wk825SqtFRAiYqqV47Wwi43AuWKut19qeTbGBZFqPow@mail.gmail.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Wed, 7 Oct 2020 00:52:07 +0800
Message-ID: <CAKgpwJWwyvUyVj+jQ0y2i_eK1XEN2g3NvR0zgrRLfcmtgn8DDg@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_reset_count
 not reset issue
To:     ChiYuan Huang <u0084500@gmail.com>
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

ChiYuan Huang <u0084500@gmail.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8812:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B410=E6=9C=885=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:30=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On 10/5/20 4:08 AM, Greg KH wrote:
> > [ ... ]
> > >>> What ever happened with this patch, is there still disagreement?
> > >>>
> > >>
> > >> Yes, there is. I wouldn't have added the conditional without reason,
> > >> and I am concerned that removing it entirely will open another probl=
em.
> > >> Feel free to apply, though - I can't prove that my concern is valid,
> > >> and after all we'll get reports from the field later if it is.
> > >
> > > Ok, can I get an ack so I know who to come back to in the future if
> > > there are issues?  :)
> > >
> >
> > Not from me, for the reasons I stated. I would be ok with something lik=
e:
> >
> > -       if (tcpm_port_is_disconnected(port))
> > +       if (tcpm_port_is_disconnected(port) ||
> > +           (tcpm_cc_is_open(port->cc1) && tcpm_cc_is_open(port->cc2)))
> >
> > to narrow down the condition.
>
> I have tried the above comment and It doesn't work.
> How about to change the judgement like as below
>
> -       if (tcpm_port_is_disconnected(port))
> +       if (tcpm_port_is_disconnected(port) || !port->vbus_present)
>
> The hard_reset_count not reset issue is following by the below order
> 1. VBUS off ( at the same time, cc is still detected as attached)
> port->attached become false and cc is not open
> 2. After that, cc detached.
> due to port->attached is false, tcpm_detach() directly return.

If tcpm_detach() return directly, then how your patch can reset
hard_reset_count?

I am seeing the same issue on my platform, the proposed change:
-       if (tcpm_port_is_disconnected(port))
-               port->hard_reset_count =3D 0;
+       port->hard_reset_count =3D 0;
can't resolve it on my platform.

How about reset hard_reset_count in SNK_READY?
@@ -3325,6 +3329,7 @@ static void run_state_machine(struct tcpm_port *port)
        case SNK_READY:
                port->try_snk_count =3D 0;
                port->update_sink_caps =3D false;
+               port->hard_reset_count =3D 0;
                if (port->explicit_contract) {
                        typec_set_pwr_opmode(port->typec_port,
                                             TYPEC_PWR_MODE_PD);

can this resolve your problem?

Li Jun
>
> And that's why hard_reset_count is not reset to 0.
> >
> > Guenter
