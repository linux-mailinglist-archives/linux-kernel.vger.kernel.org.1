Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB3728A247
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbgJJW4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731509AbgJJTbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:31:55 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559ECC0613BD;
        Sat, 10 Oct 2020 12:31:55 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id f37so12083627otf.12;
        Sat, 10 Oct 2020 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vwcfHLcRYVngE9oHmrZWpiq15TpqG/njQm6Rkvmz1tE=;
        b=dFmMXnr1SKlo1vmdOQTBaLIwo8NA+e8c9hZt208pKRLYNBIRQDgL5xf+7gHPFVPOTS
         qyo5zR3ntL8WSMxR7W40HpgCVfN9Ll/itKvULWEqIUlwFyDUE0WBBbRF9+6XPQ95wOne
         gSDc2cXki6GSJITnieMKwKbczGZXanmBQA5v08E41xvSL/v6ipF8KaKAAz+dp9EpNQVP
         mbkuC8xiK3+0K4//9YnHhHb3rNL7+3K7Nw82TBO/joR+X0S4yBpcXvLZ2P6SXk3z7COA
         3Gkk/iGaQRtX+yyKlPMDJUagroYcuNYRMrZ5qRFtQGrf2Z2ob/g+tFpt4af5Ldx24Tpc
         i3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vwcfHLcRYVngE9oHmrZWpiq15TpqG/njQm6Rkvmz1tE=;
        b=rWIInZuTZ7UILKknfK4M8JKPWq9Wof6LsHNyuHj5e0lC/vw8JifL9hXlm7KdZX/LOP
         5DAtZ8AV37VT4NazOj+OzmAdr2AqDuw7zcju0+g+hDAK1YZZoTHwl0YXUSuZtwdwhw7h
         jPNVIZg81nF2Y4h/03r6IYeYLWjw86b1AhRDiIkBApq4vLlLQx5kwE6qvZSH57fOSMO4
         eaXTQFwVso1JggabElWtDXaOCrV54j2LwJWrJIXWZ0B5pNjBCMyatDF+FkK7g9lST5U4
         E8JfYDXSSJ72jiZWLnJO6zOjEjMpu0woh5Uh4gzuCFhANkFijQwyn59AujFOErviy0Yh
         Dj2w==
X-Gm-Message-State: AOAM533QBpvBJ3rjbxwCLhizUOpSB/h8yP8LD5ehfmMSTrBgfwgantQg
        f67attFJ9dsGrxJGmMQbNvw=
X-Google-Smtp-Source: ABdhPJxlb1c24LGXkbXFMAwRsjHSXUuc8AfwBM+5CoWqo9a5C5RiQIZQKqXECibWxBhoTEjIpHWpwQ==
X-Received: by 2002:a9d:5552:: with SMTP id h18mr13624360oti.311.1602358314572;
        Sat, 10 Oct 2020 12:31:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h14sm7174554otl.0.2020.10.10.12.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2020 12:31:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_reset_count
 not reset issue
To:     Jun Li <jun.li@nxp.com>, ChiYuan Huang <u0084500@gmail.com>
Cc:     Jun Li <lijun.kernel@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
 <63c7f5e4-eff2-1420-30a5-a0b98a7815e0@roeck-us.net>
 <CADiBU3-83rVLqhVAqqSGc0qQ66PHsGVVcp_m3sm_4ZS5A+GXKQ@mail.gmail.com>
 <CADiBU3_c5O-yUac-ytp5WoQQ12edkU+4wn+WNBOVGRGM15NBJA@mail.gmail.com>
 <20201002133145.GA3384841@kroah.com>
 <c2d689eb-5538-6af2-614f-766521100273@roeck-us.net>
 <20201005110808.GA298743@kroah.com>
 <88586992-650f-a4a1-2fa0-8cef313380fb@roeck-us.net>
 <CADiBU38wk825SqtFRAiYqqV47Wwi43AuWKut19qeTbGBZFqPow@mail.gmail.com>
 <CAKgpwJWwyvUyVj+jQ0y2i_eK1XEN2g3NvR0zgrRLfcmtgn8DDg@mail.gmail.com>
 <CADiBU3_TADpGmV7-BXJd3YaPNiv8Eg8zmKUD_OoB9CG1MT12mg@mail.gmail.com>
 <CADiBU392ZL6AHf6Dns61KXFVuvwh6grfnJjXmcFE4Ma2gjK6EA@mail.gmail.com>
 <VE1PR04MB6528CF55BE68A8DCF4B7904689080@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <CADiBU38-jX=4sbQ9aFoA=Xr6S7cFbfQy8tpdohoZdpaY-AK-Vw@mail.gmail.com>
 <VE1PR04MB652891569AB48A1C90A22C6389090@VE1PR04MB6528.eurprd04.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <25503f4e-58d1-8c11-9e5e-ea570b529d09@roeck-us.net>
Date:   Sat, 10 Oct 2020 12:31:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <VE1PR04MB652891569AB48A1C90A22C6389090@VE1PR04MB6528.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/20 4:21 AM, Jun Li wrote:
> 
> 
>> -----Original Message-----
>> From: ChiYuan Huang <u0084500@gmail.com>
>> Sent: Saturday, October 10, 2020 12:06 AM
>> To: Jun Li <jun.li@nxp.com>
>> Cc: Jun Li <lijun.kernel@gmail.com>; Guenter Roeck <linux@roeck-us.net>;
>> Greg KH <gregkh@linuxfoundation.org>; Heikki Krogerus
>> <heikki.krogerus@linux.intel.com>; Linux USB List
>> <linux-usb@vger.kernel.org>; lkml <linux-kernel@vger.kernel.org>;
>> cy_huang <cy_huang@richtek.com>
>> Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_reset_count
>> not reset issue
>>
>> Jun Li <jun.li@nxp.com> 於 2020年10月9日 週五 下午2:12寫道：
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: ChiYuan Huang <u0084500@gmail.com>
>>>> Sent: Wednesday, October 7, 2020 6:13 PM
>>>> To: Jun Li <lijun.kernel@gmail.com>
>>>> Cc: Guenter Roeck <linux@roeck-us.net>; Greg KH
>>>> <gregkh@linuxfoundation.org>; Heikki Krogerus
>>>> <heikki.krogerus@linux.intel.com>; Linux USB List
>>>> <linux-usb@vger.kernel.org>; lkml <linux-kernel@vger.kernel.org>;
>>>> cy_huang <cy_huang@richtek.com>; Jun Li <jun.li@nxp.com>
>>>> Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc,
>>>> hard_reset_count not reset issue
>>>>
>>>> ChiYuan Huang <u0084500@gmail.com> 於 2020年10月7日 週三 上午1:39寫
>> 道：
>>>>>
>>>>> Jun Li <lijun.kernel@gmail.com> 於 2020年10月7日 週三 上午12:52寫
>> 道：
>>>>>>
>>>>>> ChiYuan Huang <u0084500@gmail.com> 于2020年10月6日周二 下午12:38
>> 写
>>>> 道：
>>>>>>>
>>>>>>> Guenter Roeck <linux@roeck-us.net> 於 2020年10月5日 週一 下午
>> 11:30
>>>> 寫道：
>>>>>>>>
>>>>>>>> On 10/5/20 4:08 AM, Greg KH wrote:
>>>>>>>> [ ... ]
>>>>>>>>>>> What ever happened with this patch, is there still disagreement?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Yes, there is. I wouldn't have added the conditional
>>>>>>>>>> without reason, and I am concerned that removing it
>>>>>>>>>> entirely will open
>>>> another problem.
>>>>>>>>>> Feel free to apply, though - I can't prove that my
>>>>>>>>>> concern is valid, and after all we'll get reports from
>>>>>>>>>> the field later if
>>>> it is.
>>>>>>>>>
>>>>>>>>> Ok, can I get an ack so I know who to come back to in the
>>>>>>>>> future if there are issues?  :)
>>>>>>>>>
>>>>>>>>
>>>>>>>> Not from me, for the reasons I stated. I would be ok with
>>>>>>>> something
>>>> like:
>>>>>>>>
>>>>>>>> -       if (tcpm_port_is_disconnected(port))
>>>>>>>> +       if (tcpm_port_is_disconnected(port) ||
>>>>>>>> +           (tcpm_cc_is_open(port->cc1) &&
>>>>>>>> + tcpm_cc_is_open(port->cc2)))
>>>>>>>>
>>>>>>>> to narrow down the condition.
>>>>>>>
>>>>>>> I have tried the above comment and It doesn't work.
>>>>>>> How about to change the judgement like as below
>>>>>>>
>>>>>>> -       if (tcpm_port_is_disconnected(port))
>>>>>>> +       if (tcpm_port_is_disconnected(port) ||
>>>>>>> + !port->vbus_present)
>>>>>>>
>>>>>>> The hard_reset_count not reset issue is following by the below
>>>>>>> order 1. VBUS off ( at the same time, cc is still detected as
>>>>>>> attached)
>>>>>>> port->attached become false and cc is not open
>>>>>>> 2. After that, cc detached.
>>>>>>> due to port->attached is false, tcpm_detach() directly return.
>>>>>>
>>>>>> If tcpm_detach() return directly, then how your patch can reset
>>>>>> hard_reset_count?
>>>>>>
>>>>> Yes, it can. We know vbus_present change from true to false and cc
>>>>> detach both trigger tcpm_detach.
>>>>> My change is whenever tcpm_detach to be called, hard_reset_count
>>>>> will be reset to zero.
>>>>>
>>>>>> I am seeing the same issue on my platform, the proposed change:
>>>>>> -       if (tcpm_port_is_disconnected(port))
>>>>>> -               port->hard_reset_count = 0;
>>>>>> +       port->hard_reset_count = 0;
>>>>>> can't resolve it on my platform.
>>>>>>
>>>>> I'm not sure what's your condition. Could you directly paste the
>>>>> tcpm log for the check?
>>>>>> How about reset hard_reset_count in SNK_READY?
>>>>>> @@ -3325,6 +3329,7 @@ static void run_state_machine(struct
>>>>>> tcpm_port
>>>> *port)
>>>>>>         case SNK_READY:
>>>>>>                 port->try_snk_count = 0;
>>>>>>                 port->update_sink_caps = false;
>>>>>> +               port->hard_reset_count = 0;
>>>>>>                 if (port->explicit_contract) {
>>>>>>                         typec_set_pwr_opmode(port->typec_port,
>>>>>>                                              TYPEC_PWR_MODE_PD);
>>>>>>
>>>>>> can this resolve your problem?
>>>>> I'm not sure. It need to have a try, then I can answer you.
>>>>> But from USBPD spec, the hard_reset_count need to reset zero only
>>>>> when 1. At src state, pe_src_send_cap and receive GoodCRC 2. At
>>>>> snk state, pe_snk_evaluate_cap need to reset hard_reset_count
>>>
>>> 3.
>>> 8.3.3.3.8 PE_SNK_Hard_Reset state
>>> "Note: The HardResetCounter is reset on a power cycle or Detach."
>>>
>>>>>>
>>>>>> Li Jun
>>>>>>>
>>>>>>> And that's why hard_reset_count is not reset to 0.
>>>>
>>>> I tried in snk_ready to reset hard_reset_count.
>>>> At normal case, it works.
>>>> But it seems still the possible fail case like as below.
>>>> 200ms -> cc debounce max time
>>>> 240ms -> snk_waitcap max time
>>>> If the plugin/out period is between (200+240) and (200+ 2* 240)ms ,
>>>> and the src side plug out like as the described scenario.
>>>> From this case, hard_reset_count may still 1.
>>>> And we expect the next plugin hard_reset_count is 0. But not,
>>>> actually it never reset.
>>>> So at next plugin, only one hard_reset will be sent and reach
>>>> hard_reset_count max (2).
>>>>
>>>> This case is hard to reproduce. But actually it's possible.
>>>
>>> Make sense.
>>>
>>> Then I propose doing this at SNK_UNATTACHED @@ -3156,6 +3156,7 @@
>>> static void run_state_machine(struct tcpm_port *port)
>>>                 if (!port->non_pd_role_swap)
>>>                         tcpm_swap_complete(port, -ENOTCONN);
>>>                 tcpm_pps_complete(port, -ENOTCONN);
>>> +               port->hard_reset_count = 0;
>>>                 tcpm_snk_detach(port);
>>>                 if (tcpm_start_toggling(port, TYPEC_CC_RD)) {
>>>                         tcpm_set_state(port, TOGGLING, 0); Li Jun
>>
>> For the current power role is snk, I think it may work.
>> How about the src role? src role only reset the hard_reset_count in
>> tcpm_detach and src_ready state?
> 
> Sorry, after gave more check on PD sped, this isn't a right solution.
> See below
> 
>>
>> I check the flow that  you mentioned in the previous mail. It's really a
>> special case from any state to port_reset.
>> If the case is considered, how about to reset  the hard_reset_count and don't
>> care the port is attached or not in tcpm_detach function like as below.
>>
>> @@ -2789,6 +2789,8 @@ static void tcpm_reset_port(struct tcpm_port *port)
>>
>>  static void tcpm_detach(struct tcpm_port *port)  {
>> +       port->hard_reset_count = 0;
>> +
>>         if (!port->attached)
>>                 return;
>>
>> @@ -2797,9 +2799,6 @@ static void tcpm_detach(struct tcpm_port *port)
>>                 port->tcpc->set_bist_data(port->tcpc, false);
>>         }
>>
>> -       if (tcpm_port_is_disconnected(port))
>> -               port->hard_reset_count = 0;
>> -
>>         tcpm_reset_port(port);
>>  }
>>
>> Like I mentioned before, whatever the condition is, hard_reset_count must
>> be reset to zero during tcpm_detach.
> 
> This may not be so correct as you said, I think Guenter's concern is valid.
> 
> tcpm_detach() is not *only* be called in cases of *physical* detach
> like the function name suggests.
> 
> The current proposals may *wrongly* reset this counter.
> 
> Let me give an example:
> 
> HARD_RESET_SEND -> HARD_RESET_START ->
> SNK_HARD_RESET_SINK_OFF -> SNK_HARD_RESET_WAIT_VBUS ->
> SNK_UNATTACHED(in case of VBUS doesn't come back in expected duration)
> -> call to tcpm_detach()
> 
> In this sequence, does the sink need keep the counter? From the PD spec,
> I think the answer is yes, sink need this counter to judge if need
> do hard reset again or error recovery on later try, see:
> 
> Figure 8-67 Sink Port State Diagram
> 
> The difference between your case and my example, is your case never turn
> off vbus, so will not go to SNK_UNATTACHED, so will not call to tcpm_detach()
> after first hard reset.
> 
> So
> 	if (tcpm_port_is_disconnected(port))
> 		port->hard_reset_count = 0;
> 
> should keep as it is, the counter can only be cleared if there is really
> physical disconnect by *partner*.
> 
> But current tcpm code may have some problem on keeping local CC state if
> there is hard reset on-going(port->hard_reset_count > 0), because the
> current handling of SNK_UNATTACHED may cause disconnection generated
> by *local*(partner actually keeps its CC), e.g. reset polarity and do
> drp_toggling, this should be fixed, but this is another patch, I can
> try to do this later.
> 
> Back to your problem, I think the issue is, at the first tcpm_detach()
> the cc disconnect event hasn't happen, so the reset counter is left there
> but the port->attached is cleared, then the following(real disconnect)
> tcpm_detach() will just return directly due to port->attached is false.
> 
> So I guess this will resolve your problem:
> 
> @@ -2885,6 +2885,9 @@ static void tcpm_reset_port(struct tcpm_port *port)
> 
>  static void tcpm_detach(struct tcpm_port *port)
>  {
> +       if (tcpm_port_is_disconnected(port))
> +               port->hard_reset_count = 0;
> +
>         if (!port->attached)
>                 return;
> 
> @@ -2893,9 +2896,6 @@ static void tcpm_detach(struct tcpm_port *port)
>                 port->tcpc->set_bist_data(port->tcpc, false);
>         }
> 
> -       if (tcpm_port_is_disconnected(port))
> -               port->hard_reset_count = 0;
> -
>         tcpm_reset_port(port);
>  }
> 
> 
> Compared with current code's condition:
>    3 static bool tcpm_port_is_disconnected(struct tcpm_port *port)
>    4 {
>    5         return (!port->attached && port->cc1 == TYPEC_CC_OPEN &&
>    6                 port->cc2 == TYPEC_CC_OPEN) ||
>    7                (port->attached && ((port->polarity == TYPEC_POLARITY_CC1 &&
>    8                                     port->cc1 == TYPEC_CC_OPEN) ||
>    9                                    (port->polarity == TYPEC_POLARITY_CC2 &&
>   10                                     port->cc2 == TYPEC_CC_OPEN)));
>   11 }
> 
> My above change is only adding another condition to clear the reset counter:
> (!port->attached && port->cc1 == TYPEC_CC_OPEN && port->cc2 == TYPEC_CC_OPEN)
> 
> This condition is close to Guenter's suggestion in this thread:
> 
> -       if (tcpm_port_is_disconnected(port))
> +       if (tcpm_port_is_disconnected(port) ||
> +           (tcpm_cc_is_open(port->cc1) && tcpm_cc_is_open(port->cc2)))
> 
> Hi Guenter, any comments on this?
> 

That makes sense, and I would agree to the change you suggest above.

Guenter

> Thanks
> Li Jun
> 
>>
>> But refer to Guenter's mail,  he prefer to narrow down the condition to reset
>> this counter.
>>
>> I think the original thought is important why to put this line there.
>>
>> Hi, Guenter:
>>    From the discussion, we really need to know why you put the reset line
>> below port attached is false and also make some judgement.
>> I think there may be ome condition that we don't considered.
> 
> This condition was added at first place, I think my above 
>>
>>>
>>>>
>>>>>>>>
>>>>>>>> Guenter

