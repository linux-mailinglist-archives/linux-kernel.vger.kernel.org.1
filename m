Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BA62C93D8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgLAAW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbgLAAW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:22:27 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948C7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:21:41 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b12so134680pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ud1sJmSP4gp0T9UDyAeUZIg/Ds3SexVM6owNh2yBJcY=;
        b=bJXb/dPJ4sE9SWvMKK6ZI1rpXsGHM4w8RDOpCK3+tW/MRDv/CeCe+1GXffZ9QoulXa
         aA8wlWV/GyVJr/b99QBWTujbJM7g9ElLfD3oIuzW6WseNHWeb4Jte5ZgvooI0eDpkj6s
         HnCdEWHTghkEBpN81Zh8BzyH2Z46soZSfqXEMXoDpdo8ryxqzmWIDREiFlojhfyGnKob
         XpwU26Tj/NBA/OAdOCfZapK8wM0ZoBFEAgfTeB7Juh861K4RJ3owPnTqeLDyI/yOUnyv
         BXTRgFeqU2HOpekyd/0rwGJHJ0MXoqTND2XqxHuNfh2lGso2ub8a6a4takX1dVXDCkLY
         siew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ud1sJmSP4gp0T9UDyAeUZIg/Ds3SexVM6owNh2yBJcY=;
        b=FKylOYibftpRCOSExNvjZzSfzrgFEqwM7hqixP0zDPr4M/hPOEdv6XKCGBSTk2D880
         yhUhfKba4NFrzHXN1cHVyMUW5xZxjCEGu0iYg2fGw3EBmiJheB+lhMar7Jr1V0bMksCg
         iMhvdqsHGM6ALyPlIijoCkAPPll7a66BHr9KBIlGQlFLiWyXxQN9OretYEORRVrEz8G5
         S/sNn87rH4V4Rh2F+4CpZ8ldQjwm56z85FAo6AfIv21B/TjFd6cjygtHLVv9cnV7jW55
         LS4cWhm8mxDfHg/FsaxHaxakqWqLzKi/m0WsyS0u5oWVj+21ayC7Fa5kHeSGpMZ5/tZl
         YLKg==
X-Gm-Message-State: AOAM533+1/baV23u4KBxrPG35Ey0t4Zxsxqvru4E1v3yH7bWTbNCDZHx
        xCGB57fNsAqwU7Q10rUMVLw=
X-Google-Smtp-Source: ABdhPJxvCjlZwbdSd0S11CToH2RmAL/s7p/VhnQNtQQVdOomM8j5ZZ3ynyzrncYgyijLseZdQEPjZw==
X-Received: by 2002:a17:90a:9f98:: with SMTP id o24mr385313pjp.207.1606782101058;
        Mon, 30 Nov 2020 16:21:41 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id l20sm39972pjq.33.2020.11.30.16.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 16:21:39 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:21:37 +1100
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
Subject: Re: [PATCH -tip 32/32] sched: Debug bits...
Message-ID: <20201201002137.GG473773@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-33-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-33-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:20:02PM -0500, Joel Fernandes (Google) wrote:
> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

May be put it under a #ifdef CONFIG_SCHED_CORE_DEBUG, even then please
make it more driven by selection via tracing rather than just trace_printk()

Balbir Singh.

