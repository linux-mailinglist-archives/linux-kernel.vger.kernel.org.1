Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84B229710B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374546AbgJWODm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374541AbgJWODl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:03:41 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DBCC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 07:03:39 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id n5so1451861ile.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRssJ8ydvqoiUM8sCx1vOe+z6Z5ELMLVEz5GB2mujoE=;
        b=qVnKKmWEAm0tfevBxG8rohkBBkyKlxmoQaS3qyQab549eqEpSl0oV7ZaCdkNsJbuE/
         kHi1jn95s1rccakqFUVXeSml70b7i34pPKIw9QgA/oAn4nwBJGMmeDt7oXiL20a25XYn
         EtpfoTrKVJV9n11Kf1pR2NaFLqFzUvUqLI95fEX7R1//3V+5RGWmgfytn3HqwL2vZHww
         s3BpqsuRXbNW36+STmgyfKDXJX08GZS3f9WAWGo2EuQVeDczmDwa04ag4Wf2De51teAf
         JcbFqXGzwjreIWBEUAyHJlhHenkH4iRRke0qo/lb/6saPU51C+Dpbv3zJ1v5iXORC307
         6S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRssJ8ydvqoiUM8sCx1vOe+z6Z5ELMLVEz5GB2mujoE=;
        b=tZcew5Ii7zdnlyB1+TgiiuKgLtHJmZR3TO3i8ZHpvGxiV502gOsi9yF3obr1RRkwSZ
         7m2UhiDblr1LIKHRBc0eGdrv7upPDtALLJB2gZPb4tNGJ1RTCvZjQ8Syfa9xb5AS2ZLw
         H9e0f7pPDhL+0/RgWUFdcxV5ti3to4we33A4sHhAomnnn32NTHETWXdV0l5g6GWiH7Ou
         QK6PVO9tBzmA3pWRpTvqVxlsfguj35BTWeKpTM7MK95hfy3OhTtAGnSa9JQMnaKX4Vww
         tiLUeWlJ0M5rrxiIr+EuiFu1vHUyS9KZwhsCyitfB4RfCcN2YblKBTT5FDx6uY+lantE
         nLaA==
X-Gm-Message-State: AOAM533M+tECv9TTWIXuoSEC1+G2VdBtNEys2LdCLNCHu5nfW/LrIA8n
        eamXSgvMbzVDnaLHzKCO/LUgyeKyMnb07waPkBR6VA==
X-Google-Smtp-Source: ABdhPJzrFPt45G3s0kkUubcqEPhNGKToH3X0KJNnX5ZYLf5G+oDxxsNkj03vFpNV0eVyJ5dgf2XfB+FJJrli479WSeQ=
X-Received: by 2002:a05:6e02:970:: with SMTP id q16mr1766465ilt.69.1603461818703;
 Fri, 23 Oct 2020 07:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201023111352.GA289522@rdias-suse-pc.lan>
In-Reply-To: <20201023111352.GA289522@rdias-suse-pc.lan>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 23 Oct 2020 16:03:27 +0200
Message-ID: <CANn89iJDt=XpUZA_uYK98cK8tctW6M=f4RFtGQpTxRaqwnnqSQ@mail.gmail.com>
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

On Fri, Oct 23, 2020 at 1:14 PM Ricardo Dias <rdias@memsql.com> wrote:
>
> When the TCP stack is in SYN flood mode, the server child socket is
> created from the SYN cookie received in a TCP packet with the ACK flag
> set.
>
...

This patch only handles IPv4, unless I am missing something ?

It looks like the fix should be done in inet_ehash_insert(), not
adding yet another helper in TCP.
This would be family generic.

Note that normally, all packets for the same 4-tuple should be handled
by the same cpu,
so this race is quite unlikely to happen in standard setups.
