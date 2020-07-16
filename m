Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2FD221F92
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 11:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgGPJTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 05:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgGPJTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:19:18 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA04C061755;
        Thu, 16 Jul 2020 02:19:18 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s9so6290834ljm.11;
        Thu, 16 Jul 2020 02:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XglsA6vu1woa2kgV/glk7kPKsFN4MeJdNdTHXrJSSno=;
        b=MGtkXGEvFpIkj3QBS/zV43tPHffYujAQi4Zp06aSfOPecDCub/DAcyfM7olmV30Ixw
         tqZhEpk3y2XQd5E4zcsoLUe3ig4InefSEGSL/KqACY1iP/QrvC2gFqzlS0xFvJGokl7S
         i6CsoPR2sgDJREAu7zdQkvBomUEdbqDJ+zLYOFQ3SjoAkLKxRR9zRCfRvnvGrrttubCy
         b92i+IZ1RyQVfPZHm/jqhPDfR3o55shS2DyMlV7f8bzJ8hIqsmHr+FyjmVLbEwj/wbTj
         oTsiGUVVGhMz/wq/Nev0l3bOsHm+8WQ3Fv0MWyF65gjjD20gfW+RpXRtClhXoQSNzvm4
         euVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XglsA6vu1woa2kgV/glk7kPKsFN4MeJdNdTHXrJSSno=;
        b=maa4hgF3RPUd8l4xlOtWYTCkEuJhl24kHvRZNM7qSY9zl9pdZRkMC43waY41Wul69P
         Liia1xhUAD5MdUzcV7viRvUYYhsAn6+hZVwf13Uud4YDnB98FMacW45u3sioEnwzgUBF
         SmgsFjvHdjLBk5FAc7rGV59i0WF9Lz3U2GZV3sdTjZ7uAYSNXmOdPk9p6Heg2yiFxnay
         1p8mfYjPhHBJiSVfCAUYmB+Il0VcUDtulaUCT/YBLA3fKcW9ntV8maz+zmp21iz7lAzp
         qG2+aTpL71LSCKrHduqK4scmxK+9PW54Hpa7eE1eEe7ALzaloTwU6y3XPPlxCxnzRuYX
         fOOQ==
X-Gm-Message-State: AOAM530ncDZtEipOzHA8KYmjuLOoiBVdJM50ajIzKorU7xu/jD4NkeKf
        fCjSTUiadFSvgU8sCizHbqU=
X-Google-Smtp-Source: ABdhPJwTTPYdBkI8Lx6v0NjO0Y0QrDgy1wgQ7xoBG2m+QJb9nHi8vE5tfNY2GUAlbfogigi6cG2meQ==
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr1699421ljg.344.1594891156800;
        Thu, 16 Jul 2020 02:19:16 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id w19sm920732ljm.120.2020.07.16.02.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 02:19:15 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Jul 2020 11:19:13 +0200
To:     Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200716091913.GA28595@pc636>
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <CAEXW_YRoTvQfqqcM9fi+MkMxCPEaoJh4zHRM3qNYkv=-nAVuBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRoTvQfqqcM9fi+MkMxCPEaoJh4zHRM3qNYkv=-nAVuBQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 07:13:33PM -0400, Joel Fernandes wrote:
> On Wed, Jul 15, 2020 at 2:56 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2020-07-15 20:35:37 [+0200], Uladzislau Rezki (Sony) wrote:
> > > @@ -3306,6 +3307,9 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > >                       if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > >                               return false;
> > >
> > > +                     preempt_disable();
> > > +                     krc_this_cpu_unlock(*krcp, *flags);
> >
> > Now you enter memory allocator with disabled preemption. This isn't any
> > better but we don't have a warning for this yet.
> > What happened to the part where I asked for a spinlock_t?
> 
> Ulad,
> Wouldn't the replacing of preempt_disable() with migrate_disable()
> above resolve Sebastian's issue?
>
This for regular kernel only. That means that migrate_disable() is
equal to preempt_disable(). So, no difference.

> 
> Or which scenario breaks?
> 
Proposed patch fixes Sebastian's finding about CONFIG_PROVE_RAW_LOCK_NESTING
kernel option, that checks nesting rules and forbids raw_spinlock versus
spinlock mixing.

Sebastian, could you please confirm that if that patch that is in
question fixes it?

It would be appreciated!

--
Vlad Rezki
