Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117392B0906
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgKLPzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:55:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728549AbgKLPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605196513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ckiV1DVHMhrTV0yNs1uMBmzXIDK1aa2YXRxhutVErOc=;
        b=iPTeEyN8T15qheO4lx25kmqSGFlb1Z11IrVxlheOVdJp+tQqd7UoabNWdyNDQH/tQVR/Ev
        5FVfa3BDvJIPECmp9nd82ksHbRWTDr7F5VUgzlIxespmeAy2f9z13H+M6PpopXfO9FwCgm
        0W61XGByx/C3LPfLo6NcPlVGCvMbFUE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-2vzrS8BNMIKUOnUugZSV5w-1; Thu, 12 Nov 2020 10:55:10 -0500
X-MC-Unique: 2vzrS8BNMIKUOnUugZSV5w-1
Received: by mail-ed1-f69.google.com with SMTP id dj19so2485528edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:55:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ckiV1DVHMhrTV0yNs1uMBmzXIDK1aa2YXRxhutVErOc=;
        b=K3aJ2h0Bmb2AELn+q2kRfle0761I6/3i82sqz0I45OjZQ0pycnifeUG+e7dvnoQD2y
         DEOv0OJs6k/Xsnzz4WpgxPPEkE3N2FX6ZMacvL282TXQ8a6XZuj6pt2x7FKo4GPsI2j7
         qdPJ7Z7zva/ArEUfwMhEnXISbeH9X6AqReXbsDan6IGyA1exWiPyNnWv+SqLLjgPsiCa
         DZZzCH8vsob/0sQ9sYHfpn9mJ4T6FX1qx/I6OmIGFu+7S4+BDhk62YVAimRd0msbZvKk
         4vPuxM8rdtJLap5t3R5BKgmhWbKv86v7b2bVl49/9IwTLcpKRAy2pgOIfoX6/PJtIuNt
         wHNg==
X-Gm-Message-State: AOAM533oTA7FpM7GLBEzUZ0CqyqOr9ff9QhHm3/dNzkGuJghadeu93jA
        IoVAF9QURRxdJcZ4Qy1Lxesb8Pu4hOoi4NqOWkMtOAH1290M2u9OG7DRBoqzGigkHUVkjm1ZW5f
        SjQvDuFi+3fzVFyWNwkSkDzgw
X-Received: by 2002:a05:6402:1c8e:: with SMTP id cy14mr407907edb.39.1605196508951;
        Thu, 12 Nov 2020 07:55:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEqCHDYkFwLp6VRG0s5EgrmbldluDnIIyGJ8+blt35xKg5SssVMhnwjScV3IAHA8NN5zRhfw==
X-Received: by 2002:a05:6402:1c8e:: with SMTP id cy14mr407892edb.39.1605196508796;
        Thu, 12 Nov 2020 07:55:08 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id s3sm2305295ejv.97.2020.11.12.07.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 07:55:08 -0800 (PST)
Subject: Re: [PATCH] platform/x86: dell-privacy: Add support for new privacy
 driver
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "Yuan, Perry" <Perry.Yuan@dell.com>
Cc:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <20201103125542.8572-1-Perry_Yuan@Dell.com>
 <20201104014915.45tbmnrqvccbrd2k@srcf.ucam.org>
 <SJ0PR19MB4528E93631DA5FD8BE1D6E8D84E80@SJ0PR19MB4528.namprd19.prod.outlook.com>
 <20201111072456.tkwdzuq2wa7zvbod@srcf.ucam.org>
 <DM6PR19MB2636956DB58B0E4ECAD43549FAE80@DM6PR19MB2636.namprd19.prod.outlook.com>
 <e8e06aca-c3f1-d833-c766-01f05dfa0f37@metux.net>
 <DM6PR19MB2636D792A7CCEE8937579EA6FAE70@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <544bc53f-c260-9e46-15a9-2ec2ea41343c@redhat.com>
Date:   Thu, 12 Nov 2020 16:55:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB2636D792A7CCEE8937579EA6FAE70@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/12/20 4:31 PM, Limonciello, Mario wrote:
>>> Pressing the mute key activates a time delayed circuit to physically cut
>>> off the mute.  The LED is in the same circuit, so it reflects the true
>>> state of the HW mute.  The reason for the EC "ack" is so that software
>>> can first invoke a SW mute before the HW circuit is cut off.  Without SW
>>> cutting this off first does not affect the time delayed muting or status
>>> of the LED but there is a possibility of a "popping" noise leading to a
>>> poor user experience.
>>
>> how long is that timeout ?
> 
> The exact duration is controlled by component selection in the circuit.
> Linux is typically able to respond faster than Windows in this case.
> 
>>
>>> Exposing as an LED device allows the codec drivers notification path to
>>> EC ACK to work.
>>
>> Which driver exactly ? Who's gonna access this LED ?
> 
> The flow is like this:
> 
> 1) User presses key.  HW does stuff with this key (timeout is started)
> 2) Event is emitted from FW
> 3) Event received by dell-privacy
> 4) KEY_MICMUTE emitted from dell-privacy
> 5) Userland picks up key and modifies kcontrol for SW mute
> 6) Codec kernel driver catches and calls ledtrig_audio_set, like this:
> 
> ledtrig_audio_set(LED_AUDIO_MICMUTE, rt715->micmute_led ? LED_ON : LED_OFF);
> 
> 7) If "LED" is set to on dell-privacy notifies ec, and timeout is cancelled,
> HW mic mute activated.
> 
> Again, if anything in this flow doesn't happen HW mic mute is still activated,
> just will take longer (for duration of timeout) and have popping noise.

Thank you, can we put this in a comment in the driver please ?

I guess this also means that the led_class device is just there to
catch the ledtrig_audio_set() call so that dell-firmware can tell the
EC that the sw-mute is done and that it can move ahead with the hw-mute.

While the real, physical LED is fully under hardware control, right ?

That should probably also be in the same comment in the driver
(feel free to re-use part of my wording for that if that helps).

Regards,

Hans



> 
>>
>>
>> --mtx
>>
>> --
>> ---
>> Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
>> werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
>> GPG/PGP-Schlüssel zu.
>> ---
>> Enrico Weigelt, metux IT consult
>> Free software and Linux embedded engineering
>> info@metux.net -- +49-151-27565287

