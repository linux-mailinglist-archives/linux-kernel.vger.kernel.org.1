Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F062C6D79
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 23:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgK0W66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 17:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbgK0W4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 17:56:54 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEE5C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 14:56:54 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id s9so7497308ljo.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 14:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EEgXuLgFFzflMIWu+IVyNpreE9VNoLiTG5aY7t2AQp4=;
        b=YJi2Oh06MyyGpLhe+AmMQCgYMmgqSCD7S2kZLK8zqo9j65RnK/mBoJJW4dzgwUXvAJ
         U2eQMkq0jAxgRs0GvBfqfPFkpNBWDeFVfQseoeKJwCShaw41PMvcBHtF4sbEY3LH2GIj
         A/ru4rUm7qsKXuDC2Jdhkep9uzhy//aLQ6/+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEgXuLgFFzflMIWu+IVyNpreE9VNoLiTG5aY7t2AQp4=;
        b=BvUx7+Mc43lczs3n68gLNtEfQPDWpbsKazA2k8VlNKEmzarxl/gdCcLYsDBViUjuZx
         R1Hu2pQTohh95F+XqBu0LmiV3SEdaMkgFTuqkXag1ayu40bZvshEncvXJ+nTirOkwbyM
         VQpeHoK4ZNbJxtk6p4uNmp8+PnxWOyJkwUYSVFvXLVdoaMCdy/C/skXD9CieYAFvaSzt
         4VBN3LuLD4l5zDi4WIBXjt0/CNfEUJOlnQr3vSsbWCT/+0k0dFiUs02SOO2Kg1BAYqV1
         G+FNmp4GbD0i8MztcD5taopXc6HK0B6sh77jsDFyBdvgNYEPZvUPx+LdbEPUWafraECG
         hcmg==
X-Gm-Message-State: AOAM533uUcum2M0/8h7uXvlwD2tRHml/hk0l6upP0nBxiV/prXF0mRoA
        U0nMAzho7IKpzMDq83ec/E9zYBzlTrH/Dw==
X-Google-Smtp-Source: ABdhPJzp6i3C5V5RaBMziOfEJNK1ulGwTrUSCz0Zs8oUCvBTjU3dtdeWCTq7W28moPPQipNbIHhbng==
X-Received: by 2002:a2e:9b58:: with SMTP id o24mr4863766ljj.84.1606517812487;
        Fri, 27 Nov 2020 14:56:52 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id m13sm1117531ljg.30.2020.11.27.14.56.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 14:56:51 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id q13so8377003lfr.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 14:56:51 -0800 (PST)
X-Received: by 2002:a19:c301:: with SMTP id t1mr4235349lff.105.1606517810846;
 Fri, 27 Nov 2020 14:56:50 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2Habmz95y+J+-4NiT5SGYhO_Fia-SHhapX-3NYRbEMmw@mail.gmail.com>
In-Reply-To: <CAK8P3a2Habmz95y+J+-4NiT5SGYhO_Fia-SHhapX-3NYRbEMmw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Nov 2020 14:56:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjA2Der39e_SWZ6S-DoVCJTu-Zwf6jn2wxmGTKzNPV1Dw@mail.gmail.com>
Message-ID: <CAHk-=wjA2Der39e_SWZ6S-DoVCJTu-Zwf6jn2wxmGTKzNPV1Dw@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.10, part 3
To:     Arnd Bergmann <arnd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 12:51 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
>  - Some DT patches for the Rockchip RK3399 platform,
>    in particular fixing the MMC device ordering that
>    recently became nondeterministic with async probe.

Uhhuh.

I didn't realize this MMC breakage happened.

That's just an MMC bug. Other subsystems have been able to do async
probing without making device ordering be random.

So this really smells wrong, and I just never realized.

Added Douglas Anderson to the cc - the whole PROBE_PREFER_ASYNCHRONOUS
behavior appears broken.

You basically should do the device numbering synchronously (or better
yet - asynchronously, but single-threaded for the subsystem), and then
asynchronously probe the actual device details after you've numbered
them reliably.

This is not something new - we do this for pretty much all the other
block devices, and MMC is just doing things wrong.

See SCSI probing for the traditional horrible cases (where just
spinning up a disk could take tens of seconds).  "Slow probing" is not
an excuse of "random ordering".

Behaving randomly is simply not acceptable.

             Linus
