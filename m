Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE802DA089
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 20:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502213AbgLNTcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 14:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441019AbgLNTbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 14:31:44 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF801C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 11:31:03 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id h4so11864200qkk.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 11:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PBmBiYNvM/XVhEAk0mFMcO3/S+MlnPDvjviU/Lu+LwY=;
        b=BxbrHZP3CIOcWEIfQYLevCZswwpbPGEo4TT9RhoEzs4NFvzJKef82x2jXBBZB26nna
         lP71rDN3QLd4i84kEzwOPibbd3AsXUiDhOtGHPbJu6/ivNojICnDTT6VSb79bzZKI3e/
         ZYzPtXwCNJQ/Uul6/vnoUDZi5B0hqCzjZvFLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PBmBiYNvM/XVhEAk0mFMcO3/S+MlnPDvjviU/Lu+LwY=;
        b=C+/OiVJ78gKhBqdwePtMFfCyU0r7ZGJYmeeHse1d5lsXspPA221qAOkq7svpgxVoAL
         R5344kovsQTKxk5cOatr5p0J31bwuXflp/zq/IKdfqn5vq6IoeE0U1sYjTY5vU4yzhxA
         EAbDXRKU0w1phiml2C/1gmQbPfcfa49OUkSimEo32rhGlYniTEUCe5a1Pj1pDIkDwAMP
         jyeyWtDmmmZJuAscAQ23FSdByj63svIsdEvKn0iwoS2lXfuSBCFdAy55Q8wjAYyYD1A1
         0oIPZicEI+b9jmpTSs4ZJh7XMJq2Xek6CAnAzhWLw0G7WxRRUjFR4nxW77cOCrjM7XR0
         CVYQ==
X-Gm-Message-State: AOAM531phsC3fO0GWBJqUAI5/Nicq2l7dP0EPfYkHDcRcF99DvHKMvt9
        m6H0I4yJK3WdDkxaz6SvfJz4IQ==
X-Google-Smtp-Source: ABdhPJySFkRYYz29wAGTa3FPK5kRpzSGG35aG7v7ddLy0yZGdgQeha6bXUPoXierrCiH+pZNaANyqw==
X-Received: by 2002:a37:b987:: with SMTP id j129mr31366989qkf.131.1607974262887;
        Mon, 14 Dec 2020 11:31:02 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id z78sm14840942qkb.0.2020.12.14.11.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:31:01 -0800 (PST)
Date:   Mon, 14 Dec 2020 14:31:01 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Chris Hyser <chris.hyser@oracle.com>
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
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 23/32] sched: Add a per-thread core scheduling
 interface
Message-ID: <X9e9dcLMrMJThZs+@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-24-joel@joelfernandes.org>
 <20201202214717.GA27531@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
 <20201206173418.GC201514@google.com>
 <20201209185203.GC6876@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209185203.GC6876@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index cffdfab..50c31f3 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1030,6 +1030,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>  
>  #ifdef CONFIG_SCHED_CORE
>  	__PS("core_cookie", p->core_cookie);
> +	__PS("core_task_cookie", p->core_task_cookie);
>  #endif

Hmm, so the final cookie of the task is always p->core_cookie. This is what
the scheduler uses. All other fields are ingredients to derive the final
cookie value.

I will drop this hunk from your overall diff, but let me know if you
disagree!

thanks,

 - Joel

