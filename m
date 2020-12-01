Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113F62CAAB2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbgLASYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgLASYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:24:53 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73C0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:24:12 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id d9so2229672qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rDcmO5EGcDHOUaqtJgIxREJ80cmJezdkiJUzt/0huDY=;
        b=JthbCB7ET4rwvDCTm5m/rl69OuBEotofzFOW4aaZZHym7qZ+OgIgPkDoQh/KjyxNhv
         ueivEh/+YTB8RxOXIvgU2lFkWeOLAAUCWR1luIwjauCRlWaFL12aqC8pB0XnLiZo3q4Q
         dY0l4Lc0vH3RiGEWDWAw7nIBzRZLll4S3B6N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rDcmO5EGcDHOUaqtJgIxREJ80cmJezdkiJUzt/0huDY=;
        b=cihd4CmA49gbcHUwYYWafxjaUs2Yj/3FbtoIQFPFyWt0V+P6cnN9+ksBFdVjgLm657
         h9NTbEWtmRB2NpDKdiX+2IBOTapnmvHQlm4PSnkk8lYgLQosPmMbYHJJNn0+wQHukETK
         wZQAOma5voxSwqXg+r6YNvA655UfG3nNLuOAaJiN9rECw9Bd7HMcZb9sVAXxUHos8Lm/
         Hbnab68S0bpLZVjhmiJi5/JC63xH0Xr6o3ez0qyYqgCBC2ukAuuy0JtQaEPUwFEQCiUB
         vnCSy6Bmw/6DqBljKgDhMwvF0qYj1+UFbNznff5EvdiBctedcFcPIri9La9UlU+ApKqI
         Bagg==
X-Gm-Message-State: AOAM533XHHIEvoFta4KN8lKuZqlmIDMrX+m5mjauSbmHYDQvTEc85UwY
        fhLWDVMcU210m4456s1T7lOKuw==
X-Google-Smtp-Source: ABdhPJyUZEcKyJSmXwO2J30KU6uw46hH+/5IsjfoUwGdx7s24vhEci1knbCI6QzESV9Jmxf2wn1AZQ==
X-Received: by 2002:a37:e20d:: with SMTP id g13mr4196885qki.325.1606847051958;
        Tue, 01 Dec 2020 10:24:11 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id r5sm427066qti.28.2020.12.01.10.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 10:24:11 -0800 (PST)
Date:   Tue, 1 Dec 2020 13:24:10 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
Subject: Re: [PATCH -tip 19/32] entry/idle: Enter and exit kernel protection
 during idle entry and exit
Message-ID: <20201201182410.GA209213@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-20-joel@joelfernandes.org>
 <20201124161335.GB3021@hirez.programming.kicks-ass.net>
 <20201124180343.GF1021337@google.com>
 <20201125084908.GO2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125084908.GO2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 09:49:08AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 24, 2020 at 01:03:43PM -0500, Joel Fernandes wrote:
> > On Tue, Nov 24, 2020 at 05:13:35PM +0100, Peter Zijlstra wrote:
> > > On Tue, Nov 17, 2020 at 06:19:49PM -0500, Joel Fernandes (Google) wrote:
> 
> > > > +static inline void generic_idle_enter(void)
> > > > +static inline void generic_idle_exit(void)
> 
> > > That naming is terrible..
> > 
> > Yeah sorry :-\. The naming I chose was to be aligned with the
> > CONFIG_GENERIC_ENTRY naming. I am open to ideas on that.
> 
> entry_idle_{enter,exit}() ?

Sounds good to me.

> > > I'm confused.. arch_cpu_idle_{enter,exit}() weren't conveniently placed
> > > for you?
> > 
> > The way this patch series works, it does not depend on arch code as much as
> > possible. Since there are other arch that may need this patchset such as ARM,
> > it may be better to keep it in the generic entry code.  Thoughts?
> 
> I didn't necessarily mean using those hooks, even placing your new hooks
> right next to them would've covered the exact same code with less lines
> modified.

Ok sure. I will improve it this way for next posting.

thanks,

 - Joel

