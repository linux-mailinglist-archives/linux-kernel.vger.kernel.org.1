Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E88B2D9E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440501AbgLNRpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408667AbgLNRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:43:36 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7574C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:42:55 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id p187so17697111iod.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2g3ysOsJdNzEHZSSjvgiAWWwXSJ7VSQG7WGeKf7EDYk=;
        b=YG9PnxTSKYgBempGvb8oIQ0ZUjnxFLFY9lVP36eWpSwy/UNdJXm1p8kAEO92XCO9/L
         +M2XkJOwRpu57IPEoM8xoc65PDeD6kDcpNqz5861UoiqYc0WGxwfVjdE6wCIGVaErfmJ
         XyqFzO5VJYy59o1hHckA/ZHNZKnnn/JlFUQSNq0VJWx7hGXCo0D35oFb76u2fzBTz4DB
         I7SuIRSGBfD8B5Iluy9k34utuW5foouxlkqtOeixqqzhJvZh4AjBheQgOvu4KVq8Z8Dm
         fpGtOx6rIylJFh9xqW8cFy6AJq3t0ng6rhmPC3/ZAtSbOhY//25azRsAyH8X3dQ/qJFc
         OKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2g3ysOsJdNzEHZSSjvgiAWWwXSJ7VSQG7WGeKf7EDYk=;
        b=bbLehC852PCUIGxOvk3S0WlAuQY3VQT6vyRyZSpGFkSN7YmmzhTcRYXItZ5rpkTt3J
         KgfJ+sBjNJWpPcCSuXssZZPBp8YuFntcAY4oK9hWIUlvVlmV9aKxPpBPc4y9yLHJDYRG
         hbfrpjgkzFS1k95UHI2NcL0mmJUlkjumOhMAzFEoP+JD0wA/yOYSRZu4f4oQTjMuLdqg
         tknzusswX62HM5wUxoKGMML2pw0405Qr5UMJTgRztQJ82X6SuZXNeYARFA5gHO6ggBQg
         h6gNSuHTLEwNvCEFXUQ111i1VDTckGSxuQHE8QFX4X5CVVMYp+Bb2fAnOCiGVnWSRmXc
         ZYew==
X-Gm-Message-State: AOAM531kAf8K51cOGIK25wPYKmdU4TkycsW4RK1YQUBqrA9NcVzkrXIN
        qN64On15WB4EjJZY2oX8pcEGblV4Dwc4j2zjYUiFlg==
X-Google-Smtp-Source: ABdhPJxQIvPI7dl8A7igWTP6S4CLb5Xwr+XZkZhlbucrEej5y+mRdN41Y0ICpzSNqKL08gmbeYE1lOzPkDXLsQo5Ryo=
X-Received: by 2002:a6b:c8c1:: with SMTP id y184mr32647847iof.99.1607967774499;
 Mon, 14 Dec 2020 09:42:54 -0800 (PST)
MIME-Version: 1.0
References: <160780498125.3272.15437756269539236825.stgit@localhost.localdomain>
In-Reply-To: <160780498125.3272.15437756269539236825.stgit@localhost.localdomain>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 14 Dec 2020 18:42:42 +0100
Message-ID: <CANn89i+uQ0p81O3-aWO-WPifc35KtpDFRsO9WJKrXxEhpArDWw@mail.gmail.com>
Subject: Re: [net-next PATCH v3] tcp: Add logic to check for SYN w/ data in tcp_simple_retransmit
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 9:31 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> From: Alexander Duyck <alexanderduyck@fb.com>
>
> There are cases where a fastopen SYN may trigger either a ICMP_TOOBIG
> message in the case of IPv6 or a fragmentation request in the case of
> IPv4. This results in the socket stalling for a second or more as it does
> not respond to the message by retransmitting the SYN frame.
>
> Normally a SYN frame should not be able to trigger a ICMP_TOOBIG or
> ICMP_FRAG_NEEDED however in the case of fastopen we can have a frame that
> makes use of the entire MSS. In the case of fastopen it does, and an
> additional complication is that the retransmit queue doesn't contain the
> original frames. As a result when tcp_simple_retransmit is called and
> walks the list of frames in the queue it may not mark the frames as lost
> because both the SYN and the data packet each individually are smaller than
> the MSS size after the adjustment. This results in the socket being stalled
> until the retransmit timer kicks in and forces the SYN frame out again
> without the data attached.
>
> In order to resolve this we can reduce the MSS the packets are compared
> to in tcp_simple_retransmit to -1 for cases where we are still in the
> TCP_SYN_SENT state for a fastopen socket. Doing this we will mark all of
> the packets related to the fastopen SYN as lost.
>
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
>

SGTM, thanks !

Signed-off-by: Eric Dumazet <edumazet@google.com>

> v2: Changed logic to invalidate all retransmit queue frames if fastopen SYN
> v3: Updated commit message to reflect actual solution in 3rd paragraph
>
