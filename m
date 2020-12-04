Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D22CF0F4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgLDPqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgLDPqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:46:35 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E6C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 07:45:55 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id q22so5778561qkq.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 07:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FMdFUwxD2m3I4SoM+J772H7vQty27Q4nst6R1kvnYpw=;
        b=trm3vYaGs+Ys4p9ttYTRihiN6WVvlKBfTAkmuhZGBN5sy4ZZUhSs+FLNShUkFOtBVC
         Kp4H5+JfyjnNYof04pYZ5ghqN+PnmDyhS5oRbWEMaKZQpczke8hdigyKPwOV8AutCKvr
         muYcl0x6w8aVQWeKG8p29IOqk0EPSzOsC7562MdAp3vHHrObdyclAGQ1D6w7674GFJDK
         oHXPBdHXAppU+Z+RylLDictKfT+QXhG0AdcVsUzHE5ceKTXzvFouF3mcYP+4IMh/45df
         mHzbEHXeJ4Eb2w0JJf30tMq2DcPRFSAsMRfjkmilWv1LW8cuPWqJt65B17/rehybSCcp
         1uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FMdFUwxD2m3I4SoM+J772H7vQty27Q4nst6R1kvnYpw=;
        b=AKhTSNI2AKm2yVX0X2DjyV0I/fEPreW+soZ8iK0L6hg8OvGSmKhQKzCPz7EZliEri5
         bvaDyt5+scdpXvZkXJrbcR0ENjWnC1A1MMJpW7dIfmX0PWLNv+ayMz9BgCR7H8H/jaPQ
         zrXR0M1rTVepHD9C7bnF0kP1yQ+MClCPKjWSiuCrMNyr82+I5glOXuuDXDC6XGlJ6PJ/
         aIfrtg3RWIghLlRbq4beYBOLwkUKXVkhvcfUSA450I4J3h9GKX8s18pO45DOd8TcHmUS
         0k9eFK2rhLK0NflIW0iDZHeyvVUFL2j4FKL8gK9S6loFLA3RuTQUko3CcL+UyVebsGUS
         K4oQ==
X-Gm-Message-State: AOAM533vAAQMlrO/CrUGI4LNeWAhqciBDA+PytoguI53ZC99ACwF/QEI
        51S0EkQP3sAmaFA2cMAd/ws=
X-Google-Smtp-Source: ABdhPJyyvK0D/DI7YH38pseiWLXQBnqcvP/8CVNezlSFh828yQEEaTVbXyFLwvNT3iF7ixzjo5zsMw==
X-Received: by 2002:a37:56c6:: with SMTP id k189mr9011032qkb.501.1607096754668;
        Fri, 04 Dec 2020 07:45:54 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id s130sm5055078qka.91.2020.12.04.07.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 07:45:53 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 4 Dec 2020 10:45:25 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>, chris.hyser@oracle.com,
        Ben Segall <bsegall@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Oleg Rombakh <olegrom@google.com>
Subject: Re: [PATCH -tip 26/32] sched: Add a second-level tag for nested
 CGroup usecase
Message-ID: <X8pZlZgSq4aoIqoF@mtj.duckdns.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-27-joel@joelfernandes.org>
 <20201125134237.GZ2414@hirez.programming.kicks-ass.net>
 <CABk29Nv7+nD1oU9iBhAFAuFoiPM5i7eCOtuG7vuQVcE8+Va=nw@mail.gmail.com>
 <20201202080211.GD3021@hirez.programming.kicks-ass.net>
 <CABk29Ns-QWGV+XpN8TJ5CL50jhrpqKAhfoOfaPSCjiFq7S7j1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Ns-QWGV+XpN8TJ5CL50jhrpqKAhfoOfaPSCjiFq7S7j1Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Dec 03, 2020 at 04:51:42PM -0800, Josh Don wrote:
> > So me the color thing reads like an end-run around the cgroup hierarchy.
> 
> Restructuring the cgroup resource hierarchy to incorporate the trust
> domains is not necessarily trivial (as is the case for us).  I agree
> though that that would be the ideal correct solution from the cgroup
> hierarchy perspective.

Yeah, it sure isn't. We (FB) had to go through a couple iterations and it's
looking like we need another adjustment, so I fully agree that these are
painful but at the same time I don't think it's difficult to see that how
piling up workarounds in the lowest layer is not the right thing to do. The
workarounds you guys need would be different from what we or others would
need. The kernel can't be maintained in any sustainable manner if we keep
piling on disjoint workarounds on it. Please consider long term trajectory
when proposing interface changes which often boils down to identifying the
core features which must be supported by the interface.

Thanks.

-- 
tejun
