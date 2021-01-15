Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B70B2F7F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbhAOPLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbhAOPLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:11:09 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA427C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 07:10:28 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id b9so6206338qtr.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 07:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=caQyvQJ1mfFLUe31r5kUFdAkkpEYFOjRe/4yfEGC0jc=;
        b=udKB5mwPziVmbw/vjk4IevHaynthJ+gAOwQtXdt27e2y7Vz40+VMU982WTce+VLW7I
         kuFDEwKmcU85/avIKT4zPvTk29vouIiRucrBLuaQzw9/WGGT2D105q0KyGF86fpUtTqx
         ptJMScJADBbnTvdWMpGQoPlogYFc/zJDHZ0uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=caQyvQJ1mfFLUe31r5kUFdAkkpEYFOjRe/4yfEGC0jc=;
        b=lNY/oVIxdNe8XlnjhZ9lAEm8EvUhhA7egE6AiKllVQWG6GYiNKfv7lyVFDDABE1peW
         j+JLvYKsuRbFHxDOTi69QH3+0hHRC31pXZzjVVIgPr1t5DKr4wN3A5beUCS8VECbe44d
         bNsGP7OceC5Aiy69EZpjvoxPcKqU9D9UKz3xAeHtx7svWKEWOR5R1OZjIxwWPR491TAh
         8BaHOEvlP/P48ZQ5wJhgKt1GE0WzUci8rHY1W1zzG1X1NEzDIKgH5TyB80tKPRljqsBF
         CGH/SatNHmTjijlctUO+hAB9PVbyETBO31u2MtSySUPOTkdyRKfOk2KYGiHvOTwc3vTx
         iWeg==
X-Gm-Message-State: AOAM533HS5lJaPW0yAgpc2Idk5CuDmFQOigLEqlLriY/p/+6/Ib1lRUY
        KMY9O50q8ia9Al3eITCITSe1TQ==
X-Google-Smtp-Source: ABdhPJx/a9fC/Jqe2ND2PrIq+7U1F9dR4QXXDLtw7g2db695ifyypLceLcZaNCFROW02LES7rFVjRg==
X-Received: by 2002:aed:29a5:: with SMTP id o34mr11768517qtd.379.1610723428011;
        Fri, 15 Jan 2021 07:10:28 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 190sm5235151qkf.61.2021.01.15.07.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 07:10:27 -0800 (PST)
Date:   Fri, 15 Jan 2021 10:10:26 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 32/32] sched: Debug bits...
Message-ID: <YAGwYmEXTtCtz3N/@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-33-joel@joelfernandes.org>
 <20201201002137.GG473773@balbir-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201002137.GG473773@balbir-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 11:21:37AM +1100, Balbir Singh wrote:
> On Tue, Nov 17, 2020 at 06:20:02PM -0500, Joel Fernandes (Google) wrote:
> > Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> > Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> 
> May be put it under a #ifdef CONFIG_SCHED_CORE_DEBUG, even then please
> make it more driven by selection via tracing rather than just trace_printk()

This particular patch is only for debug and is not for merging.

Peter is preparing a tree with some patches already applied, once that's done
we will send a new series with the remaining patches (mostly interface and
docs left).

thanks,

 - Joel


