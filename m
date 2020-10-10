Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7ED289F08
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 09:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgJJH4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 03:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbgJJHzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 03:55:10 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CB5C0613D0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 00:55:10 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c2so13067215qkf.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIbfa8CnKY7IkW3rParF9jXfx9AUSNx+WkfiE3ixDLU=;
        b=K74AqtWTCzeJ3fHFsLhU28oHxZJ+TBfWXN0ajy3/k79H47kIb6MQDZ9nJQCyC7X1FQ
         tr6uLNZQBBPRT+S6uqbkjrpuJdO3XjwIxeDqOGwnGiO7ZtFx3PGlnbSpe/ewrpp7dpmA
         6yM6plNwn4lhupl/UBahvQezEoGzNs3DkYzamN5bJXG5KgZ3aRevOBWopKO2nKx5gcdh
         wrxutUi4qd2RDt9iHtSgJIroiijkuyHseBKYyMkxv2dBGNmX45+SzDmE+11usmet2Y3C
         B9ycpdjwSsWETinivuhVzm/zmT56SoTeMaLwEoQRLw8++vWysmVZQwgYvmFoF0KUJnBc
         IhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIbfa8CnKY7IkW3rParF9jXfx9AUSNx+WkfiE3ixDLU=;
        b=AlIPBjgdswY9UjqBPwtQu0s0rvUM9HX+mL0H0/biSN4YybQgK1x0MncG6QWSI2am0x
         tJT9BX6s8apqLazGJpePitSAy4nIZHHyT4d+ml1HuAkyA01QM+/CE1i+D6dwsHiHQbLP
         yBk05FMzjFfnzHCgJw0us7wbS36nmQskobJmtf2Mwv6gruA9RUb51KbHgKz7JlXAYXv4
         gyl0OVTbt26Y83Rudb+I39Y0rFpKLuvG9GH+ZyYIXVKBiL2TupRZp9spryT4L1Ddve0L
         RkGKqWeRVBxDgL6KbVyWHgNSvjM8k70tIEryC2ch7NNvInJvgI98TLLHH8WWJ5Zrpf40
         n3iQ==
X-Gm-Message-State: AOAM530XrdDkkyRwwkxIaGpJwFcSkwzJ2WAZ72TizBr1Sp38/B6KFsRY
        Nv3Qn2GuTKSaZdp6wGghsuXGvM/3rOOKMreFg3TiOw==
X-Google-Smtp-Source: ABdhPJyGZIeP/r5j1IxcIHRQMZhGLZo7w7MDc8zflXTalRA5Cb9Of04dAcnojeKE3/QoqUcIaXbsjr/CPBqlOjWL7RA=
X-Received: by 2002:a37:5684:: with SMTP id k126mr1356621qkb.43.1602316509213;
 Sat, 10 Oct 2020 00:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201007101726.3149375-1-a.nogikh@gmail.com> <20201007101726.3149375-2-a.nogikh@gmail.com>
 <20201009161558.57792e1a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201009161558.57792e1a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 10 Oct 2020 09:54:57 +0200
Message-ID: <CACT4Y+ZF_umjBpyJiCb8YPQOOSofG-M9h0CB=xn3bCgK=Kr=9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: store KCOV remote handle in sk_buff
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Aleksandr Nogikh <a.nogikh@gmail.com>,
        David Miller <davem@davemloft.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Dumazet <edumazet@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 1:16 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed,  7 Oct 2020 10:17:25 +0000 Aleksandr Nogikh wrote:
> > From: Aleksandr Nogikh <nogikh@google.com>
> >
> > Remote KCOV coverage collection enables coverage-guided fuzzing of the
> > code that is not reachable during normal system call execution. It is
> > especially helpful for fuzzing networking subsystems, where it is
> > common to perform packet handling in separate work queues even for the
> > packets that originated directly from the user space.
> >
> > Enable coverage-guided frame injection by adding a kcov_handle
> > parameter to sk_buff structure. Initialization in __alloc_skb ensures
> > that no socket buffer that was generated during a system call will be
> > missed.
> >
> > Code that is of interest and that performs packet processing should be
> > annotated with kcov_remote_start()/kcov_remote_stop().
> >
> > An alternative approach is to determine kcov_handle solely on the
> > basis of the device/interface that received the specific socket
> > buffer. However, in this case it would be impossible to distinguish
> > between packets that originated from normal background network
> > processes and those that were intentionally injected from the user
> > space.
> >
> > Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
>
> Could you use skb_extensions for this?

Why? If for space, this is already under a non-production ifdef.
