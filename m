Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2771C4488
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 20:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgEDSIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 14:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732231AbgEDSIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:08:07 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139EBC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 11:08:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id i14so444788qka.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8lqlcqzLSXs6kQK5WzXKsA6SXfOJlZ0T+LEde0fpTBU=;
        b=gnaxHkTW0xp32Dnjn0U3/jhSQEoLB3QVuJZRpwpZQqGjQpILV2SWkM0bQgd73dRrsh
         V/J7zKNRB3rG2HTqPTTN47hpUnZBw81Uv14JodvK3TSNjF1447WH41WQOwua+88IdE35
         RQ58FtnvDfzr+hliOFTTwbzGh4QByFIFewB78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8lqlcqzLSXs6kQK5WzXKsA6SXfOJlZ0T+LEde0fpTBU=;
        b=abGv1Cix+6TUgAiePRi396lePJTa54C4OixEJ1ce1Q0SXrPaHMg+XjBDiamFlI5ubt
         beR+BAeHIpJvSeeX0Qc06zQyo1Mf98gqwyMlTIofz4iD4W+QqYWag6PGs03hUADy5pvP
         IY/APzsupiwhYiZWTPrHkw8MlF5tfFs3kLLoEIbHvQeC1jJarxRurfQ5MxL6bIPz6iV4
         zIoiGl0IMFJ1qM6MiPfNRP40m/rpUWLCada5MA5qc7M4xrDP31LnyaGZ6XHkrT//fCmi
         i955xRUTY8AHQ3NAUDTTsIeBrfuL17t4ISqiLHVliYqmnxyRAdKZljvReyUGPg7l33LS
         y6Sg==
X-Gm-Message-State: AGi0PuZKgQYRqeyaNO0JZsFsaz+IvQn51z65CIaAcH/jaD05sFja/cew
        VzYqRyxTbtbMGaWF7po28ygAQQ==
X-Google-Smtp-Source: APiQypI5eZszvopLJuDAZRuwCkGzdKXSDC/oOtdUeAQZtCszD77WvOxRYkXISoFQHLqf83/FhKwcrg==
X-Received: by 2002:a37:809:: with SMTP id 9mr468583qki.93.1588615686148;
        Mon, 04 May 2020 11:08:06 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g16sm8606827qkk.122.2020.05.04.11.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 11:08:05 -0700 (PDT)
Date:   Mon, 4 May 2020 14:08:05 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 09/24] rcu/tree: cache specified number of objects
Message-ID: <20200504180805.GA172409@google.com>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-10-urezki@gmail.com>
 <20200501212749.GD7560@paulmck-ThinkPad-P72>
 <20200504124323.GA17577@pc636>
 <20200504152437.GK2869@paulmck-ThinkPad-P72>
 <20200504174822.GA20446@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504174822.GA20446@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 07:48:22PM +0200, Uladzislau Rezki wrote:
> On Mon, May 04, 2020 at 08:24:37AM -0700, Paul E. McKenney wrote:
[..] 
> > > > Presumably the list can also be accessed without holding this lock,
> > > > because otherwise we shouldn't need llist...
> > > > 
> > > Hm... We increase the number of elements in cache, therefore it is not
> > > lockless. From the other hand i used llist_head to maintain the cache
> > > because it is single linked list, we do not need "*prev" link. Also
> > > we do not need to init the list.
> > > 
> > > But i can change it to list_head. Please let me know if i need :)
> > 
> > Hmmm...  Maybe it is time for a non-atomic singly linked list?  In the RCU
> > callback processing, the operations were open-coded, but they have been
> > pushed into include/linux/rcu_segcblist.h and kernel/rcu/rcu_segcblist.*.
> > 
> > Maybe some non-atomic/protected/whatever macros in the llist.h file?
> > Or maybe just open-code the singly linked list?  (Probably not the
> > best choice, though.)  Add comments stating that the atomic properties
> > of the llist functions aren't neded?  Something else?
> >
> In order to keep it simple i can replace llist_head by the list_head?

Just to clarify for me, what is the disadvantage of using llist here?

Since we don't care about traversing backwards, isn't it better to use llist
for this usecase?

I think Vlad is using locking as we're also tracking the size of the llist to
know when to free pages. This tracking could suffer from the lost-update
problem without any locking, 2 lockless llist_add happened simulatenously.

Also if list_head is used, it will take more space and still use locking.

Thoughts?

thanks,

 - Joel

> > 
> > The comments would be a good start.  Just to take pity on people seeing
> > the potential for concurrency and wondering how the concurrent accesses
> > actually happen.  ;-)
> > 
> Sounds like you are kidding me :) 
> 
> --
> Vlad Rezki
