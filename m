Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE0429686B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 04:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374485AbgJWCGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 22:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901493AbgJWCGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 22:06:37 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833AEC0613CE;
        Thu, 22 Oct 2020 19:06:37 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t25so140118ejd.13;
        Thu, 22 Oct 2020 19:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1jn8Kk50qCDHYyTfqxSuEqnO8pjhloSo58/JI251AU4=;
        b=Dpv1oxJg+k5W1Rw1w9YczB7GdmePJ1hRHL9hMruI6wG2af5CHE63mWiS4x70qxRX8T
         dBKJ2YH4nHDODuoCgR91R/phv96koj8SHhRA5/LH7NhL/9daCdFZUeHwzfoEZLXmjCob
         TUEk4p5GUo7Tg6mK5YIZw8fv7KkI5CAAl7489BG0k5O6nzI5q+WrsJVYUou1j/5fdIbk
         ycqM5F2C3KXsTu02+t38KCuD32NKpTIPZgHIQBGje46m1tVkWqEdLgQZwJCEnjBhBPMf
         NRkHi8xbHjSQ6hdItEHq+t8TUs5tcPKPjsFIsEdQ9cgP1j/m3tyN6URoz4ogNGfFmA17
         xJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1jn8Kk50qCDHYyTfqxSuEqnO8pjhloSo58/JI251AU4=;
        b=DA6y6yMT0cHwkrq4S+aj3XM/rFwcGpIEi8gfx5tcNqCOazsNYamppZB1EYKSmvAGbO
         8UCM4Y+il2VvghmfZIeS2jXhMC9IkeJjxu6R4ENI4DWl10pbSM+1/xtgugn+W/8tvRdZ
         +BWBD0Kyo+AU6Qrn0k/AazQQ4vSuwVzdxKYrxHXaeb2Kg5Q0NktR5Ba4Nsy/gRA3z9ir
         xcq665mEigSobQBMyvU3H654kxvgS5l+wngW3aWHJhtLqIzn71cw/8LRdsqmbO54juLZ
         TFznkzj59E2Y7MFK4QCqtaP9fNA2lX5xaPmVNUsFqb9/0gTWXcVfmUQDXWwEiPl+MQm3
         k1DA==
X-Gm-Message-State: AOAM532Ur6PpccTHCd94V+8q3Py+WVLB+l+SlJQ+l7BApvIKEdhp9vY0
        IqY+ZTYJzJCuJnwNJu7D2TI=
X-Google-Smtp-Source: ABdhPJxUhqAB2P0tOEAfdwNOuDcnaISIDxKzMG6OmhvPtd8RgbQIGceHBLVhtY3Qc6kSRoTuU8tJ/A==
X-Received: by 2002:a17:906:52d5:: with SMTP id w21mr5409711ejn.501.1603418796156;
        Thu, 22 Oct 2020 19:06:36 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id t7sm48463edj.45.2020.10.22.19.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2020 19:06:35 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2141927C0054;
        Thu, 22 Oct 2020 22:06:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 22 Oct 2020 22:06:33 -0400
X-ME-Sender: <xms:qDqSXwAiFAiXdd0BZpxNfWkCBv4R9u6GH1EXuW3cB5y2JnHdHlOwkg>
    <xme:qDqSXyiWFCea6bAappxieiqSELW04QDlOxCW9q_NN0KSJNAHWZkW2tQPHXHTtQaIE
    t1DaKZLXAuMUBAJmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeelgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphepuddtuddrkeeirdeguddrgeejnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:qDqSXzk37DbPZju6hTk4hTps9rUP0he4MD2ivCJuueyyjX-VVzPG0g>
    <xmx:qDqSX2wloDfz8pUB0WadMTenPKN3UuIH__HDG6EmypDcZSYiJcNUyg>
    <xmx:qDqSX1S7ovSNul-XgJyxdiOXRX70vVJWnlj1AQ8KeU56VMC48vsLbg>
    <xmx:qTqSX-JaRo17IlGzJt3XsHbgnKDUvQAQOIs4Q0QLxEOBfNeRBV85eQ>
Received: from localhost (unknown [101.86.41.47])
        by mail.messagingengine.com (Postfix) with ESMTPA id C5BF33280060;
        Thu, 22 Oct 2020 22:06:31 -0400 (EDT)
Date:   Wed, 21 Oct 2020 11:27:21 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] docs: lockdep-design: fix some warning issues
Message-ID: <20201021032721.GA1982@boqun-laptop.fareast.corp.microsoft.com>
References: <cover.1603282193.git.mchehab+huawei@kernel.org>
 <ef8a80c3250dcbea64c6dda2b9b25f81f93da4eb.1603282193.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef8a80c3250dcbea64c6dda2b9b25f81f93da4eb.1603282193.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:17:23PM +0200, Mauro Carvalho Chehab wrote:
> There are several warnings caused by a recent change
> 224ec489d3cd ("lockdep/Documention: Recursive read lock detection reasoning")
> 
> Those are reported by htmldocs build:
> 
>     Documentation/locking/lockdep-design.rst:429: WARNING: Definition list ends without a blank line; unexpected unindent.
>     Documentation/locking/lockdep-design.rst:452: WARNING: Block quote ends without a blank line; unexpected unindent.
>     Documentation/locking/lockdep-design.rst:453: WARNING: Unexpected indentation.
>     Documentation/locking/lockdep-design.rst:453: WARNING: Blank line required after table.
>     Documentation/locking/lockdep-design.rst:454: WARNING: Block quote ends without a blank line; unexpected unindent.
>     Documentation/locking/lockdep-design.rst:455: WARNING: Unexpected indentation.
>     Documentation/locking/lockdep-design.rst:455: WARNING: Blank line required after table.
>     Documentation/locking/lockdep-design.rst:456: WARNING: Block quote ends without a blank line; unexpected unindent.
>     Documentation/locking/lockdep-design.rst:457: WARNING: Unexpected indentation.
>     Documentation/locking/lockdep-design.rst:457: WARNING: Blank line required after table.
> 
> Besides the reported issues, there are some missing blank
> lines that ended producing wrong html output, and some
> literals are not properly identified.
> 
> Also, the symbols used at the irq enabled/disable table
> are not displayed as expected, as they're not literals.
> Also, on another table they're using a different notation.
> 
> Fixes: 224ec489d3cd ("lockdep/Documention: Recursive read lock detection reasoning")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  Documentation/locking/lockdep-design.rst | 51 ++++++++++++++----------
>  1 file changed, 31 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
> index cec03bd1294a..9f3cfca9f8a4 100644
> --- a/Documentation/locking/lockdep-design.rst
> +++ b/Documentation/locking/lockdep-design.rst
> @@ -42,6 +42,7 @@ The validator tracks lock-class usage history and divides the usage into
>  (4 usages * n STATEs + 1) categories:
>  
>  where the 4 usages can be:
> +
>  - 'ever held in STATE context'
>  - 'ever held as readlock in STATE context'
>  - 'ever held with STATE enabled'
> @@ -49,10 +50,12 @@ where the 4 usages can be:
>  
>  where the n STATEs are coded in kernel/locking/lockdep_states.h and as of
>  now they include:
> +
>  - hardirq
>  - softirq
>  
>  where the last 1 category is:
> +
>  - 'ever used'                                       [ == !unused        ]
>  
>  When locking rules are violated, these usage bits are presented in the
> @@ -96,9 +99,9 @@ exact case is for the lock as of the reporting time.
>    +--------------+-------------+--------------+
>    |              | irq enabled | irq disabled |
>    +--------------+-------------+--------------+
> -  | ever in irq  |      ?      |       -      |
> +  | ever in irq  |     '?'     |      '-'     |
>    +--------------+-------------+--------------+
> -  | never in irq |      +      |       .      |
> +  | never in irq |     '+'     |      '.'     |
>    +--------------+-------------+--------------+
>  
>  The character '-' suggests irq is disabled because if otherwise the
> @@ -216,7 +219,7 @@ looks like this::
>         BD_MUTEX_PARTITION
>    };
>  
> -mutex_lock_nested(&bdev->bd_contains->bd_mutex, BD_MUTEX_PARTITION);
> +  mutex_lock_nested(&bdev->bd_contains->bd_mutex, BD_MUTEX_PARTITION);
>  
>  In this case the locking is done on a bdev object that is known to be a
>  partition.
> @@ -334,7 +337,7 @@ Troubleshooting:
>  ----------------
>  
>  The validator tracks a maximum of MAX_LOCKDEP_KEYS number of lock classes.
> -Exceeding this number will trigger the following lockdep warning:
> +Exceeding this number will trigger the following lockdep warning::
>  
>  	(DEBUG_LOCKS_WARN_ON(id >= MAX_LOCKDEP_KEYS))
>  
> @@ -420,7 +423,8 @@ the critical section of another reader of the same lock instance.
>  
>  The difference between recursive readers and non-recursive readers is because:
>  recursive readers get blocked only by a write lock *holder*, while non-recursive
> -readers could get blocked by a write lock *waiter*. Considering the follow example:
> +readers could get blocked by a write lock *waiter*. Considering the follow
> +example::
>  
>  	TASK A:			TASK B:
>  
> @@ -448,20 +452,22 @@ There are simply four block conditions:
>  
>  Block condition matrix, Y means the row blocks the column, and N means otherwise.
>  
> -	    | E | r | R |
>  	+---+---+---+---+
> -	  E | Y | Y | Y |
> +	|   | E | r | R |
>  	+---+---+---+---+
> -	  r | Y | Y | N |
> +	| E | Y | Y | Y |
> +	+---+---+---+---+
> +	| r | Y | Y | N |
> +	+---+---+---+---+
> +	| R | Y | Y | N |
>  	+---+---+---+---+
> -	  R | Y | Y | N |
>  
>  	(W: writers, r: non-recursive readers, R: recursive readers)
>  
>  
>  acquired recursively. Unlike non-recursive read locks, recursive read locks
>  only get blocked by current write lock *holders* other than write lock
> -*waiters*, for example:
> +*waiters*, for example::
>  
>  	TASK A:			TASK B:
>  
> @@ -491,7 +497,7 @@ Recursive locks don't block each other, while non-recursive locks do (this is
>  even true for two non-recursive read locks). A non-recursive lock can block the
>  corresponding recursive lock, and vice versa.
>  
> -A deadlock case with recursive locks involved is as follow:
> +A deadlock case with recursive locks involved is as follow::
>  
>  	TASK A:			TASK B:
>  
> @@ -510,7 +516,7 @@ because there are 3 types for lockers, there are, in theory, 9 types of lock
>  dependencies, but we can show that 4 types of lock dependencies are enough for
>  deadlock detection.
>  
> -For each lock dependency:
> +For each lock dependency::
>  
>  	L1 -> L2
>  
> @@ -525,20 +531,25 @@ same types).
>  With the above combination for simplification, there are 4 types of dependency edges
>  in the lockdep graph:
>  
> -1) -(ER)->: exclusive writer to recursive reader dependency, "X -(ER)-> Y" means
> +1) -(ER)->:
> +	    exclusive writer to recursive reader dependency, "X -(ER)-> Y" means
>  	    X -> Y and X is a writer and Y is a recursive reader.
>  
> -2) -(EN)->: exclusive writer to non-recursive locker dependency, "X -(EN)-> Y" means
> +2) -(EN)->:
> +	    exclusive writer to non-recursive locker dependency, "X -(EN)-> Y" means
>  	    X -> Y and X is a writer and Y is either a writer or non-recursive reader.
>  
> -3) -(SR)->: shared reader to recursive reader dependency, "X -(SR)-> Y" means
> +3) -(SR)->:
> +	    shared reader to recursive reader dependency, "X -(SR)-> Y" means
>  	    X -> Y and X is a reader (recursive or not) and Y is a recursive reader.
>  
> -4) -(SN)->: shared reader to non-recursive locker dependency, "X -(SN)-> Y" means
> +4) -(SN)->:
> +	    shared reader to non-recursive locker dependency, "X -(SN)-> Y" means
>  	    X -> Y and X is a reader (recursive or not) and Y is either a writer or
>  	    non-recursive reader.
>  
> -Note that given two locks, they may have multiple dependencies between them, for example:
> +Note that given two locks, they may have multiple dependencies between them,
> +for example::
>  
>  	TASK A:
>  
> @@ -592,11 +603,11 @@ circles that won't cause deadlocks.
>  
>  Proof for sufficiency (Lemma 1):
>  
> -Let's say we have a strong circle:
> +Let's say we have a strong circle::
>  
>  	L1 -> L2 ... -> Ln -> L1
>  
> -, which means we have dependencies:
> +, which means we have dependencies::
>  
>  	L1 -> L2
>  	L2 -> L3
> @@ -633,7 +644,7 @@ a lock held by P2, and P2 is waiting for a lock held by P3, ... and Pn is waitin
>  for a lock held by P1. Let's name the lock Px is waiting as Lx, so since P1 is waiting
>  for L1 and holding Ln, so we will have Ln -> L1 in the dependency graph. Similarly,
>  we have L1 -> L2, L2 -> L3, ..., Ln-1 -> Ln in the dependency graph, which means we
> -have a circle:
> +have a circle::
>  
>  	Ln -> L1 -> L2 -> ... -> Ln
>  
> -- 
> 2.26.2
> 
