Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBC62B6CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgKQSKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbgKQSKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:10:36 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5955BC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:10:36 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r17so24157451wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpQ/esQudbW0I9Ksreww0RcPWneBs9hkz/hyGa5QmKI=;
        b=o2J1KQnKfbokmhzNNPtv4ObUJ0nsSFcPtwUgVWUB6E7UEOKPHOLdDbTw/l82RyPo/Y
         FP1+NNzwR7U1uup8V8Q4hB9qwXUBVv/7bMVNF2pQo7vmQET7y+P7QNQS7++qJ8Oi4yWq
         yLHKiGOz7qD1uwTXGoL1jWILGl4ydKYrr+xTrMhuiA8yRPUX+hAxsXeP5Ieet2O6fhmw
         3KqFDbNM6BVzATBQpgjPEYo3Rrzkf6idIZOv8mgcWajNaETmdTLQQhuNhQJJLZBvoCO5
         s1AhtDq36w2JrW8v3ODUlJ9OIM4epBwt0x0Xeo7rh2WzYkHen0q/zoEaEZYv2zCG/deV
         0tKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpQ/esQudbW0I9Ksreww0RcPWneBs9hkz/hyGa5QmKI=;
        b=Wg6lUWL6GEV9lKafMNoclOiFOvBBsIq/s/esKyl+1SZ9nYjUCB+DBn0EtRZmcGxAvf
         ZflOgIrRiF3bcH1GlNHgVPuzqOaiChUlY3Zv4R3uE1Dp9grOQFcKcjS20ScC7KdA69KE
         Z9PqFsIi1uS4fGr0UqBAHiE2ABvn394+QFeimcDO6y3Dj0dkotd68S0XstIrWd5VIToy
         kLqD9pQeSjdi4D60ikjGsXRVmP+GRKheEgsELgGHH63Mb3QeQUKXdjOchsiZj8GHPBOe
         8mjnv1iAQcRRAh8QMSTYvyq7fvJ3jwGEpNVybvaytWMe0tGWMUFPuOi8XXi0Gt7s1LNB
         TW7Q==
X-Gm-Message-State: AOAM531OMZWElkrxvwhyHSz4oOAYdK4pr1FJskv1J/ly30jDTVCFKPMc
        8TnbJSl8cdCD8hO/dMOMBJayq5lpvfZoA+64/4Q=
X-Google-Smtp-Source: ABdhPJyptDWsbC5Qr/bge72gBd+jtcErHEBjEkkn6Es7hnZm6rsRA5sysyHGzsLrtoVBAJekq8Ez9alJA65GgFnG5+w=
X-Received: by 2002:adf:8028:: with SMTP id 37mr762462wrk.111.1605636635119;
 Tue, 17 Nov 2020 10:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20200820162738.33053904@oasis.local.home> <20201022173434.910879-1-lpy@google.com>
 <CA+0soAkD7BG6CjhMW6PYR4yAgDykU2uUizcHx1QQdXqgesCFFg@mail.gmail.com>
 <20201116160508.3e86496f@gandalf.local.home> <173158b7-e65e-257f-0e24-aa9d5401d1d1@intel.com>
In-Reply-To: <173158b7-e65e-257f-0e24-aa9d5401d1d1@intel.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 17 Nov 2020 13:10:23 -0500
Message-ID: <CADnq5_NxvGynXwtw8m8bjYETHwdXExjyxsLobbBSa+pehOkq+Q@mail.gmail.com>
Subject: Re: [PATCH v4] Add power/gpu_frequency tracepoint.
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Peiyong Lin <lpy@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sidath Senanayake <sidaths@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Prahlad Kilambi <prahladk@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Pavel Machek <pavel@ucw.cz>,
        Paul Walmsley <paul.walmsley@sifive.com>, zzyiwei@android.com,
        android-kernel@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 1:00 PM Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
>
> On 11/16/2020 10:05 PM, Steven Rostedt wrote:
> > On Mon, 16 Nov 2020 12:55:29 -0800
> > Peiyong Lin <lpy@google.com> wrote:
> >
> >> Hi there,
> >>
> >> May I ask whether the merge window has passed? If so is it possible to
> >> ask for a review?
> > This is up to the maintainers of power management to accept this.
> >
> > Rafael?
>
> I'd say up to the GPU people rather (dri-devel CCed) since that's where
> it is going to be used.
>
> Also it would be good to see at least one in-the-tree user of this (or a
> usage example at least).

Can you resend the patches and cc dri-devel or point out the previous
patch discussion?

Alex
