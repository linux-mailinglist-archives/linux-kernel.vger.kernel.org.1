Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E573269C52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgIODHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgIODHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:07:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B957C06174A;
        Mon, 14 Sep 2020 20:07:32 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v23so1492592ljd.1;
        Mon, 14 Sep 2020 20:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3gqr6jBNEY+ASWMIkvM8cpZA4SkbUkARE19dPv6D5kI=;
        b=U9FPg+d3tnMPwrger9NcG55Q9DB0VbUlYIzHPxVvtrOxmZHDf7vWTFPv+NTJmkdt2Z
         ykrgU30+rW8/wsXHEBIGjEn2p5nvg3n7KRbnUidf2Hy4iGhMSEcJKRwzyPsQJz/dAj0Y
         sDrw0252O8puBsQTb3kEltwwyelhXRjE7I8RujCexrcpnh8XKD97y6r/XqHeGOYd2AmC
         7OaqHU0vJ3Ao+YPZ1ke0sEk6BopwPblu0tuhdV8XEzX+abNZ4CNOXOGMLlg6Dk1MGi/q
         YZWJWLyQHQn/FBxGIVMq8VKLXm1QbnPMbGSPTS0eErTEQABqR8oXeXignVgQrud8PeRd
         EbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3gqr6jBNEY+ASWMIkvM8cpZA4SkbUkARE19dPv6D5kI=;
        b=kByEip0uxCE4jSizAoEuD77i7d0elW2bewP0XPK1CiZY+CKR3cFw9QbyhVuKavAvrL
         kdcHxDCL6R8wAwJt79/khCwy1I8fOyERXwmkDIfGF/vQMApsuhOkdnZ8F2R/SwjBQym/
         A7cJJ7DR8KBkYoUWFIDS1xRFulPw7uixqEDaBgsMlJc1p3WN/l+eNzveZ+YYJzeqk6Zh
         1mIAM1KuzvjlSmd88j53TunX8wy3ZMp7BMyNsVdXVnWrnDZ7fqn79UzSoAoV4MsbtzVT
         78t5/vm2QmuNfNmeJqbKYFK552L8pmTDXX8VEi8h8gqt2yMdbKVltOEdlYeiMZ9XEQ3f
         zQSQ==
X-Gm-Message-State: AOAM531mqCPQnnZe67EpjnRCsF23h0aN0fs6uwdLPNQVMZBXLYP9Zz66
        t3e35YRo4fG41Xcq+AmKxvxuXsIu68UNcXynHb4=
X-Google-Smtp-Source: ABdhPJyuBg+E2YcqDm0il606vPK4VVYMwHW5wQRazUTgDHNzhNDYb+aKd7NPekYjUkDYhiTmfhYKjYmpEQdBWz+V0Hc=
X-Received: by 2002:a2e:907:: with SMTP id 7mr6436762ljj.470.1600139250537;
 Mon, 14 Sep 2020 20:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
 <20200902165713.GG56237@roeck-us.net> <CADiBU3_iHk4aoM8o6GcaTmWDZT4ymvb0Ff-XeLLZ0C9dhCnLZQ@mail.gmail.com>
 <fd2a33fc-2383-66cb-0fd7-d5aa0cc9111f@roeck-us.net> <CADiBU3_vYAmHDCONrExzyM+1CTfqJx_eS1hYG8aHkNWFzTcwfg@mail.gmail.com>
 <63c7f5e4-eff2-1420-30a5-a0b98a7815e0@roeck-us.net> <CADiBU3-83rVLqhVAqqSGc0qQ66PHsGVVcp_m3sm_4ZS5A+GXKQ@mail.gmail.com>
In-Reply-To: <CADiBU3-83rVLqhVAqqSGc0qQ66PHsGVVcp_m3sm_4ZS5A+GXKQ@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 15 Sep 2020 11:07:18 +0800
Message-ID: <CADiBU3_c5O-yUac-ytp5WoQQ12edkU+4wn+WNBOVGRGM15NBJA@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_reset_count
 not reset issue
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Guenter:

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=886=E6=97=
=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=8811:22=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B49=E6=9C=885=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8811:51=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On 9/4/20 6:24 PM, ChiYuan Huang wrote:
> > > Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B49=E6=9C=885=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=883:41=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >>
> > >> On 9/3/20 9:21 AM, ChiYuan Huang wrote:
> > >>> Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B49=E6=9C=
=883=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:57=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >>>>
> > >>>> On Wed, Sep 02, 2020 at 11:35:33PM +0800, cy_huang wrote:
> > >>>>> From: ChiYuan Huang <cy_huang@richtek.com>
> > >>>>>
> > >>>>> Fix: If vbus event is before cc_event trigger, hard_reset_count
> > >>>>> won't bt reset for some case.
> > >>>>>
> > >>>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > >>>>> ---
> > >>>>> Below's the flow.
> > >>>>>
> > >>>>> _tcpm_pd_vbus_off() -> run_state_machine to change state to SNK_U=
NATTACHED
> > >>>>> call tcpm_snk_detach() -> tcpm_snk_detach() -> tcpm_detach()
> > >>>>> tcpm_port_is_disconnected() will be called.
> > >>>>> But port->attached is still true and port->cc1=3Dopen and port->c=
c2=3Dopen
> > >>>>>
> > >>>>> It cause tcpm_port_is_disconnected return false, then hard_reset_=
count won't be reset.
> > >>>>> After that, tcpm_reset_port() is called.
> > >>>>> port->attached become false.
> > >>>>>
> > >>>>> After that, cc now trigger cc_change event, the hard_reset_count =
will be kept.
> > >>>>> Even tcpm_detach will be called, due to port->attached is false, =
tcpm_detach()
> > >>>>> will directly return.
> > >>>>>
> > >>>>> CC_EVENT will only trigger drp toggling again.
> > >>>>> ---
> > >>>>>  drivers/usb/typec/tcpm/tcpm.c | 3 +--
> > >>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
> > >>>>>
> > >>>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tc=
pm/tcpm.c
> > >>>>> index a48e3f90..5c73e1d 100644
> > >>>>> --- a/drivers/usb/typec/tcpm/tcpm.c
> > >>>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
> > >>>>> @@ -2797,8 +2797,7 @@ static void tcpm_detach(struct tcpm_port *p=
ort)
> > >>>>>               port->tcpc->set_bist_data(port->tcpc, false);
> > >>>>>       }
> > >>>>>
> > >>>>> -     if (tcpm_port_is_disconnected(port))
> > >>>>> -             port->hard_reset_count =3D 0;
> > >>>>> +     port->hard_reset_count =3D 0;
> > >>>>>
> > >>>>
> > >>>> Doesn't that mean that the state machine will never enter
> > >>>> error recovery ?
> > >>>>
> > >>> I think it does't affect the error recovery.
> > >>> All error recovery seems to check pd_capable flag.
> > >>>
> > >>> >From my below case, it's A to C cable only. There is no USBPD cont=
ract
> > >>> will be estabilished.
> > >>>
> > >>> This case occurred following by the below test condition
> > >>> Cable -> A to C (default Rp bind to vbus) connected to PC.
> > >>> 1. first time plugged in the cable with PC
> > >>> It will make HARD_RESET_COUNT  to be equal 2
> > >>> 2. And then plug out. At that time HARD_RESET_COUNT is till 2.
> > >>> 3. next time plugged in again.
> > >>> Due to hard_reset_count is still 2 , after wait_cap_timeout, the st=
ate
> > >>> eventually changed to SNK_READY.
> > >>> But during the state transition, no hard_reset  be sent.
> > >>>
> > >>> Defined in the USBPD policy engine, typec transition to USBPD, all
> > >>> variables must be reset included hard_reset_count.
> > >>> So it expected SNK must send hard_reset again.
> > >>>
> > >>> The original code defined hard_reset_count must be reset only when
> > >>> tcpm_port_is_disconnected.
> > >>>
> > >>> It doesn't make sense that it only occurred in some scenario.
> > >>> If tcpm_detach is called, hard_reset count must be reset also.
> > >>>
> > >>
> > >> If a hard reset fails, the state machine may cycle through states
> > >> HARD_RESET_SEND, HARD_RESET_START, SRC_HARD_RESET_VBUS_OFF,
> > >> SRC_HARD_RESET_VBUS_ON back to SRC_UNATTACHED. In this state,
> > >> tcpm_src_detach() and with it tcpm_detach() is called. The hard
> > >> reset counter is incremented in HARD_RESET_SEND. If tcpm_detach()
> > >> resets the counter, the state machine will keep cycling through hard
> > >> resets without ever entering the error recovery state. I am not
> > >> entirely sure where the counter should be reset, but tcpm_detach()
> > >> seems to be the wrong place.
> > >
> > > This case you specified means locally error occurred.
> >
> > It could be a local error (with the local hardware), or with the
> > remote partner not accepting the reset. We only know that an error
> > occurred.
> >
> > > It intended to re-run the state machine from typec  to USBPD.
> > >>From my understanding, hard_reset_count to be reset is reasonable.
> > >
> > > The normal stare from the state transition you specified is
> > > HARD_RESET_SEND, HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF,
> > > SRC_HARD_RESET_VBUS_ON -> received VBUS_EVENT then go to SRC_STARTUP.
> > >
> > The operational word is "normal". Error recovery is expected to handle
> > situations which are not normal.
>
> Following by the USBPD 3.0 revision 1.2, section 8.3.3.24.1
> The ErrorRecovery state is  used to electronically disconnect Port
> Partner using the USB Type-C connector.
> And there's one sentence to be said "The ErrorRecovery staste shall
> map to USB Type-C Error Recovery state operations".
> I also read ErrorRecovery state in USB TYPE-C 1.3 spec.
> Section 4.5.2.2.2.1   ErrorRecovery state requirement listed the below te=
xt.
> The port shall not drive VBUS or VCONN, and shall present a
> high-impedance to ground (above
> zOPEN) on its CC1 and CC2 pins.
> Section 4.5.2.2.2.2 Exiting from the error recovery state
> I read the description. The roughly meaning is to change the state to
> Unattached(Src or Snk) after tErrorRecovery.
>
> Summary the above text.
> Reset HardResetCounter is ok in tcpm_detach.
> My patch is just to relax the counter reset conditions during tcpm_detach=
().
> If not, it will check tcpm_port_is_disconnected().
> And only two scenario, the hard reset count will be cleared to 0 at this =
case.
> 1) port not attached and cc1=3Dopen and cc2=3Dopen
> 2) port attached and either (polarity=3Dcc1, cc1=3Dopen) or (polarity=3Dc=
c2, cc2=3Dopen)
>
> I think this judgement is narrow in tcpm_detach case.
>
> >
> > I don't question the need to reset the counter. The only question
> > is where and when to reset it.
> >
> I re-check all tcpm code for hard reset counter about the increment and r=
eset.
> They all meets USBPD spec. Only the detach case, I'm wondering why it
> need to add the check for tcpm_port_is_disconnected().
>
Below's the real case log.
[ 4848.046358] VBUS off
[ 4848.046384] state change SNK_READY -> SNK_UNATTACHED
[ 4848.050908] Setting voltage/current limit 0 mV 0 mA
[ 4848.050936] polarity 0
[ 4848.052593] Requesting mux state 0, usb-role 0, orientation 0
[ 4848.053222] Start toggling
[ 4848.086500] state change SNK_UNATTACHED -> TOGGLING
[ 4848.089983] CC1: 0 -> 0, CC2: 3 -> 3 [state TOGGLING, polarity 0, connec=
ted]
[ 4848.089993] state change TOGGLING -> SNK_ATTACH_WAIT
[ 4848.090031] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 200 =
ms
[ 4848.141162] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_ATTACH_WAIT,
polarity 0, disconnected]
[ 4848.141170] state change SNK_ATTACH_WAIT -> SNK_ATTACH_WAIT
[ 4848.141184] pending state change SNK_ATTACH_WAIT -> SNK_UNATTACHED @ 20 =
ms
[ 4848.163156] state change SNK_ATTACH_WAIT -> SNK_UNATTACHED [delayed 20 m=
s]
[ 4848.163162] Start toggling
[ 4848.216918] CC1: 0 -> 0, CC2: 0 -> 3 [state TOGGLING, polarity 0, connec=
ted]
[ 4848.216954] state change TOGGLING -> SNK_ATTACH_WAIT
[ 4848.217080] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 200 =
ms
[ 4848.231771] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_ATTACH_WAIT,
polarity 0, disconnected]
[ 4848.231800] state change SNK_ATTACH_WAIT -> SNK_ATTACH_WAIT
[ 4848.231857] pending state change SNK_ATTACH_WAIT -> SNK_UNATTACHED @ 20 =
ms
[ 4848.256022] state change SNK_ATTACH_WAIT -> SNK_UNATTACHED [delayed 20 m=
s]
[ 4848.256049] Start toggling
[ 4848.871148] VBUS on
[ 4848.885324] CC1: 0 -> 0, CC2: 0 -> 3 [state TOGGLING, polarity 0, connec=
ted]
[ 4848.885372] state change TOGGLING -> SNK_ATTACH_WAIT
[ 4848.885548] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 200 =
ms
[ 4849.088240] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 200 m=
s]
[ 4849.088284] state change SNK_DEBOUNCED -> SNK_ATTACHED
[ 4849.088291] polarity 1
[ 4849.088769] Requesting mux state 1, usb-role 2, orientation 2
[ 4849.088895] state change SNK_ATTACHED -> SNK_STARTUP
[ 4849.088907] state change SNK_STARTUP -> SNK_DISCOVERY
[ 4849.088915] Setting voltage/current limit 5000 mV 0 mA
[ 4849.088927] vbus=3D0 charge:=3D1
[ 4849.090505] state change SNK_DISCOVERY -> SNK_WAIT_CAPABILITIES
[ 4849.090828] pending state change SNK_WAIT_CAPABILITIES -> SNK_READY @ 24=
0 ms
[ 4849.335878] state change SNK_WAIT_CAPABILITIES -> SNK_READY [delayed 240=
 ms]

You can see the next type c attach log.
It directly change state from SNK_WAIT_CAPABILITIES to SNK_READY due
to not reset hard_reset_count.

It's easy to reproduce if you plugout USB Adapater w/i AtoC cable connected=
.

> > Guenter
