Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4464F2B6F99
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbgKQUHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgKQUHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:07:10 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C67C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:07:09 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 74so31868628lfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJlb0i1VGgaZ+hMXCpkpJ5hlER3U8nvvYW3fvVDgI/k=;
        b=J/YZ6h/OCZ5I/Llg6f76T474+2t8DYXpf9TaLe/UQTe9U546QNvmBmNEuXh8xRHatn
         x5dZoH3xvuvcTuHNbgryL58m+LGRM86j8ia2e8WeoVF1kEPl+sOvzsdfSdx3tahqHiRJ
         vkyAJSPq0gqZEyRGVyCbFka6jZ7H+yF7b4APw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJlb0i1VGgaZ+hMXCpkpJ5hlER3U8nvvYW3fvVDgI/k=;
        b=aTo4F3OUadKUN1ocikmy2NOAYERz8hbrFKFTd3sOwAPR7tcGDp+GraWftxGpo7bILv
         bVRJnoBUXkbRow63HbFpSFH6GVdInAY4/dhO/EhBRypbPE1bIyHS1+xraOJsms00Zx+X
         InGI50+2SO6SAuTZ7eaf5b6Yi5NFB4UxGS+TuWhpEfMGY1seiNNckW/86Trs7J1tz/C7
         wABB5F6mQyYztPYc8MvkNL4LfKeyqgCM/UqlzSK3oiDaHBNSczgwp1b6FSV6GDyfW2h4
         6w2OpMlPPWJdOctW9GMQdorD0EW6Lz7hxe9CUG8YvxL+gRbp+BYOg62G1zzbM/B9OA+Z
         XvUg==
X-Gm-Message-State: AOAM530kPaMKobQg26LvCcgnouV2On8553o97sL9LlZY7cZO2dTINYcx
        khiKqVocteDKQIe01xZ56q5SBtYmsEpRxw==
X-Google-Smtp-Source: ABdhPJyY8RN+Q1X7lKshD9//XoQRGYiCR8tYwoMEzjl+N8SzW7zaBo1sFzAcolwDW/UG31Gd/G+jtA==
X-Received: by 2002:a19:8001:: with SMTP id b1mr2422515lfd.353.1605643627703;
        Tue, 17 Nov 2020 12:07:07 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id i26sm3172488ljj.11.2020.11.17.12.07.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 12:07:05 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id u19so25648253lfr.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:07:05 -0800 (PST)
X-Received: by 2002:ac2:598f:: with SMTP id w15mr2196881lfn.148.1605643624696;
 Tue, 17 Nov 2020 12:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20200901000633.1920247-1-minchan@kernel.org> <20200901000633.1920247-4-minchan@kernel.org>
 <20200921065633.GA8070@infradead.org> <20200921175539.GB387368@google.com>
 <a376191d-908d-7d3c-a810-8ef51cc45f49@gmail.com> <20201116155132.GA3805951@google.com>
In-Reply-To: <20201116155132.GA3805951@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Nov 2020 12:06:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTctybeY7GSc+f--FVLKKUQicTq-jfEmdku+cO_VdiVg@mail.gmail.com>
Message-ID: <CAHk-=whTctybeY7GSc+f--FVLKKUQicTq-jfEmdku+cO_VdiVg@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] mm/madvise: introduce process_madvise() syscall:
 an external memory hinting API
To:     Minchan Kim <minchan@kernel.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        sj38.park@gmail.com, David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 7:51 AM Minchan Kim <minchan@kernel.org> wrote:
>
> Let me send a patch with your SoB if you don't mind.

Eric, can you ack this SoB and I'll apply it to me tree?

Or is it already queued up somewhere else?

             Linus
