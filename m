Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3D82EB2CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbhAESrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbhAESrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:47:36 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11AFC061795
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:46:55 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id a109so692009otc.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FQHYXsCfIUt8mD0gX69m0hlAumqmzATTTaH1ALT+r0M=;
        b=hg7JludzVwRDPNyqVGsLQ0++/uCbJCFiHzBlSYXsiqMt6nkIP0+1DUtGXNfLdDGQ3y
         YOu5K2thDC9v5BIynDMUdtAhtHxbKaRHpvw2PYgISnDPIXfeRCIseppO72AvngX/Dj8t
         E+SutA4sZY+EYI+gClSMF2F7sXwooH+pDi2ij9ATHkx8gyRbFx9GKI/PhUyyYR/PC+7R
         na8f5MujMn79vXpnV7yQpTAikd9Evv1ravJeVXSKiWqi02+TDt+iKpIyDwurwWQiBhiu
         FqW8Ab4iZyspFrxKAatImrTfCEjSYOmzVia5hb41KguQvY+e/pLP3fvMLSAeAm33oVzG
         h59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FQHYXsCfIUt8mD0gX69m0hlAumqmzATTTaH1ALT+r0M=;
        b=kORLghzCQOxJQPK8v0CbZCVEaxnPQcoKO2jCnRoA//m1WeJ+iLBbq0Ci07DOgxnJxa
         bRKeCx1qMZAhy0RB4Tn1yDtO1UXeVlsmH+1JcTc8PhZlvI1FdTaKycfe348S8Bm5CoLa
         rumOx8WWyDMYS3a1XzS3REx8y/HnXAmJxOouc1IGE0x+v0BjtTtsosiTXJsiXJNlbWnS
         KywiKr7RaH55Ev7Ep5oFYSj7eJdW9bjts2p//lSLAvMJPLlERwjRsTXDp6x3R+QFpzVY
         fBUxZ/V5OPvlwlnNxzYZJLk1u8+S/dPsJaxuNwXSBWB38/QNmsuE3FcydPxS1UEsLNoq
         //PA==
X-Gm-Message-State: AOAM533LM+t7J10cYTz+s0Kk1iGCeaJ4N3QGzp1aWn7gXs3+5crZ0lKh
        c3ZCFgFvBfPWOung0zQJDdFdVfd6e24=
X-Google-Smtp-Source: ABdhPJy2r7KyoYSkwjO89tdOY4o1eleC31KjqrVapGOI4xAFiboeCdHp1DkiB4Okd0BT8Q/Ypdsx1A==
X-Received: by 2002:a05:6830:11d5:: with SMTP id v21mr622116otq.306.1609872415433;
        Tue, 05 Jan 2021 10:46:55 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f201sm55555oig.21.2021.01.05.10.46.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jan 2021 10:46:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 5 Jan 2021 10:46:53 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc2
Message-ID: <20210105184653.GA88051@roeck-us.net>
References: <CAHk-=whS+rzNMSsU6vRoLMzrm0JPN-OVg+BxhybMet3NpqpR-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whS+rzNMSsU6vRoLMzrm0JPN-OVg+BxhybMet3NpqpR-Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 03, 2021 at 04:13:08PM -0800, Linus Torvalds wrote:
> Ok, let's be honest - not a lot has happened in the last week or two.
> 
> The merge window itself may not have been hugely impacted by the
> holiday season, but that's because all the new code should already
> have been ready before the merge window even opened, so the holidays
> just didn't end up affecting things all that much.
> 
> But people have (rightly) mostly been offline since, presumably
> over-eating and doing all the other traditional holiday things. And
> just generally not being hugely active. That very much shows in a tiny
> rc2 release.
> 
> I expect next week to slowly start ramping up fixes, but I know some
> people are still on vacation or just in an extended food coma, and
> there's a delay from testing to fixes, so we'll see. Maybe rc3 ends up
> being fairly small too.
> 
> It's much too early to say whether this will then end up causing some
> delays in the final release - it's possible, but with 5.11 not being a
> particularly big release maybe it doesn't even matter that we had a
> fairly quiet week or two in the early rc series.
> 
> Anyway, for whatever reasons, the few fixes we _do_ have in rc2 tend
> to be mostly in SCSI and block devices. But there's a random
> smattering of other things too. For once, the shortlog is so small
> that you might as well just read it.
> 
> Time to slowly crawl out from under all the xmas wrapping paper piles
> and go test...
> 
Build results:
	total: 153 pass: 151 fail: 2
Failed builds:
	arm64:allmodconfig
	ia64:defconfig
Qemu test results:
	total: 430 pass: 428 fail: 2
Failed tests:
	arm:raspi2:multi_v7_defconfig:bcm2836-rpi-2-b:initrd
	arm:raspi2:multi_v7_defconfig:sd:bcm2836-rpi-2-b:rootfs

arm64:allmodconfig:

ERROR: modpost: "irq_check_status_bit" [drivers/perf/arm_spe_pmu.ko] undefined!

ia64:defconfig:

include/linux/mmzone.h:1156:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE

arm:raspi2 boot tests stall during boot.

Problems are as already reported against v5.11-rc1.

Guenter
