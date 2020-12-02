Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2C52CB3CE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 05:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgLBELW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 23:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLBELV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 23:11:21 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6421DC0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 20:10:41 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id h6so224212vsr.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 20:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o26o6Y63LfBqWDNh8Vel6m2HouJ+lE/PJZZZsl78j9I=;
        b=o9ZRAM+h1fOA5f7SMozY8icPM4GeWO6lRYdwAa6aJeMaYbZLZxHyYJ8E4MqVcG8fF2
         H6qtHPPTX25r6L0PS4C5C1ktfGvtcSl1qDBULT2xd6bODqyDVcUepL8G9HZjzmiC7Zyp
         Dz8xlO0l0/4u22OZAjlLoz+yXAX6uwJp7N+Qmrwgk0wSLb1/QmLoEwO+iX60AHRT0lKd
         hvCDMPaWu5dik9vLi0bWyody02r487GyYIBOA6Io7AvpdMsOjrFYoXijYUyKx/VUJHpM
         i37z7RtkkVWF7Yvu4nsOFTp/B63S18qvHk7MDWOiamgfop4hdw9B+eRI+0SDlttKAHjH
         5ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o26o6Y63LfBqWDNh8Vel6m2HouJ+lE/PJZZZsl78j9I=;
        b=Rzm8mqXRAMO/PLEyQiKjDSa9NgxgrusDrbFCzDWWKitaEjKyClgm2RsevLpHkUo6/0
         Mt5UPWJApvljg4BLoKnynRe1soEFyb+wHOHS4kOn8S1LiuiLpLqOzGsvN4mT7ZFGWcHE
         nt9KFb11oZOHjAfyZG9v5xxvD5lGYiPQxcORamoaMDH9RMTuqK6qoC7k6x2HymfuHfT1
         K43WsgI6r5M3VyAOp2E4KqCGdcvaqtqTLxrfFwi0PWw/vmdIuWYB16dMLX4AqEyJwG3N
         3qMJgKawcTlrzIea3p6XUTexuJBZ924JPuFBU7yEql1ecwAO7Ys1IvZliFVeXrMO7uxG
         ospg==
X-Gm-Message-State: AOAM532+BqWVbL6QChfmBrQXKlndZ5vcxcMxhBymSKLF2RYUz72DC7XT
        lqHKBIJe2eImXJx7ErTyxfdsRmSbjApZUjgxT71tdg==
X-Google-Smtp-Source: ABdhPJwf30oN1OEcFXxXISMmSsyvGaqnMW9SWgn5FDGtyVJigt4UIiYNKWI0ZUktgaihtVjLRvNA29czyuxtYPks8kw=
X-Received: by 2002:a67:eb95:: with SMTP id e21mr402209vso.43.1606882240230;
 Tue, 01 Dec 2020 20:10:40 -0800 (PST)
MIME-Version: 1.0
References: <20201201013246.32034-1-badhri@google.com> <20201201131552.GB232197@roeck-us.net>
In-Reply-To: <20201201131552.GB232197@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Tue, 1 Dec 2020 20:10:03 -0800
Message-ID: <CAPTae5KZjWEOxSG+57GvdxYkzbJucbo7SB5NuhR65gGU+37s0g@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] usb: typec: tcpm: Introduce vsafe0v for vbus
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 5:15 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Nov 30, 2020 at 05:32:44PM -0800, Badhri Jagan Sridharan wrote:
> > TCPM at present lacks the notion of VSAFE0V. There
> > are three vbus threshold levels that are critical to track:
> > a. vSafe5V         - VBUS =E2=80=9C5 volts=E2=80=9D as defined by the U=
SB
> >                      PD specification.
> > b. vSinkDisconnect - Threshold used for transition from
> >                      Attached.SNK to Unattached.SNK.
> > c. vSafe0V         - VBUS =E2=80=9C0 volts=E2=80=9D as defined by the U=
SB
> >                      PD specification.
> >
> > Tracking vSafe0V is crucial for entry into Try.SNK and
> > Attached.SRC and turning vbus back on by the source in
> > response to hard reset.
> >
> > From "4.5.2.2.8.2 Exiting from AttachWait.SRC State" section
> > in the Type-C spec:
> >
> > "The port shall transition to Attached.SRC when VBUS is at
> > vSafe0V and the SRC.Rd state is detected on exactly one of
> > the CC1 or CC2 pins for at least tCCDebounce."
> >
> > "A DRP that strongly prefers the Sink role may optionally
> > transition to Try.SNK instead of Attached.SRC when VBUS
> > is at vSafe0V and the SRC.Rd state is detected on exactly
> > one of the CC1 or CC2 pins for at least tCCDebounce."
> >
> > From "7.1.5 Response to Hard Resets" section in the PD spec:
> >
> > "After establishing the vSafe0V voltage condition on VBUS,
> > the Source Shall wait tSrcRecover before re-applying VCONN
> > and restoring VBUS to vSafe5V."
> >
> > vbus_present in the TCPM code tracks vSafe5V(vbus_present is true)
> > and vSinkDisconnect(vbus_present is false).
> >
> > This change adds is_vbus_vsafe0v callback which when set makes
> > TCPM query for vSafe0V voltage level when needed.
> >
> > Since not all TCPC controllers might have the capability
> > to report vSafe0V, TCPM assumes that vSafe0V is same as
> > vSinkDisconnect when is_vbus_vsafe0v callback is not set.
> > This allows TCPM to continue to support controllers which don't
> > have the support for reporting vSafe0V.
> >
> > Introducing vSafe0V helps fix the failure reported at
> > "Step 15. CVS verifies PUT remains in AttachWait.SRC for 500ms"
> > of "TD 4.7.2 Try. SNK DRP Connect DRP Test" of
> > "Universal Serial Bus Type-C (USB Type-C) Functional Test
> > Specification Chapters 4 and 5". Here the compliance tester
> > intentionally maintains vbus at greater than vSafe0V and expects
> > the Product under test to stay in AttachWait.SRC till vbus drops
> > to vSafe0V.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 63 +++++++++++++++++++++++++++++------
> >  include/linux/usb/tcpm.h      |  6 ++++
> >  2 files changed, 58 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcp=
m.c
> > index 3bbc1f10af49..10a065eef73e 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -258,7 +258,19 @@ struct tcpm_port {
> >       bool attached;
> >       bool connected;
> >       enum typec_port_type port_type;
> > +
> > +     /*
> > +      * Set to true when vbus is greater than VSAFE5V min.
> > +      * Set to false when vbus falls below vSinkDisconnect max thresho=
ld.
> > +      */
> >       bool vbus_present;
> > +
> > +     /*
> > +      * Set to true when vbus is less than VSAFE0V max.
> > +      * Set to false when vbus is greater than VSAFE0V max.
> > +      */
> > +     bool vbus_vsafe0v;
> > +
> >       bool vbus_never_low;
> >       bool vbus_source;
> >       bool vbus_charge;
> > @@ -3094,7 +3106,7 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >               else if (tcpm_port_is_audio(port))
> >                       tcpm_set_state(port, AUDIO_ACC_ATTACHED,
> >                                      PD_T_CC_DEBOUNCE);
> > -             else if (tcpm_port_is_source(port))
> > +             else if (tcpm_port_is_source(port) && port->vbus_vsafe0v)
> >                       tcpm_set_state(port,
> >                                      tcpm_try_snk(port) ? SNK_TRY
> >                                                         : SRC_ATTACHED,
> > @@ -4097,6 +4109,12 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *p=
ort)
> >  {
> >       tcpm_log_force(port, "VBUS on");
> >       port->vbus_present =3D true;
> > +     /*
> > +      * When vbus_present is true i.e. Voltage at VBUS is greater than=
 VSAFE5V implicitly
> > +      * states that vbus is not at VSAFE0V, hence clear the vbus_vsafe=
0v flag here.
> > +      */
> > +     port->vbus_vsafe0v =3D false;
> > +
> >       switch (port->state) {
> >       case SNK_TRANSITION_SINK_VBUS:
> >               port->explicit_contract =3D true;
> > @@ -4186,16 +4204,8 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *=
port)
> >       case SNK_HARD_RESET_SINK_OFF:
> >               tcpm_set_state(port, SNK_HARD_RESET_WAIT_VBUS, 0);
> >               break;
> > -     case SRC_HARD_RESET_VBUS_OFF:
> > -             /*
> > -              * After establishing the vSafe0V voltage condition on VB=
US, the Source Shall wait
> > -              * tSrcRecover before re-applying VCONN and restoring VBU=
S to vSafe5V.
> > -              */
> > -             tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_REC=
OVER);
> > -             break;
> >       case HARD_RESET_SEND:
> >               break;
> > -
> >       case SNK_TRY:
> >               /* Do nothing, waiting for timeout */
> >               break;
> > @@ -4266,6 +4276,28 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *=
port)
> >       }
> >  }
> >
> > +static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
> > +{
> > +     tcpm_log_force(port, "VBUS VSAFE0V");
> > +     port->vbus_vsafe0v =3D true;
> > +     switch (port->state) {
> > +     case SRC_HARD_RESET_VBUS_OFF:
> > +             /*
> > +              * After establishing the vSafe0V voltage condition on VB=
US, the Source Shall wait
> > +              * tSrcRecover before re-applying VCONN and restoring VBU=
S to vSafe5V.
> > +              */
> > +             tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_REC=
OVER);
> > +             break;
> > +     case SRC_ATTACH_WAIT:
> > +             if (tcpm_port_is_source(port))
> > +                     tcpm_set_state(port, tcpm_try_snk(port) ? SNK_TRY=
 : SRC_ATTACHED,
> > +                                    PD_T_CC_DEBOUNCE);
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +}
> > +
> >  static void _tcpm_pd_hard_reset(struct tcpm_port *port)
> >  {
> >       tcpm_log_force(port, "Received hard reset");
> > @@ -4301,10 +4333,19 @@ static void tcpm_pd_event_handler(struct kthrea=
d_work *work)
> >                       bool vbus;
> >
> >                       vbus =3D port->tcpc->get_vbus(port->tcpc);
> > -                     if (vbus)
> > +                     if (vbus) {
> >                               _tcpm_pd_vbus_on(port);
> > -                     else
> > +                     } else {
> >                               _tcpm_pd_vbus_off(port);
> > +                             /*
> > +                              * When TCPC does not support detecting v=
safe0v voltage level,
> > +                              * treat vbus absent as vsafe0v. Else inv=
oke is_vbus_vsafe0v
> > +                              * to see if vbus has discharge to VSAFE0=
V.
> > +                              */
> > +                             if (!port->tcpc->is_vbus_vsafe0v ||
> > +                                 port->tcpc->is_vbus_vsafe0v(port->tcp=
c) > 0)
> > +                                     _tcpm_pd_vbus_vsafe0v(port);
> > +                     }
> >               }
> >               if (events & TCPM_CC_EVENT) {
> >                       enum typec_cc_status cc1, cc2;
> > diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> > index e68aaa12886f..615d4532c028 100644
> > --- a/include/linux/usb/tcpm.h
> > +++ b/include/linux/usb/tcpm.h
> > @@ -98,6 +98,11 @@ enum tcpm_transmit_type {
> >   *           will be turned on. requested_vbus_voltage is set to 0 whe=
n vbus
> >   *           is going to disappear knowingly i.e. during PR_SWAP and
> >   *           HARD_RESET etc.
> > + * @is_vbus_vsafe0v:
> > + *           Optional; TCPCI spec based TCPC implementations are expec=
ted to
> > + *           detect VSAFE0V voltage level at vbus. When detection of V=
SAFE0V
> > + *           is supported by TCPC, set this callback for TCPM to query
> > + *           whether vbus is at VSAFE0V when needed.
>
> Return values ?

Fixing in v2.

>
> >   */
> >  struct tcpc_dev {
> >       struct fwnode_handle *fwnode;
> > @@ -128,6 +133,7 @@ struct tcpc_dev {
> >       int (*enable_auto_vbus_discharge)(struct tcpc_dev *dev, bool enab=
le);
> >       int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, en=
um typec_pwr_opmode mode,
> >                                                bool pps_active, u32 req=
uested_vbus_voltage);
> > +     int (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
>
> I don't really see the point of returning an int here. If an error is
> returned, it should be checked. However, that is not currently the case;
> an error is treated as "false" return. As such, the function may as well
> return true/false (and false if an error is observed).

Sure. Changing the callback return to boolean in v2.

>
> >  };
> >
> >  struct tcpm_port;
> > --
> > 2.29.2.454.gaff20da3a2-goog
> >
