Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74AC2B4643
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbgKPOrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgKPOrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:47:18 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C483C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:47:16 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id o21so24794276ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37us/O2JuQQ2yWSt9utM2XNcG7HUXMnxEW//yI4vlLg=;
        b=a9hRi/xbObOHWi15XDluUp/RuCjyo9TWYSNG5gEAfGZ6VbBTqZmZ9YNCZ03u0kWv4c
         QeRDQYNgwQY+92LUH3CObQJQlkSR1J+uhAhM/I3RsJv1FSHfWkb4vh8QFdwyb62jrShP
         4+wEWJnVFduAueJhJ07s0/iWyKS1lKegSBsRMPDhjx5KafioA+0hRv1oO0EZ+Q8sTbSD
         jcVGlGgPvcg88V59EHvYILaLOu63eMQcA/FHbvfDtY4wBYK+/9YdMN/tDK4YUdiowysL
         5/iemqpyYNXMml57MFxKRYN+VwY9lGReknnFNoTLkswUyRJQfzQdqW62MzN282dVnLBB
         ZOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37us/O2JuQQ2yWSt9utM2XNcG7HUXMnxEW//yI4vlLg=;
        b=qujSVH+SNz+baIm8P9NoOvuGOZTWNs4QOjX4M02N8EmVWb8Y/0j0HJym36CVvBblG/
         MTfFpfp9epplN9hTN5OsmIUQ/zbyq77XwE8NRi3qL1SQqqE7/L9D0PpIlR/F0VBUHkyC
         AFEBPMjAMh9JZcmzXjEmKljV3kh739+q9ZRRzzdsJeC/dViJNgnsJ/FgKnKZU+ZpED8Z
         joxQvAVkzIPxJ6ywHvPeNY6l4axTap8ARDXviPlgNGf818ONENLdT1dg2e03Eo81uuTC
         i+wPBs8Kr1QVU702msvZ4GLwJHonOp79QApW0qde+tjYiwxQXvapSnQg3IfSirwXt0U8
         FCrg==
X-Gm-Message-State: AOAM53346PIOVFdtxOfC3KN1aOOHiBcXtZop4qvC6vLyl5P/A8tux4r4
        e7hQCtTUtT6u4ni8I8aTzyDDfJNeuQB0o0MykkU=
X-Google-Smtp-Source: ABdhPJwpRbMQTvr0CF6s5x8FvX/SZKNXSWOieMKYK1Wr0yMxv/pThUC1Rupo6v3JraBPzPBenM8SMBQEzfFfxpG+++Q=
X-Received: by 2002:a17:906:2313:: with SMTP id l19mr13373862eja.443.1605538035300;
 Mon, 16 Nov 2020 06:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20201113122328.22942-1-jcmvbkbc@gmail.com> <87zh3ll6hw.fsf@nanos.tec.linutronix.de>
 <CAMo8BfKEr-89awEnV072uWR=4fniDRJ0drWmZrtnyvj-mANk0A@mail.gmail.com>
 <87sg9dl3xk.fsf@nanos.tec.linutronix.de> <CAMo8Bf+2kGmg_SvJz8R=qXgPWbYWmf-PSeG71xKe5AB2LeyZ4Q@mail.gmail.com>
 <87mtzklwc7.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87mtzklwc7.fsf@nanos.tec.linutronix.de>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 16 Nov 2020 06:47:03 -0800
Message-ID: <CAMo8BfLFZ_X8y1XLZnBb-VkOPMhXT4Daau9ydKAU9L_64Zap4w@mail.gmail.com>
Subject: Re: [PATCH] highmem: fix highmem for xtensa
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Nov 13, 2020 at 2:34 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> I agree that the top down mechanics is not really intuitive, but that
> does not justify the ifdeffery in the generic code.

But then maybe xtensa did the right thing where everyone else just
copied the not really intuitive implementation? If nobody else cares
then maybe generic fix_to_virt/virt_to_fix can be changed for positive
indexing?

> xtensa can just use the generic fix_to_virt/virt_to_fix mechanics. All
> it needs is to adjust the mapping defines and to adjust the color offset
> to
>
>         NR_COLORS - color
>
> which is not an unreasonable ask. As a side effect all highmem inflicted
> systems which do not have the cache aliasing problem can just use the
> generic code as is. See untested patch below.

Thanks. I'll test this patch and post the result.
But still this change doesn't look like a step in the right direction to me:
I can't find the reason why fixmap must be indexed backwards.

> It builds for some configs, but the smp_lx200_defconfig (which has the
> aliasing) it fails to build even without this patch (highmem.o at least
> builds).
>
> Toolchain is the one from https://mirrors.edge.kernel.org/pub/tools/crosstool/

xtensa toolchain must match the selected CPU core. For smp_lx200_defconfig
the toolchain is available here:
https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-test_mmuhifi_c3-elf.tar.gz

-- 
Thanks.
-- Max
