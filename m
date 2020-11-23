Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9642BFF06
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 05:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgKWEim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 23:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKWEil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 23:38:41 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8106C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 20:38:41 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id w4so13057897pgg.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 20:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0omrRunD79MfxCMlZ16iJ8rtR9dpyKqeXUEcRuftrTc=;
        b=jJu+0yFqHJXPMXjBacDY71FLIRdFTbyxy6FE2uR29P6Okoihzob1N77enLnlw1kHgt
         iGfpgsYZSEoTWcoBO/Zn1HEN4lEjHu1/EV2C+Irwty3c4WtAzCbAO66sMNH6FEZa0APH
         8g/G1LR1fNRIs8pvgH5T7PfcA053MU/QLPLE99PKG2QlmwzjzKOQ9rw+d39MgTTETZTv
         cqZ5YxfyprgH3oYnbZzESPd6jDwCVImaSy976pZoiRaGeZHr70T/AKDC4WDMiTq9snN/
         aCl95LiE1XG0K2bl1ipnu5UORUgoQ1NpD7gz08/CJOATFHvkHweevD5Jmr5Rq2IiYXvw
         l+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0omrRunD79MfxCMlZ16iJ8rtR9dpyKqeXUEcRuftrTc=;
        b=MM8APjytWuuazRliSUNQPkZJhgrDHFYToivuNp5XzvbCNtFt7C63aJTR1+C5hH/g/0
         Z0HeFnMg4O93N9yNHI9ElcpIrR1DYtdFOIpon6SZQHjY5WE9IM1+fhpZEQMVPDg7eda3
         uv/vWUF6VmKht3exV5/Wq/x6Ccw6FG/xkQo96HYzWCq4F2XvS2F8Ddu5bFDGzUat971o
         dQ6ExH/nfSYbFG8nAAMlee5cOsHnMGG8LKUtPHmNv3fa+yHL4pTpaUcKmZicXmLCfb83
         yuY4Yh9Sa8J7lgGHzvM+vfXU+MvudxLJimmHcTkZkp6HM9EwWkYEoQsenZfLnpHTxMNS
         yZ+Q==
X-Gm-Message-State: AOAM531v6ZuJABCtxcjF9uDx/fiUN9jwyAvaj95ZUMu2idtfFFDVOQa0
        e3AYDVzxAiDcvBdnJiHtRlk=
X-Google-Smtp-Source: ABdhPJy/18kOshdKbxe83BPh7ZeTI/I/bgCyiinnrH37UnTZ89k1L42S7ib8330n/E5UuUAHl8dDJw==
X-Received: by 2002:a17:90a:ae04:: with SMTP id t4mr18883851pjq.137.1606106321062;
        Sun, 22 Nov 2020 20:38:41 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id q21sm605747pgk.3.2020.11.22.20.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 20:38:40 -0800 (PST)
Date:   Mon, 23 Nov 2020 15:38:36 +1100
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
        "Paul E . McKenney" <paulmck@kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 13/32] sched: Trivial forced-newidle balancer
Message-ID: <20201123043836.GG110669@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-14-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-14-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:43PM -0500, Joel Fernandes (Google) wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> When a sibling is forced-idle to match the core-cookie; search for
> matching tasks to fill the core.
> 
> rcu_read_unlock() can incur an infrequent deadlock in
> sched_core_balance(). Fix this by using the RCU-sched flavor instead.
> 
...
> +
> +		if (p->core_occupation > dst->idle->core_occupation)
> +			goto next;
> +

I am unable to understand this check, a comment or clarification in the
changelog will help. I presume we are looking at either one or two cpus
to define the core_occupation and we expect to match it against the
destination CPU.

Balbir Singh.
