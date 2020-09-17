Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E68326D0F3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 04:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIQCDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 22:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIQCDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 22:03:02 -0400
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 22:03:01 EDT
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC09AC06174A;
        Wed, 16 Sep 2020 18:53:44 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id r8so607969qtp.13;
        Wed, 16 Sep 2020 18:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UtmGdVHh9HT6IPtBW8yCBnrUkzJN7a2tNcA0ehwWLwU=;
        b=tgq6SoVkArsejIzixZBMCCoh8Ya0roIEAYVt5HSPQaL7+ccY0qHP9iyLAGz/wEDXwn
         VFT6TWee6L4HlqGBCwibDhaORFejfCpCGT0WaWqc8s9MAeVo4iXB6geQZsyJUMr6dfg3
         gwJh2waJkcgVR1nvmYdLFsvdebVvEgoa0Sx7c0gPCEAvP3JxHACrquZ0eq5C7n/Q4gb5
         CsPRkLm5eWYBiFY02l1Mokx+E2rKHDMpRMHKXe6flM1I+5Bv4smy5RjfUfNnghiV9870
         tPyp35MPknkFL9BHpe1Zy1+Qy7Xr1szclzGWDy7mMCv3BvewN8MMzwbzKVRy24gn6fHR
         p7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UtmGdVHh9HT6IPtBW8yCBnrUkzJN7a2tNcA0ehwWLwU=;
        b=duWOZ0ySn7nXaSUgkFLSxkIcnKz596oLc/T5TwL937bHPn1oPbtINmIPMW7v3uxbnG
         /38RfO2oXZ4P9lEoMMoF8cKEvvsOgejtLin3grlDarqrgs3SnZYk5jhRvxWDkwWEdzXW
         37TbqDW0qZ8OqkKCoMzv8KMZTxrXcYLv1RFqwWopEZc9RRyxmm8xSXqmLSka1p3gKPIe
         KZJq6iHyx7+mZI9WMIZZ7GPSdn9WHmmtrFcjn5lERHv+DknCeqBsfPBNin9jEwBA2dGM
         VtYMI75YHzpC42eGIAeJ2FeTYjxDDk2rbqAYXaxGBHDNxy4oftstbAyNZwQAtTXmFEE1
         cGXA==
X-Gm-Message-State: AOAM530c9xWoBThg7tpqfEechOgi/qSxLAYklApjtOxpXVFbQnVv0q8u
        4W2TEZK3VS4WF6vNilVb0XGieSdk5no=
X-Google-Smtp-Source: ABdhPJzzP8lWy8OkwpRxUV7hqKi88Iaub292BVV/Esx7P6uCT2gTOpHN19BMC7VJsmaz1QYIb4TQ8A==
X-Received: by 2002:aed:278a:: with SMTP id a10mr13826998qtd.261.1600307624137;
        Wed, 16 Sep 2020 18:53:44 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id k20sm28513qtm.44.2020.09.16.18.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 18:53:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id EF7B927C0054;
        Wed, 16 Sep 2020 21:53:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 16 Sep 2020 21:53:41 -0400
X-ME-Sender: <xms:pcFiX85WGTpyN-_vNQcz2_sydNqBvfQPeMRen4xuqsiuqe93bZgoqg>
    <xme:pcFiX94lpXLlyilk24MY9BQgLTLttwcPjsd8N2RjzIHyRJ_fdYBaAwek2RgwBQe1s
    mE-tc46vlJjKTvAfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdefgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphephedvrdduheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:pcFiX7frXpRN5U18R_Efx7EzjBFoO3nArgi2NXSTGUaQvFC6PPuuqg>
    <xmx:pcFiXxIzyLcBSDfxAbp5_ryniZ3cli8se7VRmzVHHYUFYlYYX7t14g>
    <xmx:pcFiXwKv-wrrvF0e7gI5FV8r27PJyS9DojhSNgc2MVKJIzXjXzenXg>
    <xmx:pcFiX48L4jOfrFHdOOGwLEUFz2a3W2Rsg9vVHNXEZVmxqPHCXORRmA>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id EAF7C3280059;
        Wed, 16 Sep 2020 21:53:40 -0400 (EDT)
Date:   Thu, 17 Sep 2020 09:53:39 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Qian Cai <cai@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>
Subject: Re: [RFC v7 11/19] lockdep: Fix recursive read lock related
 safe->unsafe detection
Message-ID: <20200917015339.GE127490@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
 <20200807074238.1632519-12-boqun.feng@gmail.com>
 <17343f6f7f2438fc376125384133c5ba70c2a681.camel@redhat.com>
 <20200916081046.GC127490@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200916161404.GD127490@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <607c446bc8d3a0cc6e96aa9792e075913ad6b2c6.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <607c446bc8d3a0cc6e96aa9792e075913ad6b2c6.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 05:11:59PM -0400, Qian Cai wrote:
> On Thu, 2020-09-17 at 00:14 +0800, Boqun Feng wrote:
> > Found a way to resolve this while still keeping the BFS. Every time when
> > we want to enqueue a lock_list, we basically enqueue a whole dep list of
> > entries from the previous lock_list, so we can use a trick here: instead
> > enqueue all the entries, we only enqueue the first entry and we can
> > fetch other silbing entries with list_next_or_null_rcu(). Patch as
> > below, I also took the chance to clear the code up and add more
> > comments. I could see this number (in /proc/lockdep_stats):
> > 
> > 	max bfs queue depth:                   201
> > 
> > down to (after apply this patch)
> > 
> > 	max bfs queue depth:                   61
> > 
> > with x86_64_defconfig along with lockdep and selftest configs.
> > 
> > Qian, could you give it a try?
> 
> It works fine as the number went down from around 3000 to 500 on our workloads.
> 

Thanks, let me send a proper patch. I will add a Reported-by tag from
you.

Regards,
Boqun
