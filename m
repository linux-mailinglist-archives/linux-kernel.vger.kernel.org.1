Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D308019FA24
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 18:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgDFQc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 12:32:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40682 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgDFQc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:32:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id j17so12379219lfe.7;
        Mon, 06 Apr 2020 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DeMJSh8JzgKPQANQorvFmrAQkO5UTeuBmpSrUn1GgpE=;
        b=IPw2IpvEzk01AdXSGLkR+7SQ6u9FEex6ZOVFYWbeeposuSgfaNysRamNsBGPkU52bG
         5oVfJcBfC7BQrkY6xbzvR7+0XlsVrcyZj3lbZpgwOlfvR3XJYKQoDgBGvCk3dxa1uoUt
         yScdRZaicRKy2LHrayPdocK63chzCd48QGS6EUzCR+nD4OBx6JsK+vNWOZY8eQ7xvEdA
         zyeVcLs2C5EOh9O4VZE6mEijzFxk2KrDGQPwEET3nc+fFICcZXbInQ8l0ULBWVXYWoWe
         q7PfYKgOlYfVTiLOZTm8UMgxiC5OGM6IFpVrN3N+26PIujj91MVjb+8mFAbjxKFSg0QE
         rpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DeMJSh8JzgKPQANQorvFmrAQkO5UTeuBmpSrUn1GgpE=;
        b=rmQbPFr0+RcO9caDeq9C0ETY34hjn5NFXnB3HnVj6+nOMUXEUsfQJdtdxgxPJ8TU08
         whJOh9Gb2pw5yrcTbzNLbn7Nv3+GvjQNj8x9oGlyhOLVpMFedxjzmQ8jVp/S4aLiwn8C
         4eglIJfq35/rusmOcD6tsw1kkgstcZVjeln+bRfkmDmGDlb3AUMzwxsp4MgJqQMw5bCE
         g6o8JzJGc7oXfsTKVLRuY52oekBdKXmz98EXtYt10wITWopqgN3uN3xOc6PWh4+QnQX9
         r7XG+fi2aE6Abg/5EH4hU+2ZrVA59j7BIpqbrJ/jBNVQcAgCyMBwtFB7kE9SNacSPiDB
         2w8w==
X-Gm-Message-State: AGi0PuZ1b2sQJBKDzfJ0Vf4szDYuPQwJfDKF/kO00mbFPtbS8EtoLMC0
        XiXf37NDsKqhrYjZxmaGCLU=
X-Google-Smtp-Source: APiQypKQ43UX6g8dBTlFCqaWswvvraHqaATn1I30zw3t/NRvWSUVHLktSY1hM42o83zQCQmt8ZqOHg==
X-Received: by 2002:a05:6512:308e:: with SMTP id z14mr14072207lfd.110.1586190744030;
        Mon, 06 Apr 2020 09:32:24 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id p21sm10205867ljg.5.2020.04.06.09.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:32:23 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 6 Apr 2020 18:32:16 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: add emergency pool for headless case
Message-ID: <20200406163216.GA4268@pc636>
References: <20200403173051.4081-1-urezki@gmail.com>
 <20200404195129.GA83565@google.com>
 <20200405172105.GA7539@pc636>
 <20200405233028.GC83565@google.com>
 <20200406125640.GA23256@pc636>
 <20200406153110.GE19865@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406153110.GE19865@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Apr 06, 2020 at 02:56:40PM +0200, Uladzislau Rezki wrote:
> > Hello, Joel.
> > 
> > > > > 
> > > > > Hi Vlad,
> > > > > 
> > > > > One concern I have is this moves the problem a bit further down. My belief is
> > > > > we should avoid the likelihood of even needing an rcu_head allocated for the
> > > > > headless case, to begin with - than trying to do damage-control when it does
> > > > > happen. The only way we would end up needing an rcu_head is if we could not
> > > > > allocate an array.
> > > > > 
> > > > Let me share my view on all such caching. I think that now it becomes less as
> > > > the issue, because of we have now https://lkml.org/lkml/2020/4/2/383 patch.
> > > > I see that it does help a lot. I tried to simulate low memory condition and 
> > > > apply high memory pressure with that. I did not manage to trigger the
> > > > "synchronize rcu" path at all. It is because of using much more permissive
> > > > parameters when we request a memory from the SLAB(direct reclaim, etc...).
> > > 
> > > That's a good sign that we don't hit this path in your tests.
> > > 
> > Just one request, of course if you have a time :) Could you please
> > double check on your test environment to stress the system to check
> > if you also can not hit it?
> > 
> > How i test it. Please apply below patch:
> 
> This is of course a double challenge.
> 
> I can assure you that even if we cannot make it happen in the comfort and
> safety of our tests systems, someone somewhere will make it happen all
> the time.  Because there is a very large number of Linux systems running
> out there.
> 
> Which leads to the other challenge:  How do we test this code path?
> 
I have added extra tests to my "vmalloc tests" https://lkml.org/lkml/2020/4/2/384
for stressing head/headless variants. Also we have rcuperf module. Running them
together under KVM(selftests) would be good. Plus we can add a counter of the
path we think is bad, synchronize_rcu() and so on.

Thanks!

--
Vlad Rezki
