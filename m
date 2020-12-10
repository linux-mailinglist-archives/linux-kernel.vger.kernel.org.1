Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10B52D5C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbgLJNkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgLJNkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:40:06 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4422C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 05:39:25 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q22so4079822pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 05:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=aDZfbSsuL0RkR6YD4b5+euu2zPKCWyDVF5MVnIDTnTA=;
        b=UrxHRjHHi8j542ElXtZA3eaX/J4DwxABMePsngyARhq2u+kKC8K67kbQB6wLtgvz1m
         2Etn62hWs69j+H0c31VXEFDIOZc2Mwupu8V0pMXRuKzcYnQOiw3eTh70TkBF1v9iQDAF
         A9PaZwd8fNspq97641oXlD2AHooBiasVPPXek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aDZfbSsuL0RkR6YD4b5+euu2zPKCWyDVF5MVnIDTnTA=;
        b=nGwgy+vbft6qKjLsj8dPaQ2lBCbPjDYtiE87AjLOrYepj2nB5ugQhKxnjeu/uW9OYP
         XEl4O+FhuXcsAUpUKbWFV99lTKNgvLFx6ft46TFBH+bW6MHMadXBIzuPTlTnKsfFcRT6
         tp/fuWkaGjstn9P7SAOvVqP+/4xl+Ppvp1LxmF43NG6xNaVNyRgMy80ARBTJ099w0FfG
         T/g64FhXwUfYJ3Zk9WZi8+FVggFfxhkEQyvYrZ06+A7hjXXCccLyeGtfo+MmJdSuF34b
         cM0hVEsFoc5Cvj4Pj/4mcBij+qSRhegkvXllpWgATViy3iL3yI9UvFERzXmbQSPT5CcR
         GHnA==
X-Gm-Message-State: AOAM532XcqF1Uf2GS34/jCblOX2T2cW18Mza02UenXLkritj98DZjRps
        ZBB8aAEmeZxk2TN8QnrRE8v2Wg==
X-Google-Smtp-Source: ABdhPJzMi1Mtx1RdN304uFXFKR2KFpX1Rd0OAIow+uzRu2Qcp+vGrFPlEfVbbAaJ82UMgV+mkbxCMg==
X-Received: by 2002:a63:ef15:: with SMTP id u21mr6745982pgh.56.1607607565338;
        Thu, 10 Dec 2020 05:39:25 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-2524-f8fd-7a21-1504.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:2524:f8fd:7a21:1504])
        by smtp.gmail.com with ESMTPSA id u12sm6019129pfn.88.2020.12.10.05.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 05:39:24 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Uladzislau Rezki <urezki@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/2] rcu-tasks: move RCU-tasks initialization out of core_initcall()
In-Reply-To: <20201209203728.GA5972@pc638.lan>
References: <20201209202732.5896-1-urezki@gmail.com> <20201209203728.GA5972@pc638.lan>
Date:   Fri, 11 Dec 2020 00:39:21 +1100
Message-ID: <875z59hjau.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlad,

>> Initialize the RCU-tasks earlier, before *_initcall() callbacks are
>> invoked. Do it after the workqueue subsytem is up and running. That
>> gives us a possibility to make use of synchronize_rcu_tasks*() wait
>> API in early_initcall() callbacks.
>> 
>> Fixes: 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Tested-by: Daniel Axtens <dja@axtens.net>

>> ---
>>  include/linux/rcupdate.h |  6 ++++++
>>  init/main.c              |  1 +
>>  kernel/rcu/tasks.h       | 26 ++++++++++++++++++++++----
>>  3 files changed, 29 insertions(+), 4 deletions(-)
>> 
> I still don't have a powerPC hw so far, even though i have sent a request
> to the osuosl.org. It would be appreciated if Michael or Daniel could run
> and verify it.

Sorry it's taken me so long to get to this. Your patch fixes things for
me. Thanks!

BTW, I'm happy to see you taking on the challenge of RCU after your good
work on vmalloc - all the best with it!

Kind regards,
Daniel

>
> Thank you in advance!
>
> --
> Vlad Rezki
