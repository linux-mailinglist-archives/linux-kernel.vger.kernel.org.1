Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED82BA1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 06:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgKTFEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 00:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgKTFE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 00:04:28 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F103DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 21:04:26 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id j19so6289157pgg.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 21:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VQwpOcD2+t3JbuTg+G3fFZr3cIdjvDbD2vJYrQnBtQU=;
        b=Wk4JERM5Uf22PLd05xcfiZd95GYLeGiNsmqT+2hVf08I2TakWYkf6ij1szw/cZj2LU
         Ap3XLp2gKoNqBxgiz+nbXoDMMiPm0Q28cpuRiVPf5Kf16qPO4FX1zk7F4w6gmyzXQbs9
         RioUZDa4YBpDhqR05ZJybicTr/AO8xCqYONW6XpkuAI0bYteJdNdklmeN8x20D4WNqjQ
         UnWiikK9O/xKS0gFtMs6gCnr4T9BOPQoQmCcxYuxINH48Whw3Yuo5ryfjCeg0iQSAqXZ
         tgLTp1fM5rGVVT56MqmF0ylslr+1ooLxMEML3Pv4cI2uuATSGfAJsVCW7P5JjT1JxRZ6
         oIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VQwpOcD2+t3JbuTg+G3fFZr3cIdjvDbD2vJYrQnBtQU=;
        b=lKswsyWX+st5C43d+3oY4hP0Y9eTWfagdFer2yBHLhhZ3lsUO4CN3W2DgjqjJiVHQ0
         Iy2j0vi+/E/8G9IVaa1/tlPdeV4+/3slpOwmSQG5tTnC5EWEk9g1C3cvuVMcug3evbFD
         LlE5DkQztZf/lGoy79lj/vDLRG0ARpJ5iDoK/zZ0r3AjYvwaRSR08Yn1CZM/berFMlaT
         R7Y1xqAYeBqnWDFIYEX+HlHgPjJF7s1sMD/eMQU+UExg4c2rztnpuSgU9XLtVrPUn6Uw
         +fkirSYSFiBMicHMEOnnbkD/g3NIxq3+2HhIP8EzHLsuwaGWct8wTM8VAw6/rj5Xmxvu
         ir8Q==
X-Gm-Message-State: AOAM531MQWL9Hk/oSOPUNhQcyl1+OpOPe1ZMsjFAq8MyKre3N38HfpOB
        FPOZzxgtcVjif7Y+My4PtCs=
X-Google-Smtp-Source: ABdhPJwJ+exJRYyCKImrposP1ochkmhd46hfB4bpJdDPr8dXKpAnuSvR43nBPgyUn6QZhheBnS1BTg==
X-Received: by 2002:a63:389:: with SMTP id 131mr15796760pgd.128.1605848666424;
        Thu, 19 Nov 2020 21:04:26 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id j16sm1529485pgl.50.2020.11.19.21.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 21:04:25 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 19 Nov 2020 21:04:23 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Zhenhua Huang <zhenhuah@codeaurora.org>
Cc:     vjitta@codeaurora.org, linux-mm <linux-mm@kvack.org>,
        glider@google.com, Dan Williams <dan.j.williams@intel.com>,
        broonie@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yogesh Lal <ylal@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>, tingwei@codeaurora.org
Subject: Re: [PATCH] lib: stackdepot: Add support to configure STACK_HASH_SIZE
Message-ID: <20201120050423.GE3113267@google.com>
References: <1603372546-27118-1-git-send-email-vjitta@codeaurora.org>
 <CAEwNFnBvxu7+oNkcO9D70OFrxQXswcJG4OvDPyzNf7kpXfpSuw@mail.gmail.com>
 <20201119033317.GA5128@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119033317.GA5128@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 11:34:32AM +0800, Zhenhua Huang wrote:
> On Wed, Nov 04, 2020 at 07:27:03AM +0800, Minchan Kim wrote:
> > Sorry if this mail corrupts the mail thread or had heavy mangling
> > since I lost this mail from my mailbox so I am sending this mail by
> > web gmail.
> > 
> > On Thu, Oct 22, 2020 at 10:18 AM <vjitta@codeaurora.org> wrote:
> > >
> > > From: Yogesh Lal <ylal@codeaurora.org>
> > >
> > > Use STACK_HASH_ORDER_SHIFT to configure STACK_HASH_SIZE.
> > >
> > > Aim is to have configurable value for  STACK_HASH_SIZE,
> > > so depend on use case one can configure it.
> > >
> > > One example is of Page Owner, default value of
> > > STACK_HASH_SIZE lead stack depot to consume 8MB of static memory.
> > > Making it configurable and use lower value helps to enable features like
> > > CONFIG_PAGE_OWNER without any significant overhead.
> > >
> > > Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
> > > Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
> > > Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> > > ---
> > >  lib/Kconfig      | 9 +++++++++
> > >  lib/stackdepot.c | 3 +--
> > >  2 files changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > index 18d76b6..b3f8259 100644
> > > --- a/lib/Kconfig
> > > +++ b/lib/Kconfig
> > > @@ -651,6 +651,15 @@ config STACKDEPOT
> > >         bool
> > >         select STACKTRACE
> > >
> > > +config STACK_HASH_ORDER_SHIFT
> > > +       int "stack depot hash size (12 => 4KB, 20 => 1024KB)"
> > > +       range 12 20
> > > +       default 20
> > > +       depends on STACKDEPOT
> > > +       help
> > > +        Select the hash size as a power of 2 for the stackdepot hash 
> > > table.
> > > +        Choose a lower value to reduce the memory impact.
> > > +
> > >  config SBITMAP
> > >         bool
> > >
> > > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > > index 2caffc6..413c20b 100644
> > > --- a/lib/stackdepot.c
> > > +++ b/lib/stackdepot.c
> > > @@ -142,8 +142,7 @@ static struct stack_record *depot_alloc_stack(unsigned 
> > > long *entries, int size,
> > >         return stack;
> > >  }
> > >
> > > -#define STACK_HASH_ORDER 20
> > > -#define STACK_HASH_SIZE (1L << STACK_HASH_ORDER)
> > > +#define STACK_HASH_SIZE (1L << CONFIG_STACK_HASH_ORDER_SHIFT)
> > >  #define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
> > >  #define STACK_HASH_SEED 0x9747b28c
> > >
> > > --
> > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> > > of Code Aurora Forum, hosted by The Linux Foundation
> > > 2.7.4
> > >
> > 
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
> Seems we have other users like kasan, and dma_buf_ref which we introduced.
> Also we can't guarantee there will not be any other users for stackdepot, so
> it's better we not depend on only page owner?

I didn't mean to make it page_owner dependent. What I suggested is just
to define kernel parameter for stackdeport hash size so admin could
override it at right size when we really need it.
