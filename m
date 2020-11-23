Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1BB2BFF5B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 06:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgKWFS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 00:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgKWFS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 00:18:59 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BD3C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 21:18:58 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id v12so13784684pfm.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 21:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pGllVt0YAWrAraB8o/xsjy9zl5s/HURFJ1GGpWvqVCI=;
        b=H/oQgJaRPzytu+MBgdw2N1oiKsUVlMAQEuLGRg9i6SMRnIhZ6qzxe983pgihLY+CsZ
         KDhviQ1Z3qoGei9PSflECA7dQo/4+hvkffHmgAUX7nVgpXrE1pY32UlFecFnSRhZNkuZ
         8vOtmuXOPpJWQP0RpiIC0ldsWhaZ804W40C9imN0n5yksNCavpq0pxAqTVwvKCw+MACC
         TopDUs/MUQcwZmTrtHF8M2lx0hdfN6J1Ngqt9VcDL5ZfBgfPmeg5M2uoxjv+2b13yepW
         THgwcaauX8jv0rBTlDSeOAyQCQRKpXy1YNt5R8tjO22yfRRqUFobOP1jR8Z2UV84QowU
         i0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pGllVt0YAWrAraB8o/xsjy9zl5s/HURFJ1GGpWvqVCI=;
        b=nVBPUQ03WgkhgVtX3d4xhkF2JD2sZnaksY6Eht9ZrQ76epw70PqDc+skuuSTKm/QTX
         2RZkjrIYzsx9qvdOivvwG8jnQnCboAK5eYxbMgDT0smmUJjdhkRVee8hL54V0S2D3hIt
         uoeJCf3pyX3txfilw8AdsOe9a2puM/9lnJ0ZqPqFIzu1nilFL/l+fJqhGp6KnEqwbvSS
         OAz9UdgKYknOJl3BIebVYASV5Wbp3vzpkv2EZAYwwFrRc5ZcEIC7MJnrI0GFYckcjv8B
         8QHnR1cvV10HuEpzPQHX16M0ZCeSUop0Ep8areP/Knh+dFKvfZLp3OmJ4f7/HW3oVo4s
         4vnw==
X-Gm-Message-State: AOAM5333xqLhMCQuSytptzPaMOhDO3zAgovfjJueXJPILcWioOzLWs+3
        q7K6NOJDJdaSAgWNJfFIxb0=
X-Google-Smtp-Source: ABdhPJyiNdSj5OIIge3kyGIXOgYbubbctnlcgBQqTDktGnqvwdRL50nZQgcezMWuZY5QHoIWtX4wpQ==
X-Received: by 2002:a17:90a:cb0c:: with SMTP id z12mr8812952pjt.60.1606108738106;
        Sun, 22 Nov 2020 21:18:58 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id e14sm9298893pga.61.2020.11.22.21.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 21:18:56 -0800 (PST)
Date:   Mon, 23 Nov 2020 16:18:53 +1100
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
Subject: Re: [PATCH -tip 17/32] arch/x86: Add a new TIF flag for untrusted
 tasks
Message-ID: <20201123051853.GH110669@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-18-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-18-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:47PM -0500, Joel Fernandes (Google) wrote:
> Add a new TIF flag to indicate whether the kernel needs to be careful
> and take additional steps to mitigate micro-architectural issues during
> entry into user or guest mode.
> 
> This new flag will be used by the series to determine if waiting is
> needed or not, during exit to user or guest mode.
> 
> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Reviewed-by: Aubrey Li <aubrey.intel@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
