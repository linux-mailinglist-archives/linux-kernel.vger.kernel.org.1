Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D1E2C01A5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 09:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgKWIqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 03:46:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49966 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727874AbgKWIqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 03:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606121168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jYMiKkTGrMYQ2NetJ3YPrn1xVtPypbL8WrDyKHTMzOs=;
        b=IoHkrwUt/lSVqsfW11vdDCxj8HvLnJCFta122mfB8fBtmYKm8n0Bu4K46pOpmXDHDT2n2G
        1eE7Pg+jZ58PLsP9RKdHOuxrl4/kt/TfK75bN8B/J+howYl74e5NrD0VRfo+UShrsgqaIT
        qsZ6l7NhFJIhJmWmbaD/90FcWnAs8I0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-0UAr7mYON8S7z-T0nCn91g-1; Mon, 23 Nov 2020 03:46:06 -0500
X-MC-Unique: 0UAr7mYON8S7z-T0nCn91g-1
Received: by mail-ej1-f72.google.com with SMTP id f21so5353730ejf.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 00:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jYMiKkTGrMYQ2NetJ3YPrn1xVtPypbL8WrDyKHTMzOs=;
        b=KOFHe+Ph1DKnOXJo8UV1z7ZXfeM0BgsrC9FW/72tYog8ln53mPG05vUYwCLo0A6Hhd
         bLAfe/V8or1zFulcoKCg6ywzo1vAv/4v0R6P29v9HamnHwEMsfiCtueSdk9PMpe/zTYD
         ePve3Mp495H7+uXlf35u7GoVhvDhaRJWTzWbAVZnYKlHioUrPgIGXEZevNPiUYnL/qp4
         saymf3PJ3Tluy8gTnVVBc8MOa1EF1ZCwrnXYiH5BBWP67OCvMnBGDd8T9DwM3QRkeTU2
         4rCDF/+03+N484SsmULlhq2WrjXzYYZnOhLdQnsJX+lSPY9AmVgPPmFMfzoP/QLB9pWL
         qkwQ==
X-Gm-Message-State: AOAM530pdlA6y2ShW2msU/XMuAjDunTkDaAD6vt2MDl5GnLmiuxQ9ml7
        bd5mdS5BVGRGUoOy67ot66Zz0yAPDD1DNXtuJ9iFHsOXXxeiVRTpCT/GaANf1aCyrgcn05kyseb
        i2bJQAdJ5ICTXL/rlq4XjjRIP
X-Received: by 2002:a05:6402:1a22:: with SMTP id be2mr24532768edb.102.1606121165436;
        Mon, 23 Nov 2020 00:46:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHAlytM8HZAuIe1TFTLq5EO2Yi955/QctUdn81v7hrbJNCLA84nh49UlvJcnxIviSNRiTGPw==
X-Received: by 2002:a05:6402:1a22:: with SMTP id be2mr24532760edb.102.1606121165221;
        Mon, 23 Nov 2020 00:46:05 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id j9sm4519025ejf.105.2020.11.23.00.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 00:46:04 -0800 (PST)
Subject: Re: [PATCH 1/3] Input: goodix - add option to disable firmware
 loading
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andrej Valek <andrej.valek@siemens.com>, nick@shmanahar.org,
        hadess@hadess.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20201029170313.25529-1-andrej.valek@siemens.com>
 <20201029170313.25529-2-andrej.valek@siemens.com>
 <20201029203608.GE2547185@dtor-ws>
 <a5964429-a472-6b78-e53c-69b4cb115b94@redhat.com>
 <20201123065336.GC2034289@dtor-ws>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <07a7e9e2-0c82-fdc0-2db0-5011b94816e2@redhat.com>
Date:   Mon, 23 Nov 2020 09:46:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201123065336.GC2034289@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/23/20 7:53 AM, Dmitry Torokhov wrote:
> On Fri, Oct 30, 2020 at 10:56:20AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 10/29/20 9:36 PM, Dmitry Torokhov wrote:
>>> Hi Andrej,
>>>
>>> On Thu, Oct 29, 2020 at 06:03:11PM +0100, Andrej Valek wrote:
>>>> Firmware file loadind for GT911 controller takes too much time (~60s).
>>>> There is no check that configuration is the same which is already present.
>>>> This happens always during boot, which makes touchscreen unusable.
>>>>
>>>> Add there an option to prevent firmware file loading, but keep it enabled
>>>> by default.
>>>
>>> I thought that Goodix was losing firmware loading at poweroff. Is this
>>> not the case with this model?
>>
>> So first of all there are 2 sorts of firmware involved with the
>> Goodix touchscreen controllers, the actual firmware and a block
>> of config data for that firmware which I presume adjusts it for
>> the specific (model of) the digitizer which is attached.
>>
>> ATM the mainline Linux driver does not support models where
>> the actual firmware itself needs to be loaded (because they
>> only have RAM, so they come up without firmware).
>>
>> I do have one model tablet with a ROM-less goodix touchpad
>> controller, so if I ever find the time I might add support
>> for loading the actual firmware.
>>
>> So what we are talking about here is just loading the config
>> data and I'm a bit surprised that this take so long.
> 
> So I am still confused about this: is the config stored in RAM or NVRAM?
> I.e. do we actually need to re-load it every time on boot, or it
> supposed to be flashed only when it is changed (or lost)?

I only know about these touchscreens on x86, where we have a BIOS
muddling the waters.

We have seen devices which loose the config over suspend/resume,
which suggests it is in RAM. I recently added a fix for these which
saves the config at boot, which suggests that at least on the device
model with the suspend/resume issue the config is loaded into the chip
by the BIOS.

But I'm not sure that this is the case everywhere. Most other models
likely have the config in NVRAM.

I guess this is the same as with the firmware, and it differs per
model. I know for sure that their are RAM only models which need
the firmware loaded at boot, these are mostly found on ARM devs,
but I have one X86 devices (which currently does not work) which
also has RAM only and thus needs Linux to load the firmware
(which is not supported atm). These RAM only models, presumably
also have only RAM for the config.

Regards,

Hans

