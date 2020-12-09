Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EB02D454A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgLIPXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgLIPXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:23:16 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30440C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 07:22:36 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id a12so2154784wrv.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 07:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTgwVeeqci2xCcDuc9NOyWDrkF20FO+ohqACUzZkke0=;
        b=WnILBfwlCP0Q0e3BrnCYKb3P0YWTRXpVBH/BJmLF5J1Pd8ffrhvQBMo7V8u+rbAVVg
         4suonF/4o9Wmp/xvl2yym/d9/a6QbjNS2WPA4qUfqdDTDXGfXEMa0R6F65RB+aCQABFg
         1FD5x9caoY38cIY0UP/uzgco/iiDxoeLVbmynNkhaRVGMlmzTBPXhqID01Yo5FT5i6I3
         q4S04LDaqbSVIbhWlilxvNfZ4tcSbpHrouU8MEEBAmhFBQHBX+TGcuZ4Dm4f7qeN+UPE
         /NHRP12oWzncxsV1cQhxlj3mz2gxj+PPt+KkLuuLJPJaHFe0+zhXZyIMha6FLW+FqYYn
         feSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTgwVeeqci2xCcDuc9NOyWDrkF20FO+ohqACUzZkke0=;
        b=fsS3WqL7Q96vjt2KucM2GxoU1ZN1GG+2Ehn+4piIrh2t6mHVtOf89LHtMLXyLVHAi7
         1PoJfccM3nGUlORUuWf36HfB/Qg6SwG0+ZdFXDUiGX7GTmpIVwxOFj6bNKv4StFVdk6I
         rPE9SdQ3SAm2w/kv08RxPPJwO5z/RDeoA0lHBVl74SQpUtMG50TEoZEU4Fo2Nk5ou5EF
         iX77lFQsgnbCuedtoma+WylS0bx9rKJmZibKzWwudCWrsn3/yTsCg1s8hU2Kg2LJmaDE
         kMn4tDNvCqx24eya1NfdECSiE/w5T3oL2kvU1lz14Zn9rDDcujXZ0+m1XRqhHdrA9DQO
         FKSQ==
X-Gm-Message-State: AOAM530lUgsEUp9vZu6UMFvBU1i3PbSEo+CH+wT73ZLjxfhIF2cusowf
        FQdsULAJoROBPkHqQi+EubXi+XzcB12Ikjn2PMw=
X-Google-Smtp-Source: ABdhPJyZLOqHJZEwBlxAiDLN5z/ofKNjNxvzAaQG0i7Geg3uaEI2LcKDglXptmQa/kD3A0kSSfMDLu8quGpd+sBl6bs=
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr3264563wrw.123.1607527354801;
 Wed, 09 Dec 2020 07:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20201206152352.35026-1-dwaipayanray1@gmail.com> <CAKXUXMxD9wyaKf1TrZchOY1NBkFKSrHhFefQc9AK-bfH8fu8oA@mail.gmail.com>
In-Reply-To: <CAKXUXMxD9wyaKf1TrZchOY1NBkFKSrHhFefQc9AK-bfH8fu8oA@mail.gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Wed, 9 Dec 2020 20:52:08 +0530
Message-ID: <CABJPP5CKC3QafB7LvP758Gsoqe7xinYT7P9CED_j1kU-LVGFFQ@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add --fix option to include linux checks
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Dwaipayan, can you run this rule from checkpatch.pl on all files in
> the current linux-next tree and share all findings with me?
>
> Maybe, we can fix a few places and improve the rule.
>
> Lukas
>
Hi,
I am actually a bit confused here. I couldn't find any particular place in
documentation which demarcates where to include asm or linux headers.
As far as my understanding, include/linux headers are meant to be
architecture independent.

There are several places in the kernel tree which use the <asm/*> headers.
Checkpatch emits warnings for the following headers in kernel/ :

kernel/dma/swiotlb.c:43:#include <asm/io.h>
kernel/exit.c:69:#include <asm/mmu_context.h>
kernel/fork.c:103:#include <asm/mmu_context.h>
kernel/irq_work.c:21:#include <asm/processor.h>
kernel/module-internal.h:9:#include <asm/module.h>
kernel/module.c:45:#include <asm/mmu_context.h>
kernel/resource.c:27:#include <asm/io.h>
kernel/power/snapshot.c:36:#include <asm/mmu_context.h>
kernel/power/snapshot.c:38:#include <asm/io.h>
kernel/sys.c:73:#include <asm/io.h>
kernel/sysctl.c:78:#include <asm/processor.h>
kernel/sysctl.c:81:#include <asm/nmi.h>
kernel/sysctl.c:83:#include <asm/io.h>
kernel/time/timer.c:52:#include <asm/io.h>

drivers/ had yet a more number of such uses.

I am not entirely sure that changing them will break more stuff or not.
It would be great to have your opinions on this as experienced kernel
programmers.

Thank you,
Dwaipayan.
