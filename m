Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6462E018D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 21:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgLUU36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 15:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUU36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 15:29:58 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1021C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:29:17 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j1so6209782pld.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jxLW2pdUWD7RzC62LfDYxo1HOe4nc7nIXlrDQklPFuU=;
        b=QcYIhsyzsT3cpFBxIQogxXeiwDgF4ahvIkqsoOOddsOKu1aXJtWZXhvWZTSFoRvOtq
         Y2+9LQi704NiDZmu6QWZ/6BzvFlgI8UcW+dJgOtO/ZL0uhEjXN5JiNBv1dMvaWD3chy9
         ZiZym9rjs7H717mshEohmqV5V3VMAvaQAcQ4z4BUr5gX+yUSM9xdbkX0anjqgqf5mjaw
         tz3j4hQBworRUgE0dCli4Oz9QOirl7LG8W0xlU7hfCYatPFvuH5vRac34qH7g/mYm+Jl
         KHmkN6Gl3eWFCsJVDpsah5C6VzuESn/5hLotj6Qlx/s3NzCvXdVgUCWmTXHkf0jxHEnu
         +siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jxLW2pdUWD7RzC62LfDYxo1HOe4nc7nIXlrDQklPFuU=;
        b=WaF+0otNcvjN/QrJs13JqkgxeZoF5+Sxk4Pm6XzxIyHSZEaNOOqBtwwcf2Fuvp27oF
         hgca/SFpxLkTghh8I+Y8DtYNlEjSRTBshR4uTI4KzJB2jVEsLj6Uk6rcphyxGB+8C2zM
         bGsfiAOuivHenBPfdzAH34gtq72B5smXN4OOQbPXkF7wf/DivhJkWuqkhffUaftkiaCE
         NMdadGo6A3j+t6ewMah75ynhsC5hDsiDdqS8Je6fAw7+DYuSzHeKAazgAnQvZay6xV19
         kL2NV7O3p0YTiNCfNdr3/B9C9CXMPLHxGtdeyCDBnQx3Malu5THLXxHEOHc2U60UBKq8
         SpoA==
X-Gm-Message-State: AOAM531dEitIyesKjEvtktrZ7vGr8L7mTi3rqUBFUwWp6kntn5hIKpaw
        mXs/vTaSmu2OMIWg3or4Lus=
X-Google-Smtp-Source: ABdhPJxW6dgRtQ9ocqk12r1QBKA+zpKEECuJNaWqOmp3jt0cSEiX7zpY8aiH7NCkX+vKYKgexNC+CA==
X-Received: by 2002:a17:90a:b110:: with SMTP id z16mr18441668pjq.167.1608582556811;
        Mon, 21 Dec 2020 12:29:16 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id f29sm17695810pfk.32.2020.12.21.12.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 12:29:15 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 21 Dec 2020 12:29:13 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Vijayanand Jitta <vjitta@codeaurora.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        dan.j.williams@intel.com, broonie@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, qcai@redhat.com,
        ylal@codeaurora.org, vinmenon@codeaurora.org,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v3] lib: stackdepot: Add support to configure
 STACK_HASH_SIZE
Message-ID: <X+EFmQz6JKfpdswG@google.com>
References: <CAG_fn=UjJQP_gfDm3eJTPY371QTwyDJKXBCN2gs4DvnLP2pbyQ@mail.gmail.com>
 <7f2e171f-fa44-ef96-6cc6-14e615e3e457@codeaurora.org>
 <CAG_fn=VihkHLx7nHRrzQRuHeL-UYRezcyGLDQMJY+d1O5AkJfA@mail.gmail.com>
 <601d4b1a-8526-f7ad-d0f3-305894682109@codeaurora.org>
 <CAG_fn=V8e8y1fbOaYUD5SfDSQ9+Tc3r7w6ZSoJ-ZNFJvvq-Aeg@mail.gmail.com>
 <9e0d2c07-af1f-a1d3-fb0d-dbf2ae669f96@codeaurora.org>
 <CAG_fn=UXQUGiDqmChqD-xX-yF5Jp+7K+oHwKPrO9DZL-zW_4KQ@mail.gmail.com>
 <48df48fe-dc36-83a4-1c11-e9d0cf230372@codeaurora.org>
 <6110a26b-dc87-b6f9-e679-aa60917403de@codeaurora.org>
 <CAG_fn=VjejHtY8=cuuFkixpXd6A6q1C==6RAaUC3Vb5_4hZkcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=VjejHtY8=cuuFkixpXd6A6q1C==6RAaUC3Vb5_4hZkcg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 04:04:09PM +0100, Alexander Potapenko wrote:
> On Mon, Dec 21, 2020 at 12:15 PM Vijayanand Jitta <vjitta@codeaurora.org> wrote:
> >
> >
> >
> > On 12/18/2020 2:10 PM, Vijayanand Jitta wrote:
> > >
> > >
> > > On 12/17/2020 4:24 PM, Alexander Potapenko wrote:
> > >>>> Can you provide an example of a use case in which the user wants to
> > >>>> use the stack depot of a smaller size without disabling it completely,
> > >>>> and that size cannot be configured statically?
> > >>>> As far as I understand, for the page owner example you gave it's
> > >>>> sufficient to provide a switch that can disable the stack depot if
> > >>>> page_owner=off.
> > >>>>
> > >>> There are two use cases here,
> > >>>
> > >>> 1. We don't want to consume memory when page_owner=off ,boolean flag
> > >>> would work here.
> > >>>
> > >>> 2. We would want to enable page_owner on low ram devices but we don't
> > >>> want stack depot to consume 8 MB of memory, so for this case we would
> > >>> need a configurable stack_hash_size so that we can still use page_owner
> > >>> with lower memory consumption.
> > >>>
> > >>> So, a configurable stack_hash_size would work for both these use cases,
> > >>> we can set it to '0' for first case and set the required size for the
> > >>> second case.
> > >>
> > >> Will a combined solution with a boolean boot-time flag and a static
> > >> CONFIG_STACKDEPOT_HASH_SIZE work for these cases?
> > >> I suppose low-memory devices have a separate kernel config anyway?
> > >>
> > >
> > > Yes, the combined solution will also work but i think having a single
> > > run time config is simpler instead of having two things to configure.
> > >
> >
> > To add to it we started of with a CONFIG first, after the comments from
> > Minchan (https://lkml.org/lkml/2020/11/3/2121) we decided to switch to
> > run time param.
> >
> > Quoting Minchan's comments below:
> >
> > "
> > 1. When we don't use page_owner, we don't want to waste any memory for
> > stackdepot hash array.
> > 2. When we use page_owner, we want to have reasonable stackdeport hash array
> >
> > With this configuration, it couldn't meet since we always need to
> > reserve a reasonable size for the array.
> > Can't we make the hash size as a kernel parameter?
> > With it, we could use it like this.
> >
> > 1. page_owner=off, stackdepot_stack_hash=0 -> no more wasted memory
> > when we don't use page_owner
> > 2. page_owner=on, stackdepot_stack_hash=8M -> reasonable hash size
> > when we use page_owner.
> > "
> 
> Minchan, what do you think about making the hash size itself a static
> parameter, while letting the user disable stackdepot completely at
> runtime?
> As noted before, I am concerned that moving a low-level configuration
> bit (which essentially means "save 8Mb - (1 << stackdepot_stack_hash)
> of static memory") to the boot parameters will be unused by most
> admins and may actually trick them into thinking they reduce the
> overall stackdepot memory consumption noticeably.
> I also suppose device vendors may prefer setting a fixed (maybe
> non-default) hash size for low-memory devices rather than letting the
> admins increase it.

I am totally fine if we could save the static memory alloation when
the page_owner is not used.

IOW, page_owner=disable, stackdepot=disable will not consume the 8M
memory.
When we want to use page_owner, we could just do like this

	page_owner=enable, stackdepot=enable

(Maybe we need something to make warning if stackdepot is disabled
but someone want to use it, for example, KASAN?)

Vijayanand, If we could work this this, should we still need the
config option, then? 
