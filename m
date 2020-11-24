Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1F22C26A1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbgKXM5R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Nov 2020 07:57:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52836 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733262AbgKXM5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:57:17 -0500
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1khXsf-0006Os-UL
        for linux-kernel@vger.kernel.org; Tue, 24 Nov 2020 12:57:14 +0000
Received: by mail-pg1-f197.google.com with SMTP id i7so9804025pgn.22
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 04:57:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X8iDYlGf8nwy/cRec/5+aTzq8vO1DEtqnmOZbXaUW3s=;
        b=Kxsvx/qfwDIOvKRuWgNhjGDEgvOYAjngD9fvakO0kovVoCcXqtX4in/+TGiuHeAwi6
         voDxX3FKadiV99dZKvr95cc7BUBHC59JR2gzrL6SH77dpex6X5Z2bSjASXJsQeBO1fUQ
         BYGPFCNkBmLkpHSiNeAZFRHa1xfWPAqWcEHWsuHngTg/cTFTdz38IuM+lNQvG63ukqng
         LprycUeEqFQ7Shiqb/fB7Ojsc2lW3OHhK7ln1a1OniyF/gAdojsgi3WVLgqXGqotfoKt
         Gz8guaiXTNs8rhLXn7O0lYXDJsAMSZrxDWcM424GlQdF3qgcGpkjrUIt11sk4Bxjc71N
         nyHg==
X-Gm-Message-State: AOAM530nFBGB4u8KI8HSNQqmD1ggjLv7bpUQiXdkQ48vlmzm/Qu20Pfp
        XThltSbGSQ3nJEoQOxzUoVQPwibNi+mSbXT7uDfKIFDgeNeW9n52wrJo7QAF4VDNMoGTGqYePRv
        8/+IxV/2BzsdS26Vp6vWIphxEL5u3VATKNpOkzF1cCQ==
X-Received: by 2002:a17:902:70cc:b029:d7:e8ad:26d4 with SMTP id l12-20020a17090270ccb02900d7e8ad26d4mr3807233plt.33.1606222632572;
        Tue, 24 Nov 2020 04:57:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwozB2pCgo1Ni9DdJRatk31M0oTPqAtTl0z7nrnx3WvUiICbsTns3if3MiDh+TKIGCtfwofHg==
X-Received: by 2002:a17:902:70cc:b029:d7:e8ad:26d4 with SMTP id l12-20020a17090270ccb02900d7e8ad26d4mr3807205plt.33.1606222632167;
        Tue, 24 Nov 2020 04:57:12 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id i19sm13444182pgk.44.2020.11.24.04.57.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 04:57:11 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND
 quirkforLenovo A630Z TIO built-in usb-audio card
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1503654237.281102.1605875117132.JavaMail.xmail@bj-wm-cp-6>
Date:   Tue, 24 Nov 2020 20:57:07 +0800
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        johan <johan@kernel.org>, jonathan <jonathan@jdcox.net>,
        tomasz <tomasz@meresinski.eu>,
        Hans de Goede <hdegoede@redhat.com>,
        dlaz <dlaz@chromium.org>,
        "richard.o.dodd" <richard.o.dodd@gmail.com>,
        kerneldev <kerneldev@karsmulder.nl>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <484458B3-EADF-48AC-94E0-13C3247783DA@canonical.com>
References: <20201118123039.11696-1-penghao@uniontech.com>
 <49219711-84BE-44FC-BBFE-DD8D609CA26D@canonical.com>
 <1892790617.185900.1605788248261.JavaMail.xmail@bj-wm-cp-6>
 <7D73C39C-C3E2-4C08-A773-3D7582A6AA7D@canonical.com>
 <X7Z6RKu4T5IrhUFB@kroah.com>
 <FB40A0E5-5E3C-4FC6-B690-02F9785EC7D5@canonical.com>
 <X7Z/+Tehbmx54Fzb@kroah.com>
 <2FEF0396-33A8-4164-AB79-E5B8F87F6ABF@canonical.com>
 <1503654237.281102.1605875117132.JavaMail.xmail@bj-wm-cp-6>
To:     =?utf-8?B?5b2t5rWp?= <penghao@uniontech.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi penghao,

> On Nov 20, 2020, at 20:25, 彭浩 <penghao@uniontech.com> wrote:
> 
> 
> > Seeking a better fix, we've tried a lot of things, including:
> > - Check that the device's power/wakeup is disabled
> > - Check that remote wakeup is off at the USB level
> > - All the quirks in drivers/usb/core/quirks.c
> Since the machine has been returned to the manufacturer, i can not provide dynamic debugging information.
> Is there any other way to solve your doubts？

Basically, no.

It would be great if we can know whether the device is quiesced in U3 before suspend.
Currently xHCI doesn't poll for U3 for global suspend.

Kai-Heng

> 
> peng hao 
> 
> 统信软件技术有限公司
> 
> UnionTech Software Technology Co., Ltd. 　
> 
> 官网：www.uniontech.com　　
> 
> 
> 
> 此电子邮件消息仅供预期收件人使用，其中可能包含保密或特权使用信息。如果您不是预期收件人，请勿使用、传播、分发或复制此电子邮件或信赖此邮件采取任何行动。如果您误收了此邮件，请立即回复邮件通知统信软件技术有限公司发件人，并删除误收电子邮件及其相关附件。感谢配合！
> 
> This email message is intended only for the use of the individual or entity who/which is the intended recipient and may contain information that is privileged or confidential. If you are not the intended recipient, you are hereby notified that any use, dissemination, distribution or copying of, or taking any action in reliance on, this e-mail is strictly prohibited. If you have received this email in error, please notify UnionTech Software Technology  immediately by replying to this e-mail and immediately delete and discard all copies of the e-mail and the attachment thereto (if any). Thank you.
> 
> 
> 
> 
> ----- Original Message -----
> From:Kai-Heng Feng <kai.heng.feng@canonical.com> 
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>  
> CC: 彭浩 <penghao@uniontech.com> johan <johan@kernel.org> jonathan <jonathan@jdcox.net> tomasz <tomasz@meresinski.eu> Hans de Goede <hdegoede@redhat.com> dlaz <dlaz@chromium.org> richard.o.dodd <richard.o.dodd@gmail.com> kerneldev <kerneldev@karsmulder.nl> linux-usb <linux-usb@vger.kernel.org> linux-kernel <linux-kernel@vger.kernel.org>  
> Sent: 2020-11-20 02:27
> Subject: Re:Re: [PATCH] USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirkforLenovo A630Z TIO built-in usb-audio card
> 
> 
> 
> > On Nov 19, 2020, at 22:23, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > On Thu, Nov 19, 2020 at 10:12:02PM +0800, Kai-Heng Feng wrote:
> >> 
> >> 
> >>> On Nov 19, 2020, at 21:59, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >>> 
> >>> On Thu, Nov 19, 2020 at 09:41:32PM +0800, Kai-Heng Feng wrote:
> >>>> Hi penghao,
> >>>> 
> >>>>> On Nov 19, 2020, at 20:17, 彭浩 <penghao@uniontech.com> wrote:
> >>>>> 
> >>>>> root@uos-PC:/sys/bus/usb/devices/usb7# dmesg
> >>>>> [ 0.000000] Linux version 4.19.0-6-amd64 (debian-kernel@lists.debian.org) (gcc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Uos 4.19.67-11eagle (2020-03-21)
> >>>> 
> >>>> Thanks for the dmesg. But would it be possible to use mainline kernel enable dynamic debug?
> >>>> 
> >>>> But anyway, this is not a regular AMD or Intel platform, so I guess we can merge the quirk as is...
> >>>> 
> >>>> Kai-Heng
> >>>> 
> >>>>> [ 0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-6-amd64 root=UUID=e5a40c4f-d88e-4a4d-9414-a27892a31be7 ro splash console=ttyS0,115200n8 loglevel=7 DEEPIN_GFXMODE=0,1920x1080,1600x1200,1280x1024,1024x768
> >>>>> [ 0.000000] Zhaoxin Linux Patch Version is V3.0.2 
> >>>>> [ 0.000000] With Zhaoxin Shanghai CPU patch V2.0.0
> >>> 
> >>> What do you mean "not a regular"? This is an x86-variant chip platform,
> >>> but what does that have to do with the USB quirk detection?
> >> 
> >> USB quirk detection should work fine. I was trying to find the root cause, but seeing it's a Zhaoxin CPU, that could be the reason why mainline kernel, which has many USB power management fixes, wasn't used.
> >> 
> >> penghao, is it possible to boot mainline kernel on Zhaoxin CPU?
> > 
> > There have been a number of small patches for this type of CPU merged
> > over the past months, so I hope a mainline kernel works here :)
> > 
> > That being said, why would the platform matter for a USB device quirk?
> 
> No, it doesn't matter at all. 
> Because I am not sure if it can boot a mainline kernel, and the author doesn't know how to enable dynamic debug to let us understand what really happens here.
> 
> Kai-Hen
> 
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> 

