Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93BF2BC49A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 10:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgKVJMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 04:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgKVJL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 04:11:59 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3D4C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 01:11:57 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id l11so7312931plt.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 01:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CWLOOIouluXSNbm57Xabnw0CTGlPnZHHKBLLIyM6ePc=;
        b=g+sKzqLtAw2CvMS0ifj7hkY7v+vqGQmUt2OjgLeMMbsweVvMiSDiw9gSU4e81bvJ7t
         h9SQ483QFJHBZhaXIZT1+QXmvy92yn8hMR5CnCYHWKnOtBwiQCLAUrjn5vCoU1jOAJwh
         YPZjLYBi+gxUXP8Y+/e/7QW75jlTnRL+2IpXH57fJnj8z82b7SM/ZhYlD5Dx0TaYTDqn
         7XAEGp5sGVlNil08Ruf8GAZ1XbwWaHhKZA8sDtOdeI3CcQo51KSP5xuc9TQuO6rzdW5r
         HglP3j6Giogjy97jSZ8kZjL14yK4PCAvfWyX1gnaI/AcI41sMvKqxl1ONJax5TJyJeHw
         krBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CWLOOIouluXSNbm57Xabnw0CTGlPnZHHKBLLIyM6ePc=;
        b=ljr8v9egmHXL7e9+vr1GBb7asZbJImKVVy00Q8gXwNLEmW9tumJdCisQNcQ+p0Z549
         njbTaU31UKCOT+DOBb1PNeISzc7ehDYABhK8o63p7mSvV1HF+b9SolpvHed7yzXR7a4P
         335TbdTS/YUmqwwGFP7RReG2lS5areJ1nfaOTcCkNgsi3UqtWpmDJMVlavt71sYHaLVL
         JmZsQqN5VgHXJ6zl0XGva9GSR5MreLAS/EY5YDIM9vW0bSVNZOvyZxTm243K13qh1i2B
         EYClUJ3AZNFwKmDIL9dz9gdzRASbA5oWA+41RVM+4g3ZpjY3ZtU2nu4hjHBTdgvfpBgE
         V2Cg==
X-Gm-Message-State: AOAM530q3GgWV9vn13ITtwCp+9bFRtRmd4zWmZwaTzrWIwEE+9WeNX5L
        Xke15wlKm/AEqgDzdLKQFew=
X-Google-Smtp-Source: ABdhPJyBa0PuXH8P8YuQMSEVPBRcCXkvOiPTe40iYpWChF48S1GdcLUF2OIuPZDskVfWRnA9kiV0Sw==
X-Received: by 2002:a17:902:6b48:b029:d8:e603:75fb with SMTP id g8-20020a1709026b48b02900d8e60375fbmr20428011plt.6.1606036317314;
        Sun, 22 Nov 2020 01:11:57 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id a11sm8884053pfn.125.2020.11.22.01.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 01:11:55 -0800 (PST)
Date:   Sun, 22 Nov 2020 20:11:52 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
Subject: Re: [PATCH -tip 04/32] sched: Core-wide rq->lock
Message-ID: <20201122091152.GB110669@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-5-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:34PM -0500, Joel Fernandes (Google) wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Introduce the basic infrastructure to have a core wide rq->lock.
>

Reading through the patch, it seems like all the CPUs have to be
running with sched core enabled/disabled? Is it possible to have some
cores with core sched disabled? I don't see a strong use case for it,
but I am wondering if the design will fall apart if that assumption is
broken?

Balbir Singh

