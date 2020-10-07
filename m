Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB10B285CA1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 12:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgJGKNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 06:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgJGKNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 06:13:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA163C061755;
        Wed,  7 Oct 2020 03:13:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w11so1647628lfn.2;
        Wed, 07 Oct 2020 03:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ewd4LtfqtNkhVWU3VONTQ6vI4mvJvbco8agzVzhKr1I=;
        b=CR9rt1niMJirEHDEFDMmfALUTb+4zJ3Fh7PGyD2pS95WQJY8sLMyAJq7o4pLgoTppW
         fLkpHS9GcxDYWXlWW6MVjJ3WuwLWhjNBirt3nWrThwsuHh7xPV7ed/1uKwWgB5uoEsGb
         GS+/oPgjThXJDpUcyi6k2cnMjr892chjKRXX8BL1FS2QP4u+WPGpU4zPXVaz/0RWMTGw
         MIAcUFlPUsAKWeKnnU5lhUqJWjhEI4RIOB6Q9Qnh4OZxzt3lBrAPo9ZNEdl0YZCRtl6X
         PWzVIimp1zaWpHIQlmD/xJC0ql7y5NGl/Un63odlaLEs31Hy+vNAOLpmOHNH6UmJwCiy
         XXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ewd4LtfqtNkhVWU3VONTQ6vI4mvJvbco8agzVzhKr1I=;
        b=t3qvxlswiH3cJpx7kgIdCuuzNoJqkWvZPZFSwA3xrS8Shm7X23pN4B2T+g4mG/Gfpr
         xAZdorCmdtcJUDF9Sf5rP/uI4ASgozPApzZAetwEDB2yTSxvnIoPaakVDJyrXzOeMDBx
         rd2KwDSIpZiFhTOPYa69dj0R0EGm5QCujV6IOxXOa7O49zak7QqAMhSK9KdsKMM/IIbq
         uhrFoJUf3VAlAA2VUaAre4KPuvyNUCeVNfQ+eaoVK5kC7ma/Qvc1QmkuSNaps4DZM/GV
         9bkd95FBsvU2lPlS7O+K37fONa1emoQCLCICrk+zrJgP8Kt58NkkMQK2Tq8pyAatKK8C
         NqTg==
X-Gm-Message-State: AOAM530d5G8/NC1kOodc20Oy0rUsqWZ31/pR+KCgJ0CkfqiXTA+AO05t
        QNsnfDsEbm/h/xDyeMcXJYj+Yk1tKdL1VLpU4uw=
X-Google-Smtp-Source: ABdhPJwAWzq1TjRuq7x4STjjojfUmIeFyubZBl8F77H02l0SZYg9AVH3i43CABEyxJ27jh9ybq+Sq7/Qsj4M5jgPrPw=
X-Received: by 2002:a19:2346:: with SMTP id j67mr664264lfj.427.1602065594983;
 Wed, 07 Oct 2020 03:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
 <20200902165713.GG56237@roeck-us.net> <CADiBU3_iHk4aoM8o6GcaTmWDZT4ymvb0Ff-XeLLZ0C9dhCnLZQ@mail.gmail.com>
 <fd2a33fc-2383-66cb-0fd7-d5aa0cc9111f@roeck-us.net> <CADiBU3_vYAmHDCONrExzyM+1CTfqJx_eS1hYG8aHkNWFzTcwfg@mail.gmail.com>
 <63c7f5e4-eff2-1420-30a5-a0b98a7815e0@roeck-us.net> <CADiBU3-83rVLqhVAqqSGc0qQ66PHsGVVcp_m3sm_4ZS5A+GXKQ@mail.gmail.com>
 <CADiBU3_c5O-yUac-ytp5WoQQ12edkU+4wn+WNBOVGRGM15NBJA@mail.gmail.com>
 <20201002133145.GA3384841@kroah.com> <c2d689eb-5538-6af2-614f-766521100273@roeck-us.net>
 <20201005110808.GA298743@kroah.com> <88586992-650f-a4a1-2fa0-8cef313380fb@roeck-us.net>
 <CADiBU38wk825SqtFRAiYqqV47Wwi43AuWKut19qeTbGBZFqPow@mail.gmail.com>
 <CAKgpwJWwyvUyVj+jQ0y2i_eK1XEN2g3NvR0zgrRLfcmtgn8DDg@mail.gmail.com> <CADiBU3_TADpGmV7-BXJd3YaPNiv8Eg8zmKUD_OoB9CG1MT12mg@mail.gmail.com>
In-Reply-To: <CADiBU3_TADpGmV7-BXJd3YaPNiv8Eg8zmKUD_OoB9CG1MT12mg@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 7 Oct 2020 18:13:03 +0800
Message-ID: <CADiBU392ZL6AHf6Dns61KXFVuvwh6grfnJjXmcFE4Ma2gjK6EA@mail.gmail.com>
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

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:39=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Jun Li <lijun.kernel@gmail.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:52=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > ChiYuan Huang <u0084500@gmail.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=886=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8812:38=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B410=E6=9C=88=
5=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:30=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > >
> > > > On 10/5/20 4:08 AM, Greg KH wrote:
> > > > [ ... ]
> > > > >>> What ever happened with this patch, is there still disagreement=
?
> > > > >>>
> > > > >>
> > > > >> Yes, there is. I wouldn't have added the conditional without rea=
son,
> > > > >> and I am concerned that removing it entirely will open another p=
roblem.
> > > > >> Feel free to apply, though - I can't prove that my concern is va=
lid,
> > > > >> and after all we'll get reports from the field later if it is.
> > > > >
> > > > > Ok, can I get an ack so I know who to come back to in the future =
if
> > > > > there are issues?  :)
> > > > >
> > > >
> > > > Not from me, for the reasons I stated. I would be ok with something=
 like:
> > > >
> > > > -       if (tcpm_port_is_disconnected(port))
> > > > +       if (tcpm_port_is_disconnected(port) ||
> > > > +           (tcpm_cc_is_open(port->cc1) && tcpm_cc_is_open(port->cc=
2)))
> > > >
> > > > to narrow down the condition.
> > >
> > > I have tried the above comment and It doesn't work.
> > > How about to change the judgement like as below
> > >
> > > -       if (tcpm_port_is_disconnected(port))
> > > +       if (tcpm_port_is_disconnected(port) || !port->vbus_present)
> > >
> > > The hard_reset_count not reset issue is following by the below order
> > > 1. VBUS off ( at the same time, cc is still detected as attached)
> > > port->attached become false and cc is not open
> > > 2. After that, cc detached.
> > > due to port->attached is false, tcpm_detach() directly return.
> >
> > If tcpm_detach() return directly, then how your patch can reset
> > hard_reset_count?
> >
> Yes, it can. We know vbus_present change from true to false and cc
> detach both trigger tcpm_detach.
> My change is whenever tcpm_detach to be called, hard_reset_count will
> be reset to zero.
>
> > I am seeing the same issue on my platform, the proposed change:
> > -       if (tcpm_port_is_disconnected(port))
> > -               port->hard_reset_count =3D 0;
> > +       port->hard_reset_count =3D 0;
> > can't resolve it on my platform.
> >
> I'm not sure what's your condition. Could you directly paste the tcpm
> log for the check?
> > How about reset hard_reset_count in SNK_READY?
> > @@ -3325,6 +3329,7 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >         case SNK_READY:
> >                 port->try_snk_count =3D 0;
> >                 port->update_sink_caps =3D false;
> > +               port->hard_reset_count =3D 0;
> >                 if (port->explicit_contract) {
> >                         typec_set_pwr_opmode(port->typec_port,
> >                                              TYPEC_PWR_MODE_PD);
> >
> > can this resolve your problem?
> I'm not sure. It need to have a try, then I can answer you.
> But from USBPD spec, the hard_reset_count need to reset zero only when
> 1. At src state, pe_src_send_cap and receive GoodCRC
> 2. At snk state, pe_snk_evaluate_cap need to reset hard_reset_count
> >
> > Li Jun
> > >
> > > And that's why hard_reset_count is not reset to 0.

I tried in snk_ready to reset hard_reset_count.
At normal case, it works.
But it seems still the possible fail case like as below.
200ms -> cc debounce max time
240ms -> snk_waitcap max time
If the plugin/out period is between (200+240) and (200+ 2* 240)ms ,
and the src side plug out like as the described scenario.
From this case, hard_reset_count may still 1.
And we expect the next plugin hard_reset_count is 0. But not, actually
it never reset.
So at next plugin, only one hard_reset will be sent and reach
hard_reset_count max (2).

This case is hard to reproduce. But actually it's possible.

> > > >
> > > > Guenter
