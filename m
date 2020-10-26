Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30C8299124
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784019AbgJZPgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1783972AbgJZPgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603726578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4T8J9h8aHDWVKUpT3UKKBDgLYCTKNVpvy5H15xGKCd0=;
        b=ImZQLNz6+xCVSx0n+riRa+PQUkmnHxPu3MxofY/9K9tmozIMRx8VRBkyx+KQce6qjZpGxs
        5IYOwP9sWhrTg8ibHv2QA5bAnUfjrp4SUNzTyFeOWGKH5pCLn6QHni9Yl32WeGZ73iE+GN
        UMpfnePiN7XQKIfIin1iVcYhVIcO7PI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-Pwr4L6NJOg2jbONSADGgNQ-1; Mon, 26 Oct 2020 11:36:16 -0400
X-MC-Unique: Pwr4L6NJOg2jbONSADGgNQ-1
Received: by mail-ed1-f70.google.com with SMTP id be19so4547577edb.22
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 08:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4T8J9h8aHDWVKUpT3UKKBDgLYCTKNVpvy5H15xGKCd0=;
        b=pNg/W5m9qqD/qMwnEtaZaCNnVYGQj0/cvh9QT3pQaZKAw/PfHn/8dTYFME/BE4vLn0
         U+OdJ7M+v3MQ10/CIr3yx5XSCm+VjWGVLpEjWsFX8M+V9FA3HPaIzSCpFn8TCB3Gcnfy
         fH/jo2kUehxRj1ZaUIM3ZvIQlaV4pw6lJOYtcscR5RXWnm1HcqPh3TBRIGHw0XMqkxzH
         Cs7AnBF/aT/ZuF1V2KeGqUFBHLZ3AqVzI2xaon/Fneuinjx6LZlTG+adWH5a5nqztJlt
         rF6UaLzhIjRTIemooYTNLnkK2m6EIPF2rqSTW7E0D2WF8BCPl4LsrEuH6Ywr6oXkfy3O
         Rk2Q==
X-Gm-Message-State: AOAM531bqF7tttraxjS1IOliRX15sCDAT/VziOlAgh6gd+VQY0/wYuDK
        9IPlivwrXVPhqx0cbXNkm24AZDXOIymgTUeQ7HdcqwHH9U/+C9io2Eu+tqbsQz8JKy+qwaXtAHn
        h2EphwobwPwgjIocCvycqavks
X-Received: by 2002:a05:6402:1615:: with SMTP id f21mr16888468edv.257.1603726575232;
        Mon, 26 Oct 2020 08:36:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRiV17XlEk9Alol3IXbaQKVZJaHSEnTXtXAKR+AVqFgAOQj00dGvz+dxPWGkm6yB+z64/rRA==
X-Received: by 2002:a05:6402:1615:: with SMTP id f21mr16888443edv.257.1603726575039;
        Mon, 26 Oct 2020 08:36:15 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id rl1sm6136899ejb.36.2020.10.26.08.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 08:36:14 -0700 (PDT)
Subject: Re: [PATCH v6] Introduce support for Systems Management Driver over
 WMI for Dell Systems
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
References: <20201006082618.209287-1-divya.bharathi@dell.com>
 <101db8e3-70f0-4e85-b4b9-008995939b1a@redhat.com>
 <DM6PR19MB2636A7CAF82D8CB7DEEF7B2DFA190@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4e415aea-d855-e8a5-0b61-785b67efeb59@redhat.com>
Date:   Mon, 26 Oct 2020 16:36:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB2636A7CAF82D8CB7DEEF7B2DFA190@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/26/20 4:25 PM, Limonciello, Mario wrote:
>>> +
>>> +	print_hex_dump_bytes("set attribute data: ", DUMP_PREFIX_NONE, buffer,
>> buffer_size);
>>
>> This seems to be a debugging left-over?
> 
> Yes it was for debugging, but its configurable to turn on by dynamic
> debug as I can tell.  Is that not correct?

Since it does not have debug in its name I sorta assumed it would
always do the print. But you are right, this is a shorthand macro
for print_hex_dump_debug() (which takes a few more arguments), so
this only dumps the buffer when debugging is enabled.

IOW keeping this "as is" is fine, sorry for the noise.

Regards,

Has

