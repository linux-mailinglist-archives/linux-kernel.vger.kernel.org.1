Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC92A667C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgKDOgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgKDOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:36:54 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4688CC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 06:36:53 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id z6so19466091qkz.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 06:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hIr0lJXtiFGz2bnTfSBzXYbPqtfqn5n6TkaR8vQe3Qo=;
        b=t12SCC7mhFlP8NeVsHLtlKBUiRsgIGL2XL2ja+oo/2LA1K6U7mJ5j0NO0805MvnvIq
         nuxeTT0jvhf60k1aHJ+4GiFCyIJLqHmAIkwkw8Ww2F7L69i5ecuKeNiMRu26hp3Cvmwm
         ORkhgXyrs6zkv3bgIdmYwpvGZcBxs01fJyu5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hIr0lJXtiFGz2bnTfSBzXYbPqtfqn5n6TkaR8vQe3Qo=;
        b=V37qLwRn5cI8KEtVSdp03hliFqY6H1uj3ZBsL+mIu/UWl61sOp9Fz6UgnHeGt4mEO+
         gR9Xr9bsH6lBavvjjne8FWFwzXXfpr1cPrIUfaOIBU7SFsm67rBj0A8aGoNTT3nCmRUJ
         UxJuSTc49FO/njnGcPZQLHbDdmEuYNmJtilWeUzr2+30gYTcEm6NqwdTVqEfX4+Qkbnq
         tVD8lg8b1aZdi3MIbJ+dafAvO/LPJqoFaR6/E/lP1jYOfMHHyKhT9kmo1TXqvMlOZIC4
         wrXbpUVUlnzuNB39yJbPqN756oFf0Fzb7Wt/aq3aiXxfjNRXTbf3z7Iq4d78BgbRctmw
         zaIg==
X-Gm-Message-State: AOAM530fLHtolor6OJmZfP6bo6Shrznm28DVRz6QoDaMiKdTsCQ1JOqq
        f5V265DlKazJLanGVnd6CB+34Q==
X-Google-Smtp-Source: ABdhPJyPc9nBgsF2q2hGkbpCTcvazLIdnEmZ48OOg+nCLVJ2eAggO01IjIb678ztsccPASCM/JrUKg==
X-Received: by 2002:a37:6cd:: with SMTP id 196mr1318432qkg.228.1604500612536;
        Wed, 04 Nov 2020 06:36:52 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x21sm2801960qkb.78.2020.11.04.06.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 06:36:51 -0800 (PST)
Date:   Wed, 4 Nov 2020 09:36:51 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 15/16] rcu/tree: Allocate a page when caller is
 preemptible
Message-ID: <20201104143651.GA2313912@google.com>
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201029165019.14218-15-urezki@gmail.com>
 <20201103180316.GC1310511@google.com>
 <20201104113931.GA17782@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104113931.GA17782@pc636>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:39:31PM +0100, Uladzislau Rezki wrote:
[..] 
> > > -	if (!krcp->bkvhead[idx] ||
> > > -			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > > -		bnode = get_cached_bnode(krcp);
> > > -		/* Switch to emergency path. */
> > > +	if (!(*krcp)->bkvhead[idx] ||
> > > +			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > > +		bnode = get_cached_bnode(*krcp);
> > > +		if (!bnode && can_alloc_page) {
> > 
> > I think you can directly put preemptible() here with a comment saying
> > allocate only if preemptible and get rid of can_alloc_page.
> > 
> Not really. We check preemtable() before acquiring the internal lock,
> otherwise it will always return "false". Thus, it is checked on the
> entry in the beginning.

You are right. Sorry. Sounds good to me.

 - Joel
