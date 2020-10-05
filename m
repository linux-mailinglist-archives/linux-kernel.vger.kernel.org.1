Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C769283D07
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgJERGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgJERGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:06:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0AAC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 10:06:12 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k8so7359994pfk.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QJsZuOnyWzmKdnctAuoMEQMQqm/WISbiLiahJ2L7nKE=;
        b=oFu5Avy5EYPCaSh28cD3EXQh65ngDF+xNTwG43t4h9K5/8JMTuHYZcvRBBBBCV+kUW
         ZTvTg4rt4w9A5iu6ztdV4X7jz4Y6hiQw/9PySrrEifg6AdIQMZdrg2tJy8CWMH3gMcjg
         S/QH5N25h3yeLdNnPf2BuJlZsG19mLZhHryWxOqf1CGvtlRouYdYyRLRT/LgAlC3d5F7
         cZFEm09gqgp4qlb9XHJXld51jHSOsrlvZ3t0Nt8xDiyJXXGCh6fdpteQL7QRYBnmGgcg
         R1vbPqFwaxjtacaxdY6JMGRLg8Mz6N0ksGDsjY4GQiqEkrTiSmUjR4Kk/RTyst11FPJq
         nquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QJsZuOnyWzmKdnctAuoMEQMQqm/WISbiLiahJ2L7nKE=;
        b=makyXp3z9HP83XKdvTgihJZPlElatG5aykeLSkppaFT/apNPquarIv6P1E7PRPG4x6
         AAWFRd6HJbjXxy+skOyFHWmgQSkTHRfpmzL+nzkM8ntRg8zAygp0w4FR+Z/Lq1Ww0tYd
         Ip/2piLvdSbiWJ/QNA8x95aD2HEpyJxrzbsFgPzQoq/wur/LW7cUSRTT/63tzn410Xhw
         Nmov8mV1UcpKRlluL8SfordjvP6GkiT2sBlzjqUXqJgERCdrTzq+uAVVxd6LGJuvUGMo
         R06h7ym/eX/c/OWHmOaitXX0AkQ9vQCHVd5pHvrIeJw+waj8mLzPAwySwqE65WZ5Qk7J
         oTgw==
X-Gm-Message-State: AOAM5311FfjcJlpLrnTq1ET/fl/eu0Ugd4nQmRx8cn8wGO3Sw23lHIvi
        Hj5Po0ufWLgi5dol/NitBKI=
X-Google-Smtp-Source: ABdhPJwyt0CtK3vTFmc8cEvhQzsJloClcoUKBauUZMgan1b9etkxw5fAdTfXtPf8XGRn0acZK7KDsQ==
X-Received: by 2002:a62:7f81:0:b029:152:6197:f1f2 with SMTP id a123-20020a627f810000b02901526197f1f2mr436452pfd.49.1601917572154;
        Mon, 05 Oct 2020 10:06:12 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id jx17sm139098pjb.10.2020.10.05.10.06.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Oct 2020 10:06:11 -0700 (PDT)
Date:   Tue, 6 Oct 2020 01:06:07 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, valentin.schneider@arm.com,
        raistlin@linux.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] sched/deadline: Fix sched_dl_global_validate()
Message-ID: <20201005170607.GA24115@iZj6chx1xj0e0buvshuecpZ>
References: <20200925162032.GA9692@iZj6chx1xj0e0buvshuecpZ>
 <20201005091100.GA4352@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005091100.GA4352@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 11:11:00AM +0200, Juri Lelli wrote:

...

> >  	/*
> >  	 * Here we want to check the bandwidth not being set to some
> >  	 * value smaller than the currently allocated bandwidth in
> >  	 * any of the root_domains.
> > -	 *
> > -	 * FIXME: Cycling on all the CPUs is overdoing, but simpler than
> > -	 * cycling on root_domains... Discussion on different/better
> > -	 * solutions is welcome!
> 
> So, this patch changes 2 things: it actually fixes the problem and it
> optimizes scanning of root domains. Even though the changes are limited,
> I'd be more comfortable if we split them in two (fix + optimization).
> 
> Would you be up for doing it?

OK, I will split them.

> 
> >  struct dl_bandwidth {
> >  	raw_spinlock_t		dl_runtime_lock;
> > @@ -801,6 +795,8 @@ struct root_domain {
> >  	struct dl_bw		dl_bw;
> >  	struct cpudl		cpudl;
> >  
> > +	u64			visit_gen;
> > +
> 
> I think this deserves a comment explaining what it is and how it's used.
> 
> Also, do we really need an u64? Maybe an smaller type would be OK as
> well and could fit in the 4 bytes hole that seems available after
> dlo_count, I'm thinking.
> 
> Thanks,
> Juri
> 

u32 is also fine, after all consecutively 2^32 - 1 times validation
failure followed by a success in sched_dl_bandwidth_validate() is still
a very very unlikely case.

On a 64-bit machine, dlo_count should be aligned on a 8 bytes boundary,
there would be a 4 bytes hole between dlo_mask and dl_bw, put the new
member there seems reasonable. I'm OK with this.
