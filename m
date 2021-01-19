Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971A42FAF27
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 04:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbhASDgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 22:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbhASDgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 22:36:42 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65060C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 19:36:02 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id i7so12179376pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 19:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVL8UC5bJ7q4Dftmka3lWgXYmFR5nguk3Goz+6Bfmoo=;
        b=eKcJMCPg4kenjEwMvZbCCebWpsJgjo0LQSrvccl1rB8U907AzpCiQIp5ez3YRX1Xz/
         S+uCTn6TC4yRYkbLtNWVJ+RDenN5/5RWMDiPuEyLF2ok5CZfSH4vitClur2lB2JkWlsR
         cqE40d7FOwL719OotbERTHD7X9+uJjdb+DruEZ+v2fwKMrBL/nzYOblaOv7PCV/i/KFn
         txP3sDKkGbKXyLvsW8xH/3BWVZ8/fFmkg1nZBQjdo+GkgiDfva72NjjcSbrbm9HeHrKz
         Lsi5/2+DreeEh9avEJaLyYaHT7Ph+S+gdPhFNbMKQkjGjqHx+adLqQyjp/SbSOljsCTQ
         vjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVL8UC5bJ7q4Dftmka3lWgXYmFR5nguk3Goz+6Bfmoo=;
        b=NwPX86UJRQFZfZBUiiKJqEiulBTwxqYLMQt3BpSwYFxis9M/OdjBTbZ10ey4oi7U/c
         GmfuKo4pU3IuwOznPcBe7mkBtvw25KHeq24HUlL8JTQXaeKt13TdiKbaBC+iT0Iczs8f
         H9npEiClutF3DFBnLuAQxfTPdkwABoDAThbgwWLWmimFTK/7nBiVuXxniAvvHph7iRG4
         MHFEGfVrZcfP6HoEMTunFyZ6a7ut2vFI1B8A2G11t6GxoCdwJnznArKMbN5B/nQRrn1I
         aVmj1UZR4USUebILNSPHMv9T74eqPuCdh/gVeNns+/zoi93A83s6W97hFlhSNdkgrgbQ
         7MaA==
X-Gm-Message-State: AOAM533bHR4hhLaAYg0mq2tUE3CLB/K7pFjBzzIU4jhJDplla3nsx56B
        XIxgqumvg5aAPk9NmoF6kgusT1Iyz3QFvQ==
X-Google-Smtp-Source: ABdhPJwJde0VXSUJnTCm1gDlwGgrs/ZgQ+I0+blqn+gPHtjMztl5CAw1qMI0C4wNZTk2R07u+6H4zQ==
X-Received: by 2002:a63:50a:: with SMTP id 10mr2562243pgf.273.1611027361824;
        Mon, 18 Jan 2021 19:36:01 -0800 (PST)
Received: from localhost.localdomain ([75.167.198.216])
        by smtp.gmail.com with ESMTPSA id n1sm16736606pfu.28.2021.01.18.19.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 19:36:01 -0800 (PST)
From:   Paul Zimmerman <pauldzim@gmail.com>
To:     linux@roeck-us.net
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: Linux 5.11-rc4
Date:   Mon, 18 Jan 2021 20:35:53 -0700
Message-Id: <20210119033553.39607-1-pauldzim@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223520.GA193902@roeck-us.net>
References: <20210118223520.GA193902@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 14:35:20 -0800, Guenter Roeck wrote:
> On Sun, Jan 17, 2021 at 04:56:46PM -0800, Linus Torvalds wrote:
>> Things continue to look fairly normal for this release: 5.11-rc4 is
>> solidly average in size, and nothing particularly scary stands out.
>> 
>> In the diff itself, the new ampere modesetting support shows up fairly
>> clearly - it's one of those hardware enablement things that should be
>> entirely invisible to people who don't have that hardware, but it does
>> end up being about a fifth of the whole rc4 patch.
>> 
>> If you ignore that oddity, the rest looks pretty normal, with random
>> patches all over, and a lot of it being quite small. All the usual
>> suspects: drivers (gpu, sound, rdma, md, networking..) arch updates
>> (arm64, risc-v, x86), fiesystems (ext4, nfs, btrfs), core networking,
>> documentation and tooling. And just random fixes.
>> 
>
>Here are the test results:
>
>Build results:
>	total: 153 pass: 151 fail: 2
>Failed builds:
>	arm64:allmodconfig
>	ia64:defconfig
>Qemu test results:
>	total: 430 pass: 428 fail: 2
>Failed tests:
>	arm:raspi2:multi_v7_defconfig:bcm2836-rpi-2-b:initrd
>	arm:raspi2:multi_v7_defconfig:sd:bcm2836-rpi-2-b:rootfs
>
>Same old ...

Hi Guenter,

Can you give a link to the problem that Qemu is having with RPI2?
Maybe I can take a look at it.

Thanks,
Paul
