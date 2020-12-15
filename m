Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7792DB03F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgLOPkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgLOPkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:40:15 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35A8C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:39:34 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id b24so2249747otj.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CCMZcHb9YzX0hMfzSST+IXmSKcnC7HCoDAqqlcqAUUY=;
        b=b1UP1oOVHUCYEDcEx3NZHDQ7WvtOxWJtYsuvH8kECvaVBcsYyzIAJc/6fNS5mFQ731
         XJwcjET+SgMK0R1g0Ku2ENiWDVGgOlodpzK3F9hKeIZj+qJRWrtZlvkRa/f0LiPMgbMc
         s+20D50QsBgl0qm27DL+NUr/karY+kuCZaQGHfaYXZEZYjaP2lk2Cwdln1ZPsEPvBPgV
         hyT637LkDYWbs7oTkCOgK3Z+IWwLwICZMYLJwjxrQG1Sd/T+5t3XDtUHL62q11AP3rDE
         OAUXz4I43SKr/HuNPGsSldRiIfMJNiZHw0l2Xp6bOa6kXrLmvHN42t8qf7iGrgxKVvtO
         80BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CCMZcHb9YzX0hMfzSST+IXmSKcnC7HCoDAqqlcqAUUY=;
        b=ZwkujqiDTr2vbDKhkFmfYy2c8VfmFOAe5v0hNImVZCZMs3Xe/2N/jX3UDqNI8F86hD
         irso4S0FjrxPjB8F3Hsg9vCZ8zvhozPjBWysk3VAYYFH4s8B5cNhfcQFfMi3bDHUZmb1
         AQ9sTteYRcmGZc5kR+TUuFD7EGQF9SxL4TI+7RtBbJUy/9kqDU69/wszCQHN0X2Qdp5S
         /NoEAZRdHGlVy6D8KmzSqetKVqqQMGGmd5RQsTQpOITgESuNNzx51X/CyNhER95Egy5D
         W4PDr/BKesQx66J+oosKlsMlfzbhHaJUDed/eMZmJeGXEgcr1QFjtRC8Av5OHVieuMRq
         Djkg==
X-Gm-Message-State: AOAM5330jqedZe1O9cSDXVI7uRVBqJ00iUn7yrNMp8tGAWxaW5w26Ub3
        thG2xb6O9o0Xgetw+jMZYTc=
X-Google-Smtp-Source: ABdhPJxWt+cvnY0RxudKF3FKgr5ZWz15QnkRLKDLzH03p3jT5pQd8UClgg+dsPH3SibUqcYsyMv05Q==
X-Received: by 2002:a9d:a78:: with SMTP id 111mr23355114otg.94.1608046772690;
        Tue, 15 Dec 2020 07:39:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t3sm4637759oon.14.2020.12.15.07.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 07:39:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 3/5] irqchip/bcm2836: Make IPIs use
 handle_percpu_devid_irq()
To:     Marc Zyngier <maz@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Lunn <andrew@lunn.ch>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Scott Branden <sbranden@broadcom.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
References: <20201109094121.29975-1-valentin.schneider@arm.com>
 <20201109094121.29975-4-valentin.schneider@arm.com>
 <20201215002134.GA182208@roeck-us.net>
 <38f8fbe9ceb7a0adb47e62d62260b297@kernel.org>
 <1795afb5-a4fd-3a90-99c4-71373476ad65@roeck-us.net>
 <9007dd8a0d5334141d083b14121ba11c@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <c9fb4ab3-a5cb-648c-6de3-c6a871e60870@roeck-us.net>
Date:   Tue, 15 Dec 2020 07:39:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9007dd8a0d5334141d083b14121ba11c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/20 7:26 AM, Marc Zyngier wrote:
> On 2020-12-15 15:21, Guenter Roeck wrote:
>> Hi Marc,
>>
>> On 12/15/20 2:19 AM, Marc Zyngier wrote:
>>> Hi Gunter,
>>>
>>> On 2020-12-15 00:21, Guenter Roeck wrote:
>>>> On Mon, Nov 09, 2020 at 09:41:19AM +0000, Valentin Schneider wrote:
>>>>> As done for the Arm GIC irqchips, move IPIs to handle_percpu_devid_irq() as
>>>>> handle_percpu_devid_fasteoi_ipi() isn't actually required.
>>>>>
>>>>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>>>>
>>>> This patch results in boot failures (silent stall) for the qemu
>>>> raspi2 emulation. Unfortunately it can not be reverted because
>>>> handle_percpu_devid_fasteoi_ipi no longer exists in next-20201214,
>>>> so I don't know if it is the only problem.
>>>
>>> This is odd. This works just fine for me on both the RPi2 and 3
>>> emulation, running a full Debian userspace. Could this be caused
>>> by the version of QEMU you are using? Here's what I have:
>>>
>>> $ qemu-system-arm --version
>>> QEMU emulator version 5.1.0 (Debian 1:5.1+dfsg-4+b1)
>>>
>>
>> I used qemu 5.0 which - up to now - worked fine. Let me try with
>> 5.1 and 5.2. Sorry, I should have tried first before bothering you.
> 
> No bother at all. If this works for you on more recent versions of
> QEMU, that'd be an interesting data point. I'm also interested in
> the result of the patch either way.
> 

It doesn't work for me with qemu 5.1, nor with qemu 5.2. My userspace
is generated with buildroot, busybox-based, and very basic.

Your patch fixes the problem for me, though, so feel free to add

Tested-by: Guenter Roeck <linux@roeck-us.net>

if/when you submit it.

Thanks,
Guenter
