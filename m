Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16A2F32AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbhALOKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbhALOKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:10:12 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEF0C061786;
        Tue, 12 Jan 2021 06:09:32 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id d189so2401981oig.11;
        Tue, 12 Jan 2021 06:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OeKweST8lxunWd5nJjqzuoPLNHXlVRG7GZzmbSxYm9A=;
        b=I3ZNk06jxUCvuEIXgoNelrfGPFRx/sy5wRprBg/inuCZgBeCURnmhK7P8mMyLn0YBl
         8WGG8wn0UMI+RXYTLHU4h+HjfQJ9y1Hv7CTBeLARFp2BN+QNVQfJXTP3a65VlSLbCoo9
         A533MfjchwFQUHDtpF871EW7tNk4erB2WZsbbNy/IlXvYm/EHJHlqQx4DJyGM8DQrtob
         bobRq/HfbujSayXgDHg1AIU1mioTkgP32GPaIhHMu1YasIh6/HPxhQBcsmdDdAUQws+x
         U0To0qcOUy4K4v2c9bfipU+b7LZL2zM9PV4fE707JP14Ho+srP5vGl0eQ6CiKSibvyRI
         7ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OeKweST8lxunWd5nJjqzuoPLNHXlVRG7GZzmbSxYm9A=;
        b=L3kMFaUFLFoHbBP5ZGR9pjqokfuLmtj7piNXdr463UlqWYOdI3925f485du9jX6P3c
         CWO/3eMj15darr0Sd9XhzLl6TEXRC7pHclIs2tjcwoQmWcWtyPZLuRE8fN8vXrmDXUxo
         bMTLYOhKbippsceRY/GzvM3bsoKkHeWeudXDGzJPSgnuif3+zrAvxW8NltdAdHKfgfES
         onb1J97fiFno5MSMvEwxZxp+FsDzobsyKurS7NdQdBZdlkKlU4jsoC9V93SYaRJKim4o
         nxExjNjjys+MEhUeJziQkxkJBJWob9gaZWAIheRHCo8vAwqyAJ8lKHKXYur5HZh8nn0F
         XrdA==
X-Gm-Message-State: AOAM530eylFVQvROCn/9B03d0kFXaNk5h3jwRx/x0tUiFdvMJ1htzmJt
        P+pSVfOGNgr797x7orm+B3mPD7LPrek=
X-Google-Smtp-Source: ABdhPJy0wjNrtTkdRDm+NBLo/bxnc1hGkrduvLgGA7V8+PsIF+exvIciChF/HXz1CnK+J/8mufa1Bw==
X-Received: by 2002:aca:7544:: with SMTP id q65mr2450436oic.51.1610460571060;
        Tue, 12 Jan 2021 06:09:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s23sm636455otr.59.2021.01.12.06.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 06:09:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v5 0/3] AMS, Collision Avoidance, and Protocol Error
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Kyle Tso <kyletso@google.com>, hdegoede@redhat.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210105163927.1376770-1-kyletso@google.com>
 <X/2N1LAgNRCSkWrw@kroah.com> <20210112115913.GB2020859@kuha.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <0fb8c97e-e071-0fd2-c235-8b9609604a9e@roeck-us.net>
Date:   Tue, 12 Jan 2021 06:09:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210112115913.GB2020859@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/21 3:59 AM, Heikki Krogerus wrote:
> On Tue, Jan 12, 2021 at 12:53:56PM +0100, Greg KH wrote:
>> On Wed, Jan 06, 2021 at 12:39:24AM +0800, Kyle Tso wrote:
>>> This series include previous patch "[v4] AMS and Collision Avoidance"
>>> https://lore.kernel.org/r/20201217030632.903718-1-kyletso@google.com
>>> and two more patches "Protocol Error handling" and "Respond Wait if...".
>>>
>>> The patch "AMS and Collision Avoidance" in [v5] is the same as the one
>>> in [v4] (only rebased to ToT).
>>>
>>> The patch "Protocol Error handling" is based on PD3 6.8.1 to fix the
>>> wrong handling.
>>>
>>> The patch "Respond Wait if..." is to fix a conflict when 
>>> DR/PR/VCONN_SWAP occurs just after the state machine enters Ready State.
>>>
>>> Kyle Tso (3):
>>>   usb: typec: tcpm: AMS and Collision Avoidance
>>>   usb: typec: tcpm: Protocol Error handling
>>>   usb: typec: tcpm: Respond Wait if VDM state machine is running
>>>
>>>  drivers/usb/typec/tcpm/tcpm.c | 925 +++++++++++++++++++++++++++++-----
>>>  include/linux/usb/pd.h        |   2 +
>>>  include/linux/usb/tcpm.h      |   4 +
>>>  3 files changed, 792 insertions(+), 139 deletions(-)
>>
>> Heikki, any thoughts about this series?
> 
> Sorry, I did yet go over these yet. I'll review them now.
> 
> Guenter, have you had time to take a look at these?
> 

Not yet. I have been been buried lately :-(

Guenter
