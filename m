Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F4021A06C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 15:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGINDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 09:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgGINDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:03:23 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEA0C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:03:23 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d18so2236336ion.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCJEZqPYLwHBRN2tJDDZEnNxnDsfp52exKS71/f+yOI=;
        b=Y2yQGbGwBev46VHambDCQw9GmVL/N5p1KqynyDZem+EQ/dtbcW1QBUnySaG7hGK1UU
         jPm3cs6h2/Si01FDBBygM+fZV68SmSuhGM4OnjsP945Jk4ack63URLLKh13U/8t5dgrB
         I3Ltl39cIUtcukeN3apObdqWfDjnbxmyveNVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCJEZqPYLwHBRN2tJDDZEnNxnDsfp52exKS71/f+yOI=;
        b=YpeCkbOypA4aJgTc/xT7j2ic5LafYelcYY3YDEJi2n5Qi4k8ULRY/Hv33662KlDDwZ
         OsxfAd4MwrlAXpFArdYKtXLyty/W+JoANPIeyCtLJBX4BJc+y5FR+3WalE2xfWPoJta1
         L1OqTUN5nk8ZPhPXGO1QseewRwaFqaBvIeSPwgSk2g0Fe+g+jciu3CSkv6ezpHCw3JvR
         fY3tjqWfe2tP/5fHoFjeLjpng9ztBuSpXrco5+O46wjni7XhJZDBsvc2PsRNw7GQfHKX
         CjUX0rpRUO7saQnL+B6D24ltv2DOvk8lqhZE8zvQw3KQguEU0T5kabuvKZSetEWVgRBZ
         Cbuw==
X-Gm-Message-State: AOAM532qfPUbqXsUKq/9RJwCNytmDN3+zuOJUVpd2eqslbfxOd97c/sc
        6zmKLw11R2EV7xkRg+HtktBCQqMroLf5nBSDdYOstQ==
X-Google-Smtp-Source: ABdhPJwEWrpHFoTBKANDXInsuxsAi5TVUpo9DngpjaO3ch6NELsRVOIrX06+UtMl65bw/KAQc8vgqGi2gqpPevMGM3o=
X-Received: by 2002:a05:6638:16c5:: with SMTP id g5mr10317558jat.92.1594299803121;
 Thu, 09 Jul 2020 06:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200708231253.3831497-1-surenb@google.com> <20200709081820.GB13487@kroah.com>
In-Reply-To: <20200709081820.GB13487@kroah.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 9 Jul 2020 09:03:13 -0400
Message-ID: <CAEXW_YQ5VoN6DZcfJH_4u5MnRc0vybY7zYH3Y_WD=j3u-RRVHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: add Hridya and myself into Android
 driver maintainers list
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Todd Kjos <tkjos@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 4:18 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> And I thought we were deleting ashmem soon?

This seems harder than initially thought. The Android userspace is
intertwined with ashmem in various ways (security policies, apps etc).
There were various concerns with old apps using /dev/ashmem directly
without going through library layers and that such apps could not be
upgraded. Various approaches were tried to work around this by
different folks to varying degrees of effect. Also, I am no longer
with the Android team at Google, but I continue to work with them
upstream.

Fwiw, I will continue reviewing this and other Android code from my
side. Thanks.
