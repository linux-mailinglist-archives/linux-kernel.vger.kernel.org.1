Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0742928AE3C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgJLGXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgJLGXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:23:01 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAF9C0613CE;
        Sun, 11 Oct 2020 23:23:00 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a5so15756352ljj.11;
        Sun, 11 Oct 2020 23:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wWhpfxqjmysru3xbxoDe4/3rp+u5Cg8Cjv0ZsOdWs1o=;
        b=OWRHslKHQxZBTrPYojNmKiSGkVo7IXTbizzB2CHyxk8u4P+jcp3MHzFAiAXMaUTiGR
         xmMTlHIF9IYa+Iz/4x9QuUw27hm1U8ZZ65brF4tnm7tLx4j1m31wpDkMKcvlpW8+Cs9Y
         9iBx82VG6UDLCyiga0ehxo2TDvJx3QIpr+a/RXDDCAizVrcAkIJdJY4SonkZ6UbDGqDh
         F6AH48nDZKa2QB0QeLAf0X3vZO880NWD5iL96V/vCYuyzjBkiOywnvIBbOsF4ms2HFip
         glIyvKOntNqPp9Y/kMcJOJhPGY00TN5xKofhApNFwj5OjFFeU9vN3OEgtMlfw2O5NQQ4
         DIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wWhpfxqjmysru3xbxoDe4/3rp+u5Cg8Cjv0ZsOdWs1o=;
        b=X+2c8Jpib6gjylB4iCHMdXp37/zVHRnh83FzqkQU95YeY+KXXNHpRZXNLs224JyB0A
         dZyPEVDQULa0iQ+ZrnroDlh7L6+TgM7Sr1CYjF+p2mF6fJQ5efvvdox8Ta9+ppqpvkHc
         3HZiUzxK+BTbjmG1ldcdM9zlZijrgqZgfyhJnUm2oGf/dfCuhxlM8EzwKR3FdQavyEt4
         8XgQYJBT25xgNE2nwUElDds/FkH7AbSXY40wQlldFFWdC4Teyxx3Z+4XUcUVNqw/OtKg
         kipvavyMNkUHCGn7kpCqMrPkMRW5NYlJ2CPVv8y0yaV/lwWFHYsqrMI2H+XyYBRrPfjj
         Wffw==
X-Gm-Message-State: AOAM531grYBl18AJohbt6OMdW7J6o6xLOduPTDBAgegqJ3/ZlDCSW4Do
        7Du0OUCvY+GssDp0Wvs9L70rNcvVofYZZAUX5W0=
X-Google-Smtp-Source: ABdhPJx/st3LPx/T8zID/rFFzf+RvGBK2uL95H3rdPCbECz3NpkN07mLzIsr+XswOOyv3rRwfaUHUghQhwFw5gnpoc8=
X-Received: by 2002:a2e:8e96:: with SMTP id z22mr9052243ljk.154.1602483778732;
 Sun, 11 Oct 2020 23:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
 <63c7f5e4-eff2-1420-30a5-a0b98a7815e0@roeck-us.net> <CADiBU3-83rVLqhVAqqSGc0qQ66PHsGVVcp_m3sm_4ZS5A+GXKQ@mail.gmail.com>
 <CADiBU3_c5O-yUac-ytp5WoQQ12edkU+4wn+WNBOVGRGM15NBJA@mail.gmail.com>
 <20201002133145.GA3384841@kroah.com> <c2d689eb-5538-6af2-614f-766521100273@roeck-us.net>
 <20201005110808.GA298743@kroah.com> <88586992-650f-a4a1-2fa0-8cef313380fb@roeck-us.net>
 <CADiBU38wk825SqtFRAiYqqV47Wwi43AuWKut19qeTbGBZFqPow@mail.gmail.com>
 <CAKgpwJWwyvUyVj+jQ0y2i_eK1XEN2g3NvR0zgrRLfcmtgn8DDg@mail.gmail.com>
 <CADiBU3_TADpGmV7-BXJd3YaPNiv8Eg8zmKUD_OoB9CG1MT12mg@mail.gmail.com>
 <CADiBU392ZL6AHf6Dns61KXFVuvwh6grfnJjXmcFE4Ma2gjK6EA@mail.gmail.com>
 <VE1PR04MB6528CF55BE68A8DCF4B7904689080@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <CADiBU38-jX=4sbQ9aFoA=Xr6S7cFbfQy8tpdohoZdpaY-AK-Vw@mail.gmail.com>
 <VE1PR04MB652891569AB48A1C90A22C6389090@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <25503f4e-58d1-8c11-9e5e-ea570b529d09@roeck-us.net>
In-Reply-To: <25503f4e-58d1-8c11-9e5e-ea570b529d09@roeck-us.net>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 12 Oct 2020 14:22:47 +0800
Message-ID: <CADiBU39nvJU2t6qCnW3pBfguTkQmM_iZ_MVRuHFs1dU3+XLy=g@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_reset_count
 not reset issue
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jun Li <jun.li@nxp.com>, Jun Li <lijun.kernel@gmail.com>,
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

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B410=E6=9C=8811=E6=
=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=883:31=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 10/10/20 4:21 AM, Jun Li wrote:
> >
> >
> >> -----Original Message-----
> >> From: ChiYuan Huang <u0084500@gmail.com>
> >> Sent: Saturday, October 10, 2020 12:06 AM
> >> To: Jun Li <jun.li@nxp.com>
> >> Cc: Jun Li <lijun.kernel@gmail.com>; Guenter Roeck <linux@roeck-us.net=
>;
> >> Greg KH <gregkh@linuxfoundation.org>; Heikki Krogerus
> >> <heikki.krogerus@linux.intel.com>; Linux USB List
> >> <linux-usb@vger.kernel.org>; lkml <linux-kernel@vger.kernel.org>;
> >> cy_huang <cy_huang@richtek.com>
> >> Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_res=
et_count
> >> not reset issue
> >>
> >> Jun Li <jun.li@nxp.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=889=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:12=E5=AF=AB=E9=81=93=EF=BC=9A
> >>>
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: ChiYuan Huang <u0084500@gmail.com>
> >>>> Sent: Wednesday, October 7, 2020 6:13 PM
> >>>> To: Jun Li <lijun.kernel@gmail.com>
> >>>> Cc: Guenter Roeck <linux@roeck-us.net>; Greg KH
> >>>> <gregkh@linuxfoundation.org>; Heikki Krogerus
> >>>> <heikki.krogerus@linux.intel.com>; Linux USB List
> >>>> <linux-usb@vger.kernel.org>; lkml <linux-kernel@vger.kernel.org>;
> >>>> cy_huang <cy_huang@richtek.com>; Jun Li <jun.li@nxp.com>
> >>>> Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc,
> >>>> hard_reset_count not reset issue
> >>>>
> >>>> ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=
=887=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:39=E5=AF=AB
> >> =E9=81=93=EF=BC=9A
> >>>>>
> >>>>> Jun Li <lijun.kernel@gmail.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:52=E5=AF=AB
> >> =E9=81=93=EF=BC=9A
> >>>>>>
> >>>>>> ChiYuan Huang <u0084500@gmail.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=
=886=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8812:38
> >> =E5=86=99
> >>>> =E9=81=93=EF=BC=9A
> >>>>>>>
> >>>>>>> Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B410=E6=
=9C=885=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=88
> >> 11:30
> >>>> =E5=AF=AB=E9=81=93=EF=BC=9A
> >>>>>>>>
> >>>>>>>> On 10/5/20 4:08 AM, Greg KH wrote:
> >>>>>>>> [ ... ]
> >>>>>>>>>>> What ever happened with this patch, is there still disagreeme=
nt?
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Yes, there is. I wouldn't have added the conditional
> >>>>>>>>>> without reason, and I am concerned that removing it
> >>>>>>>>>> entirely will open
> >>>> another problem.
> >>>>>>>>>> Feel free to apply, though - I can't prove that my
> >>>>>>>>>> concern is valid, and after all we'll get reports from
> >>>>>>>>>> the field later if
> >>>> it is.
> >>>>>>>>>
> >>>>>>>>> Ok, can I get an ack so I know who to come back to in the
> >>>>>>>>> future if there are issues?  :)
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Not from me, for the reasons I stated. I would be ok with
> >>>>>>>> something
> >>>> like:
> >>>>>>>>
> >>>>>>>> -       if (tcpm_port_is_disconnected(port))
> >>>>>>>> +       if (tcpm_port_is_disconnected(port) ||
> >>>>>>>> +           (tcpm_cc_is_open(port->cc1) &&
> >>>>>>>> + tcpm_cc_is_open(port->cc2)))
> >>>>>>>>
> >>>>>>>> to narrow down the condition.
> >>>>>>>
> >>>>>>> I have tried the above comment and It doesn't work.
> >>>>>>> How about to change the judgement like as below
> >>>>>>>
> >>>>>>> -       if (tcpm_port_is_disconnected(port))
> >>>>>>> +       if (tcpm_port_is_disconnected(port) ||
> >>>>>>> + !port->vbus_present)
> >>>>>>>
> >>>>>>> The hard_reset_count not reset issue is following by the below
> >>>>>>> order 1. VBUS off ( at the same time, cc is still detected as
> >>>>>>> attached)
> >>>>>>> port->attached become false and cc is not open
> >>>>>>> 2. After that, cc detached.
> >>>>>>> due to port->attached is false, tcpm_detach() directly return.
> >>>>>>
> >>>>>> If tcpm_detach() return directly, then how your patch can reset
> >>>>>> hard_reset_count?
> >>>>>>
> >>>>> Yes, it can. We know vbus_present change from true to false and cc
> >>>>> detach both trigger tcpm_detach.
> >>>>> My change is whenever tcpm_detach to be called, hard_reset_count
> >>>>> will be reset to zero.
> >>>>>
> >>>>>> I am seeing the same issue on my platform, the proposed change:
> >>>>>> -       if (tcpm_port_is_disconnected(port))
> >>>>>> -               port->hard_reset_count =3D 0;
> >>>>>> +       port->hard_reset_count =3D 0;
> >>>>>> can't resolve it on my platform.
> >>>>>>
> >>>>> I'm not sure what's your condition. Could you directly paste the
> >>>>> tcpm log for the check?
> >>>>>> How about reset hard_reset_count in SNK_READY?
> >>>>>> @@ -3325,6 +3329,7 @@ static void run_state_machine(struct
> >>>>>> tcpm_port
> >>>> *port)
> >>>>>>         case SNK_READY:
> >>>>>>                 port->try_snk_count =3D 0;
> >>>>>>                 port->update_sink_caps =3D false;
> >>>>>> +               port->hard_reset_count =3D 0;
> >>>>>>                 if (port->explicit_contract) {
> >>>>>>                         typec_set_pwr_opmode(port->typec_port,
> >>>>>>                                              TYPEC_PWR_MODE_PD);
> >>>>>>
> >>>>>> can this resolve your problem?
> >>>>> I'm not sure. It need to have a try, then I can answer you.
> >>>>> But from USBPD spec, the hard_reset_count need to reset zero only
> >>>>> when 1. At src state, pe_src_send_cap and receive GoodCRC 2. At
> >>>>> snk state, pe_snk_evaluate_cap need to reset hard_reset_count
> >>>
> >>> 3.
> >>> 8.3.3.3.8 PE_SNK_Hard_Reset state
> >>> "Note: The HardResetCounter is reset on a power cycle or Detach."
> >>>
> >>>>>>
> >>>>>> Li Jun
> >>>>>>>
> >>>>>>> And that's why hard_reset_count is not reset to 0.
> >>>>
> >>>> I tried in snk_ready to reset hard_reset_count.
> >>>> At normal case, it works.
> >>>> But it seems still the possible fail case like as below.
> >>>> 200ms -> cc debounce max time
> >>>> 240ms -> snk_waitcap max time
> >>>> If the plugin/out period is between (200+240) and (200+ 2* 240)ms ,
> >>>> and the src side plug out like as the described scenario.
> >>>> From this case, hard_reset_count may still 1.
> >>>> And we expect the next plugin hard_reset_count is 0. But not,
> >>>> actually it never reset.
> >>>> So at next plugin, only one hard_reset will be sent and reach
> >>>> hard_reset_count max (2).
> >>>>
> >>>> This case is hard to reproduce. But actually it's possible.
> >>>
> >>> Make sense.
> >>>
> >>> Then I propose doing this at SNK_UNATTACHED @@ -3156,6 +3156,7 @@
> >>> static void run_state_machine(struct tcpm_port *port)
> >>>                 if (!port->non_pd_role_swap)
> >>>                         tcpm_swap_complete(port, -ENOTCONN);
> >>>                 tcpm_pps_complete(port, -ENOTCONN);
> >>> +               port->hard_reset_count =3D 0;
> >>>                 tcpm_snk_detach(port);
> >>>                 if (tcpm_start_toggling(port, TYPEC_CC_RD)) {
> >>>                         tcpm_set_state(port, TOGGLING, 0); Li Jun
> >>
> >> For the current power role is snk, I think it may work.
> >> How about the src role? src role only reset the hard_reset_count in
> >> tcpm_detach and src_ready state?
> >
> > Sorry, after gave more check on PD sped, this isn't a right solution.
> > See below
> >
> >>
> >> I check the flow that  you mentioned in the previous mail. It's really=
 a
> >> special case from any state to port_reset.
> >> If the case is considered, how about to reset  the hard_reset_count an=
d don't
> >> care the port is attached or not in tcpm_detach function like as below=
.
> >>
> >> @@ -2789,6 +2789,8 @@ static void tcpm_reset_port(struct tcpm_port *po=
rt)
> >>
> >>  static void tcpm_detach(struct tcpm_port *port)  {
> >> +       port->hard_reset_count =3D 0;
> >> +
> >>         if (!port->attached)
> >>                 return;
> >>
> >> @@ -2797,9 +2799,6 @@ static void tcpm_detach(struct tcpm_port *port)
> >>                 port->tcpc->set_bist_data(port->tcpc, false);
> >>         }
> >>
> >> -       if (tcpm_port_is_disconnected(port))
> >> -               port->hard_reset_count =3D 0;
> >> -
> >>         tcpm_reset_port(port);
> >>  }
> >>
> >> Like I mentioned before, whatever the condition is, hard_reset_count m=
ust
> >> be reset to zero during tcpm_detach.
> >
> > This may not be so correct as you said, I think Guenter's concern is va=
lid.
> >
> > tcpm_detach() is not *only* be called in cases of *physical* detach
> > like the function name suggests.
> >
> > The current proposals may *wrongly* reset this counter.
> >
> > Let me give an example:
> >
> > HARD_RESET_SEND -> HARD_RESET_START ->
> > SNK_HARD_RESET_SINK_OFF -> SNK_HARD_RESET_WAIT_VBUS ->
> > SNK_UNATTACHED(in case of VBUS doesn't come back in expected duration)
> > -> call to tcpm_detach()
> >
> > In this sequence, does the sink need keep the counter? From the PD spec=
,
> > I think the answer is yes, sink need this counter to judge if need
> > do hard reset again or error recovery on later try, see:
> >
> > Figure 8-67 Sink Port State Diagram
> >
> > The difference between your case and my example, is your case never tur=
n
> > off vbus, so will not go to SNK_UNATTACHED, so will not call to tcpm_de=
tach()
> > after first hard reset.
> >
> > So
> >       if (tcpm_port_is_disconnected(port))
> >               port->hard_reset_count =3D 0;
> >
> > should keep as it is, the counter can only be cleared if there is reall=
y
> > physical disconnect by *partner*.
> >
> > But current tcpm code may have some problem on keeping local CC state i=
f
> > there is hard reset on-going(port->hard_reset_count > 0), because the
> > current handling of SNK_UNATTACHED may cause disconnection generated
> > by *local*(partner actually keeps its CC), e.g. reset polarity and do
> > drp_toggling, this should be fixed, but this is another patch, I can
> > try to do this later.
> >
> > Back to your problem, I think the issue is, at the first tcpm_detach()
> > the cc disconnect event hasn't happen, so the reset counter is left the=
re
> > but the port->attached is cleared, then the following(real disconnect)
> > tcpm_detach() will just return directly due to port->attached is false.
> >
> > So I guess this will resolve your problem:
> >
> > @@ -2885,6 +2885,9 @@ static void tcpm_reset_port(struct tcpm_port *por=
t)
> >
> >  static void tcpm_detach(struct tcpm_port *port)
> >  {
> > +       if (tcpm_port_is_disconnected(port))
> > +               port->hard_reset_count =3D 0;
> > +
> >         if (!port->attached)
> >                 return;
> >
> > @@ -2893,9 +2896,6 @@ static void tcpm_detach(struct tcpm_port *port)
> >                 port->tcpc->set_bist_data(port->tcpc, false);
> >         }
> >
> > -       if (tcpm_port_is_disconnected(port))
> > -               port->hard_reset_count =3D 0;
> > -
> >         tcpm_reset_port(port);
> >  }
> >
> >
I have checked this patch. It can solve the problem.

> > Compared with current code's condition:
> >    3 static bool tcpm_port_is_disconnected(struct tcpm_port *port)
> >    4 {
> >    5         return (!port->attached && port->cc1 =3D=3D TYPEC_CC_OPEN =
&&
> >    6                 port->cc2 =3D=3D TYPEC_CC_OPEN) ||
> >    7                (port->attached && ((port->polarity =3D=3D TYPEC_PO=
LARITY_CC1 &&
> >    8                                     port->cc1 =3D=3D TYPEC_CC_OPEN=
) ||
> >    9                                    (port->polarity =3D=3D TYPEC_PO=
LARITY_CC2 &&
> >   10                                     port->cc2 =3D=3D TYPEC_CC_OPEN=
)));
> >   11 }
> >
> > My above change is only adding another condition to clear the reset cou=
nter:
> > (!port->attached && port->cc1 =3D=3D TYPEC_CC_OPEN && port->cc2 =3D=3D =
TYPEC_CC_OPEN)
> >
> > This condition is close to Guenter's suggestion in this thread:
> >
> > -       if (tcpm_port_is_disconnected(port))
> > +       if (tcpm_port_is_disconnected(port) ||
> > +           (tcpm_cc_is_open(port->cc1) && tcpm_cc_is_open(port->cc2)))
> >
> > Hi Guenter, any comments on this?
> >
>
> That makes sense, and I would agree to the change you suggest above.
Jun:
   will you send the patch following the final discussion? Or I also can he=
lp.
Thx.
>
> Guenter
>
> > Thanks
> > Li Jun
> >
> >>
> >> But refer to Guenter's mail,  he prefer to narrow down the condition t=
o reset
> >> this counter.
> >>
> >> I think the original thought is important why to put this line there.
> >>
> >> Hi, Guenter:
> >>    From the discussion, we really need to know why you put the reset l=
ine
> >> below port attached is false and also make some judgement.
> >> I think there may be ome condition that we don't considered.
> >
> > This condition was added at first place, I think my above
> >>
> >>>
> >>>>
> >>>>>>>>
> >>>>>>>> Guenter
>
