Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C7728150E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbgJBO02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBO02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:26:28 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F393C0613D0;
        Fri,  2 Oct 2020 07:26:28 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id y5so1499438otg.5;
        Fri, 02 Oct 2020 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i5fXVVdZttAUdz9JmDB3uE+OLB3uDce3IunmeUUR8Ro=;
        b=Jf32ZZh8/n0E6/4wvWZzO+OM0KDLet/AQaQ8SqSup9VqsW6YDtuvImra2y/wYJgOW1
         WnWT3ZfcXY3+Hr/Uuv/JzIE67ShhJI3qp7tU7ETavzqt3+Lw+1/N3P1+4jk9JtpJYNHD
         maZ7ANBXSsyRhuDPPuj6d++Vqjs++B4FN8Vkhu17iMNtsqVK62KES4d7/XfUofPb8q+a
         EYgDI+que/71Ibu2PQf5h5yihZBwW3iPuH83zwAqjsu2I+q9GeDfBZpbVJ71C1Z862y4
         b348XOOYy9GAFVLDmBoudQk/F1PC16FTywcYT+OmaiiBiNKAld5CjS8t6oxqoXZMzmcf
         JvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=i5fXVVdZttAUdz9JmDB3uE+OLB3uDce3IunmeUUR8Ro=;
        b=H9B21YsKHxL/EtUWO+L7Q1D0RUDCttxReqACj9ACCKe46XhqBuqLJ0SW8RaZd+Kt51
         qC7iB46tbtpxLDUDzGhQA+njieP6q+QblDZmdlWVrrgEvZbDAwKGDJFGtYjaieyNPkHc
         JRIYSe7sx3wK99FFV/CrdGbZpLoYDqbJAqJn7AgoYy6TKXfceegb/7ZP6OZyz+v0WFkb
         U7la9EYfUwjHrXuld3sKERq20QS4tL2V/9d+VQMz+iYitRshiHqY5p3oVLyKVh0YZTvo
         keykduv/aYK71MT9xtcA7OYYqzB2L2ZcyVAm1kY6ky5UQNUVOjiZdKPLnQl/jCQNw6iS
         tn9A==
X-Gm-Message-State: AOAM531nhjJdbV8PwmyUvlWecCfAGdFwAOxbf3kR0kY8pmh63lIv0dgT
        tJ4wQur6vC5g6pbYtaqMvr0=
X-Google-Smtp-Source: ABdhPJwsE8RKdxkI0yB2dwyFvSLqoMz7vKm0dgy0/8tJ0PhSQJ4cHzOaNIiLU1PwZlYjdpPBYFQakw==
X-Received: by 2002:a9d:5a92:: with SMTP id w18mr1860209oth.145.1601648787398;
        Fri, 02 Oct 2020 07:26:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u9sm393954otq.54.2020.10.02.07.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 07:26:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_reset_count
 not reset issue
To:     Greg KH <gregkh@linuxfoundation.org>,
        ChiYuan Huang <u0084500@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang <cy_huang@richtek.com>
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
 <20200902165713.GG56237@roeck-us.net>
 <CADiBU3_iHk4aoM8o6GcaTmWDZT4ymvb0Ff-XeLLZ0C9dhCnLZQ@mail.gmail.com>
 <fd2a33fc-2383-66cb-0fd7-d5aa0cc9111f@roeck-us.net>
 <CADiBU3_vYAmHDCONrExzyM+1CTfqJx_eS1hYG8aHkNWFzTcwfg@mail.gmail.com>
 <63c7f5e4-eff2-1420-30a5-a0b98a7815e0@roeck-us.net>
 <CADiBU3-83rVLqhVAqqSGc0qQ66PHsGVVcp_m3sm_4ZS5A+GXKQ@mail.gmail.com>
 <CADiBU3_c5O-yUac-ytp5WoQQ12edkU+4wn+WNBOVGRGM15NBJA@mail.gmail.com>
 <20201002133145.GA3384841@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <c2d689eb-5538-6af2-614f-766521100273@roeck-us.net>
Date:   Fri, 2 Oct 2020 07:26:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002133145.GA3384841@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 6:31 AM, Greg KH wrote:
> On Tue, Sep 15, 2020 at 11:07:18AM +0800, ChiYuan Huang wrote:
>> Hi, Guenter:
>>
>> ChiYuan Huang <u0084500@gmail.com> 於 2020年9月6日 週日 下午11:22寫道：
>>>
>>> Guenter Roeck <linux@roeck-us.net> 於 2020年9月5日 週六 下午11:51寫道：
>>>>
>>>> On 9/4/20 6:24 PM, ChiYuan Huang wrote:
>>>>> Guenter Roeck <linux@roeck-us.net> 於 2020年9月5日 週六 上午3:41寫道：
>>>>>>
>>>>>> On 9/3/20 9:21 AM, ChiYuan Huang wrote:
>>>>>>> Guenter Roeck <linux@roeck-us.net> 於 2020年9月3日 週四 上午12:57寫道：
>>>>>>>>
>>>>>>>> On Wed, Sep 02, 2020 at 11:35:33PM +0800, cy_huang wrote:
>>>>>>>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>>>>>>>
>>>>>>>>> Fix: If vbus event is before cc_event trigger, hard_reset_count
>>>>>>>>> won't bt reset for some case.
>>>>>>>>>
>>>>>>>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>>>>>>>> ---
>>>>>>>>> Below's the flow.
>>>>>>>>>
>>>>>>>>> _tcpm_pd_vbus_off() -> run_state_machine to change state to SNK_UNATTACHED
>>>>>>>>> call tcpm_snk_detach() -> tcpm_snk_detach() -> tcpm_detach()
>>>>>>>>> tcpm_port_is_disconnected() will be called.
>>>>>>>>> But port->attached is still true and port->cc1=open and port->cc2=open
>>>>>>>>>
>>>>>>>>> It cause tcpm_port_is_disconnected return false, then hard_reset_count won't be reset.
>>>>>>>>> After that, tcpm_reset_port() is called.
>>>>>>>>> port->attached become false.
>>>>>>>>>
>>>>>>>>> After that, cc now trigger cc_change event, the hard_reset_count will be kept.
>>>>>>>>> Even tcpm_detach will be called, due to port->attached is false, tcpm_detach()
>>>>>>>>> will directly return.
>>>>>>>>>
>>>>>>>>> CC_EVENT will only trigger drp toggling again.
>>>>>>>>> ---
>>>>>>>>>  drivers/usb/typec/tcpm/tcpm.c | 3 +--
>>>>>>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>>>>>>>>> index a48e3f90..5c73e1d 100644
>>>>>>>>> --- a/drivers/usb/typec/tcpm/tcpm.c
>>>>>>>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>>>>>>>>> @@ -2797,8 +2797,7 @@ static void tcpm_detach(struct tcpm_port *port)
>>>>>>>>>               port->tcpc->set_bist_data(port->tcpc, false);
>>>>>>>>>       }
>>>>>>>>>
>>>>>>>>> -     if (tcpm_port_is_disconnected(port))
>>>>>>>>> -             port->hard_reset_count = 0;
>>>>>>>>> +     port->hard_reset_count = 0;
>>>>>>>>>
>>>>>>>>
>>>>>>>> Doesn't that mean that the state machine will never enter
>>>>>>>> error recovery ?
>>>>>>>>
>>>>>>> I think it does't affect the error recovery.
>>>>>>> All error recovery seems to check pd_capable flag.
>>>>>>>
>>>>>>> >From my below case, it's A to C cable only. There is no USBPD contract
>>>>>>> will be estabilished.
>>>>>>>
>>>>>>> This case occurred following by the below test condition
>>>>>>> Cable -> A to C (default Rp bind to vbus) connected to PC.
>>>>>>> 1. first time plugged in the cable with PC
>>>>>>> It will make HARD_RESET_COUNT  to be equal 2
>>>>>>> 2. And then plug out. At that time HARD_RESET_COUNT is till 2.
>>>>>>> 3. next time plugged in again.
>>>>>>> Due to hard_reset_count is still 2 , after wait_cap_timeout, the state
>>>>>>> eventually changed to SNK_READY.
>>>>>>> But during the state transition, no hard_reset  be sent.
>>>>>>>
>>>>>>> Defined in the USBPD policy engine, typec transition to USBPD, all
>>>>>>> variables must be reset included hard_reset_count.
>>>>>>> So it expected SNK must send hard_reset again.
>>>>>>>
>>>>>>> The original code defined hard_reset_count must be reset only when
>>>>>>> tcpm_port_is_disconnected.
>>>>>>>
>>>>>>> It doesn't make sense that it only occurred in some scenario.
>>>>>>> If tcpm_detach is called, hard_reset count must be reset also.
>>>>>>>
>>>>>>
>>>>>> If a hard reset fails, the state machine may cycle through states
>>>>>> HARD_RESET_SEND, HARD_RESET_START, SRC_HARD_RESET_VBUS_OFF,
>>>>>> SRC_HARD_RESET_VBUS_ON back to SRC_UNATTACHED. In this state,
>>>>>> tcpm_src_detach() and with it tcpm_detach() is called. The hard
>>>>>> reset counter is incremented in HARD_RESET_SEND. If tcpm_detach()
>>>>>> resets the counter, the state machine will keep cycling through hard
>>>>>> resets without ever entering the error recovery state. I am not
>>>>>> entirely sure where the counter should be reset, but tcpm_detach()
>>>>>> seems to be the wrong place.
>>>>>
>>>>> This case you specified means locally error occurred.
>>>>
>>>> It could be a local error (with the local hardware), or with the
>>>> remote partner not accepting the reset. We only know that an error
>>>> occurred.
>>>>
>>>>> It intended to re-run the state machine from typec  to USBPD.
>>>>> >From my understanding, hard_reset_count to be reset is reasonable.
>>>>>
>>>>> The normal stare from the state transition you specified is
>>>>> HARD_RESET_SEND, HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF,
>>>>> SRC_HARD_RESET_VBUS_ON -> received VBUS_EVENT then go to SRC_STARTUP.
>>>>>
>>>> The operational word is "normal". Error recovery is expected to handle
>>>> situations which are not normal.
>>>
>>> Following by the USBPD 3.0 revision 1.2, section 8.3.3.24.1
>>> The ErrorRecovery state is  used to electronically disconnect Port
>>> Partner using the USB Type-C connector.
>>> And there's one sentence to be said "The ErrorRecovery staste shall
>>> map to USB Type-C Error Recovery state operations".
>>> I also read ErrorRecovery state in USB TYPE-C 1.3 spec.
>>> Section 4.5.2.2.2.1   ErrorRecovery state requirement listed the below text.
>>> The port shall not drive VBUS or VCONN, and shall present a
>>> high-impedance to ground (above
>>> zOPEN) on its CC1 and CC2 pins.
>>> Section 4.5.2.2.2.2 Exiting from the error recovery state
>>> I read the description. The roughly meaning is to change the state to
>>> Unattached(Src or Snk) after tErrorRecovery.
>>>
>>> Summary the above text.
>>> Reset HardResetCounter is ok in tcpm_detach.
>>> My patch is just to relax the counter reset conditions during tcpm_detach().
>>> If not, it will check tcpm_port_is_disconnected().
>>> And only two scenario, the hard reset count will be cleared to 0 at this case.
>>> 1) port not attached and cc1=open and cc2=open
>>> 2) port attached and either (polarity=cc1, cc1=open) or (polarity=cc2, cc2=open)
>>>
>>> I think this judgement is narrow in tcpm_detach case.
>>>
>>>>
>>>> I don't question the need to reset the counter. The only question
>>>> is where and when to reset it.
>>>>
>>> I re-check all tcpm code for hard reset counter about the increment and reset.
>>> They all meets USBPD spec. Only the detach case, I'm wondering why it
>>> need to add the check for tcpm_port_is_disconnected().
>>>
>> Below's the real case log.
>> [ 4848.046358] VBUS off
>> [ 4848.046384] state change SNK_READY -> SNK_UNATTACHED
>> [ 4848.050908] Setting voltage/current limit 0 mV 0 mA
>> [ 4848.050936] polarity 0
>> [ 4848.052593] Requesting mux state 0, usb-role 0, orientation 0
>> [ 4848.053222] Start toggling
>> [ 4848.086500] state change SNK_UNATTACHED -> TOGGLING
>> [ 4848.089983] CC1: 0 -> 0, CC2: 3 -> 3 [state TOGGLING, polarity 0, connected]
>> [ 4848.089993] state change TOGGLING -> SNK_ATTACH_WAIT
>> [ 4848.090031] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 200 ms
>> [ 4848.141162] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_ATTACH_WAIT,
>> polarity 0, disconnected]
>> [ 4848.141170] state change SNK_ATTACH_WAIT -> SNK_ATTACH_WAIT
>> [ 4848.141184] pending state change SNK_ATTACH_WAIT -> SNK_UNATTACHED @ 20 ms
>> [ 4848.163156] state change SNK_ATTACH_WAIT -> SNK_UNATTACHED [delayed 20 ms]
>> [ 4848.163162] Start toggling
>> [ 4848.216918] CC1: 0 -> 0, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
>> [ 4848.216954] state change TOGGLING -> SNK_ATTACH_WAIT
>> [ 4848.217080] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 200 ms
>> [ 4848.231771] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_ATTACH_WAIT,
>> polarity 0, disconnected]
>> [ 4848.231800] state change SNK_ATTACH_WAIT -> SNK_ATTACH_WAIT
>> [ 4848.231857] pending state change SNK_ATTACH_WAIT -> SNK_UNATTACHED @ 20 ms
>> [ 4848.256022] state change SNK_ATTACH_WAIT -> SNK_UNATTACHED [delayed 20 ms]
>> [ 4848.256049] Start toggling
>> [ 4848.871148] VBUS on
>> [ 4848.885324] CC1: 0 -> 0, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
>> [ 4848.885372] state change TOGGLING -> SNK_ATTACH_WAIT
>> [ 4848.885548] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 200 ms
>> [ 4849.088240] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 200 ms]
>> [ 4849.088284] state change SNK_DEBOUNCED -> SNK_ATTACHED
>> [ 4849.088291] polarity 1
>> [ 4849.088769] Requesting mux state 1, usb-role 2, orientation 2
>> [ 4849.088895] state change SNK_ATTACHED -> SNK_STARTUP
>> [ 4849.088907] state change SNK_STARTUP -> SNK_DISCOVERY
>> [ 4849.088915] Setting voltage/current limit 5000 mV 0 mA
>> [ 4849.088927] vbus=0 charge:=1
>> [ 4849.090505] state change SNK_DISCOVERY -> SNK_WAIT_CAPABILITIES
>> [ 4849.090828] pending state change SNK_WAIT_CAPABILITIES -> SNK_READY @ 240 ms
>> [ 4849.335878] state change SNK_WAIT_CAPABILITIES -> SNK_READY [delayed 240 ms]
>>
>> You can see the next type c attach log.
>> It directly change state from SNK_WAIT_CAPABILITIES to SNK_READY due
>> to not reset hard_reset_count.
>>
>> It's easy to reproduce if you plugout USB Adapater w/i AtoC cable connected.
> 
> What ever happened with this patch, is there still disagreement?
> 

Yes, there is. I wouldn't have added the conditional without reason,
and I am concerned that removing it entirely will open another problem.
Feel free to apply, though - I can't prove that my concern is valid,
and after all we'll get reports from the field later if it is.

Guenter
