Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B2E2C845C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgK3Mvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:51:44 -0500
Received: from meesny.iki.fi ([195.140.195.201]:32978 "EHLO meesny.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgK3Mvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:51:43 -0500
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Nov 2020 07:51:42 EST
Received: from [10.32.112.20] (unknown [85.134.33.118])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tmb)
        by meesny.iki.fi (Postfix) with ESMTPSA id F3C9420591;
        Mon, 30 Nov 2020 14:43:43 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1606740224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ygPwP4/rNEuq2KAYSzF2xm3mKQmUAmbfyutUI0CJeMA=;
        b=PvY4CA8WUgu44YYGVhAc5d+v+dIHVbU86c/IzUKXhmrL4h/ohqeSPtENa7XHdBNyiUDT7R
        /r7fS9BTy+x6DvJD8jYTlIOzaPcz0d9GJXcPDAJfSdS2CSCVtewQ428M1VzYBZxplp/AcU
        rdDTO/iK6oWpOpeT5A5IBVRLn9RgezQ=
Subject: Re: [PATCH] hwmon: corsair-psu: update supported devices
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Jonas Malaco <jonas@protocubo.io>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
References: <X7+T4aZSUuzfsf7H@monster.powergraphx.local>
 <CANS_-EN8rgFEyE5rDw3=JLUYNwLQexafn7efvMC_=+4s2h1R6Q@mail.gmail.com>
 <20201128113524.24f4f56f@monster.powergraphx.local>
From:   Thomas Backlund <tmb@iki.fi>
Message-ID: <4917cc59-aa35-7fb1-d2d0-75039523816f@iki.fi>
Date:   Mon, 30 Nov 2020 14:43:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201128113524.24f4f56f@monster.powergraphx.local>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: sv
Content-Transfer-Encoding: 7bit
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1606740224; a=rsa-sha256; cv=none;
        b=LZ+52FewLvVovFhaQcAVumsyO1OjiZLNzpKXuIBHddXB6jyIUtin7v0GA8PE/EdepRSZLk
        y2yKNC4jrn9MudLkksGdxPAv0UzyclGBmjkkdkomWwDbEMgVuhlxQvoFsCkgqDTnEsXm2W
        NNPQXZwJf9xw1u6IgWICf77Qlxc6ZtE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1606740224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ygPwP4/rNEuq2KAYSzF2xm3mKQmUAmbfyutUI0CJeMA=;
        b=lOKYTuVHUkmvGcfVj2LLxTmSa1180v59NllGuNmC+IVr1uutzw65vAmDGge60m0WyJrksD
        ixbr1yLwwkA4ybUehm9fpMchj8YfaP7+tglV/YqhujizkDF20TwQdWFYTBSmVJG+V9HKW6
        tDdYnggSAnQ/5j4eKAZVpL5Sb0Cz4oU=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=tmb smtp.mailfrom=tmb@iki.fi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den 28.11.2020 kl. 12:35, skrev Wilken Gottwalt:
> On Sat, 28 Nov 2020 02:37:38 -0300
> Jonas Malaco <jonas@protocubo.io> wrote:
> 
>> On Thu, Nov 26, 2020 at 8:43 AM Wilken Gottwalt
>> <wilken.gottwalt@posteo.net> wrote:
>>>
>>> Adds support for another Corsair PSUs series: AX760i, AX860i, AX1200i,
>>> AX1500i and AX1600i. The first 3 power supplies are supported through
>>> the Corsair Link USB Dongle which is some kind of USB/Serial/TTL
>>> converter especially made for the COM ports of these power supplies.
>>> There are 3 known revisions of these adapters. The AX1500i power supply
>>> has revision 3 built into the case and AX1600i is the only one in that
>>> series, which has an unique usb hid id like the RM/RX series.
>>
>> Can I ask what AXi power supplies were tested?
>>
>> I ask because, based on the user-space implementations I am aware of,
>> the AXi dongle protocol appears to be different from the RMi/HXi series.
> 
> I was not able to test this against the AX power supplies, they are really
> hard to find (and are far to expensive). But I went through all these tools
> and stuck to the most common commands, which all 3 series support. Not every
> series supports all commands (there also seem to be different firmwares in
> the micro-conrollers). But this is fine, some sensors will show up as N/A.
> Even my HX850i does not support all commands covered in this driver.
> 

What kind of tests do you want / need ?

I have an AX860i here.

--
Regards

Thomas Backlund

