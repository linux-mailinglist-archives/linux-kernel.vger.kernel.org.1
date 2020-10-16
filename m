Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE843290C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411156AbgJPTsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411129AbgJPTsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:48:03 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02545C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:48:03 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m17so5404670ioo.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=oIHWgAPAlJGpXNJ9CkfTC+TmqbPOy0Eq8ny6o9WXrC4=;
        b=aaooTPFUG0+7nk/NaTfmd6J+HvKUBMWXoJ9WD6ETtr/AUjAyKBykA+68zLbitpoPHl
         DOoWpn0c1u564KpDtwSzxd4xkWP+dWzFXIfv0id2lJoMcReAUGorRVEF3AUKbWildfya
         MUNGtUyIUzn70Hlvok69ID/hq/bSQX6TGq3jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=oIHWgAPAlJGpXNJ9CkfTC+TmqbPOy0Eq8ny6o9WXrC4=;
        b=byWuWnhy8qGmglmovRmKjOtzhY6zCFW4aE3DgbhI5LhbIxpxEmvQvKM8rmDq0xQV3C
         jQqai/zViqC1k+sGk/r96Wgj1ZG1hdsWobapgC4iYOobawOTAAn3AD1p4jpdF9Slz/64
         nUaPatVkZd4NozMT3uqtvec4YwlCk1Vm3kfV5t4dw6cB5xaALAu7t0z2uhZ2E0zrK+YN
         Koj1TJEtQpCOF3mk2VKR/ikPceHpDCF2XQNvYW068WEs21menvguEAiDcO3M5Z5WaFJN
         bbPI471Bi6nfspLW/k24hmvhKEgPOVAFyTLQfNKzeULKfvPrPyNEzWCwkZrYQLaC5D+n
         XyWQ==
X-Gm-Message-State: AOAM530yU4+HD9nXYVqO2qRYNatE7DoMag1vTOfpFsoBDHZgYagPQZvi
        MMvfrSqFhTRRAnMFIupbaXcNBQ==
X-Google-Smtp-Source: ABdhPJxYId5Twz3cb+wkNjf6UyNkgCc4kg+9HoEDy0a1n9sO4JfQ3cc61TnEcpjSECYukcKd38DwSQ==
X-Received: by 2002:a02:5e04:: with SMTP id h4mr4171962jab.6.1602877682311;
        Fri, 16 Oct 2020 12:48:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q16sm2775889ilj.71.2020.10.16.12.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 12:48:01 -0700 (PDT)
Subject: Re: KASAN: null-ptr-deref Write in event_handler
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+bf1a360e305ee719e364@syzkaller.appspotmail.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <000000000000810a4405b0ece316@google.com>
 <CAAeHK+xWQp87S=bF2RfUjcudGaLVjk3yKLL-bxRzVM=YNRtzRA@mail.gmail.com>
 <2947473d-76cd-a663-049a-4d51a97e2a3e@linuxfoundation.org>
 <4b6c9d53-a4de-8749-e0b1-055dbb42703b@linuxfoundation.org>
 <CAAeHK+wZGwovnT969F-aq+EzH8-K21GxJ7YJ0S0Ynd4GM_B4kA@mail.gmail.com>
 <5e0e21bd-5cc9-f1d8-d45e-ec7f10edbfba@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9256b41b-fe27-a453-ab30-8999379bc1e3@linuxfoundation.org>
Date:   Fri, 16 Oct 2020 13:48:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5e0e21bd-5cc9-f1d8-d45e-ec7f10edbfba@linuxfoundation.org>
Content-Type: multipart/mixed;
 boundary="------------E76659FECC40DD1FA21751DE"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E76659FECC40DD1FA21751DE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/20 9:48 AM, Shuah Khan wrote:
> On 10/7/20 8:28 AM, Andrey Konovalov wrote:
>> On Wed, Oct 7, 2020 at 3:56 PM Shuah Khan <skhan@linuxfoundation.org> 
>> wrote:
>>>

[snip]

>>>
>>> Hi Andrey,
>>>
>>> I have been unable to reproduce the problem with the reproducer
>>> so far. You mentioned it happens quite often.
>>>
>>> - matched config with yours
>>> - load vhci_hcd module and run the reproducer
>>
>> Hm, if you matched the config, then the module should be built-in?
>>
> 
> Right. I did notice that your config has built-in. This shouldn't
> matter, I have a kernel built with it static. I will try it to
> see if it makes a difference.
> 
>>>
>>> I do see the messages during shutdown - stop threads etc.
>>>
>>> What am I missing?
>>
>> This appears to be a race that requires precise timings. I failed to
>> reproduce it with the C reproducer, but I managed to reproduce it with
>> the syzkaller repro program:
>>
>> https://syzkaller.appspot.com/x/repro.syz?x=16cbaa7d900000
>>
>> To do that you need to build syzkaller, and copy ./bin/syz-execprog
>> and ./bin/syz-executor into your testing environment, and then do:
>>
>> ./syz-execprog -sandbox=none -repeat=0 -procs=6 ./repro.prog
>>
> 

Andrey,

I am unable to reproduce the problem. I even tweaked the reproducer
to launch 10 procs and 100 threads.

Can you test the following patch with your setup

Here it is - also attached.

=======================================================================
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 66cde5e5f796..3fdcb93b667d 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -997,14 +997,12 @@ static void vhci_device_unlink_cleanup(struct 
vhci_device *vdev)
  	spin_unlock_irqrestore(&vhci->lock, flags);
  }

-/*
- * The important thing is that only one context begins cleanup.
- * This is why error handling and cleanup become simple.
- * We do not want to consider race condition as possible.
- */
  static void vhci_shutdown_connection(struct usbip_device *ud)
  {
  	struct vhci_device *vdev = container_of(ud, struct vhci_device, ud);
+	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
+	struct vhci *vhci = vhci_hcd->vhci;
+	unsigned long flags;

  	/* need this? see stub_dev.c */
  	if (ud->tcp_socket) {
@@ -1012,6 +1010,10 @@ static void vhci_shutdown_connection(struct 
usbip_device *ud)
  		kernel_sock_shutdown(ud->tcp_socket, SHUT_RDWR);
  	}

+	/* avoid races during shutdown */
+	spin_lock_irqsave(&vhci->lock, flags);
+	spin_lock(&vdev->priv_lock);
+
  	/* kill threads related to this sdev */
  	if (vdev->ud.tcp_rx) {
  		kthread_stop_put(vdev->ud.tcp_rx);
@@ -1031,6 +1033,10 @@ static void vhci_shutdown_connection(struct 
usbip_device *ud)
  	}
  	pr_info("release socket\n");

+	/* unlock - vhci_device_unlink_cleanup() holds the locks */
+	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vhci->lock, flags);
+
  	vhci_device_unlink_cleanup(vdev);

  	/*
=======================================================================

thanks,
-- Shuah






--------------E76659FECC40DD1FA21751DE
Content-Type: text/x-patch; charset=UTF-8;
 name="vhci_hcd_shutdown.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="vhci_hcd_shutdown.diff"

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 66cde5e5f796..3fdcb93b667d 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -997,14 +997,12 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
 	spin_unlock_irqrestore(&vhci->lock, flags);
 }
 
-/*
- * The important thing is that only one context begins cleanup.
- * This is why error handling and cleanup become simple.
- * We do not want to consider race condition as possible.
- */
 static void vhci_shutdown_connection(struct usbip_device *ud)
 {
 	struct vhci_device *vdev = container_of(ud, struct vhci_device, ud);
+	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
+	struct vhci *vhci = vhci_hcd->vhci;
+	unsigned long flags;
 
 	/* need this? see stub_dev.c */
 	if (ud->tcp_socket) {
@@ -1012,6 +1010,10 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 		kernel_sock_shutdown(ud->tcp_socket, SHUT_RDWR);
 	}
 
+	/* avoid races during shutdown */
+	spin_lock_irqsave(&vhci->lock, flags);
+	spin_lock(&vdev->priv_lock);
+
 	/* kill threads related to this sdev */
 	if (vdev->ud.tcp_rx) {
 		kthread_stop_put(vdev->ud.tcp_rx);
@@ -1031,6 +1033,10 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 	}
 	pr_info("release socket\n");
 
+	/* unlock - vhci_device_unlink_cleanup() holds the locks */
+	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vhci->lock, flags);
+
 	vhci_device_unlink_cleanup(vdev);
 
 	/*

--------------E76659FECC40DD1FA21751DE--
