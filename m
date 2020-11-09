Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8232AC049
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 16:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgKIPyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 10:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIPyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 10:54:45 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E650AC0613CF;
        Mon,  9 Nov 2020 07:54:44 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id x13so7484827pgp.7;
        Mon, 09 Nov 2020 07:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q9So97P5RaD1SfjadwJYSOU81IgJTVhXc7LrS5OO0kw=;
        b=pyXIQ+eZbNQNFBFZyhBj4nw77KGfgHaodRGeO8QBoFZz35RgljQfJ3Da+1q1ys9nD5
         1pIq0sm1uXdllYrmCV5k0tqs1wEHHBPcr4uFMVNbhLxmGaScjOSLz3CAKY8JrkPfiFhB
         ngm2P8ku7lGChu45Of/r6zmxiK2E9knTYJBbcXDzaCRJl71GyoB0FpPJBDc35kIL5Ib1
         xmO3IY1S3M+FsSLXWdI/zdvqXIS5y0ThmpMIRsDXSKp5FLuT2BbZjgbnt6yIYinqjegj
         kA5keV96Q2JznjihtPXLpvCHngHw+gTd9lY4toimmlIAd9d2sP8Iocug90Fs/Be+Lelu
         jgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q9So97P5RaD1SfjadwJYSOU81IgJTVhXc7LrS5OO0kw=;
        b=nLTCd3aTMPUUHhXX2Ndhr72briwnbafGHGiqr8cdTUuYTmftuNDv8EE787CgfXEgpr
         MWGQf00HRR5WziZB8SxeLLXy7EPIAk3nz+C7Wcble7adVBSDoS/njvMmbDLlki1YBl3X
         mqDmdJOzIwvW2ycRVATZJVqMRS07yrifhaDGXCzUCC96ertNV4hvZR7Xi3dtkFVY5/D5
         6TVs39tkPlWzNWh2veyYx+XmTxuJFD/IvYzflpEf5i89NoR13OXCwm+XWXrwXp2V8l6C
         v6PpIIPEBKdVwTMVX3Urcml0ETdXHqM4F2qXYH+L1a8V41yqd4YeGlq2nYrsoC6ql3TT
         vkRA==
X-Gm-Message-State: AOAM533cBXBYAV4IvjKWiInf0bT7xcnYwOvt+PvfNAImU3OUUvjrZ+Sz
        3MySlfmTZK7Kn90oyjNaU1JyUd4C71k=
X-Google-Smtp-Source: ABdhPJzowlUUELs3070Lm7KfkkA0Qpe86xHqwKtTJjqhYoHQcSl+P/DeraukBAiBa6ZJtqNGyqHZHQ==
X-Received: by 2002:a63:2b4f:: with SMTP id r76mr12846174pgr.194.1604937284019;
        Mon, 09 Nov 2020 07:54:44 -0800 (PST)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id l62sm11174922pga.63.2020.11.09.07.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 07:54:42 -0800 (PST)
Subject: Re: [PATCH v2 2/2] ARM: dts: BCM5301X: Linksys EA9500 make use of
 pinctrl
To:     Vivek Unune <npcomplete13@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
 <20201104202952.783724-1-npcomplete13@gmail.com>
 <20201104202952.783724-3-npcomplete13@gmail.com>
 <c0d62a2e-59e2-c811-f5bd-e7299f540ca3@gmail.com>
 <20201104205836.GA783888@ubuntu>
 <CAChtp76diZQfoQXmaFw1ugfYda_rrwAacE3G1mx5j-MmHGtaEw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4c264a8e-5644-f5c9-f5db-2e7b9994022e@gmail.com>
Date:   Mon, 9 Nov 2020 07:54:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <CAChtp76diZQfoQXmaFw1ugfYda_rrwAacE3G1mx5j-MmHGtaEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/2020 5:24 AM, Vivek Unune wrote:
> On Wed, Nov 4, 2020 at 3:58 PM Vivek Unune <npcomplete13@gmail.com> wrote:
>>
>> On Wed, Nov 04, 2020 at 12:37:45PM -0800, Florian Fainelli wrote:
>>>
>>>
>>> On 11/4/2020 12:29 PM, Vivek Unune wrote:
>>>> Now that we have a pin controller, use that instead of manuplating the
>>>> mdio/mdc pins directly. i.e. we no longer require the mdio-mii-mux
>>>
>>> I am a bit confused here as I thought the mux was intended to
>>> dynamically switch the pins in order to support both internal and
>>> external MDIO devices but given the register ranges that were used,
>>> these were actually the pinmux configuration for the MDC and MDIO pins.
>>>
>>> This does not break USB and/or PCIe PHY communication does it?
>>
>> Hi Florian,
>>
>> The external and internal MDIO logic is controlled by mdio-bus-mux.
>> Which controls the BIT(9) of the mdio register. This stays.
>>
>> The removal of mdio-mii-mux and it's replacement with usage of
>> pinctrl doesn't affect USB3 or PCIe. See below USB3 detection.
>>
>> [ 4295.450118] usb 1-1: new high-speed USB device number 2 using ehci-platform
>> [ 4295.690183] usb 4-1: new SuperSpeed Gen 1 USB device number 2 using xhci-hcd
>> [ 4295.721888] usb-storage 4-1:1.0: USB Mass Storage device detected
>> [ 4295.728349] scsi host0: usb-storage 4-1:1.0
>> [ 4296.811047] scsi 0:0:0:0: Direct-Access     SanDisk  Ultra Fit        1.00 PQ: 0 ANSI: 6
>> [ 4296.821159] sd 0:0:0:0: [sda] 60063744 512-byte logical blocks: (30.8 GB/28.6 GiB)
>> [ 4296.829667] sd 0:0:0:0: [sda] Write Protect is off
>> [ 4296.834502] sd 0:0:0:0: [sda] Mode Sense: 43 00 00 00
>> [ 4296.834864] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
>> [ 4296.852604] GPT:Primary header thinks Alt. header is not at the end of the disk.
>> [ 4296.860079] GPT:1540387 != 60063743
>> [ 4296.863586] GPT:Alternate GPT header not at the end of the disk.
>> [ 4296.869600] GPT:1540387 != 60063743
>> [ 4296.873090] GPT: Use GNU Parted to correct GPT errors.
>> [ 4296.878266]  sda: sda1 sda2
>> [ 4296.884416] sd 0:0:0:0: [sda] Attached SCSI removable disk
>>
> 
> Hi Florian,
> 
> Does this clarify your confusion?

It does, thank you for bearing with me, I will apply this later today.
-- 
Florian
