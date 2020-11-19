Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BAD2B9A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgKSS1h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Nov 2020 13:27:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50432 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgKSS1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:27:36 -0500
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kfoeb-0005it-Iq
        for linux-kernel@vger.kernel.org; Thu, 19 Nov 2020 18:27:33 +0000
Received: by mail-pg1-f199.google.com with SMTP id n16so4645472pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e9YpARSCr0Yxjh2p6zuNpM6B/wLzy00GbmQQtJLsTrk=;
        b=R2o2wvQrx3BcJv3myjMSTpNpzXGyiJFB68oHQEARnxNNcpsYY1mMfpYsVWpDWae9Zf
         zVyq3NrRgowhSkg53WMBh21E0VqdeHt26+jrfLMCzvfSFx7h25CsWFzoicR/pgo8fH0J
         dtwUxCZR3obiHZV+wBM2ZjxDlXxByGVfwppisrrsHniI9k0aKJ9KuyQku/A8RitISxGX
         chuu5FC7XYwzcCKiAsZACGPsuDoG3Vi0g1okx5ovDNOt+Tf/wFlu7qGbfI/7v1J/2FGE
         TKRyfBkYY0G1Wd41g/2IP7mG26JMTUsXimIyDsr28Wmqm4fNbtfZXQGNa6Z/0IPMP0eq
         ndKQ==
X-Gm-Message-State: AOAM531tJgAo9ck33jlz5AWv539QYputXzs1SEb28TN3BpLP+QqloMTA
        cqSQeXYlvtNevDf/LpRlLHlL/8/BWjX0W6pvn85Oc7SMCiMAGCyegIdN+sQ2la43ADQl7/Y0Wuf
        5XvZYTuDe8mbpUofQ5Rf+GQWigabl8bUQhROT7E38dA==
X-Received: by 2002:a17:902:bc8c:b029:d8:efb7:ae74 with SMTP id bb12-20020a170902bc8cb02900d8efb7ae74mr10430849plb.10.1605810452105;
        Thu, 19 Nov 2020 10:27:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwT0fNlLpTwIROMD7ATbO0dNVI8CFSdV7EJpVbWuqajjMteFvr9duBl6s3FrN2lPwCcvzDrLg==
X-Received: by 2002:a17:902:bc8c:b029:d8:efb7:ae74 with SMTP id bb12-20020a170902bc8cb02900d8efb7ae74mr10430826plb.10.1605810451746;
        Thu, 19 Nov 2020 10:27:31 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id w127sm519097pfc.172.2020.11.19.10.27.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 10:27:30 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirk
 forLenovo A630Z TIO built-in usb-audio card
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <X7Z/+Tehbmx54Fzb@kroah.com>
Date:   Fri, 20 Nov 2020 02:27:27 +0800
Cc:     =?utf-8?B?5b2t5rWp?= <penghao@uniontech.com>,
        johan <johan@kernel.org>, jonathan <jonathan@jdcox.net>,
        tomasz <tomasz@meresinski.eu>,
        Hans de Goede <hdegoede@redhat.com>,
        dlaz <dlaz@chromium.org>,
        "richard.o.dodd" <richard.o.dodd@gmail.com>,
        kerneldev <kerneldev@karsmulder.nl>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <2FEF0396-33A8-4164-AB79-E5B8F87F6ABF@canonical.com>
References: <20201118123039.11696-1-penghao@uniontech.com>
 <49219711-84BE-44FC-BBFE-DD8D609CA26D@canonical.com>
 <1892790617.185900.1605788248261.JavaMail.xmail@bj-wm-cp-6>
 <7D73C39C-C3E2-4C08-A773-3D7582A6AA7D@canonical.com>
 <X7Z6RKu4T5IrhUFB@kroah.com>
 <FB40A0E5-5E3C-4FC6-B690-02F9785EC7D5@canonical.com>
 <X7Z/+Tehbmx54Fzb@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 19, 2020, at 22:23, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> On Thu, Nov 19, 2020 at 10:12:02PM +0800, Kai-Heng Feng wrote:
>> 
>> 
>>> On Nov 19, 2020, at 21:59, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>>> 
>>> On Thu, Nov 19, 2020 at 09:41:32PM +0800, Kai-Heng Feng wrote:
>>>> Hi penghao,
>>>> 
>>>>> On Nov 19, 2020, at 20:17, 彭浩 <penghao@uniontech.com> wrote:
>>>>> 
>>>>> root@uos-PC:/sys/bus/usb/devices/usb7# dmesg
>>>>> [ 0.000000] Linux version 4.19.0-6-amd64 (debian-kernel@lists.debian.org) (gcc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Uos 4.19.67-11eagle (2020-03-21)
>>>> 
>>>> Thanks for the dmesg. But would it be possible to use mainline kernel enable dynamic debug?
>>>> 
>>>> But anyway, this is not a regular AMD or Intel platform, so I guess we can merge the quirk as is...
>>>> 
>>>> Kai-Heng
>>>> 
>>>>> [ 0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-6-amd64 root=UUID=e5a40c4f-d88e-4a4d-9414-a27892a31be7 ro splash console=ttyS0,115200n8 loglevel=7 DEEPIN_GFXMODE=0,1920x1080,1600x1200,1280x1024,1024x768
>>>>> [ 0.000000] Zhaoxin Linux Patch Version is V3.0.2 
>>>>> [ 0.000000] With Zhaoxin Shanghai CPU patch V2.0.0
>>> 
>>> What do you mean "not a regular"?  This is an x86-variant chip platform,
>>> but what does that have to do with the USB quirk detection?
>> 
>> USB quirk detection should work fine. I was trying to find the root cause, but seeing it's a Zhaoxin CPU, that could be the reason why mainline kernel, which has many USB power management fixes, wasn't used.
>> 
>> penghao, is it possible to boot mainline kernel on Zhaoxin CPU?
> 
> There have been a number of small patches for this type of CPU merged
> over the past months, so I hope a mainline kernel works here :)
> 
> That being said, why would the platform matter for a USB device quirk?

No, it doesn't matter at all. 
Because I am not sure if it can boot a mainline kernel, and the author doesn't know how to enable dynamic debug to let us understand what really happens here.

Kai-Hen

> 
> thanks,
> 
> greg k-h

