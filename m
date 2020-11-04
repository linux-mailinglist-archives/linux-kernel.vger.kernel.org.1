Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA482A5D3D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgKDD5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbgKDD5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:57:24 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A31C061A4D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 19:57:24 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id c129so16836434yba.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 19:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylcoj02BPuhWE4EiF6XhbU6xzEwhDsrRnFe1b7UE1QU=;
        b=RS745sukUYYE+uqmJPdr7qy95EfqozAkhDd17x9feNndVTRzq6PgngRzYYb1dg6YzN
         0GUz6fBUrOCBSPhoEGx8MH6hR+s9t951hKsBzV+XW4V2+kNKoL7Do2+JPI+5sHSa/IUF
         tcHe1RarfYJW72+POgITtJArYbURMTxsr3KHnBAszf8JnvHBIuAkdu9IoyDMrBPYtM85
         K+spYuiORQqqPKwZVnSPQ2+1eDGINfCdAG9hCZex7Tv3ZG56MCshkCogMsLwZUq3t0/Y
         Y/1VieioaRG4OMDRS9Pl0m9lQtOjFN9te4QQzwmzhPDt7G20lPWDfwlrCIWi1HgkFV66
         pJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylcoj02BPuhWE4EiF6XhbU6xzEwhDsrRnFe1b7UE1QU=;
        b=QqvHt+51OB3qbv6BLfkpxH+E3F0y70xwjBy3WzYyjw/F+GyTbc8xHkvmna3+qa9q6h
         77geolAal96VjtHuMcXF1/LSKI2tMy3gs0ihszzq/a4jL95pozcWdtn2Vo/QqFOxUmJN
         IPldLJzsl5TwL4PSJEf9ONU5DOhNxFpmbfhvzMZTIThjyKHW0zo/3uQTQdlDa8pfkgbv
         qeAwjPPtYz3KDb+eoU51XYuAep6rL8Rwt9Bm6flFUJoElhq5kU6xeBd2PC/+6kBvOTz4
         +rAgLb6nEwmuNMw7IRjFrINCUry4AacBoTfNY/shBkSUx0jhXoNAii6XncikjhzE40DF
         Bosg==
X-Gm-Message-State: AOAM533R4U8ZvRnLT4gGJ2g/9/dScAa7JeT/uXoHAVPV8u3Uqxx15oJ5
        OQha/uxpuQmDNf/HTqVzLDCACzRUcyRoPJjp0wZyVbV7RPE=
X-Google-Smtp-Source: ABdhPJwWNuk3aE/7/Pfe9WLAilxwhtNdkbMGK8HlZULa/7TS1eoV/uKUUODqyISyO1PZq1mUESqQfcVS+gNuqH6HddQ=
X-Received: by 2002:a25:e5c1:: with SMTP id c184mr6444106ybh.247.1604462243664;
 Tue, 03 Nov 2020 19:57:23 -0800 (PST)
MIME-Version: 1.0
References: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com>
 <CANiq72=r6oieZ-Nj-e6e+HriW8kADB75z2pj6W-gg7Cff3nqGw@mail.gmail.com>
 <f474396f8f47c303e3a3ac90a582c116e38e50e4.camel@perches.com>
 <CANiq72nnpdPSngjoOf=imLxZ2g0A7ZXe5nRjF0qf5AG1UCfXyw@mail.gmail.com> <8d02497f4565c3154d3f7bcf2968b56ccd945ab4.camel@perches.com>
In-Reply-To: <8d02497f4565c3154d3f7bcf2968b56ccd945ab4.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 4 Nov 2020 04:57:12 +0100
Message-ID: <CANiq72k11+VO-igyHRakJEGuSmsDJyQCpYDVeNxZwRt62yCFXQ@mail.gmail.com>
Subject: Re: [RFC PATCH] .clang-format: Remove conditional comments
To:     Joe Perches <joe@perches.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 4:15 AM Joe Perches <joe@perches.com> wrote:
>
> No one ever will use clang-format on the current kernel sources
> without having a recent version of clang and clang-format.

Why? Many distros come with clang-format pre-packaged, and in fact the
original patch (that you commented on) argued for the >= 4 requirement
that way.

I am not saying we cannot change it, in fact I'd prefer if we do it
(see my answer to Nick); but I don't understand your basis to claim
nobody is installing their distro clang-format package.

Cheers,
Miguel
