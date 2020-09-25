Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCE9278648
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgIYLvP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Sep 2020 07:51:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35155 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgIYLvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:51:15 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kLmFs-0002v4-Ig
        for linux-kernel@vger.kernel.org; Fri, 25 Sep 2020 11:51:12 +0000
Received: by mail-pf1-f200.google.com with SMTP id s12so1944793pfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5BRkerAIEsczFoqzPwpTd9ZEzsA8kT3a52lgaI3lgaI=;
        b=WwHafgvWDCrHlQnemu8fFZ0ZqGrgH/rKYFm1PiR3qi3tjM5qI3nftBPyH2u7RCJ+2I
         Sj44LDPSvqazj/sLACullgeH20wpHOX9dcUlgMHAf7RKXleTEOSHXBGyYaSMY3/OwxwJ
         b2P2RTTEILuHwwTaCL+uyyZllO+YE/MHETMgjbHGjZqDIEMyI2uP9aqfxDZSE6odBDjr
         KQaDINaAjQtaNpm8yifnAv3za/Eez/dtk3/flYCPtYi1NJPcxNds+fFsrl5iffmYOtJa
         Zkz6PwXZtcIk+ECJlkU13tD/0gOWlz8Vc/vDWc+i4pREX6lfOc2guh1Yg9oJnWOGDlS4
         NSpg==
X-Gm-Message-State: AOAM533IgaziozH4Ttz0W65E/Ib5QyUzfIEmPHQmsUArpoypnLUEliWB
        baSNXLqKH/XWcSvlrlaqbrCs/dkbq3t2clHVsF6GIcvm83N4HDA4POVh5DZzIZmJUkZ8IeWL1Zd
        V/xghwBomSMbPMrAvWZz0LshSxjp5rz3ZziYuqjcOwA==
X-Received: by 2002:a62:3001:0:b029:142:2501:39e3 with SMTP id w1-20020a6230010000b0290142250139e3mr3574288pfw.50.1601034670798;
        Fri, 25 Sep 2020 04:51:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPpS82lcNLbndhVQqetio5q1/5e7ovsnA1ZdIlMT4OZOipe1Yj42p2RePr+Itf158X7qv5dA==
X-Received: by 2002:a62:3001:0:b029:142:2501:39e3 with SMTP id w1-20020a6230010000b0290142250139e3mr3574263pfw.50.1601034670375;
        Fri, 25 Sep 2020 04:51:10 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id q20sm2278991pgm.24.2020.09.25.04.51.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 04:51:09 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Bluetooth: btusb: Avoid unnecessary reset upon system
 resume
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <30ce4ee1eede47c09c3e7f277c26918a@realsil.com.cn>
Date:   Fri, 25 Sep 2020 19:51:06 +0800
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E2E04FDC-C62A-4F8C-A8EF-20868504A2BC@canonical.com>
References: <30ce4ee1eede47c09c3e7f277c26918a@realsil.com.cn>
To:     =?utf-8?B?6ZmG5pyx5Lyf?= <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> On Sep 25, 2020, at 16:23, 陆朱伟 <alex_lu@realsil.com.cn> wrote:
> 
> Hi Kai-Heng,
> 
>> On September 25, 2020 at 15:56, Kai-Heng Feng wrote:
>> 
>> Hi Alex,
>> 
>>> On Sep 25, 2020, at 15:42, 陆朱伟 <alex_lu@realsil.com.cn> wrote:
>>> 
>>> Hi Kai-Heng,
>>> 
>>>> On 25 September 2020 at 15:14, Kai-Heng Feng wrote:
>>>> 
>>>> Hi Alex,
>> 
>> [snipped]
>> 
>>>> Apparently for my case, RTL8821CE, firmware was kept without setting
>>>> remote wakeup.
>>> 
>>> So you got the btusb disconnect and reprobe sequence after resume, and "
>> Bluetooth: hci0: command 0x1001 tx timeout " before firmware downloading ?
>> 
>> USB power wasn't lost, but it got USB warm reset because btusb driver
>> explicitly flagged "reset_resume = 1".
>> Then the issue appeared as "Bluetooth: hci0: command 0x1001 tx timeout",
>> before downloading firmware.
>> 
>>> 
>>>> Is it okay to also set remote wakeup for global suspend to retain the
>>>> firmware?
>>> 
>>> Yes, it's ok.
>> 
>> Abhishek, does setting remote wakeup during global suspend works for you?
> 
> It depends on your desire on power consumption during global suspend.
> The BT controller takes less power if firmware was lost during global suspend.

For my case, the firmware is retained after S3, despite of "reset_resume = 1":

[ 30.164036] ACPI: Waking up from system sleep state S3 
[ 30.167913] ACPI: EC: interrupt unblocked
[ 31.284138] ACPI: EC: event unblocked
...
[   31.467484] usb 1-14: reset full-speed USB device number 3 using xhci_hcd
...
[   32.732934] Bluetooth: hci0: RTL: examining hci_ver=08 hci_rev=826c lmp_ver=08 lmp_subver=a99e
[   32.732937] Bluetooth: hci0: RTL: unknown IC info, lmp subver a99e, hci rev 826c, hci ver 0008
[   32.732937] Bluetooth: hci0: RTL: assuming no firmware upload needed

Kai-Heng

> 
>> 
>>> 
>>>> If firmware was retained, does USB warm reset affect BT controller in
>>>> anyway?
>>> 
>>> USB warm reset shouldn't affect BT controller.
>>> But hci device will not work after resume, because btrtl will find "unknown
>> IC info, lmp subvert ..." and return error when hci device setup is called.
>>> Tips: The lmp subver in controller changes after firmware downloading.
>> And driver will find " unknown IC info, lmp subver  ..." when setup is called
>> with firmware retained.
>> 
>> This should already be fixed by "Bluetooth: btrtl: Restore old logic to assume
>> firmware is already loaded".
>> 
>> Kai-Heng
>> 
>>> 
>>>> 
>>>> Kai-Heng
>>>> 
>>>>> 
>>>>>> 
>>>>>> Kai-Heng
>>>>>> 
>>>>>>> 
>>>>>>> @Alex -- What is the common behavior for Realtek controllers?
>> Should
>>>>>>> we set BTUSB_WAKEUP_DISABLE only on RTL8822CE or should we
>> unset
>>>> it
>>>>>>> only on RTL8821CE?
>>>>>>> 
>>>>>>>>> 
>>>>>>>>> I would prefer this doesn't get accepted in its current state.
>>>>>>>> 
>>>>>>>> Of course.
>>>>>>>> I think we need to find the root cause for your case before applying
>> this
>>>>>> one.
>>>>>>>> 
>>>>>>>> Kai-Heng
>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> Abhishek
>>>>>>>>> 
>>>>>>>>> On Wed, Sep 23, 2020 at 10:56 AM Kai-Heng Feng
>>>>>>>>> <kai.heng.feng@canonical.com> wrote:
>>>>>>>>>> 
>>>>>>>>>> Realtek bluetooth controller may fail to work after system sleep:
>>>>>>>>>> [ 1272.707670] Bluetooth: hci0: command 0x1001 tx timeout
>>>>>>>>>> [ 1280.835712] Bluetooth: hci0: RTL:
>> HCI_OP_READ_LOCAL_VERSION
>>>>>> failed (-110)
>>>>>>>>>> 
>>>>>>>>>> If platform firmware doesn't cut power off during suspend, the
>>>>>> firmware
>>>>>>>>>> is considered retained in controller but the driver is still asking USB
>>>>>>>>>> core to perform a reset-resume. This can make bluetooth
>> controller
>>>>>>>>>> unusable.
>>>>>>>>>> 
>>>>>>>>>> So avoid unnecessary reset to resolve the issue.
>>>>>>>>>> 
>>>>>>>>>> For devices that really lose power during suspend, USB core will
>>>> detect
>>>>>>>>>> and handle reset-resume correctly.
>>>>>>>>>> 
>>>>>>>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>>>>>>> ---
>>>>>>>>>> drivers/bluetooth/btusb.c | 8 +++-----
>>>>>>>>>> 1 file changed, 3 insertions(+), 5 deletions(-)
>>>>>>>>>> 
>>>>>>>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>>>>>>>> index 8d2608ddfd08..de86ef4388f9 100644
>>>>>>>>>> --- a/drivers/bluetooth/btusb.c
>>>>>>>>>> +++ b/drivers/bluetooth/btusb.c
>>>>>>>>>> @@ -4255,17 +4255,15 @@ static int btusb_suspend(struct
>>>>>> usb_interface *intf, pm_message_t message)
>>>>>>>>>>            enable_irq(data->oob_wake_irq);
>>>>>>>>>>    }
>>>>>>>>>> 
>>>>>>>>>> -       /* For global suspend, Realtek devices lose the loaded fw
>>>>>>>>>> -        * in them. But for autosuspend, firmware should remain.
>>>>>>>>>> -        * Actually, it depends on whether the usb host sends
>>>>>>>>>> +       /* For global suspend, Realtek devices lose the loaded fw in
>>>> them
>>>>>> if
>>>>>>>>>> +        * platform firmware cut power off. But for autosuspend,
>>>>>> firmware
>>>>>>>>>> +        * should remain.  Actually, it depends on whether the usb
>> host
>>>>>> sends
>>>>>>>>>>     * set feature (enable wakeup) or not.
>>>>>>>>>>     */
>>>>>>>>>>    if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags)) {
>>>>>>>>>>            if (PMSG_IS_AUTO(message) &&
>>>>>>>>>>                device_can_wakeup(&data->udev->dev))
>>>>>>>>>>                    data->udev->do_remote_wakeup = 1;
>>>>>>>>>> -               else if (!PMSG_IS_AUTO(message))
>>>>>>>>>> -                       data->udev->reset_resume = 1;
>>>>>>>>>>    }
>>>>>>>>>> 
>>>>>>>>>>    return 0;
>>>>>>>>>> --
>>>>>>>>>> 2.17.1
>>>>>> 
>>>>>> 
>>>>>> ------Please consider the environment before printing this e-mail.
> 

