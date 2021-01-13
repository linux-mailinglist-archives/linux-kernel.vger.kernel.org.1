Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672512F5465
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 22:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbhAMVAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 16:00:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25689 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728839AbhAMU5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610571422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KyeVTvomgCzlV9Xq0HncJHDevMWvQaxSid6diziHy50=;
        b=iGwsCkDf0987fTSNdrj/aZfBcSZcbABgvQ3f0kNqZv6giuYdf4AEasgKsmVFcNqv2XACe2
        Ea+BzSWptZfWpZ4ALS40gAaHPsQfY1YEcA3XdGWPI9p4ln+gGP7T6Uh+aeXa5x/NkGh9QC
        mz0MIYZmFzzv3NzP4g7Uh3eca6mJAuQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544--URE32o2PNe7apz8LXt7TA-1; Wed, 13 Jan 2021 15:55:52 -0500
X-MC-Unique: -URE32o2PNe7apz8LXt7TA-1
Received: by mail-ed1-f71.google.com with SMTP id cm4so1456874edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KyeVTvomgCzlV9Xq0HncJHDevMWvQaxSid6diziHy50=;
        b=P3uXNiua9jvCBS9egCWqQEnyAfeVkYwVspSOWD/wNIepN43ZY4H6XWCo3LBStpqKUp
         Hyxc8xRstqDIHh/DbjNAnQjDyLxV/g+/takCBG4d6SAa+CcFLz6OVrWjNLe6TiCp33rG
         +1M5uD6mPP7xA4G9PSicFANecTQv5ABIq1w9iKsfkhLRy3tLPQozEClpbXc+R42KJT2i
         WX0J8m6r1DXyGbE8E6pJ5rJh/a47W63lmt+UKwzBOFiEob6Klk8vBlYqwH+Nz+vFq8nw
         oanRaLm9WCrijLSozg8XHtQN1XOrnHcj/dmhJrTNdLV4lztuibMGRpK/6R1C+8kB3Lr7
         S3bw==
X-Gm-Message-State: AOAM533f4twBm0kXOhsmfOECw110K8uYAoBW0x3LGvQLRiCzhEeFEs5K
        ix+pp1g0bwsLAgyEdGKAnZBxCPlQBTjoIGpFKRV/UdIblGQrsN2dIOGWnAcgyU7XDkGFXTX1dBb
        hWe3Ash8YOsqBiBt/Zq4RWxs6
X-Received: by 2002:a17:906:24d1:: with SMTP id f17mr1985211ejb.21.1610571351326;
        Wed, 13 Jan 2021 12:55:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIFkrj0zV6MG35I2/95jUJA70odVCeRn+Mht21EoWlSfwxuvEVlcTT4VHqNFVhHDJZ3rHKfQ==
X-Received: by 2002:a17:906:24d1:: with SMTP id f17mr1985197ejb.21.1610571351193;
        Wed, 13 Jan 2021 12:55:51 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id i8sm1312749eds.72.2021.01.13.12.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 12:55:50 -0800 (PST)
Subject: Re: [PATCH v5 1/3] usb: typec: tcpm: AMS and Collision Avoidance
To:     Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will McVicker <willmcvicker@google.com>
References: <20210105163927.1376770-1-kyletso@google.com>
 <20210105163927.1376770-2-kyletso@google.com>
 <20210112132925.GC2020859@kuha.fi.intel.com>
 <CAPTae5LLtjQAt4db+ZVttEGxnueydmEZ4eu+gQSEOaZE4B=u0A@mail.gmail.com>
 <CAGZ6i=2cQywq82QrJg=t-KVMqSdjME-dkd-8aH3au_RTju2zTA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ad606425-8c2c-d95b-5d72-602d55ac6aa2@redhat.com>
Date:   Wed, 13 Jan 2021 21:55:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ6i=2cQywq82QrJg=t-KVMqSdjME-dkd-8aH3au_RTju2zTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/13/21 3:46 PM, Kyle Tso wrote:
> On Wed, Jan 13, 2021 at 2:11 PM Badhri Jagan Sridharan
> <badhri@google.com> wrote:
>>
>> Hi Kyle,
>>
>> Do you want to handle the FAST_ROLE_SWAP case as well ?
>>
> I forgot this part....
> Thanks for catching this.
> I will fix it.

That sounds like a v6 is upcoming which not only will have
code-style changes but also some functional changes ?

In that case I will wait a bit before running the tests
which I want to run with this patch-set and run those
tests with v6 so that I don't have to redo them later.

Regards,

Hans



> 
> 
>> You would have to fix up in two places:
>>
>> #1
>> -                       if (port->state == SNK_READY)
>> -                               tcpm_set_state(port, FR_SWAP_SEND, 0);
>> -                       else
>> +                       if (port->state == SNK_READY) {
>> +                               int ret;
>> +
>> +                               port->upcoming_state = FR_SWAP_SEND;
>> +                               ret = tcpm_ams_start(port, FAST_ROLE_SWAP);
>> +                               if (ret == -EAGAIN)
>> +                                       port->upcoming_state = INVALID_STATE;
>> +                       } else {
>>                                 tcpm_log(port, "Discarding FRS_SIGNAL!
>> Not in sink ready");
>> +                       }
>>
>> #2
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -4449,9 +4449,14 @@ static void tcpm_enable_frs_work(struct
>> kthread_work *work)
>>         if (port->state != SNK_READY || port->vdm_state !=
>> VDM_STATE_DONE || port->send_discover)
>>                 goto resched;
>>
>> -       tcpm_set_state(port, GET_SINK_CAP, 0);
>> -       port->sink_cap_done = true;
>> -
>> +       port->upcoming_state = GET_SINK_CAP;
>> +       ret = tcpm_ams_start(port, GET_SINK_CAPABILITIES);
>> +       if (ret == -EAGAIN) {
>> +               port->upcoming_state = INVALID_STATE;
>> +       } else {
>> +               port->sink_cap_done = true;
>> +               goto unlock;
>> +       }
>>
>> Thanks,
>> Badhri
>>
>>
> 

