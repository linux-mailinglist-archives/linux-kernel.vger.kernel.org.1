Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046902F2E85
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbhALL7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:59:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727952AbhALL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610452652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DC7rR7ULlVE2IO8fZp2tkCjKsJ3W2x6CKkTH1E9AjlQ=;
        b=RmehnfTAIdfYlH0fVgSRznNCrZbeINRbHWn97XulkBtyageRpDAhu1x2WQ+3KndChPwFln
        LAf/Jkl7WLxkrOzgrWCrwv0z4vRqgQ9JtUbCU28dWWKG72+hzHn6AdDAbtybbOjnGRM7Wh
        lBMDqPoNgjfLkx3clJokUMp8yFXbwcg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-MTsgNmK3PxiMiuOh4vcWEA-1; Tue, 12 Jan 2021 06:57:31 -0500
X-MC-Unique: MTsgNmK3PxiMiuOh4vcWEA-1
Received: by mail-ed1-f69.google.com with SMTP id u17so888099edi.18
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DC7rR7ULlVE2IO8fZp2tkCjKsJ3W2x6CKkTH1E9AjlQ=;
        b=jkowLXmmDeAlAJ8XJR6gJN6kJ/PACtt74Qah+iMWsKNmN5/+z7/GKsrWMzKCoOrA+R
         y7smwQ66kf5tc5Z2mmPAg4v83moga8vU+M2TVAoRyQ2N9zVszTrFaZofhZVR/c1CWyn4
         Z8TIsthDXRazCWK5XUEbZ5nPNgfgk8QrDBtiRnfIFCvvh2GKMbZFeG4QkZ5eduD1q+wG
         n7ghDl1xe80+A7kiK4mgVJD8NxPUK4UEzLHHc1/ngd+bKVxPij8/P5UG7XAlsKsf+b51
         6yxzfctIAeucoiV4CadXA7OpJ87RRWRhgqamMMdsSwmkwN9ZvjVPr6t1t4YDNSB/i63e
         MSaw==
X-Gm-Message-State: AOAM531w6uITsJQji2oLnmj5TQ03M7WZNfEAVX7UvAIb4qfdRK2nPRLM
        gYHpyCqKMW3sZB+Ga84dMu/PzEb9mvS5j5XDNUizPuw1vZRtJkcnLRbqvP9Nh2Qk/yAOwbqKd4B
        BnsBmqzvAyRJDisNg3aBwVR8+gWK6yrvXYifjUAg8KBJCzURw08UCug9OnrTdsujZFsTIqewEew
        o5
X-Received: by 2002:a50:d604:: with SMTP id x4mr3153361edi.64.1610452649936;
        Tue, 12 Jan 2021 03:57:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/vv5m6LzNOBm0g6qucAIqUBD0DMvj0NuDY0CmxfuDDkCQIB0LUg0uBMpJV4FbvioJyBF2tw==
X-Received: by 2002:a50:d604:: with SMTP id x4mr3153340edi.64.1610452649764;
        Tue, 12 Jan 2021 03:57:29 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id d18sm1357725edz.14.2021.01.12.03.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 03:57:29 -0800 (PST)
Subject: Re: [PATCH v5 0/3] AMS, Collision Avoidance, and Protocol Error
To:     Greg KH <gregkh@linuxfoundation.org>, Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210105163927.1376770-1-kyletso@google.com>
 <X/2N1LAgNRCSkWrw@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bfb36421-ec4a-9ea6-585c-798f626e069b@redhat.com>
Date:   Tue, 12 Jan 2021 12:57:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X/2N1LAgNRCSkWrw@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/12/21 12:53 PM, Greg KH wrote:
> On Wed, Jan 06, 2021 at 12:39:24AM +0800, Kyle Tso wrote:
>> This series include previous patch "[v4] AMS and Collision Avoidance"
>> https://lore.kernel.org/r/20201217030632.903718-1-kyletso@google.com
>> and two more patches "Protocol Error handling" and "Respond Wait if...".
>>
>> The patch "AMS and Collision Avoidance" in [v5] is the same as the one
>> in [v4] (only rebased to ToT).
>>
>> The patch "Protocol Error handling" is based on PD3 6.8.1 to fix the
>> wrong handling.
>>
>> The patch "Respond Wait if..." is to fix a conflict when 
>> DR/PR/VCONN_SWAP occurs just after the state machine enters Ready State.
>>
>> Kyle Tso (3):
>>   usb: typec: tcpm: AMS and Collision Avoidance
>>   usb: typec: tcpm: Protocol Error handling
>>   usb: typec: tcpm: Respond Wait if VDM state machine is running
>>
>>  drivers/usb/typec/tcpm/tcpm.c | 925 +++++++++++++++++++++++++++++-----
>>  include/linux/usb/pd.h        |   2 +
>>  include/linux/usb/tcpm.h      |   4 +
>>  3 files changed, 792 insertions(+), 139 deletions(-)
> 
> Heikki, any thoughts about this series?

Note I plan to test this series on a device with a fusb302 Type-C
controller, where it broke role-swappings in a previous version of
this series. This is supposed to be fixed now but I would like to
confirm this.

I've had this on my todo list for a while now. I've
now put this in my calendar as a task for tomorrow. So please wait
till you hear back from me (hopefully with a Tested-by) with
merging this, thanks.

Regards,

Hans

