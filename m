Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC651EE870
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 18:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgFDQTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 12:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgFDQTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:19:17 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE58C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 09:19:17 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s18so7006849ioe.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f96YLfaQIgNcB1dmAhGYVDcba0Obue/K4JOqEtQDBU4=;
        b=gsIyS0ZTluu0FBxhg7W5iWnpdQ39EZrrGFq7C74g/gg+EzTkRY3vi2bK0aqLgRGJn/
         Hz1aCmwGlVjPKs+suMoyugHFPJg3BQO/OO9m71ufINiTZDjKyoAiSQ0/+i5sPUkOsmX2
         GNZi8s3MBbtcgd25+bxYRZ6Z9lZJWynGe5ujUGvZNBg7Z/r/MShNFtFnA5Wk9VMPqYho
         MmSudaf9QNX0+x48ScVxDQlyj1Av9K7cQr2BTBvP1y+ZqOGkApJ7/eFHmk+dVbIIJSWM
         XlxKO9V6ZFgrfmvxeHvehkyiNMWECQFx0H5RBDJkBqvvNn/6PkjFgqHcn4Xp3XFvc+gj
         wm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f96YLfaQIgNcB1dmAhGYVDcba0Obue/K4JOqEtQDBU4=;
        b=oXPQOPUdgvL6mfaBmnv1Z+YYPpkeHq9VjV/pJ3AnFf+BAYo4WyQvRS/DjIaAoiZ7pk
         h9yIeT2TF0rk2WDdgprBZy70BDlYKVMKqkpPpw71WMH2xCoWX+h8uARX/VG7+sgUU3X7
         qMBToxiP+JGSHbKQokSVCTIgBsrwNVYClgeK+IgLIcgzd6PAJAEATx3cqRa4KYbt12IJ
         umgCgcn4vCKH826QWP6iBsJEwND4BTxc7y24I9LKxkGIxXIubnvl52qQbmO5NM2DGPCt
         t6+wrgFjVBEvZSVsu7HnV2izq9nPhlLtywndQnfsxlJ55VUh9EprYuyimmrwND+jFmed
         AIzA==
X-Gm-Message-State: AOAM530v+0RcipKZnIxs8fpNf5ZAo3vJ1dWuGh6A2swLH9y0zRwsOIpT
        A0KrzojYBXt9BnNM3f1CE6ou8w+DJ9kWy3srSbo=
X-Google-Smtp-Source: ABdhPJyWIVaeHAPopsEZbD3b8JJ7uBWTPui/+QEUuXYIK1pF/FPttq/l5QVCSLWrdroARd/JILduLoJmFTiKZqebyrk=
X-Received: by 2002:a05:6602:15c8:: with SMTP id f8mr4680317iow.183.1591287556520;
 Thu, 04 Jun 2020 09:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLUrNYk6JKTbTQuFkfuGKxGvW9XVq6+p9igsBgX1-e9Cxg@mail.gmail.com>
 <CAKb7Uvg0W_1qUjf3G4JrCb2oJgkwz4G5T6PwkyeL-rZEp4UnTw@mail.gmail.com>
 <CAOkhzLV+suVNAoyiaHKOkbwP-KKgTLEa7S8kp8+GSTLm_-wWFw@mail.gmail.com>
 <CAKb7UvgWMsLSHCayzdY7UYMVTjN3OHbH2WhKd-BP46K=r4Ra8A@mail.gmail.com>
 <CAOkhzLXZVNdpgwV=iiO0TEvLp3Hx28Zk8iYzwy5BvJ1pWi4QxQ@mail.gmail.com> <CAKb7UviB22HxSJ6j4ts=fU=J24Hh69NCBw4uHC5vsi902Pp6bA@mail.gmail.com>
In-Reply-To: <CAKb7UviB22HxSJ6j4ts=fU=J24Hh69NCBw4uHC5vsi902Pp6bA@mail.gmail.com>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Thu, 4 Jun 2020 18:19:05 +0200
Message-ID: <CAOkhzLVwQyN3RcUXH6YHMH+VmKtGNvzidfnqQ80t72gu+bm3oQ@mail.gmail.com>
Subject: Re: [Nouveau] NVIDIA GP107 (137000a1) - acr: failed to load firmware
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ilia

On Thu, Jun 4, 2020 at 6:13 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:

> Not sure why you bother asking questions when you're just going to
> dump nouveau anyways. This is the second time I've answered your
> questions on this very topic, I think it'll be the last too.

I will try again with the next Kernel release. So far I spent a lot of
time and I did not manage to get it to work. And I need my graphical
Linux Desktop.

I am a Nouveau user since day one.

This may also be a Gentoo/Funtoo Issue. I will keep you posted, if I
have any success.

Best
Zeno
