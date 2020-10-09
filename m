Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CD0288DBB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389604AbgJIQG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgJIQG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:06:28 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04111C0613D2;
        Fri,  9 Oct 2020 09:06:27 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r127so11208209lff.12;
        Fri, 09 Oct 2020 09:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hVM3wtpHG/QwknzCZDjPbZZwN5F8vjj/ZrYHWh9NZ7g=;
        b=RGwkmFzpAa0LIDU2sfh/kpdO8Ob+aaYCKuip5WJdj2QHrvE3saKd97qgpp+Hr80zIp
         aSJN4aeRp80n9lH7FPHxjaY3eOVDZUYyhAM3M74QgiBBU2nXvfBoVgAjsWIE8Tfv9lhh
         lGnyFgXlhAkOL7ZMBTeVNLDKNeptoifLMhFoLTCfSz5ApxWKk1HFXCk+yiLwiOtd14P/
         6evWyAsxIlfwsJR7cITVLgQb8d1q7BuX4A3lwcRBgWATA3/7Qb4QxnTXIbHZxDxvMoqI
         KxvvFeZuUEVzjDWsLcVbfqY3MOElL3Rp7cWX+YafA9XgcJMExgHKaSIYdfy6hTc69OQK
         EUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hVM3wtpHG/QwknzCZDjPbZZwN5F8vjj/ZrYHWh9NZ7g=;
        b=JGAZg/FaVfZS7/xLNecX3nqAyDnha6Zv2+7/LHGr0UisZxIXtaSrpCWyhpJ425Vy+F
         dbCHH+DOFTPITCahdfs3HZfjBwjzKkH7UbYPBemEIsf1LguPlZ1beCUfjsqzVvLeU1/D
         D1FhYDf0Uv3u83DmPjMFzE/H9kOk76Q3Jeqcv/xRegb/c/pFZuPawkbYpPesvmvxmKBi
         qlaiQ5kCRXA6OBAtelinvpxaAeaSa3arXgRZscPKc8zvTV6qD1nJPWIFLrSnyWTIlw/M
         b6+eJ0ym6tESKsE9lghfDN++XEzgGzvh/WBfpYo8JlHD6xMrikm5ANL3/txDVjsk3at+
         av2g==
X-Gm-Message-State: AOAM53290vJG1b4Cs7eZIYvHRLLCyB1SMmaNT/3xlw6vTUn5naSJQFug
        Injs5KYSC2T0EyeNWy4QeOk8uqY6gZuNNxNc5Lg=
X-Google-Smtp-Source: ABdhPJzS/RTF66VORQsC5HkYJjNUswX0Xrsu3VrHvwmmlzhy+F9N8feTY4i+IP9TTtVNQj74Mu0nO46k0vqCQ8KwIS8=
X-Received: by 2002:a19:2346:: with SMTP id j67mr4213461lfj.427.1602259585224;
 Fri, 09 Oct 2020 09:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
 <20200902165713.GG56237@roeck-us.net> <CADiBU3_iHk4aoM8o6GcaTmWDZT4ymvb0Ff-XeLLZ0C9dhCnLZQ@mail.gmail.com>
 <fd2a33fc-2383-66cb-0fd7-d5aa0cc9111f@roeck-us.net> <CADiBU3_vYAmHDCONrExzyM+1CTfqJx_eS1hYG8aHkNWFzTcwfg@mail.gmail.com>
 <63c7f5e4-eff2-1420-30a5-a0b98a7815e0@roeck-us.net> <CADiBU3-83rVLqhVAqqSGc0qQ66PHsGVVcp_m3sm_4ZS5A+GXKQ@mail.gmail.com>
 <CADiBU3_c5O-yUac-ytp5WoQQ12edkU+4wn+WNBOVGRGM15NBJA@mail.gmail.com>
 <20201002133145.GA3384841@kroah.com> <c2d689eb-5538-6af2-614f-766521100273@roeck-us.net>
 <20201005110808.GA298743@kroah.com> <88586992-650f-a4a1-2fa0-8cef313380fb@roeck-us.net>
 <CADiBU38wk825SqtFRAiYqqV47Wwi43AuWKut19qeTbGBZFqPow@mail.gmail.com>
 <CAKgpwJWwyvUyVj+jQ0y2i_eK1XEN2g3NvR0zgrRLfcmtgn8DDg@mail.gmail.com>
 <CADiBU3_TADpGmV7-BXJd3YaPNiv8Eg8zmKUD_OoB9CG1MT12mg@mail.gmail.com>
 <CADiBU392ZL6AHf6Dns61KXFVuvwh6grfnJjXmcFE4Ma2gjK6EA@mail.gmail.com> <VE1PR04MB6528CF55BE68A8DCF4B7904689080@VE1PR04MB6528.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB6528CF55BE68A8DCF4B7904689080@VE1PR04MB6528.eurprd04.prod.outlook.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Sat, 10 Oct 2020 00:06:13 +0800
Message-ID: <CADiBU38-jX=4sbQ9aFoA=Xr6S7cFbfQy8tpdohoZdpaY-AK-Vw@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_reset_count
 not reset issue
To:     Jun Li <jun.li@nxp.com>
Cc:     Jun Li <lijun.kernel@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jun Li <jun.li@nxp.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=889=E6=97=A5 =E9=80=
=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> > -----Original Message-----
> > From: ChiYuan Huang <u0084500@gmail.com>
> > Sent: Wednesday, October 7, 2020 6:13 PM
> > To: Jun Li <lijun.kernel@gmail.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>; Greg KH
> > <gregkh@linuxfoundation.org>; Heikki Krogerus
> > <heikki.krogerus@linux.intel.com>; Linux USB List
> > <linux-usb@vger.kernel.org>; lkml <linux-kernel@vger.kernel.org>;
> > cy_huang <cy_huang@richtek.com>; Jun Li <jun.li@nxp.com>
> > Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_rese=
t_count
> > not reset issue
> >
> > ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:39=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Jun Li <lijun.kernel@gmail.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:52=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > >
> > > > ChiYuan Huang <u0084500@gmail.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=
=886=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8812:38=E5=86=99
> > =E9=81=93=EF=BC=9A
> > > > >
> > > > > Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B410=E6=
=9C=885=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:30
> > =E5=AF=AB=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > On 10/5/20 4:08 AM, Greg KH wrote:
> > > > > > [ ... ]
> > > > > > >>> What ever happened with this patch, is there still disagree=
ment?
> > > > > > >>>
> > > > > > >>
> > > > > > >> Yes, there is. I wouldn't have added the conditional without
> > > > > > >> reason, and I am concerned that removing it entirely will op=
en
> > another problem.
> > > > > > >> Feel free to apply, though - I can't prove that my concern i=
s
> > > > > > >> valid, and after all we'll get reports from the field later =
if
> > it is.
> > > > > > >
> > > > > > > Ok, can I get an ack so I know who to come back to in the
> > > > > > > future if there are issues?  :)
> > > > > > >
> > > > > >
> > > > > > Not from me, for the reasons I stated. I would be ok with somet=
hing
> > like:
> > > > > >
> > > > > > -       if (tcpm_port_is_disconnected(port))
> > > > > > +       if (tcpm_port_is_disconnected(port) ||
> > > > > > +           (tcpm_cc_is_open(port->cc1) &&
> > > > > > + tcpm_cc_is_open(port->cc2)))
> > > > > >
> > > > > > to narrow down the condition.
> > > > >
> > > > > I have tried the above comment and It doesn't work.
> > > > > How about to change the judgement like as below
> > > > >
> > > > > -       if (tcpm_port_is_disconnected(port))
> > > > > +       if (tcpm_port_is_disconnected(port) ||
> > > > > + !port->vbus_present)
> > > > >
> > > > > The hard_reset_count not reset issue is following by the below
> > > > > order 1. VBUS off ( at the same time, cc is still detected as
> > > > > attached)
> > > > > port->attached become false and cc is not open
> > > > > 2. After that, cc detached.
> > > > > due to port->attached is false, tcpm_detach() directly return.
> > > >
> > > > If tcpm_detach() return directly, then how your patch can reset
> > > > hard_reset_count?
> > > >
> > > Yes, it can. We know vbus_present change from true to false and cc
> > > detach both trigger tcpm_detach.
> > > My change is whenever tcpm_detach to be called, hard_reset_count will
> > > be reset to zero.
> > >
> > > > I am seeing the same issue on my platform, the proposed change:
> > > > -       if (tcpm_port_is_disconnected(port))
> > > > -               port->hard_reset_count =3D 0;
> > > > +       port->hard_reset_count =3D 0;
> > > > can't resolve it on my platform.
> > > >
> > > I'm not sure what's your condition. Could you directly paste the tcpm
> > > log for the check?
> > > > How about reset hard_reset_count in SNK_READY?
> > > > @@ -3325,6 +3329,7 @@ static void run_state_machine(struct tcpm_por=
t
> > *port)
> > > >         case SNK_READY:
> > > >                 port->try_snk_count =3D 0;
> > > >                 port->update_sink_caps =3D false;
> > > > +               port->hard_reset_count =3D 0;
> > > >                 if (port->explicit_contract) {
> > > >                         typec_set_pwr_opmode(port->typec_port,
> > > >                                              TYPEC_PWR_MODE_PD);
> > > >
> > > > can this resolve your problem?
> > > I'm not sure. It need to have a try, then I can answer you.
> > > But from USBPD spec, the hard_reset_count need to reset zero only whe=
n
> > > 1. At src state, pe_src_send_cap and receive GoodCRC 2. At snk state,
> > > pe_snk_evaluate_cap need to reset hard_reset_count
>
> 3.
> 8.3.3.3.8 PE_SNK_Hard_Reset state
> "Note: The HardResetCounter is reset on a power cycle or Detach."
>
> > > >
> > > > Li Jun
> > > > >
> > > > > And that's why hard_reset_count is not reset to 0.
> >
> > I tried in snk_ready to reset hard_reset_count.
> > At normal case, it works.
> > But it seems still the possible fail case like as below.
> > 200ms -> cc debounce max time
> > 240ms -> snk_waitcap max time
> > If the plugin/out period is between (200+240) and (200+ 2* 240)ms , and=
 the
> > src side plug out like as the described scenario.
> > From this case, hard_reset_count may still 1.
> > And we expect the next plugin hard_reset_count is 0. But not, actually =
it
> > never reset.
> > So at next plugin, only one hard_reset will be sent and reach hard_rese=
t_count
> > max (2).
> >
> > This case is hard to reproduce. But actually it's possible.
>
> Make sense.
>
> Then I propose doing this at SNK_UNATTACHED
> @@ -3156,6 +3156,7 @@ static void run_state_machine(struct tcpm_port *por=
t)
>                 if (!port->non_pd_role_swap)
>                         tcpm_swap_complete(port, -ENOTCONN);
>                 tcpm_pps_complete(port, -ENOTCONN);
> +               port->hard_reset_count =3D 0;
>                 tcpm_snk_detach(port);
>                 if (tcpm_start_toggling(port, TYPEC_CC_RD)) {
>                         tcpm_set_state(port, TOGGLING, 0);
> Li Jun

For the current power role is snk, I think it may work.
How about the src role? src role only reset the hard_reset_count in
tcpm_detach and src_ready state?

I check the flow that  you mentioned in the previous mail. It's really
a special case from any state to port_reset.
If the case is considered, how about to reset  the hard_reset_count
and don't care the port is attached or not in tcpm_detach function
like as below.

@@ -2789,6 +2789,8 @@ static void tcpm_reset_port(struct tcpm_port *port)

 static void tcpm_detach(struct tcpm_port *port)
 {
+       port->hard_reset_count =3D 0;
+
        if (!port->attached)
                return;

@@ -2797,9 +2799,6 @@ static void tcpm_detach(struct tcpm_port *port)
                port->tcpc->set_bist_data(port->tcpc, false);
        }

-       if (tcpm_port_is_disconnected(port))
-               port->hard_reset_count =3D 0;
-
        tcpm_reset_port(port);
 }

Like I mentioned before, whatever the condition is, hard_reset_count
must be reset to zero during tcpm_detach.

But refer to Guenter's mail,  he prefer to narrow down the condition
to reset this counter.

I think the original thought is important why to put this line there.

Hi, Guenter:
   From the discussion, we really need to know why you put the reset
line below port attached is false and also make some judgement.
I think there may be ome condition that we don't considered.

>
> >
> > > > > >
> > > > > > Guenter
