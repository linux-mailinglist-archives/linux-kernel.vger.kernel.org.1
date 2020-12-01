Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A997F2CAB2D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392288AbgLAS4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLAS4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:56:50 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BABC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:56:10 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 4so1365379qvh.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SnExyO2cxfLMHMB/MdA4Td+5GAqX/9sCmYFijfCLuv4=;
        b=j6S8tdmm9n5STmHpqvyJ+gAmYMxWA+XARCQNaQFH50SWIcJwPP8+9HSOS1ZisogmGy
         Zb9GFhcqloh8I805gC9m5izcFkxwGQLo2/+mVzMujkVVNIhrlhEnebHkf4J2Wg6dR8AX
         GZQ18YsV50/bM3H4pG3SBPPm8JncHZ7WyM1uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SnExyO2cxfLMHMB/MdA4Td+5GAqX/9sCmYFijfCLuv4=;
        b=MqTKid4kbS32a0qDqKcjieVJpvJnwoTKjAVCTTzbGNcChiPxY4KVSF36CDyeYC6xjK
         QZ/VyyG8Ei3GDy54ETB1WFYi24xcG1qVPCRD+DgapR+AmHqdhpjHV+DS7jbj5W82BKKF
         NANoOvNwW7abcRULmwvuB64/OHm4WCv3yu3DmI8q/+87GN5edfI2naWsaBB8n9/+8Xac
         CpV2GexQAr/YOgaEufHnMXhU/hO55nOSS4oUECQscDk68aRYn1O4cmUASwOD3ODMPrRb
         ND3CWg+ftAv4snkUWLEO3ybXqVLc/OXGlzJlPwNuCCUUx++1Tqei5DT3jF9Emx9rYD1k
         g1xw==
X-Gm-Message-State: AOAM532rtYtyTXR+fuIDvengXg7tkfGtBy/4C5uGxkj04TLwggQ1qU/E
        uk9zLGjAk92LsXEkInSCyjWxhA==
X-Google-Smtp-Source: ABdhPJy36x/GNPwdutQhGwx4AS2lqhWYw11FX0TYbedMiONQnju8iXiFz1TjFL0FWkepRL60JdAR+A==
X-Received: by 2002:a0c:cd0d:: with SMTP id b13mr4383243qvm.12.1606848969666;
        Tue, 01 Dec 2020 10:56:09 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id v9sm525082qkv.34.2020.12.01.10.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 10:56:09 -0800 (PST)
Date:   Tue, 1 Dec 2020 13:56:08 -0500
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
Subject: Re: [PATCH -tip 22/32] sched: Split the cookie and setup per-task
 cookie on fork
Message-ID: <20201201185608.GA219024@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-23-joel@joelfernandes.org>
 <20201125110709.GR2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125110709.GR2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 12:07:09PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 06:19:52PM -0500, Joel Fernandes (Google) wrote:
> > Also, for the per-task cookie, it will get weird if we use pointers of any
> > emphemeral objects. For this reason, introduce a refcounted object who's sole
> > purpose is to assign unique cookie value by way of the object's pointer.
> 
> Might be useful to explain why exactly none of the many pid_t's are
> good enough.

I thought about this already and it does not seem a good fit. When 2
processes share, it is possible that more processes are added to that logical
group. Then the original processes that share die, but if we hold on to the
pid_t or task_struct, that would be awkward. It seemed introducing a new
refcounted struct was the right way to go. I can add these details to the
change log.

thanks!

 - Joel

