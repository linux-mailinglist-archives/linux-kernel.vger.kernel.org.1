Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE532A9B49
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 18:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgKFRya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 12:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgKFRya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:54:30 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B8EC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 09:54:29 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id y11so431063qvu.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 09:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o+oYtulVtt4EMGqh61wHdK2Zyyic+H6Jv31LtpmqP64=;
        b=aVsjWKGr4EF2MMPKJizXm9+dd3n+eO+c8Z+SQrROa1AzuHkcE4kCTYOHYDBrsGo7/i
         2Hjs8oJaoTViA6U4vK9uXZgS76byC0ihKclLFGLqJdgASjsB3/lpoOKd5AdLh6uoVaos
         kg+uwyUDd5H9oCn/0yVpCtlbaHugt7pMukN7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o+oYtulVtt4EMGqh61wHdK2Zyyic+H6Jv31LtpmqP64=;
        b=CyUkzTax3FX8Ol9BG5KFDQPzSAULGsGQAt9oCOaQXD6hfvlVnhT8mYQbbwNN28QJ6E
         Io/3UF7GA3qHaNGS91dG23AHfqmUZYjLwPzQC5nqlquBbkWFXnRKelvAqJN1cFJ6bNPM
         bxL1hDu4XvsADzNIN1KjKUEOy5lp5t8ZXFYyXJjGIbo2BnQ0ISe/xVev2fOIC48ureJ5
         2mqzqD+9MrVk5mEqIdGHlGW93ZiQXXE8vBtXeILChV4cFdQtGurVPtTGTCS59XCrXJrD
         7pwFgEZJkSaohZ50ivXlydmlvaFghvu9i4lAvt/vB8hkPbl+ZNFVcil5DVCsEmRgDKsf
         Zq3Q==
X-Gm-Message-State: AOAM5314yGZpC3GUoSwNsKmWEB42C6AiXIL/j3n9iJWeKYEmv2veqa5c
        wh5GFQxaOgSINOUKU4pOa+dX+Q==
X-Google-Smtp-Source: ABdhPJyWsZ1KbFyPk3yEzzFEia0WagMqu7J5YN5rWwu8Pye14MohrZESnuNz+OK48FikHh86n1i20A==
X-Received: by 2002:ad4:468b:: with SMTP id bq11mr1908716qvb.8.1604685269034;
        Fri, 06 Nov 2020 09:54:29 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d184sm1009560qkf.136.2020.11.06.09.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 09:54:28 -0800 (PST)
Date:   Fri, 6 Nov 2020 12:54:27 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     "Ning, Hongyu" <hongyu.ning@linux.intel.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        chris.hyser@oracle.com, Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 00/26] Core scheduling
Message-ID: <20201106175427.GB2845264@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <f7fc588b-12cf-95a8-6142-e4d112fb1689@linux.intel.com>
 <bf2ee997-1f53-0eef-40ad-1e98274da587@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2ee997-1f53-0eef-40ad-1e98274da587@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:58:58AM +0800, Li, Aubrey wrote:

> > 
> > 	-- workload D, new added syscall workload, performance drop in cs_on:
> > 	+----------------------+------+-------------------------------+
> > 	|                      | **   | will-it-scale  * 192          |
> > 	|                      |      | (pipe based context_switch)   |
> > 	+======================+======+===============================+
> > 	| cgroup               | **   | cg_will-it-scale              |
> > 	+----------------------+------+-------------------------------+
> > 	| record_item          | **   | threads_avg                   |
> > 	+----------------------+------+-------------------------------+
> > 	| coresched_normalized | **   | 0.2                           |
> > 	+----------------------+------+-------------------------------+
> > 	| default_normalized   | **   | 1                             |
> > 	+----------------------+------+-------------------------------+
> > 	| smtoff_normalized    | **   | 0.89                          |
> > 	+----------------------+------+-------------------------------+
> 
> will-it-scale may be a very extreme case. The story here is,
> - On one sibling reader/writer gets blocked and tries to schedule another reader/writer in.
> - The other sibling tries to wake up reader/writer.
> 
> Both CPUs are acquiring rq->__lock,
> 
> So when coresched off, they are two different locks, lock stat(1 second delta) below:
> 
> class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
> &rq->__lock:          210            210           0.10           3.04         180.87           0.86            797       79165021           0.03          20.69    60650198.34           0.77
> 
> But when coresched on, they are actually one same lock, lock stat(1 second delta) below:
> 
> class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
> &rq->__lock:      6479459        6484857           0.05         216.46    60829776.85           9.38        8346319       15399739           0.03          95.56    81119515.38           5.27
> 
> This nature of core scheduling may degrade the performance of similar workloads with frequent context switching.

When core sched is off, is SMT off as well? From the above table, it seems to
be. So even for core sched off, there will be a single lock per physical CPU
core (assuming SMT is also off) right? Or did I miss something?

thanks,

 - Joel

