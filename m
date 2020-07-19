Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE2D2253AE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 21:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgGST2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 15:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgGST2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 15:28:33 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BEDC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 12:28:33 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z24so17948173ljn.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOzG0VwI/nHjqcTTd/0RSnaqr0ty8WGWju2cNR/S0kY=;
        b=EXMQsuOcBH+qn3lSJ6Zx5JRTyYr/4OdJYaSMa4Bry4+gKY7gSdpbzK3GfXZScLAxXq
         pXBClpedVFxqvZNlQm7uABVvo9duzFbRns/ysfziBPCqArrRWPV4Ovr73eJqvwGS5A9t
         TMG9FhnMf83M1eb05gEyFrEkjtO/hs/Oz//jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOzG0VwI/nHjqcTTd/0RSnaqr0ty8WGWju2cNR/S0kY=;
        b=hyyyQUBlesdYlr5PeNbMb7g0+aF8+ts3Jtvq6EvB9qx5/N/WlxFRezv950D7MObBdG
         cci3hSQBs/nfpn/V/Hzt74q1s44+ydZQErfJLpYte4jyE4Tt2t478EoiZITV069FZEDC
         Rt8x8Xpo6CGFnCEP3kE2CimwDdixgDv2R6uFUdqRzXC6K5Bulrf6QB9xNo1xJikWheRQ
         9WrXNJSEPB+3e2ZI1v+l5WQl7VNuBQzDH3/uipjkqPKpr4m6BoHunrRklHVkkj5cHL7O
         dJm56QnUvcmyYo/5czqVi1nBAO/vTg/ax4beHkPX/nSP4JDEjXYBKs0xZ0sOdIx/zyg6
         zwqQ==
X-Gm-Message-State: AOAM532u8AHvaL4gjalbjaExwaEymqDDEv/+PCzQH4NA7zmX+0IAkReI
        A9uruQ5iMVTOFKnym/dc0MoLYD90rz0=
X-Google-Smtp-Source: ABdhPJzeLqlXCq2xn1mJHgMrby/XHFoQNHDhmV2WSaYJrdfVM9XEGIZ1wf6C0GvCXlwplJe1W6jqsg==
X-Received: by 2002:a2e:a168:: with SMTP id u8mr8017797ljl.178.1595186911211;
        Sun, 19 Jul 2020 12:28:31 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id l5sm2825604ljh.56.2020.07.19.12.28.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2020 12:28:30 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id f5so17956951ljj.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 12:28:29 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr9071955ljj.312.1595186909554;
 Sun, 19 Jul 2020 12:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200719031733.GI2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200719031733.GI2786714@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Jul 2020 12:28:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7f5vG+s=aFsskzcTRs+f7MVHK9yJFZtUEfndy6ScKRQ@mail.gmail.com>
Message-ID: <CAHk-=wi7f5vG+s=aFsskzcTRs+f7MVHK9yJFZtUEfndy6ScKRQ@mail.gmail.com>
Subject: Re: [RFC] raw_copy_from_user() semantics
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 8:17 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         So any byte-squeezing loop of that sort would break on a bunch
> of architectures.

I think we should try to get rid of the exact semantics.

If "copy_from/to_user()" takes a fault because it does a
larger-than-byte access (and with unrolling, it could be a _lot_
larger than one byte: x86 dcurrently has that "generic" case that
isn't used very much, but it unrolls 8-byte accesses 8 times, so it
does a 64-byte block that we could just say "if any fo those didn't
work, then you're done), then the copy failed. The exact number of
bytes we _could_ have copied is not important.

So we could simplify the x86 end condition too and remove all the
"handle_tail" complexity.

                  Linus

(*) Yes, it aligns things to 64-byte boundaries too, but only for the
write side, not the read side.
