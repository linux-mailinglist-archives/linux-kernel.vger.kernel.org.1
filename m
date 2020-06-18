Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED8A1FFA46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 19:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgFRRaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 13:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgFRRay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:30:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A8EC06174E;
        Thu, 18 Jun 2020 10:30:54 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s1so8295355ljo.0;
        Thu, 18 Jun 2020 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LLjHIli70RtnXlTI4EfBB8zQjRqR6fYYQyFR1XCt3TI=;
        b=bX0kTC4lkS2aDFGGfAbSxQf8k+8W6lxo9zA1oY/DEpo69uco2s+8ITfTMzSygfxtSj
         A0LhmXbvmZ+kYVl6x66ZeBudU5yBp8RSb6EQ+SachuR48JB3oNQVMSQAShC17rKgdoMu
         tPu6e3vifyaejtBzHxsAxPYoq0wUMha+e6upecJ1I3pqksjDVobyrPoCIVbd47F82wxI
         mcBRxW0o43tGYJHYA6afwFUZPfAeSO24JC6txW38uya+pWbKQ2GUBmCb3UM2ZeOpVMvt
         UnxDOBKy3ZTI3sEPTDdcklWl8ZpeSMtxnVgIWgCcLXZbTXgOtKMCwDyIaSpn/YLaO0Mp
         nkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LLjHIli70RtnXlTI4EfBB8zQjRqR6fYYQyFR1XCt3TI=;
        b=fP2DmKbLDUOAdTeSR7pBMrzHes5mGPtUN//NrAUlpRPJ09Gwkbm1N0ZXOqxqgbSAgK
         qrt2+d4Fhit9j+jnHnO3+IhBtcGAMC79ZTd23UPPbfC+CSe7TcxaJgiBJtTNqqp5oiG6
         yxrLApMtz5wHRFXXsGOCzxKadzU58OZMyacDc3CykyLDgZCN8UKzU9RvsgUMKOemWDQ8
         Zte/3R29xkMzoXzSxWwB3b2wsJ1TOz2tgtxgUc73Ta1it3fOA5GpOYkzVB69xNjoCXvT
         fyvdoQPeaR1cFG7VlDEsmRcLVplNcyh9ZVk8IOAY26O7vdwrdZTi8FkxLKJF7+Gn5TRd
         wSNA==
X-Gm-Message-State: AOAM5329jjGEmH0hHhfwle7DyBmsv+SUKPIvwPlnzf/TWMmjevm6Cz0Q
        GsIcZZP/mU5SdOP6KEz6kWo=
X-Google-Smtp-Source: ABdhPJxBZuKl2yX1qrLrJhO8AfooCK/RcO1iqNMoYLCS85yGswo/fmNGfIBzwQ+bscKFxkQE56ffpA==
X-Received: by 2002:a2e:8953:: with SMTP id b19mr3029047ljk.187.1592501452890;
        Thu, 18 Jun 2020 10:30:52 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id q11sm876206lfe.34.2020.06.18.10.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 10:30:51 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 18 Jun 2020 19:30:49 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618173049.GB14613@pc636>
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618005214.GN8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618005214.GN8681@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Not an emergency, but did you look into replacing this "if" statement
> > with an array of pointers to functions implementing the legs of the
> > "if" statement?  If nothing else, this would greatly reduced indentation.
> 
> I don't think that replacing direct function calls with indirect function
> calls is a great suggestion with the current state of play around branch
> prediction.
> 
> I'd suggest:
> 
>  			rcu_lock_acquire(&rcu_callback_map);
> 			trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
> 				bkvhead[i]->nr_records, bkvhead[i]->records);
>  			if (i == 0) {
>  				kfree_bulk(bkvhead[i]->nr_records,
>  					bkvhead[i]->records);
>  			} else {
>  				for (j = 0; j < bkvhead[i]->nr_records; j++) {
>  					vfree(bkvhead[i]->records[j]);
>  				}
>  			}
>  			rcu_lock_release(&rcu_callback_map);
>
There are two different trace functions, one for "bulk" tracing
messages, and another one is per one call of kfree(), though we use 
to indicate vfree() call.

Probably we can rename it to: trace_rcu_invoke_kvfree_callback();

What do you think?

> 
> But I'd also suggest a vfree_bulk be added.  There are a few things
> which would be better done in bulk as part of the vfree process
> (we batch them up already, but i'm sure we could do better).
> 
I was thinking to implement of vfree_bulk() API, but i guess it can
be done as future work.

Does that sound good?

--
Vlad Rezki
