Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645E32B7057
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgKQUmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729301AbgKQUmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:42:07 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CECC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:42:07 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id j19so10018001pgg.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=duT/CyaJ82WSIZu+w/NyT8ZBnm8LYdwKsQ41CeSRpTg=;
        b=GOEyU+PFgxtJ/JlybIstLKF/zCFvMRj0HJfuZye3TWtFKPRGlcxk3Yyj3mFdDiYHoQ
         Oxy/iE2KCz1O2vDfls03Z3/4WckMIQuvf0zoiaN2/gsG3IwzzWalP2JCSHjYgtOG/7Tg
         hHQ5ejLjyxSJyU8R2LXZewWk4YJ0z9lO+94qZetH0mbnI/p/QZWM4vVEnKAqW7UnAvyb
         n61egTcSufMSGQQ8lQ0ceEIS/CLdxyN69LppoWwz8QqnMz0RIcaXEgV1yjE9uDQNgKGB
         jMZZ6B3BoyF2O+jpaCeYktquGKpjDTsNlyfYpxu9+S/Skoo2GNFazgNFc4DmGkf9a/bc
         EMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=duT/CyaJ82WSIZu+w/NyT8ZBnm8LYdwKsQ41CeSRpTg=;
        b=NAIlnZBn4XQOneRT6vPrNSwT+AJNFFcL6jRjUwKiEITyH+Spnnmj3YqQM0y8y4eEt2
         tG+Q1u9uoUNFiwKG5IhARmYjbHBRYItoyNrMpWLYV0feU7vhhNRW4O39f+xmeg1Hx3u+
         SfyCTHLqmRuWiEa5hnkHhQSVTgx/gaxUdjbJJ3gXKJO8Oa68EUvPod2/QCZV3YEnd4BY
         /GdAxz2BMJLhdgK2pCPgC5jTg3I9tI01qofCM4BphdoAzUmUv6V+6TbXYccWPGWU5ptt
         eGCoea/WdABSAZL+mS2LE1JinxQ7CRrZfCgKL7Wa1zN/VEtBsjwKq4N6BGjEbc7lg4mI
         RW9Q==
X-Gm-Message-State: AOAM531CmYf5RIvnUUi7VcdKKltqH1qj8MTHhEmYl/z89pXY9J+0JTDv
        Fyu7bupTo5DttvpVQVRkCZk=
X-Google-Smtp-Source: ABdhPJzJc0tbp+bsXkyuSyM2yRe4AH5B0nq/qRb/0+/Ytls8/F4RazcUEeomrq3NRVlKzw6kf6wKMQ==
X-Received: by 2002:aa7:8154:0:b029:156:4b89:8072 with SMTP id d20-20020aa781540000b02901564b898072mr1240748pfn.51.1605645727311;
        Tue, 17 Nov 2020 12:42:07 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id r36sm19659553pgb.75.2020.11.17.12.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 12:42:06 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 17 Nov 2020 12:42:04 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vijayanand Jitta <vjitta@codeaurora.org>,
        linux-mm <linux-mm@kvack.org>, glider@google.com,
        Dan Williams <dan.j.williams@intel.com>, broonie@kernel.org,
        mhiramat@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Lal <ylal@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>
Subject: Re: [PATCH] lib: stackdepot: Add support to configure STACK_HASH_SIZE
Message-ID: <20201117204204.GA3905260@google.com>
References: <1603372546-27118-1-git-send-email-vjitta@codeaurora.org>
 <CAEwNFnBvxu7+oNkcO9D70OFrxQXswcJG4OvDPyzNf7kpXfpSuw@mail.gmail.com>
 <282d7028-498d-50b3-37d4-2381571f9f9e@codeaurora.org>
 <ed4a1e75-3e3a-4950-7bb5-3d83db7bf054@codeaurora.org>
 <20201112145649.3fcd9dc4d6d3db4bd26245bb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112145649.3fcd9dc4d6d3db4bd26245bb@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 02:56:49PM -0800, Andrew Morton wrote:
> On Thu, 12 Nov 2020 18:26:24 +0530 Vijayanand Jitta <vjitta@codeaurora.org> wrote:
> 
> > >> 1. page_owner=off, stackdepot_stack_hash=0 -> no more wasted memory
> > >> when we don't use page_owner
> > >> 2. page_owner=on, stackdepot_stack_hash=8M -> reasonable hash size
> > >> when we use page_owner.
> > >>
> > >>
> > > 
> > > This idea looks fine to me. Andrew and others would like to hear your
> > > comments as well on this before implementing.
> > > 
> > > Thanks,
> > > Vijay
> > > 
> > 
> > Awaiting for comments from Andrew and others.
> 
> I don't actually understand the problem.
> 
> What is it about page-owner that causes stackdepot to consume
> additional memory?  As far as I can tell, sizeof(struct stack_record)
> isn't affected by page-owner?
> 

Thing is once we build stackdepot due to the dependency from page_owner,
it will consume 8M regardless of using page_owner.

#define STACK_HASH_SIZE (1L << CONFIG_STACK_HASH_ORDER_SHIFT)

static struct stack_record *stack_table[STACK_HASH_SIZE] = {
	[0 ...  STACK_HASH_SIZE - 1] = NULL
};

So if we decide the size option at build time, we should consume
the memory anyway regardless of page_owner enabling in runtime.
