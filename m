Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0CB286639
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgJGRtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgJGRtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:49:49 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B81FC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 10:49:49 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id t18so3049285ilo.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nJKk1hLd7KbKjZ00VmZ+hLnKCsK4KTZ8u5X+jlAR4/8=;
        b=fiNFvhC0EjVgl4an7ToE/0ySy/w4E+0JaskdSdW6m0Nlv+lH57csHVAXRBPDIlUx0c
         Ja7IPWM4uws9fR70U0A/S2LYStAHC2iEfJH+8lxqSb/pLf5B4qn2CgSz0HVTWgiNHnhc
         lA7+CcWN9OGG2zZXXpJDn+1dNWj/K3R2WcBnLfOxdm+2MiPmLpKrHFQsiIuE0MS+lKHG
         Nki+d1nxkU2Nbo1/+LbPlwQdRdeHLQAqkwaviefoiXTMstMuDJCmgj/kCItR7qIlHaYn
         nR3bTuv/mRuIxMG5HVMZRvkxKyNevr4lfdC9YsoiBFxx3cjqtIEhMG93CY6CqSd0O9jv
         IBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nJKk1hLd7KbKjZ00VmZ+hLnKCsK4KTZ8u5X+jlAR4/8=;
        b=ViMFhNbReJADGrYq8Wl8kewI/UriIDp1pHisoGJBIZvR64yMJCWzTDnepk1za7G5GH
         eBR4g1AJZeots9Tps2VrcdddWslXU4tqAndaOWs2kUCfGNC8LH2bEgfopZ3ZImPF7Xc7
         6XZteOegKH+y8yLwGxDKzPVGzFc3UpRo8PF56M+M0x/xKMyGZKVBcqXyl0uhyWI7/7AO
         WLOYdlCnunTZ4VQDmIWGk7hp4ia0r84Xe1N/AKmEG/9/EGnKNejtTPVdhV4+Wbh5IjRr
         nbtUVlGHPejhygGsDTIrIu2FvL+GOCOzpHLS3+RVadAhSYR5vx7D2FrQnKhvZqNr1472
         dQUg==
X-Gm-Message-State: AOAM5323v8xfbClckEwaIT8RZWzTsJsIPR0GlNcGZbShmzogNRPU2Mcx
        UlzOjL2gCQgp4gWUjsHB+FYXOfuYSk03blLdB4FLfIvZo0MdQw==
X-Google-Smtp-Source: ABdhPJx4hBU9oshybpAesDN7nAJJvTwASyZxpsLYRxIjEKstyiKTqDBC0hgHNOL2/vw/4v2pG2Oj72ecuhz6WaNkUUU=
X-Received: by 2002:a92:b30c:: with SMTP id p12mr3382233ilh.35.1602092988665;
 Wed, 07 Oct 2020 10:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAAObsKCP+ve2ZdXQk62aTo70G9i9Vo17dh6k-fcY23NC=EYZxg@mail.gmail.com>
In-Reply-To: <CAAObsKCP+ve2ZdXQk62aTo70G9i9Vo17dh6k-fcY23NC=EYZxg@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 7 Oct 2020 19:49:37 +0200
Message-ID: <CAJiuCcf3YYvAjyPwn8XK-56_YJ4dxQFAUOpL0nEQ8fnED5u8rQ@mail.gmail.com>
Subject: Re: devfreq and panfrost on Allwinner H6
To:     Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomeu,

On Wed, 7 Oct 2020 at 10:58, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
>
> Hi Cl=C3=A9ment,
>
> Have just noticed that my Pine H64 board hangs when I try to set the
> performance governor for the GPU devfreq.
>
> Is this a known bug?
Yes it is.

I try to summarize everything in this message:
https://lkml.org/lkml/2020/8/3/153

Clement

>
> Thanks,
>
> Tomeu
