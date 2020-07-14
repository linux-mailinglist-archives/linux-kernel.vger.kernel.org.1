Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA0221E59C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 04:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgGNCYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 22:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNCYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 22:24:46 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51FBC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 19:24:46 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id o38so11726895qtf.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 19:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbcRxgW3JR28m29u/55Y7F17wlRrdtYw3svGpp+m0sg=;
        b=JFfrRU6VO9nyB2CutrxZpYRw9Z/DY7NGnHc7yaGCJgjV/oeGMm7gUDUMn2Hw+DFEwr
         iZFUnN+AU8QEv3VXY6QjmLpETHOxi44WxXXIGVTMsBKAsoQ/Vo47oKXxr1TYPabv1FZ9
         Rpn0etW2cq4MVhIPqvOLKoA8d6WFKcLsjpf49XKFfUczmsMfHqLtVLjdchl733qmpaU1
         iGeOj/BLj0e/CL66lzd3dXDyTfv/XlxtbtsYKYpaeULok22FZz9GEHaGCT9l7NzMZPEZ
         877VHoIAL1jv2u5a2U5eONSDPTqMFHxQ0nkY/+kKjs/YlvQo5uCW56e2K1KQv455VLuo
         2iFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbcRxgW3JR28m29u/55Y7F17wlRrdtYw3svGpp+m0sg=;
        b=YWhFlMqxiVPHhjFZy3dkgwuWVY+JZDaJdCBHNyjfwCPfyNOyuWQ4bFxlmOi72SIWHw
         FmBHNKtHwpIgg8z2qW20oaJHzQstvYjo6xr43Xh9ADvRdBim9gvHIbQGGGcrbVBFoSS9
         q1s8aKJPpiN6RwuU8v+t9UVxlhpl0d3MmrlNpUY9NQ3/JzzEyoEVfs2uK//SZO+XfyhU
         +Zydot2WFd8xs/12zfSWe/8q3sDPQPXUhi78hyXt96AEEs6C9rAkRtgvASxW3SacEonp
         lj0T6pHkhFxNMwhbdbKaiX9egqP2T6P7s8EQjkygo+ak1b/9J32MaFglrI4NodUyIC5D
         iovQ==
X-Gm-Message-State: AOAM530S8TbH9GAkaxfmu5/86w6jZnnzV5a6MWNfcTg70VbHR7i1YG7e
        lnrqWldCbYxvnDu8LhvuLJePiFXhO6xQ1nzyb1Y=
X-Google-Smtp-Source: ABdhPJyAQ09tdvgL6Dv66Q8tRJxbejbevW6MHwgjkdJo1J0PJRpaqYJXXUOl1c4EvtR33b15Bha4oFqdqndgJf9A6aY=
X-Received: by 2002:ac8:24fc:: with SMTP id t57mr2611282qtt.116.1594693484792;
 Mon, 13 Jul 2020 19:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <CALaQ_hosk7627nTx97+xSSsGiN-qt=pTGNW4DZn4TOcAeRSC8g@mail.gmail.com>
 <20200714000347.GA19314@google.com>
In-Reply-To: <20200714000347.GA19314@google.com>
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Mon, 13 Jul 2020 21:24:34 -0500
Message-ID: <CALaQ_hriyvF8yaSihvGEN1U2jufCQ5sj=aknN+1xB=4EbkBWaQ@mail.gmail.com>
Subject: Re: F2FS Segmentation Fault
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 7:03 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Hi Nathan,
>
> Could you try to say "N" here to move forward to fix the corrupted metadata?
>
> Thanks,
*****
Do you want to restore lost files into ./lost_found/? [Y/N] N
Info: Write valid nat_bits in checkpoint
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18eca] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18ecb] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18ecc] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18ee3] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18ee4] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18ee5] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18f78] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18f79] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18f7a] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x4d621] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x4d622] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x7fa32] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x7fa33] in NAT
Info: Write valid nat_bits in checkpoint

Done.
*****

*****
Info: Fix the reported corruption.
Info: Force to fix corruption
Info: Segments per section = 1
Info: Sections per zone = 1
Info: sector size = 512
Info: total sectors = 124168159 (60628 MB)
Info: MKFS version
  "Linux version 5.1.15.a-1-hardened (builduser@slave-1) (gcc version
9.1.0 (GCC)) #1 SMP PREEMPT Thu Jun 27 11:33:04 CEST 2019"
Info: FSCK version
  from "Linux version 4.19.13-dirty (nater@devx64) (gcc version 8.2.1
20181127 (GCC)) #2 SMP PREEMPT Mon Dec 31 00:15:50 CST 2018"
    to "Linux version 4.19.13-dirty (nater@devx64) (gcc version 8.2.1
20181127 (GCC)) #2 SMP PREEMPT Mon Dec 31 00:15:50 CST 2018"
Info: superblock features = 0 :
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: total FS sectors = 124168152 (60628 MB)
Info: CKPT version = 63f2b4a
Info: checkpoint state = 281 :  allow_nocrc nat_bits unmount
Info: No error was reported
*****
I'm now booted in from my SDHC card. So it "seems" I'm good to go.
But with the actions taken and the files I've seen displayed during
the fsck, I'm thinking I'm going to reinstall all packages.
Assuming the issue was related to the power outage, I do wonder why
there weren't any fsck issues at bootup at that time. I hadn't had any
disk issues before with that card.
At least now I know the issue would be resolved by not saving the lost
files and I can continue on my merry way.
