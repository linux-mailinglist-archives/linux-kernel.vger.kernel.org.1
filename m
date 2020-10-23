Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B575129753F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752884AbgJWQva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752837AbgJWQvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:51:18 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFFAC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:51:17 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z17so2556994iog.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DmFI4CxVV7TudqMTviEtcNfGxb5h9F5Q2IKtouYB1hE=;
        b=LlEXD4kLLiSoxBpI240zn1UfC62F49ZtKjMvF7CB1GROCq0qmKooibsDhIvGz6T+zn
         ngUdE1T1VPuBbRSV6FN9EbPP5YCrueaZXLSZjxWWWO5fi/5v5QJlJZ2xdbx3cKeFT+Sf
         Lx3p6yf6euF32EFur+ZK8MY/7pb0qhd6GO0zGx0qjH7H6w663MSiiTtgPKxqrp/xsIN1
         y4wrsfeLtnZuGcQisWiNSuhVqL/rynqfVT8IqlxVD4bF+2gCRaef89YfKB8Zf+1+54HI
         Kld3Uqyg56crCtv+Q7aLeUcIGooWEQb3ZqsDCYqKU3iokdXYffcjIORoIBve8dyAxDsd
         TwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmFI4CxVV7TudqMTviEtcNfGxb5h9F5Q2IKtouYB1hE=;
        b=KiXlbA2sShHMnnm/wdtnl4iVjrMapdB9NJLXT63EMqa9PjhFSDfqDpliepLGGdSuLN
         MsmD7tgV3K2yFtt8O+KFsWIvRbetKNagDJuI0XvomeEN3za1Z6H/it99t0zJy8VElJ52
         U8a1HAilW5FK19A0qgdNTtqGQ5EA/MQ3iiNjUDLBj7psbP2uiJZgrM9GNRjjiBFk+wMX
         Vg8A62ggTvslYM6YsLaKEcjztluXegjxuQ0+DkakcnngDK+faLEVnpBIitpx+EM/cz7c
         zRr9TBnHWog3eWk6LM+w91Em7RgaRdtRQAyCHvIBE/Z3kQ00jLGFSzyaNhoBfX0eGv8T
         5fLA==
X-Gm-Message-State: AOAM532Ix4Uu7qwWFFKLAHE2wy+8yUgWjyTvmzBn15xGoRJQkVntR5kg
        rz+Dg2u+pxT9FwlnJ8iu+xr/0plSWGdn0FqiAvyyWg==
X-Google-Smtp-Source: ABdhPJxO84LY34qh8Lu4tjpjxiP21DFKo5lhbPCzTRhUKADeYIQLMyruEDCxTp64jHNAkSwkp7KxC2MhiM7Nv+jZ6cw=
X-Received: by 2002:a5e:9411:: with SMTP id q17mr2266246ioj.157.1603471877101;
 Fri, 23 Oct 2020 09:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201023111352.GA289522@rdias-suse-pc.lan> <CANn89iJDt=XpUZA_uYK98cK8tctW6M=f4RFtGQpTxRaqwnnqSQ@mail.gmail.com>
 <20201023155145.GA316015@rdias-suse-pc.lan> <CANn89iL2VOH+Mg9-U7pkpMkKykDfhoX-GMRnF-oBmZmCGohDtA@mail.gmail.com>
 <20201023160628.GA316690@rdias-suse-pc.lan> <CANn89i+OZF2HJQYT0FGtzyFeZMdof9RAfGXQRKUVY6Hg9ZPpcg@mail.gmail.com>
 <20201023164825.GA321826@rdias-suse-pc.lan>
In-Reply-To: <20201023164825.GA321826@rdias-suse-pc.lan>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 23 Oct 2020 18:51:05 +0200
Message-ID: <CANn89iKOiAp96yu=7OVn72R8EMukErBSXeWURJp3qTqrurtt0Q@mail.gmail.com>
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

On Fri, Oct 23, 2020 at 6:48 PM Ricardo Dias <rdias@memsql.com> wrote:
>

> In that case, I can change the patch to only iterate the ehash bucket
> only when the listening socket is using the loopback interface, correct?

No, the fix should be generic.

We could still have bad NIC, or bad configuration, spreading packets
on random cpus ;)
