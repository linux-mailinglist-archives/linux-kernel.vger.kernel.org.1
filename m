Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5DC2DCFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgLQKza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgLQKz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:55:29 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C16C0617B0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:54:49 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id 7so19797926qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sh6ZnsaNRvH6fFObdqzFfNsJfBDLItS7EZc+yZ7OoyM=;
        b=cktvz8iyymm/hF3fCobUejCYA6uMLR/8L0y78pCxB2LCyGdpY8uwRvyMTtL6sH3Q8G
         QKcp4htfA64JxcyeqV6TnQ1/ZBmTxDCWvxJaStyD3mZfss32yIHmhu4w9w+GwisrUhUO
         NE1c5l7tsc5pd57P4yQYK3kiIbFtOcL8pcjpL8/TA/1oLhYftAw+JkipXckCzd+v+l8c
         oZfLiXm6H0N8f4uihVkc1KxsC/6WJ50qdrk8ReW2eyS3uY16s8jq8ru7KfLq3eKLjzDy
         ACAwUSa4Mcnk45hZCaPq/aBNw40YfnD4P56Km/s2nqsb/9wb8EefACLkzj9yzQMutoMf
         qV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sh6ZnsaNRvH6fFObdqzFfNsJfBDLItS7EZc+yZ7OoyM=;
        b=bSqAote0d7MX9u3NOsxwStQbcLRQsXwrQCvVsh34YCm2feO3e6NBzYXpnl7GYQg6AU
         zfuTNyz2oxHOOrO4hg2+I0/eBOZrV+5ki8j2h4dYihoNdO2vW4PCSuI5WjjrGKeso+Iw
         er87V6rZGj8W1kqnl6cg4wd7CPAK8Sxic/CUsmxLFdfBA1JgfQUCaLrMW3kWy1it4erc
         2F68PtVEEpIomXLVzcluv0YB+I5HO6L1rP1m6btE3aE+4AD5/aF8zj7g9KSIlyqIyYQA
         AD0hxBGgfk+KrMt4aNi5T0UciAw50rf4RT+KJh+8odoeUPs9rfKVZhSSKhjVuLnaRF3d
         EVfw==
X-Gm-Message-State: AOAM531mxj+AU6Y45Mideik55iA0OWDzaOjl+OyViiOGc7ZuYwjfpaF8
        WbxiXpTtTXgdRTv/SVJLN6GnPcJj0NjKdnTRvXENGg==
X-Google-Smtp-Source: ABdhPJwih/ZiDzT5ONo50bjt8s2BgeL1bZlfwxI7lEhnlzTsnJKhqJRuO7qnXBZ6a/uhG7C6WdJ04idhrGyePva8/lo=
X-Received: by 2002:ac8:6f3c:: with SMTP id i28mr46368743qtv.8.1608202488317;
 Thu, 17 Dec 2020 02:54:48 -0800 (PST)
MIME-Version: 1.0
References: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org>
 <CAG_fn=VKsrYx+YOGPnZw_Q5t6Fx7B59FSUuphj7Ou+DDFKQ+8Q@mail.gmail.com>
 <77e98f0b-c9c3-9380-9a57-ff1cd4022502@codeaurora.org> <CAG_fn=WbN6unD3ASkLUcEmZvALOj=dvC0yp6CcJFkV+3mmhwxw@mail.gmail.com>
 <6cc89f7b-bf40-2fd3-96ce-2a02d7535c91@codeaurora.org> <CAG_fn=VOHag5AUwFbOj_cV+7RDAk8UnjjqEtv2xmkSDb_iTYcQ@mail.gmail.com>
 <255400db-67d5-7f42-8dcb-9a440e006b9d@codeaurora.org> <f901afa5-7c46-ceba-2ae9-6186afdd99c0@codeaurora.org>
 <CAG_fn=UjJQP_gfDm3eJTPY371QTwyDJKXBCN2gs4DvnLP2pbyQ@mail.gmail.com>
 <7f2e171f-fa44-ef96-6cc6-14e615e3e457@codeaurora.org> <CAG_fn=VihkHLx7nHRrzQRuHeL-UYRezcyGLDQMJY+d1O5AkJfA@mail.gmail.com>
 <601d4b1a-8526-f7ad-d0f3-305894682109@codeaurora.org> <CAG_fn=V8e8y1fbOaYUD5SfDSQ9+Tc3r7w6ZSoJ-ZNFJvvq-Aeg@mail.gmail.com>
 <9e0d2c07-af1f-a1d3-fb0d-dbf2ae669f96@codeaurora.org>
In-Reply-To: <9e0d2c07-af1f-a1d3-fb0d-dbf2ae669f96@codeaurora.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 17 Dec 2020 11:54:36 +0100
Message-ID: <CAG_fn=UXQUGiDqmChqD-xX-yF5Jp+7K+oHwKPrO9DZL-zW_4KQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib: stackdepot: Add support to configure STACK_HASH_SIZE
To:     Vijayanand Jitta <vjitta@codeaurora.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        dan.j.williams@intel.com, broonie@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, qcai@redhat.com,
        ylal@codeaurora.org, vinmenon@codeaurora.org,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Can you provide an example of a use case in which the user wants to
> > use the stack depot of a smaller size without disabling it completely,
> > and that size cannot be configured statically?
> > As far as I understand, for the page owner example you gave it's
> > sufficient to provide a switch that can disable the stack depot if
> > page_owner=off.
> >
> There are two use cases here,
>
> 1. We don't want to consume memory when page_owner=off ,boolean flag
> would work here.
>
> 2. We would want to enable page_owner on low ram devices but we don't
> want stack depot to consume 8 MB of memory, so for this case we would
> need a configurable stack_hash_size so that we can still use page_owner
> with lower memory consumption.
>
> So, a configurable stack_hash_size would work for both these use cases,
> we can set it to '0' for first case and set the required size for the
> second case.

Will a combined solution with a boolean boot-time flag and a static
CONFIG_STACKDEPOT_HASH_SIZE work for these cases?
I suppose low-memory devices have a separate kernel config anyway?

My concern is that exposing yet another knob to users won't really
solve their problems, because the hash size alone doesn't give enough
control over stackdepot memory footprint (we also have stack_slabs,
which may get way bigger than 8Mb).
