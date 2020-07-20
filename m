Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F6622634C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 17:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgGTP2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 11:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTP2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:28:47 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0CDC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:28:46 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 18so12491638otv.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdh/3oobHD34a1kJiuWq2ijPPTIyAhzdnaJOlh4baoc=;
        b=UryDttv08+Kd0782Ub9jObflwCo8KN1o0aD8XVBshgaChXB90YeJO530ewsyByqXTF
         AolsatR1PSYBGlkIVDrbVOwordJi1QMccuXNLspdRg9WMK0ujskd/HwRBFOzfBw2XRrk
         83tN/LB1+HDgaoVe6tLiPOfCqxSqoKDO8v5GRWC1HyNG4qNuj8qJZO93z4fOi00n4f7y
         suTwI4BNLl203srmzUadzj1q0v30jjDsn8mUXAJ6Y3Jlq1+wXyKWWXLh0NwXjmC1NtI6
         6TtsLkhCdrPkAu5Citobl/Fp88+0vwJMNe0oNL0nponhuXzcsvRRX2feztaCUr/txyJJ
         Z9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdh/3oobHD34a1kJiuWq2ijPPTIyAhzdnaJOlh4baoc=;
        b=ju5jLRt9k0mabE+OAnzJvhiky/Ks4ubAe74VHEEMr45/Aup9ZvS0X2hWxAvGyZ6LHY
         B4KY6UvZSJWdSuXFWMQM0jD/r6OILdkvv5k5huXGYMJ0tMhtcRniNdVDedg+rAsmBN4a
         +6eobY3lvE7jFp6MRGdLMJyNQkAmYAPsLv1Kq/+BS1g5puQwV1b3/zCgPFI/IeU5xDd3
         kFNSC/Hx4TziaLlfhqJFfw94ujWXxk9WcTISdmXPx41Vw6+AXriLyIq599kTRlbWR3Qa
         z0c3B3j54EecEilXUGRTd0qBsC/WewVz/+zU6aoHie54o8XZuCFHdVXR9ktdgu7YQAf0
         LSHQ==
X-Gm-Message-State: AOAM5303emeWPithNsdWPwGP9oPXC/ioMSRsxOqs8mXT+P0NBDdMoGhU
        FH/nY6QmBl3LLuBMx2OD8ZoJgrbpaujp+ZEAnsv0sA==
X-Google-Smtp-Source: ABdhPJzgL662DP2DY0joCjZPstwjO1Nm06BA6C3F+sweNoSKCLCmH/ycjqQz9ppNVau0BOd2rVRcptooWNlRCz/9jhw=
X-Received: by 2002:a05:6830:10ce:: with SMTP id z14mr21044319oto.135.1595258926244;
 Mon, 20 Jul 2020 08:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-2-hch@lst.de>
 <20200718013849.GA157764@roeck-us.net> <20200718094846.GA8593@lst.de>
 <fe1d4a6d-e32d-6994-a08b-40134000e988@roeck-us.net> <20200720100104.GA20196@lst.de>
 <c6099697-5ccd-22b4-f5cb-cbe1c14644a9@roeck-us.net>
In-Reply-To: <c6099697-5ccd-22b4-f5cb-cbe1c14644a9@roeck-us.net>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 20 Jul 2020 16:28:35 +0100
Message-ID: <CAFEAcA8=O6TbxYwmRwZJbcqFKi364=ueV_TsTu_84M5WFVtD8g@mail.gmail.com>
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in addr_limit_user_check
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 at 15:55, Guenter Roeck <linux@roeck-us.net> wrote:
> Ah, sorry, you can't use the upstream version of qemu to test mps2-an385
> Linux images. You'll have to use a version from https://github.com/groeck/qemu.
> I'd recommend to use the v5.0.0-local branch.
>
> I had to make some changes to qemu to be able to boot mps2-an385.
> I tried to submit those changes into upstream qemu, but that was
> rejected because, as I was told, the qemu implementation
> would no longer reflect the real hardware with those changes in
> place.

Yes; the rationale is that if you wanted to boot a kernel
on an actual MPS2 board you'd need a bit of guest code to
start it up (and to bundle the initrd/dtb in with it), so
since you need to write that code anyway you could use it for
booting the kernel in QEMU too.

I appreciate that this is awkward for kernel developers (and
perhaps for some other users too), but QEMU's handling of
-kernel and built-in-bootloader code is already a morass of
special cases and do-what-I-mean behaviour that I'm not
enthusiastic about further complicating :-)

(https://lists.gnu.org/archive/html/qemu-arm/2018-06/msg00393.html
has the archive of our original discussion on the point, for
other readers of this post interested in further context and
discussion.)

thanks
-- PMM
