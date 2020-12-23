Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D62A2E1D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 15:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgLWO0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 09:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgLWO0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:26:37 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC82C0613D6;
        Wed, 23 Dec 2020 06:25:56 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id j20so15118068otq.5;
        Wed, 23 Dec 2020 06:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fEcnt/Un2EDi62ILI861Z5k4Fp15xzDNHdZFR8+dXbk=;
        b=dZy4uq5yyb9nyk7421cPRWw9v/ZJRvPvM9w7jjpe03/eWZbbyMHZuRJYOpi611j7DB
         iCWexdJ9cH01hKyJihRzxd6AqK1n5ojyLOAB+YmR+8+khEWumpbRoah/Dq3nnNhwkA6k
         WUSCbPKOarGthVWuOF/kHGQpsTuR61xwNwdvl7YQ1QHZb5UFXvBy7EqOWD7779iUJqpT
         NWEcilnUDK+IvOULh3ejPYqLTXcpmp7GyF0MxOx0hHLddSOn0w7uk7MKdejfHjzFMbDG
         U8m4q0zX65x6aRf8p/N474lMmK5f9RrKSIXRnrEO+GxOy2znufNMRnx8HUOFjZt6Mddh
         1oQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fEcnt/Un2EDi62ILI861Z5k4Fp15xzDNHdZFR8+dXbk=;
        b=RwnLvU80oQx8btcH3FE6DwW3w/d/WtICrDDpL0AVucoT6Auh2Gp0i3w3QuRO0/2cuV
         CoNw5fXA35T86lrDvB2TFybKQxVvngg67JDcvjsemjkT1tFVdW85zyDZDVva4OlDxCGe
         5fCzGxGFkltzt5XlzhKhzM1xTZT9YibOc6XKJDrsK0WQJYOI5kHi7dYQWmSfObF8c+04
         P3GCrvL9WeG2E09xdpxK+FgPjI3K/07R9CzqP4tsf7Mh/VG+nz7wFgSKAsrR/QF5tRfl
         TcbYQ+1bqjtrZZRZ1L/sTpgyQ/sQu8rfDQpCycbMda+nZGAlRV9P4eJ5s6d4W7npp7p1
         Zh1Q==
X-Gm-Message-State: AOAM530jexBjw2v98kU8CbNn6gBqJ6Z+HOD/5DQZA0XrmI0byaLVBBGg
        WfhR3kstlEMCRNlNT4Susog=
X-Google-Smtp-Source: ABdhPJxlA5wuYcZjYORVFqH6bp5FJM+yD3Kg0QbqoMkMIZeiP93dRyCko/uTBITrsES2ALEaOAJmkg==
X-Received: by 2002:a05:6830:717:: with SMTP id y23mr20147339ots.268.1608733556307;
        Wed, 23 Dec 2020 06:25:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 8sm5564387otq.18.2020.12.23.06.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 06:25:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: k10temp: ZEN3 readings are broken
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Gabriel C <nix.or.die@googlemail.com>, linux-hwmon@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Wei Huang <wei.huang2@amd.com>
References: <CAEJqkgiiU7miC13iT6DufjFAsHkNZk6rBAw=KRRnHe47kTZDnw@mail.gmail.com>
 <9d621d34-e5ce-301a-1b89-92c0791fe348@roeck-us.net>
 <4483r6o2-245o-147-s71r-s64ss3nqr8ps@vanv.qr>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <a259d4da-e66b-30c0-f3de-f32f31ae148e@roeck-us.net>
Date:   Wed, 23 Dec 2020 06:25:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4483r6o2-245o-147-s71r-s64ss3nqr8ps@vanv.qr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/20 2:41 AM, Jan Engelhardt wrote:
> 
> On Tuesday 2020-12-22 04:58, Guenter Roeck wrote:
>> On 12/21/20 5:45 PM, Gabriel C wrote:
>>> Hello Guenter,
>>>
>>> while trying to add ZEN3 support for zenpower out of tree modules, I find out
>>> the in-kernel k10temp driver is broken with ZEN3 ( and partially ZEN2 even ).
>>
>> [...] since I do not have time to actively maintain
>> the driver, since each chip variant seems to use different addresses and scales,
>> and since the information about voltages and currents is unpublished by AMD,
>> I'll remove support for voltage/current readings from the upstream driver.
> 
> I support that decision.
> 
> /proc/cpuinfo::AMD Ryzen 7 3700X 8-Core Processor, fam 23 model 113 step 0
> 
> A synthetic load (perl -e '1 while 1') x 16 shows:
> Adapter: PCI adapter
> Vcore:        +1.28 V
> Vsoc:         +1.02 V
> Tctl:         +94.8°C
> Tdie:         +94.8°C
> Tccd1:        +94.8°C
> Icore:       +76.00 A
> Isoc:         +6.75 A
> 
> A BOINC workload on average:
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:        +1.17 V  
> Vsoc:         +1.02 V  
> Tctl:         +94.9°C  
> Tdie:         +94.9°C  
> Tccd1:        +95.0°C  
> Icore:       +88.00 A  
> Isoc:         +8.00 A  
> 
> The BOINC workload, when it momentarily spikes:
> Adapter: PCI adapter
> Vcore:        +1.32 V  
> Vsoc:         +1.02 V  
> Tctl:         +94.1°C  
> Tdie:         +94.1°C  
> Tccd1:        +96.0°C  
> Icore:       +105.00 A  
> Isoc:         +7.75 A  
> 
> For a processor sold as a 65 W part, observing reported sensors as 
> 88 A x 1.17 V + 8 A x 1.02 V = 111.12 W just can't be. We are off by a 
> factor of about 2.
> 

Currents were always supposed to be unscaled. So this post is again
proving my point.

Either case, the code removing voltage and current support is now upstream.

Guenter
