Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA102BA2D4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgKTHI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:08:27 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:39233 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgKTHI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:08:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605856105; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=xhUyB64LZP19yOoIWdbZSf39K15d0YpoLNAdjUAmtwI=; b=RTa2rtAQLSL2rf2U/Cu/xTtL6G0yKlkpwLKwKLdrHGctOlCeSEHJpZKDptPZ1htHlAkVRhbF
 d6UWyWpEdD1gRIWKXkpp8UVj6f0m0Wqhcusp1FcxcRQMc0hr6GkUBWBmusloJzp3Ii2Wo5qN
 nz9w9icsVw0n1uP9FoNucv07vHE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fb76b661b731a5d9c1358fd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Nov 2020 07:08:22
 GMT
Sender: zhenhuah=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D25DC43463; Fri, 20 Nov 2020 07:08:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zhenhuah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DFB71C433ED;
        Fri, 20 Nov 2020 07:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DFB71C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=zhenhuah@codeaurora.org
Date:   Fri, 20 Nov 2020 15:08:06 +0800
From:   Zhenhua Huang <zhenhuah@codeaurora.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     vjitta@codeaurora.org, linux-mm <linux-mm@kvack.org>,
        glider@google.com, Dan Williams <dan.j.williams@intel.com>,
        broonie@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yogesh Lal <ylal@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>, tingwei@codeaurora.org
Subject: Re: [PATCH] lib: stackdepot: Add support to configure STACK_HASH_SIZE
Message-ID: <20201120070450.GA28239@codeaurora.org>
References: <1603372546-27118-1-git-send-email-vjitta@codeaurora.org>
 <CAEwNFnBvxu7+oNkcO9D70OFrxQXswcJG4OvDPyzNf7kpXfpSuw@mail.gmail.com>
 <20201119033317.GA5128@codeaurora.org>
 <20201120050423.GE3113267@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120050423.GE3113267@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:04:23PM +0800, Minchan Kim wrote:
> On Thu, Nov 19, 2020 at 11:34:32AM +0800, Zhenhua Huang wrote:
> > On Wed, Nov 04, 2020 at 07:27:03AM +0800, Minchan Kim wrote:
> > > Sorry if this mail corrupts the mail thread or had heavy mangling
> > > since I lost this mail from my mailbox so I am sending this mail by
> > > web gmail.
> > > 
> > > On Thu, Oct 22, 2020 at 10:18 AM <vjitta@codeaurora.org> wrote:
> > > >
> > > > From: Yogesh Lal <ylal@codeaurora.org>
> > > >
> > > > Use STACK_HASH_ORDER_SHIFT to configure STACK_HASH_SIZE.
> > > >
> > > > Aim is to have configurable value for  STACK_HASH_SIZE,
> > > > so depend on use case one can configure it.
> > > >
> > > > One example is of Page Owner, default value of
> > > > STACK_HASH_SIZE lead stack depot to consume 8MB of static memory.
> > > > Making it configurable and use lower value helps to enable features
> like
> > > > CONFIG_PAGE_OWNER without any significant overhead.
> > > >
> > > > Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
> > > > Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
> > > > Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> > > > ---
> > > >  lib/Kconfig      | 9 +++++++++
> > > >  lib/stackdepot.c | 3 +--
> > > >  2 files changed, 10 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > > index 18d76b6..b3f8259 100644
> > > > --- a/lib/Kconfig
> > > > +++ b/lib/Kconfig
> > > > @@ -651,6 +651,15 @@ config STACKDEPOT
> > > >         bool
> > > >         select STACKTRACE
> > > >
> > > > +config STACK_HASH_ORDER_SHIFT
> > > > +       int "stack depot hash size (12 => 4KB, 20 => 1024KB)"
> > > > +       range 12 20
> > > > +       default 20
> > > > +       depends on STACKDEPOT
> > > > +       help
> > > > +        Select the hash size as a power of 2 for the stackdepot
> hash 
> > > > table.
> > > > +        Choose a lower value to reduce the memory impact.
> > > > +
> > > >  config SBITMAP
> > > >         bool
> > > >
> > > > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > > > index 2caffc6..413c20b 100644
> > > > --- a/lib/stackdepot.c
> > > > +++ b/lib/stackdepot.c
> > > > @@ -142,8 +142,7 @@ static struct stack_record
> *depot_alloc_stack(unsigned 
> > > > long *entries, int size,
> > > >         return stack;
> > > >  }
> > > >
> > > > -#define STACK_HASH_ORDER 20
> > > > -#define STACK_HASH_SIZE (1L << STACK_HASH_ORDER)
> > > > +#define STACK_HASH_SIZE (1L << CONFIG_STACK_HASH_ORDER_SHIFT)
> > > >  #define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
> > > >  #define STACK_HASH_SEED 0x9747b28c
> > > >
> > > > --
> > > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member 
> > > > of Code Aurora Forum, hosted by The Linux Foundation
> > > > 2.7.4
> > > >
> > > 
> > > 1. When we don't use page_owner, we don't want to waste any memory for
> > > stackdepot hash array.
> > > 2. When we use page_owner, we want to have reasonable stackdeport hash
> array
> > > 
> > > With this configuration, it couldn't meet since we always need to
> > > reserve a reasonable size for the array.
> > > Can't we make the hash size as a kernel parameter?
> > > With it, we could use it like this.
> > > 
> > > 1. page_owner=off, stackdepot_stack_hash=0 -> no more wasted memory
> > > when we don't use page_owner
> > > 2. page_owner=on, stackdepot_stack_hash=8M -> reasonable hash size
> > > when we use page_owner.
> > Seems we have other users like kasan, and dma_buf_ref which we
> introduced.
> > Also we can't guarantee there will not be any other users for
> stackdepot, so
> > it's better we not depend on only page owner?
> 
> I didn't mean to make it page_owner dependent. What I suggested is just
> to define kernel parameter for stackdeport hash size so admin could
> override it at right size when we really need it.
OK, Thanks Minchan for explanation. It's a good idea then, admin needs to
consider all users but, especailly when setting it to 0...

Thanks,
Zhenhua
