Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EA428140B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387902AbgJBNbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBNbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:31:47 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE2D122262;
        Fri,  2 Oct 2020 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601645506;
        bh=gRs+0Tz8K20f8VWjmkXyRso+CwVdIFD9/M9EvnK5pqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rm94eNBod7WhsyFZNEa9Sm9bjrZRnZBlVcUuu660qOehd68ln4ulfEW/0zVjZHFn7
         VrtgAp5H3/ottjIF6j+7BR7N9SfuFqDeZkTaHaf+WOfYDOBps56sBdZsjnik0cFBPQ
         HiHyAF1qvg5IOQ4YOGb8NuzTbNUTkwblzIPuPgkM=
Date:   Fri, 2 Oct 2020 15:31:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang <cy_huang@richtek.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc,
 hard_reset_count not reset issue
Message-ID: <20201002133145.GA3384841@kroah.com>
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
 <20200902165713.GG56237@roeck-us.net>
 <CADiBU3_iHk4aoM8o6GcaTmWDZT4ymvb0Ff-XeLLZ0C9dhCnLZQ@mail.gmail.com>
 <fd2a33fc-2383-66cb-0fd7-d5aa0cc9111f@roeck-us.net>
 <CADiBU3_vYAmHDCONrExzyM+1CTfqJx_eS1hYG8aHkNWFzTcwfg@mail.gmail.com>
 <63c7f5e4-eff2-1420-30a5-a0b98a7815e0@roeck-us.net>
 <CADiBU3-83rVLqhVAqqSGc0qQ66PHsGVVcp_m3sm_4ZS5A+GXKQ@mail.gmail.com>
 <CADiBU3_c5O-yUac-ytp5WoQQ12edkU+4wn+WNBOVGRGM15NBJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADiBU3_c5O-yUac-ytp5WoQQ12edkU+4wn+WNBOVGRGM15NBJA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:07:18AM +0800, ChiYuan Huang wrote:
> Hi, Guenter:
> 
> ChiYuan Huang <u0084500@gmail.com> 於 2020年9月6日 週日 下午11:22寫道：
> >
> > Guenter Roeck <linux@roeck-us.net> 於 2020年9月5日 週六 下午11:51寫道：
> > >
> > > On 9/4/20 6:24 PM, ChiYuan Huang wrote:
> > > > Guenter Roeck <linux@roeck-us.net> 於 2020年9月5日 週六 上午3:41寫道：
> > > >>
> > > >> On 9/3/20 9:21 AM, ChiYuan Huang wrote:
> > > >>> Guenter Roeck <linux@roeck-us.net> 於 2020年9月3日 週四 上午12:57寫道：
> > > >>>>
> > > >>>> On Wed, Sep 02, 2020 at 11:35:33PM +0800, cy_huang wrote:
> > > >>>>> From: ChiYuan Huang <cy_huang@richtek.com>
> > > >>>>>
> > > >>>>> Fix: If vbus event is before cc_event trigger, hard_reset_count
> > > >>>>> won't bt reset for some case.
> > > >>>>>
> > > >>>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > >>>>> ---
> > > >>>>> Below's the flow.
> > > >>>>>
> > > >>>>> _tcpm_pd_vbus_off() -> run_state_machine to change state to SNK_UNATTACHED
> > > >>>>> call tcpm_snk_detach() -> tcpm_snk_detach() -> tcpm_detach()
> > > >>>>> tcpm_port_is_disconnected() will be called.
> > > >>>>> But port->attached is still true and port->cc1=open and port->cc2=open
> > > >>>>>
> > > >>>>> It cause tcpm_port_is_disconnected return false, then hard_reset_count won't be reset.
> > > >>>>> After that, tcpm_reset_port() is called.
> > > >>>>> port->attached become false.
> > > >>>>>
> > > >>>>> After that, cc now trigger cc_change event, the hard_reset_count will be kept.
> > > >>>>> Even tcpm_detach will be called, due to port->attached is false, tcpm_detach()
> > > >>>>> will directly return.
> > > >>>>>
> > > >>>>> CC_EVENT will only trigger drp toggling again.
> > > >>>>> ---
> > > >>>>>  drivers/usb/typec/tcpm/tcpm.c | 3 +--
> > > >>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >>>>>
> > > >>>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > > >>>>> index a48e3f90..5c73e1d 100644
> > > >>>>> --- a/drivers/usb/typec/tcpm/tcpm.c
> > > >>>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > >>>>> @@ -2797,8 +2797,7 @@ static void tcpm_detach(struct tcpm_port *port)
> > > >>>>>               port->tcpc->set_bist_data(port->tcpc, false);
> > > >>>>>       }
> > > >>>>>
> > > >>>>> -     if (tcpm_port_is_disconnected(port))
> > > >>>>> -             port->hard_reset_count = 0;
> > > >>>>> +     port->hard_reset_count = 0;
> > > >>>>>
> > > >>>>
> > > >>>> Doesn't that mean that the state machine will never enter
> > > >>>> error recovery ?
> > > >>>>
> > > >>> I think it does't affect the error recovery.
> > > >>> All error recovery seems to check pd_capable flag.
> > > >>>
> > > >>> >From my below case, it's A to C cable only. There is no USBPD contract
> > > >>> will be estabilished.
> > > >>>
> > > >>> This case occurred following by the below test condition
> > > >>> Cable -> A to C (default Rp bind to vbus) connected to PC.
> > > >>> 1. first time plugged in the cable with PC
> > > >>> It will make HARD_RESET_COUNT  to be equal 2
> > > >>> 2. And then plug out. At that time HARD_RESET_COUNT is till 2.
> > > >>> 3. next time plugged in again.
> > > >>> Due to hard_reset_count is still 2 , after wait_cap_timeout, the state
> > > >>> eventually changed to SNK_READY.
> > > >>> But during the state transition, no hard_reset  be sent.
> > > >>>
> > > >>> Defined in the USBPD policy engine, typec transition to USBPD, all
> > > >>> variables must be reset included hard_reset_count.
> > > >>> So it expected SNK must send hard_reset again.
> > > >>>
> > > >>> The original code defined hard_reset_count must be reset only when
> > > >>> tcpm_port_is_disconnected.
> > > >>>
> > > >>> It doesn't make sense that it only occurred in some scenario.
> > > >>> If tcpm_detach is called, hard_reset count must be reset also.
> > > >>>
> > > >>
> > > >> If a hard reset fails, the state machine may cycle through states
> > > >> HARD_RESET_SEND, HARD_RESET_START, SRC_HARD_RESET_VBUS_OFF,
> > > >> SRC_HARD_RESET_VBUS_ON back to SRC_UNATTACHED. In this state,
> > > >> tcpm_src_detach() and with it tcpm_detach() is called. The hard
> > > >> reset counter is incremented in HARD_RESET_SEND. If tcpm_detach()
> > > >> resets the counter, the state machine will keep cycling through hard
> > > >> resets without ever entering the error recovery state. I am not
> > > >> entirely sure where the counter should be reset, but tcpm_detach()
> > > >> seems to be the wrong place.
> > > >
> > > > This case you specified means locally error occurred.
> > >
> > > It could be a local error (with the local hardware), or with the
> > > remote partner not accepting the reset. We only know that an error
> > > occurred.
> > >
> > > > It intended to re-run the state machine from typec  to USBPD.
> > > >>From my understanding, hard_reset_count to be reset is reasonable.
> > > >
> > > > The normal stare from the state transition you specified is
> > > > HARD_RESET_SEND, HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF,
> > > > SRC_HARD_RESET_VBUS_ON -> received VBUS_EVENT then go to SRC_STARTUP.
> > > >
> > > The operational word is "normal". Error recovery is expected to handle
> > > situations which are not normal.
> >
> > Following by the USBPD 3.0 revision 1.2, section 8.3.3.24.1
> > The ErrorRecovery state is  used to electronically disconnect Port
> > Partner using the USB Type-C connector.
> > And there's one sentence to be said "The ErrorRecovery staste shall
> > map to USB Type-C Error Recovery state operations".
> > I also read ErrorRecovery state in USB TYPE-C 1.3 spec.
> > Section 4.5.2.2.2.1   ErrorRecovery state requirement listed the below text.
> > The port shall not drive VBUS or VCONN, and shall present a
> > high-impedance to ground (above
> > zOPEN) on its CC1 and CC2 pins.
> > Section 4.5.2.2.2.2 Exiting from the error recovery state
> > I read the description. The roughly meaning is to change the state to
> > Unattached(Src or Snk) after tErrorRecovery.
> >
> > Summary the above text.
> > Reset HardResetCounter is ok in tcpm_detach.
> > My patch is just to relax the counter reset conditions during tcpm_detach().
> > If not, it will check tcpm_port_is_disconnected().
> > And only two scenario, the hard reset count will be cleared to 0 at this case.
> > 1) port not attached and cc1=open and cc2=open
> > 2) port attached and either (polarity=cc1, cc1=open) or (polarity=cc2, cc2=open)
> >
> > I think this judgement is narrow in tcpm_detach case.
> >
> > >
> > > I don't question the need to reset the counter. The only question
> > > is where and when to reset it.
> > >
> > I re-check all tcpm code for hard reset counter about the increment and reset.
> > They all meets USBPD spec. Only the detach case, I'm wondering why it
> > need to add the check for tcpm_port_is_disconnected().
> >
> Below's the real case log.
> [ 4848.046358] VBUS off
> [ 4848.046384] state change SNK_READY -> SNK_UNATTACHED
> [ 4848.050908] Setting voltage/current limit 0 mV 0 mA
> [ 4848.050936] polarity 0
> [ 4848.052593] Requesting mux state 0, usb-role 0, orientation 0
> [ 4848.053222] Start toggling
> [ 4848.086500] state change SNK_UNATTACHED -> TOGGLING
> [ 4848.089983] CC1: 0 -> 0, CC2: 3 -> 3 [state TOGGLING, polarity 0, connected]
> [ 4848.089993] state change TOGGLING -> SNK_ATTACH_WAIT
> [ 4848.090031] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 200 ms
> [ 4848.141162] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_ATTACH_WAIT,
> polarity 0, disconnected]
> [ 4848.141170] state change SNK_ATTACH_WAIT -> SNK_ATTACH_WAIT
> [ 4848.141184] pending state change SNK_ATTACH_WAIT -> SNK_UNATTACHED @ 20 ms
> [ 4848.163156] state change SNK_ATTACH_WAIT -> SNK_UNATTACHED [delayed 20 ms]
> [ 4848.163162] Start toggling
> [ 4848.216918] CC1: 0 -> 0, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
> [ 4848.216954] state change TOGGLING -> SNK_ATTACH_WAIT
> [ 4848.217080] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 200 ms
> [ 4848.231771] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_ATTACH_WAIT,
> polarity 0, disconnected]
> [ 4848.231800] state change SNK_ATTACH_WAIT -> SNK_ATTACH_WAIT
> [ 4848.231857] pending state change SNK_ATTACH_WAIT -> SNK_UNATTACHED @ 20 ms
> [ 4848.256022] state change SNK_ATTACH_WAIT -> SNK_UNATTACHED [delayed 20 ms]
> [ 4848.256049] Start toggling
> [ 4848.871148] VBUS on
> [ 4848.885324] CC1: 0 -> 0, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
> [ 4848.885372] state change TOGGLING -> SNK_ATTACH_WAIT
> [ 4848.885548] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 200 ms
> [ 4849.088240] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 200 ms]
> [ 4849.088284] state change SNK_DEBOUNCED -> SNK_ATTACHED
> [ 4849.088291] polarity 1
> [ 4849.088769] Requesting mux state 1, usb-role 2, orientation 2
> [ 4849.088895] state change SNK_ATTACHED -> SNK_STARTUP
> [ 4849.088907] state change SNK_STARTUP -> SNK_DISCOVERY
> [ 4849.088915] Setting voltage/current limit 5000 mV 0 mA
> [ 4849.088927] vbus=0 charge:=1
> [ 4849.090505] state change SNK_DISCOVERY -> SNK_WAIT_CAPABILITIES
> [ 4849.090828] pending state change SNK_WAIT_CAPABILITIES -> SNK_READY @ 240 ms
> [ 4849.335878] state change SNK_WAIT_CAPABILITIES -> SNK_READY [delayed 240 ms]
> 
> You can see the next type c attach log.
> It directly change state from SNK_WAIT_CAPABILITIES to SNK_READY due
> to not reset hard_reset_count.
> 
> It's easy to reproduce if you plugout USB Adapater w/i AtoC cable connected.

What ever happened with this patch, is there still disagreement?

thanks,

greg k-h
