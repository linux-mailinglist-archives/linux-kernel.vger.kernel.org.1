Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D755D2DA3A1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441240AbgLNWqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388836AbgLNWqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:46:34 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B17C06179C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:45:54 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id x20so14850845lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7NaDwH+o13pplnZETDzpNME+J09xWs3e8EEhHwcKak0=;
        b=ccYsGAkpyBJRTXebW7C/10KTxYSYkH7Io1+MOhcYKa9x0bSowk4sf2EaTjtwDjVwtC
         j5R0aUWOt8PkssLyXcMUWqsORAydSH314HhQlbVlcO0j8L3JeNgfFi2drjubqu+Nf0KI
         zTwXmqP0Si1UqYciCHWMz0hs+VAyjhxxAWLsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NaDwH+o13pplnZETDzpNME+J09xWs3e8EEhHwcKak0=;
        b=RSZNTiVlMhL4bCPPC1cxI/0x7yt5kOA9lEgrjVWoX+xeOPiHpUcT9s80OHwfoFNeEx
         JN0iHKmrH8fdO4TMEF2IC1qTwGBNltxS1LzFTlyBfl2s6mYJOGISts3+c7DwLBned5pl
         qlI1q61G73ovY++/ydrG/aTap5+9zozOM6D1vT0dgOaZCF1hfe0uUS0EUtxdGKNvfQP4
         EDIPvPtqqLq1jv1F2iGvTz9gcQQ251qI0oIB/ETGzp7wvONK1+Ed2bVX1NNbdef9OcK2
         0PAL3ukdJyQbaFWSRL6aQfnNFxHk6Ka9pF2q+i4t4KhpMd9wjMsAINnMA90n3t8zNcNE
         6nsQ==
X-Gm-Message-State: AOAM533aJI1ezOZU23NNy0jWfIIak4mn6IYnX9z+cltcVp7aXC/xbMUJ
        IvmbuhVdYRfNx7sTKvUHb17J4dsEDzCAiw==
X-Google-Smtp-Source: ABdhPJyqIQH2oQj8IziFCyIdG5I/fmg4H1gQmwS9XbD9pQEhJoWKP99UdkeR/Wj8k4Oq573a2rNP5A==
X-Received: by 2002:a05:6512:21cd:: with SMTP id d13mr10932509lft.471.1607985951819;
        Mon, 14 Dec 2020 14:45:51 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id t3sm2225676lfe.263.2020.12.14.14.45.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 14:45:50 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 23so34397423lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:45:49 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr9754755lfd.201.1607985949442;
 Mon, 14 Dec 2020 14:45:49 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tyNrbap4FG6qstkC5YTznqVebD=ye+4+Z+t42yQnL325A@mail.gmail.com>
 <CAHk-=wjue4aOyQQq+C6SEurwe6XABhMyNtsfn1goU==Hf_QUqA@mail.gmail.com> <CADnq5_MyMm+FmmbKHccDDOBryEdgbQHdw3rtuhUv=cvJrirHFg@mail.gmail.com>
In-Reply-To: <CADnq5_MyMm+FmmbKHccDDOBryEdgbQHdw3rtuhUv=cvJrirHFg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Dec 2020 14:45:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLKJ6S0V0YgVWdcXVH9Zh8CEV5xPBUSFkJ7fywNLtqeg@mail.gmail.com>
Message-ID: <CAHk-=wgLKJ6S0V0YgVWdcXVH9Zh8CEV5xPBUSFkJ7fywNLtqeg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.11-rc1
To:     Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 2:29 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> The relevant fixes are:

Ok, I can confirm that applying those two patches gets my workstation
working properly again.

Would it be possible to get those submitted properly (or I can just
take them as-is, but would like to get a "please just pick them
directly")?

I don't like to continue to do merges during the merge windows with a
known broken base - it makes for a nightmare of bisection when you
have multiple independent problems, and I assume this hits not just me
but a lot of people with radeon/amdgpu graphics?

               Linus
