Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D14222621
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 16:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgGPOrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 10:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgGPOrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:47:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6023AC061755;
        Thu, 16 Jul 2020 07:47:32 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q7so7506110ljm.1;
        Thu, 16 Jul 2020 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZK+12jCm5MTg9xTYbE2yZv4zQUftKp93X+3l7pCSao4=;
        b=s0u/HAsCNUtZR50BTvHEvUbFZTcNF5MMv/OtOPlBrTusN+bAJzQ6jwX8yWN292TZUJ
         hvy6W37KFJgsC0GfRQuFT+npoqDJajMcD1xyOnAb66OCFeioKWl7V9UoQSiue+Zg0rl9
         uF9Cj0VICMZot1rrggzjhl+haD44TvEQ364maW3y3yK9kpfEv4AapC2UKYXj7Cu2ZB9R
         MY7c0SuMOqSXHw+SptBOs+TlgSI2rOMcYO0qctkPJMkNhG66ZbqA+qIto+uZ07Yf2c/E
         dYtqXhY2dr5Gv0FOvfyu4qGnv5Y6x/PdR2f4efTbkUlQcmGhgSFPioOom1xtNNEghyXB
         SPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZK+12jCm5MTg9xTYbE2yZv4zQUftKp93X+3l7pCSao4=;
        b=fkfKWCBObHrEoclvDvUvlRx+hVZizavhj3+vVljVDiEg17AB3y1a0MYdUy2Eh83PJX
         dSTRm6PV4SmAl80owRkGJtxc2WrgdKb5n5giDhttFJQ6y6zLsPL/5+GuVxiKw9+RW7Av
         zQrk8GrwE9L1w2CElEg1i3lDNOuV1HQYFhbwez82LlhNVQ5QweMkJbt4gSACiAgxFbfp
         j2nqoPrLfqNs8yGlgKbM1M2v9nwJchzS29IWuFBATwOZApTNMT7Tn5aX8qRO0+ightng
         WVLhV1V/wS2++CeX00Qoh1mHBki0b1YoP0J8LxqvY1lozBdabNXQFOKMEFnq1U47r3w6
         giRw==
X-Gm-Message-State: AOAM530udnB8lLkDYAL1LpDuql6qDc0ftT53Fdx36wsfe96R3HGeCGle
        6oBx1/vZ02HoeQVht1NNgHs=
X-Google-Smtp-Source: ABdhPJw7FKB1H+uh2YcUwLfPEd3YRdVWzZdnBADWD+s29180OuS+ew/Uqhk6AcX0ISyzUJDeBtHMGA==
X-Received: by 2002:a2e:961a:: with SMTP id v26mr2323209ljh.467.1594910850791;
        Thu, 16 Jul 2020 07:47:30 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id m1sm1224034lfa.22.2020.07.16.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:47:30 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Jul 2020 16:47:28 +0200
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200716144728.GA31046@pc636>
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <CAEXW_YRoTvQfqqcM9fi+MkMxCPEaoJh4zHRM3qNYkv=-nAVuBQ@mail.gmail.com>
 <20200716091913.GA28595@pc636>
 <20200716142537.ecp4icsq7kg6qhdx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716142537.ecp4icsq7kg6qhdx@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 04:25:37PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-07-16 11:19:13 [+0200], Uladzislau Rezki wrote:
> > Sebastian, could you please confirm that if that patch that is in
> > question fixes it?
> > 
> > It would be appreciated!
> 
> So that preempt disable should in terms any warnings. However I don't
> think that it is strictly needed and from scheduling point of view you
> forbid a CPU migration which might be good otherwise.
>
Please elaborate your point regarding "i do not think it is strictly needed".

Actually i can rework the patch to remove even such preempt_enable/disable
to stay on the same CPU, but i do not see the point of doing it.

Do you see the point?

As for scheduling point of view. Well, there are many places when there
is a demand in memory or pages from atomic context. Also, getting a page
is not considered as a hot path in the kfree_rcu(). 

>
> Also if interrupts and everything is enabled then someone else might
> invoke kfree_rcu() from BH context for instance.
> 
And what? What is a problem here, please elaborate if you see any
issues.

--
Vlad Rezki
