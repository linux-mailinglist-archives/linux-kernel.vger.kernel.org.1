Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B779227802E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgIYGDp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Sep 2020 02:03:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53656 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgIYGDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:03:44 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kLgpZ-0005ln-H8
        for linux-kernel@vger.kernel.org; Fri, 25 Sep 2020 06:03:41 +0000
Received: by mail-pf1-f197.google.com with SMTP id 135so1308022pfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 23:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1yvwZFftP3xTcobSpqJkVCGIkCDtLpkz77Q75FFnu3Y=;
        b=g+m/P5OUfQ0EqQY5pctpuR26CnEr762M5z2BXiGAFoHw1S9V/vePY6otbIapmHqbAb
         hLrbts9lW713g2ymME2ooYmP28TK0cHLY4Njr0lLrXlBlllltZMSJx2/2Eq06AEtXafL
         ZMj0pgDou0wpmDU2JZJ+5uYc9+UWY1S++VhPyyoAD+UFHygXDwpX5jBkKgi0mHG7NhpD
         PTgltDQCJhDSl5dgee6q26dgvw0aImrl6DkR2N/fuGdDtR0EC0HIsvSZqNTz1BIe3vE+
         Lq/H/w7EKNXKMSdAnYcwJw3eJ1Hpil4Od5Bn8JkBFniJbiNQjcTFfm5+/FjKKl6e2x47
         Fexw==
X-Gm-Message-State: AOAM533mZrEGe82B9hHU3EKMPdpiSmAHcGhrrd8YSsCURn+B67DPxK2R
        oP+4rptaGRqyQKE0KgY2CaZLyJx/R0hEzDmUN/ihWrt1sCaN1U32pvzRB5PG5Fs/Kv+YRg/A8He
        Lbi2j45lzPyvlcunWlYPE+RKaFrA1ipWMdzO6E/QYuQ==
X-Received: by 2002:a17:90a:bd8b:: with SMTP id z11mr1252548pjr.2.1601013819768;
        Thu, 24 Sep 2020 23:03:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0eE+7B6RPzAMojOVsY1JICA+CjPuJqwRSCmBlDjFS5gUnDiI2EvpjiLEGxEyGWcGQTy+y9A==
X-Received: by 2002:a17:90a:bd8b:: with SMTP id z11mr1252502pjr.2.1601013819085;
        Thu, 24 Sep 2020 23:03:39 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id a9sm938208pjm.40.2020.09.24.23.03.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 23:03:38 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Bluetooth: btusb: Avoid unnecessary reset upon system
 resume
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CANFp7mVJZTizHJDss5BJmdm5ydrfrVy4sBhXRX4vLBmK2sRGSA@mail.gmail.com>
Date:   Fri, 25 Sep 2020 14:03:34 +0800
Cc:     Alex Lu <alex_lu@realsil.com.cn>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C9D4A438-0CF8-42A2-8B9D-F5EF117AEF9B@canonical.com>
References: <20200923175602.9523-1-kai.heng.feng@canonical.com>
 <CANFp7mV7fC9_EZHd7B0Cu-owgCVdA6CNd2bb7XwFf5+6b7FVpg@mail.gmail.com>
 <A6F728DB-A07B-4323-83A5-3DABA8FDC156@canonical.com>
 <CANFp7mVJZTizHJDss5BJmdm5ydrfrVy4sBhXRX4vLBmK2sRGSA@mail.gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,
> On Sep 25, 2020, at 11:33, Abhishek Pandit-Subedi <abhishekpandit@chromium.org> wrote:
> 
> + Alex Lu (who contributed the original change)
> 
> Hi Kai-Heng,
> 
> 
> On Thu, Sep 24, 2020 at 12:10 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> [+Cc linux-usb]
>> 
>> Hi Abhishek,
>> 
>>> On Sep 24, 2020, at 04:41, Abhishek Pandit-Subedi <abhishekpandit@chromium.org> wrote:
>>> 
>>> Hi Kai-Heng,
>>> 
>>> Which Realtek controller is this on?'
>> 
>> The issue happens on 8821CE.
>> 
>>> 
>>> Specifically for RTL8822CE, we tested without reset_resume being set
>>> and that was causing the controller being reset without bluez ever
>>> learning about it (resulting in devices being unusable without
>>> toggling the BT power).
>> 
>> The reset is done by the kernel, so how does that affect bluez?
>> 
>> From what you described, it sounds more like runtime resume since bluez is already running.
>> If we need reset resume for runtime resume, maybe it's another bug which needs to be addressed?
> 
> From btusb.c:  https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/drivers/bluetooth/btusb.c#n4189
> /* Realtek devices lose their updated firmware over global
> * suspend that means host doesn't send SET_FEATURE
> * (DEVICE_REMOTE_WAKEUP)
> */
> 
> Runtime suspend always requires remote wakeup to be set and reset
> resume isn't used there.

Thanks for the clarification.

> 
> During system suspend, when remote wakeup is not set, RTL8822CE loses
> the FW loaded by the driver and any state currently in the controller.
> This causes the kernel and the controller state to go out of sync.
> One of the issues we observed on the Realtek controller without the
> reset resume quirk was that paired or connected devices would just
> stop working after resume.
> 
>> 
>>> If the firmware doesn't cut off power during suspend, maybe you
>>> shouldn't set the BTUSB_WAKEUP_DISABLE flag for that controller.
>> 
>> We don't know beforehand if the platform firmware (BIOS for my case) will cut power off or not.
>> 
>> In general, laptops will cut off the USB power during S3.
>> When AC is plugged, some laptops cuts USB power off and some don't. This also applies to many desktops. Not to mention there can be BIOS options to control USB power under S3/S4/S5...
>> 
>> So we don't know beforehand.
>> 
> 
> I think the confusion here stems from what is actually being turned
> off between our two boards and what we're referring to as firmware :)

Yes :)

> 
> In your case, the Realtek controller retains firmware unless the
> platform cuts of power to USB (which it does during S3).

Not all platform firmware (i.e. BIOS for x86) cut USB power during S3, as I describe in last reply.

> In my case, the Realtek controller loses firmware when Remote Wakeup
> isn't set, even if the platform doesn't cut power to USB.

Thanks for the clarification, I believe it's a case that should to be handled separately.

> 
> In your case, since you don't need to enforce the 'Remote Wakeup' bit,
> if you unset the BTUSB_WAKEUP_DISABLE for that VID:PID, you should get
> the desirable behavior (which is actually the default behavior; remote
> wake will always be asserted instead of only during Runtime Suspend).

So we have three cases here. Assuming reset_resume isn't flagged by btusb:

1) Both USB power and BT firmware were lost during suspend.
USB core finds out power was lost, try to reset resume the device. Since btusb doesn't have reset_resume callback, USB core calls probe instead.

2) Both USB power and BT firmware were kept during suspend. This is my case.
Regular resume handles everything.

3) USB power was kept but BT firmware was lost. This is your case.
USB core finds out power was kept, use regular resume. However the BT firmware was lost, so resume fails.
For this case, maybe we can use btrtl_setup_realtek() in btusb_resume()? It won't re-upload firmware if firmware is retained, and will do proper initializing if firmware was lost.

Kai-Heng

> 
> @Alex -- What is the common behavior for Realtek controllers? Should
> we set BTUSB_WAKEUP_DISABLE only on RTL8822CE or should we unset it
> only on RTL8821CE?
> 
>>> 
>>> I would prefer this doesn't get accepted in its current state.
>> 
>> Of course.
>> I think we need to find the root cause for your case before applying this one.
>> 
>> Kai-Heng
>> 
>>> 
>>> Abhishek
>>> 
>>> On Wed, Sep 23, 2020 at 10:56 AM Kai-Heng Feng
>>> <kai.heng.feng@canonical.com> wrote:
>>>> 
>>>> Realtek bluetooth controller may fail to work after system sleep:
>>>> [ 1272.707670] Bluetooth: hci0: command 0x1001 tx timeout
>>>> [ 1280.835712] Bluetooth: hci0: RTL: HCI_OP_READ_LOCAL_VERSION failed (-110)
>>>> 
>>>> If platform firmware doesn't cut power off during suspend, the firmware
>>>> is considered retained in controller but the driver is still asking USB
>>>> core to perform a reset-resume. This can make bluetooth controller
>>>> unusable.
>>>> 
>>>> So avoid unnecessary reset to resolve the issue.
>>>> 
>>>> For devices that really lose power during suspend, USB core will detect
>>>> and handle reset-resume correctly.
>>>> 
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>> drivers/bluetooth/btusb.c | 8 +++-----
>>>> 1 file changed, 3 insertions(+), 5 deletions(-)
>>>> 
>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>> index 8d2608ddfd08..de86ef4388f9 100644
>>>> --- a/drivers/bluetooth/btusb.c
>>>> +++ b/drivers/bluetooth/btusb.c
>>>> @@ -4255,17 +4255,15 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>>>>               enable_irq(data->oob_wake_irq);
>>>>       }
>>>> 
>>>> -       /* For global suspend, Realtek devices lose the loaded fw
>>>> -        * in them. But for autosuspend, firmware should remain.
>>>> -        * Actually, it depends on whether the usb host sends
>>>> +       /* For global suspend, Realtek devices lose the loaded fw in them if
>>>> +        * platform firmware cut power off. But for autosuspend, firmware
>>>> +        * should remain.  Actually, it depends on whether the usb host sends
>>>>        * set feature (enable wakeup) or not.
>>>>        */
>>>>       if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags)) {
>>>>               if (PMSG_IS_AUTO(message) &&
>>>>                   device_can_wakeup(&data->udev->dev))
>>>>                       data->udev->do_remote_wakeup = 1;
>>>> -               else if (!PMSG_IS_AUTO(message))
>>>> -                       data->udev->reset_resume = 1;
>>>>       }
>>>> 
>>>>       return 0;
>>>> --
>>>> 2.17.1

