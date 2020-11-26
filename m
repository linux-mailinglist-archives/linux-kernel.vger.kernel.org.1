Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA8C2C4C37
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 01:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgKZAfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 19:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgKZAfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 19:35:50 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD5DC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 16:35:48 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b23so248415pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 16:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V0dNtSa5noANhT7MZOk6/1YCHxaz2RZIGNOcwDoZpgk=;
        b=Rbug2CNGkuIQ3UHB/kXN9JkJSw9mewahJXuhv6rke06VYqhJVwLQdB1Y6/zzY5L9Ja
         xwPH+m8rfHnheRnWOwSdO4Atrjbs+r0NYcKnygcyrvd1DQtngP69+SiepzUYRl7iLIx9
         tIpK0OSfPqI5sUW3+n1/9K/7/Pj14uvyOsK7GHp/fZdEIYnnwXhQ6lz9E3QzHuKBQ94M
         euzCnikaDFXOZg759npz6Hh4h9+QaAgyTefUzZh+TtSYx+i3W0AIlLpJ+weIqgak2wN/
         PYD6pbqIKtBgvQfXULcLh/hkOlKuU0Jyc8UFcPc/Hf73i+XgdjbXcrbZp3PVVpS0ut1J
         pnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V0dNtSa5noANhT7MZOk6/1YCHxaz2RZIGNOcwDoZpgk=;
        b=f9rTNVVY/6mEUidXFMQVx8o7bNwaE2G3EfBmTM7lzy/v99NrtZMB7qdoQYsZ7MVL6K
         PfSYdB6Ex/ChfNRTcaL3KwhRXNSGua1t5XXsCl1XiNFZfdOrDe1ZmzdC/ZxJQE0dm7I+
         rVhP0xHSFUz1/fZ8wfCFCGq3PFl59wqZO4lohzJMwctZuapsj4YY3P9yKeGeBRjCUzmX
         iwEtLSFqlUhcqVgnYzEuxXpBnjrykMvStCz2Omq7cvpBbIWJGKPSZoyVI+o3GMop08oD
         H13gaF2x5navqGhXM5zn5B6BptqL0ezStHm/Wp0luxS/NRk+cn1z4OQ+alEETd+8QtEg
         4E7g==
X-Gm-Message-State: AOAM531R8q9cLfPk9MF9/3vq/Xj3UC2ZrJuhKadOYr87W3qaT33wTODZ
        imq++psaippCLbvdDKvmRO0=
X-Google-Smtp-Source: ABdhPJzdbN/ioG52T0Bx2Aw59V0pNmjgf7IhyfrUKIp5vT9gx1DXekeClOxdWAcjEKmmNAkUUoHMJA==
X-Received: by 2002:a17:902:167:b029:d8:cfe5:bdee with SMTP id 94-20020a1709020167b02900d8cfe5bdeemr412666plb.11.1606350947883;
        Wed, 25 Nov 2020 16:35:47 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id u4sm3528397pjg.55.2020.11.25.16.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 16:35:46 -0800 (PST)
Date:   Thu, 26 Nov 2020 11:35:43 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 04/32] sched: Core-wide rq->lock
Message-ID: <20201126003543.GG163610@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-5-joel@joelfernandes.org>
 <20201122091152.GB110669@balbir-desktop>
 <20201124081617.GT3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124081617.GT3021@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 09:16:17AM +0100, Peter Zijlstra wrote:
> On Sun, Nov 22, 2020 at 08:11:52PM +1100, Balbir Singh wrote:
> > On Tue, Nov 17, 2020 at 06:19:34PM -0500, Joel Fernandes (Google) wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > 
> > > Introduce the basic infrastructure to have a core wide rq->lock.
> > >
> > 
> > Reading through the patch, it seems like all the CPUs have to be
> > running with sched core enabled/disabled? Is it possible to have some
> > cores with core sched disabled?
> 
> Yep, patch even says so:
> 
>  + * XXX entirely possible to selectively enable cores, don't bother for now.

Yes, it does in the comments, I looked at just the changelog :)

> 
> > I don't see a strong use case for it,
> > but I am wondering if the design will fall apart if that assumption is
> > broken?
> 
> The use-case I have is not using stop-machine. That is, stopping a whole
> core at a time, instead of the whole sodding machine. It's on the todo
> list *somewhere*....
> 
>

Good to know, I guess that would need a transition of the entire core to
idle and maintenance of a mask that prevents tasks that need core
scheduling from getting off of CPUs that enable core scheduling.

Balbir Singh.
