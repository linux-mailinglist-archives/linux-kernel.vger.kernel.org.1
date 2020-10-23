Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8993B29746E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465112AbgJWQgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464515AbgJWQgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:36:41 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F81C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:36:41 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z5so2537223iob.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOj/oHfwxUuvaYgCe+uyCqY9qKTixx5oRdiXvb0Y2Lo=;
        b=Gbrae/12ltjvScvPtnck8CY8F6IEdPW8r/G5bdTru4Mr495QtvKEqkx0wCOE4lldFA
         SHWlX0VslTR9iSEUphZvQvdMtzRWnTwBUSTSOQCNJtQrWAESJzw7fIL7AJr9kGtbZ8/f
         HMM2cinNOf8VUvHb41p7hJGjHIG673cq2szUmhE3kOz3xfp1UUVPbv55iYMtLZlGbcMg
         2iheUBSAqcfjBWrv70lgwLHePg9f8H9Js/Omdq5aylRwapBb8j2dcsCtRwrhSnYCzJWN
         sta32ZfUuTVJCWy5XvjMNjk3eFd3zJKRe2SPo5ZXFGwpNAwCudtKiCk8dzg87ZaFFOIJ
         kCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOj/oHfwxUuvaYgCe+uyCqY9qKTixx5oRdiXvb0Y2Lo=;
        b=kVYqssWHYIsf9/UrlNYIZFzOEwDG7GtBXb/bn8f1xTzdVJLrw2OKDXSAOZ1W9Po1Sa
         hdXglQaF0Yy2ZgBd9ZYsTMTGmZ/Ux9/Qg3oVd9LFUyykAh2G7Jxw6ZhPIt8/EwPg0dMn
         g11xtObxegP/FdUHNHyJ0pDJjumc49Q18bnR9BW8uFl4V7xOmfthy7LtV/Z2L8C17nEw
         MZ03+qPjjZ6/UiKsW3OLBd3ntpY330OwjMLIpDnQ3XRhdxCTXP/Lsp7Ny16dVjTERbc2
         3ej0VgO0fwDZg9o/TRwtiDCDRQimqCrscQwrcku/dqjq5z4vq8gvuhuZmF9feE4Tq0Yv
         7k3w==
X-Gm-Message-State: AOAM5335XF7xwMQRTjy/5pTFjdMkTQY16xql7eeXW9wOdwgPVRwhX4Ut
        ZL8iqFAF7wPNFOwhekD0QSayon1yHjtRlxaQD9sM2w==
X-Google-Smtp-Source: ABdhPJznzDOojs2FtX5ZA1bExkgHggY5gvxhCu5xAgM9eK5VkKYxyXwxGKhU6pI5JVBM4/sb4lnPGLtlKOILsQYlJxg=
X-Received: by 2002:a5d:8e12:: with SMTP id e18mr2043995iod.99.1603471000904;
 Fri, 23 Oct 2020 09:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201023111352.GA289522@rdias-suse-pc.lan> <CANn89iJDt=XpUZA_uYK98cK8tctW6M=f4RFtGQpTxRaqwnnqSQ@mail.gmail.com>
 <20201023155145.GA316015@rdias-suse-pc.lan> <CANn89iL2VOH+Mg9-U7pkpMkKykDfhoX-GMRnF-oBmZmCGohDtA@mail.gmail.com>
 <20201023160628.GA316690@rdias-suse-pc.lan>
In-Reply-To: <20201023160628.GA316690@rdias-suse-pc.lan>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 23 Oct 2020 18:36:29 +0200
Message-ID: <CANn89i+OZF2HJQYT0FGtzyFeZMdof9RAfGXQRKUVY6Hg9ZPpcg@mail.gmail.com>
Subject: Re: [PATCH] tcp: fix race condition when creating child sockets from syncookies
To:     Ricardo Dias <rdias@memsql.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 6:06 PM Ricardo Dias <rdias@memsql.com> wrote:

> And what about the loopback interface? Why couldn't the loopback
> interface also use a single RX queue?
>

Loopback is using a per-cpu queue, with no crossing, for efficiency.

That means : whenever a packet is sent on lo interface from CPU X, it
is put on CPU X backlog queue.

If the connect() and sendmsg() are run from different cpus, then the
ACK (from last packet of 3WH) and the data packet might land on
different queues.
