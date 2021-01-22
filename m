Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2610300DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbhAVUon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730458AbhAVUmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:42:36 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1A3C061797
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:41:39 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q1so13892150ion.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+7s2tkVUfM+BW/7C7dTp16gqbBze+VCFXaj6B34TXk=;
        b=XRup72qxPpm4XucnYUWWeTrU8zT1PVzcryeZqqt0TZNUriBcCV7X4Fao8MBin4HMWr
         Rd/NO378OhnB0m5mGUkXdU2gUoUfY3Ln8ACRtV7O7HllUUd75LZzb/yBcBSKsbyags7Q
         ivdJGru80ZQYqYuv3FyAjaU3YqexHBtkgAwEgZcEXyGKz8cI21K86lU+vduYDgzpe9Xo
         q3iddcUdBwIoqvdU44qu+VDkfdapD2aelJ8ZJZ12Qzg5Gy9W1kDdaniTpZIaL6+/MqyI
         V6W+QLdsjXxwUwXWe+qScL9fabX1pvLZagXcByHOZbWl2S/iJjrSswtEQEJtkWOBYtJ5
         gflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+7s2tkVUfM+BW/7C7dTp16gqbBze+VCFXaj6B34TXk=;
        b=LBksygVZQ1Y67FPvBsG+Yx/M8TOpdVUlQP8Nne0sv7ciiZciPvyC2YYHmQwWteoeLs
         QsZG+01Sp4fA9rSGFohwBXNCW64wyW2QVhTgAC6ZAxk8vkrHcuRF2ESe2SO/Qrp8acJS
         xQ4LnyxIwpCD2QBL7or9LKfhCsW0rmVukKXanhh1xFaPfi90YhuWC5oiLV3egbGgXFga
         7TPAS2PjXtFE1Zf51azdCdw0Rcp9BZh6I+1easCs9KqQZ2h1izSvPx89J0mQk7LGK4kZ
         Kv7ggRU9Jsl5cbQ8yP4C5dN4fYA1YPza/krZHRLzFh5a5t7B2JmIbvHxTLlHOhb4Rh9V
         pZgQ==
X-Gm-Message-State: AOAM533T0iorNjG1ZNGAyUJDVxjtLT0dkHi9XdXU1uN/NWDnau882Kuj
        zWO3XkMBMZAnazCoFkBTj3q/vH+QSWz5SS9qsWms7A==
X-Google-Smtp-Source: ABdhPJxLMyDjGbtY2wgA8tFrQ/qTzOK66CQMt4Xb4gbdaIM3nCoCLboO+3v3ou2vq+M7xjHoB/hFoqJ8Qbmte5x0A5o=
X-Received: by 2002:a92:d3c7:: with SMTP id c7mr300561ilh.137.1611348098424;
 Fri, 22 Jan 2021 12:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20210122191306.GA99540@localhost.localdomain>
In-Reply-To: <20210122191306.GA99540@localhost.localdomain>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 22 Jan 2021 21:41:27 +0100
Message-ID: <CANn89iLBvwmRbbgw=U3z8k+i_S-ycSf7K-ow4rH5ZQP9CFJuWQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: make TCP_USER_TIMEOUT accurate for zero window probes
To:     Enke Chen <enkechen2020@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 8:13 PM Enke Chen <enkechen2020@gmail.com> wrote:
>
> From: Enke Chen <enchen@paloaltonetworks.com>
>
> The TCP_USER_TIMEOUT is checked by the 0-window probe timer. As the
> timer has backoff with a max interval of about two minutes, the
> actual timeout for TCP_USER_TIMEOUT can be off by up to two minutes.
>
> In this patch the TCP_USER_TIMEOUT is made more accurate by taking it
> into account when computing the timer value for the 0-window probes.
>
> This patch is similar to the one that made TCP_USER_TIMEOUT accurate for
> RTOs in commit b701a99e431d ("tcp: Add tcp_clamp_rto_to_user_timeout()
> helper to improve accuracy").
>
> Signed-off-by: Enke Chen <enchen@paloaltonetworks.com>
> Reviewed-by: Neal Cardwell <ncardwell@google.com>
> ---

SGTM, thanks !

Signed-off-by: Eric Dumazet <edumazet@google.com>
