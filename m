Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671F929213D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 04:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgJSCuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 22:50:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49317 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgJSCuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 22:50:40 -0400
Received: from mail-lj1-f198.google.com ([209.85.208.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kULFu-0005NR-Az
        for linux-kernel@vger.kernel.org; Mon, 19 Oct 2020 02:50:38 +0000
Received: by mail-lj1-f198.google.com with SMTP id r15so4681884ljn.16
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 19:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTrK0pAVZQQtS/tzM7uwTIFZMUuNtDoL2D9yFspbaVY=;
        b=WQDe/efmUgduOuVma8Y8g0GVrU1Ck1s95jzhQpjQ2LucrQCbAKlEYEQXoz5FvZIxhQ
         7kcL7El2bbPWeHqTDWljDjp/Pk/U1LbmYaL0NqEbXPYtfdc8ybX3gwuz9MyN5Kg0sQFQ
         hsC34WDD8xfeg3wo7salbtr1VQoGbChYGjzAumnhmrODz0NhLY3zFq4iL9YIiBZ16RwU
         leZxqWA5O1yj5TKrFVB1VyJiL6qWY4kXjBbu2OKHpRLsiSgIc4z6BCjuoGF+kUVgXYfC
         CT72dPNMem8hcNYkwHyh76g+Er/N2gbwRdAvkQ/ukI9WMHEXd8RTETIjdA+7+nBNbQXw
         hm3A==
X-Gm-Message-State: AOAM532C8VixXWWLZmFWvuYluuyCBJnCsdgSuXYk2BL0sisWFwyLJuZS
        zcQDCxsMBl6cH2GCPI9SnHg+2UnEWnbmNQYTVTjzaYV5bqYf2GpvAwN6nAu+piwbxzgg2hcK/fn
        mR66+6Q1Xd+x36INd9s8rA2Rm0ttW7k0kNvxjF5DlhN70gLxFPGkDuI5M
X-Received: by 2002:a2e:b610:: with SMTP id r16mr5420422ljn.145.1603075837823;
        Sun, 18 Oct 2020 19:50:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykKr5i72+Z18iQtWw3/e6ifc5NFHwy1z43A4/0WmlyHcQutDyhot3re5YEu2SGMKKEoY3zxU0o520TJ6gK/gM=
X-Received: by 2002:a2e:b610:: with SMTP id r16mr5420418ljn.145.1603075837589;
 Sun, 18 Oct 2020 19:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201016041211.18827-1-po-hsu.lin@canonical.com> <20201016163248.57af2b95@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201016163248.57af2b95@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Mon, 19 Oct 2020 10:50:26 +0800
Message-ID: <CAMy_GT_vTmVRi-pjysaw1ccwek0r+w12zZokKDmMsCd+ut5eaQ@mail.gmail.com>
Subject: Re: [PATCHv4] selftests: rtnetlink: load fou module for
 kci_test_encap_fou() test
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 7:32 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 16 Oct 2020 12:12:11 +0800 Po-Hsu Lin wrote:
> > The kci_test_encap_fou() test from kci_test_encap() in rtnetlink.sh
> > needs the fou module to work. Otherwise it will fail with:
> >
> >   $ ip netns exec "$testns" ip fou add port 7777 ipproto 47
> >   RTNETLINK answers: No such file or directory
> >   Error talking to the kernel
> >
> > Add the CONFIG_NET_FOU into the config file as well. Which needs at
> > least to be set as a loadable module.
> >
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>
> Doesn't apply :( Could you rebase on top of:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/
Ah OK, I was using the next branch in kselftest, will resend another one.
Thanks.
