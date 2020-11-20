Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F462BA733
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgKTKQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKTKQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:16:27 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A23FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:16:26 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 34so6892774pgp.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FuGAn79U75S5ZXGo8UVyUxX/L7xANKhtdIaztcATE34=;
        b=KQd57JMjjJejeNYOnX+iSU+OqayHDjugqVBc7S8yABDQ6A9FyEb6wkRl3NRZ/RlrU8
         MZ/+S/KQduE6aCKpwjpk6HXqFJSarckiBBk2Dlgs1RHwD52Q29tqYD8rfIa6A45N5x2G
         JmR2qKNG7Eqm+SldcemjEDKPSnP9L8zApGA+aMP3PXnKG9m73AeBUCwyb4q+1FEFHxM3
         NG54kkuZ9C9kxWWZXTXeX8gRcgcNmBUccu+kgmLmS0sNWBCdwsnzCOAjKcvy3kTZ6KiS
         5LyNQewnnYrPmMFmZ+7Hm07h4SXlEdUbxarieAP2+35ZbXcWGzEiAcCA8i10EuT6X1f/
         yLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FuGAn79U75S5ZXGo8UVyUxX/L7xANKhtdIaztcATE34=;
        b=DSjNO+QLATTRuD9jzrhE154VFrAyx0h4HvNZMI8cYMpPgs29PP1PxGwbottioPupek
         MnDlKrsa0jSiEpwQs/H3A5HGOC3YmaK+SJyIYIv+F4dwAQ4omFlmub5MOVezd0SQHnHB
         nTITJ1pCn1G2QrsUCOHPgVF3saFm/8VIc1HzE6XS4pwyKSPqZXU+ftApi8h7gypuwWz5
         Ya0DEBcBen1ujsw9p7x1T9347cdgnIoG1JFVJQcBEyF/PHYQTxFqNzwRiNoP54tW55+y
         Nnwf5xesLiidgd0lgHMqz+roqQma5Tdd7lmZvvya4ywmo3icq4RlIB10EouevzmgoWxW
         2BeQ==
X-Gm-Message-State: AOAM530RH/nUVChP0kZqD2qLZ6lIuUZWT+rPHzy8rj9Yw2nQ5pHfjxYg
        sWUz2yS+SO3lfhsJyZGxmsc=
X-Google-Smtp-Source: ABdhPJyD654fWz1fAsqEaxw2ruQtPdHlRNromTcG1UEv3lks7dS10JFgKuWbOVUh8TA1FnNswdTdTw==
X-Received: by 2002:a17:90a:de5:: with SMTP id 92mr9227794pjv.179.1605867385350;
        Fri, 20 Nov 2020 02:16:25 -0800 (PST)
Received: from f8ffc2228008.ant.amazon.com (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id c8sm3235181pjd.13.2020.11.20.02.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 02:16:24 -0800 (PST)
Subject: Re: [PATCH -tip 03/32] sched/fair: Fix pick_task_fair crashes due to
 empty rbtree
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
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
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-4-joel@joelfernandes.org>
From:   "Singh, Balbir" <bsingharora@gmail.com>
Message-ID: <cab6918c-7b52-923c-4274-f92e9f0a5cd2@gmail.com>
Date:   Fri, 20 Nov 2020 21:15:28 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201117232003.3580179-4-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/20 10:19 am, Joel Fernandes (Google) wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> pick_next_entity() is passed curr == NULL during core-scheduling. Due to
> this, if the rbtree is empty, the 'left' variable is set to NULL within
> the function. This can cause crashes within the function.
> 
> This is not an issue if put_prev_task() is invoked on the currently
> running task before calling pick_next_entity(). However, in core
> scheduling, it is possible that a sibling CPU picks for another RQ in
> the core, via pick_task_fair(). This remote sibling would not get any
> opportunities to do a put_prev_task().
> 
> Fix it by refactoring pick_task_fair() such that pick_next_entity() is
> called with the cfs_rq->curr. This will prevent pick_next_entity() from
> crashing if its rbtree is empty.
> 
> Also this fixes another possible bug where update_curr() would not be
> called on the cfs_rq hierarchy if the rbtree is empty. This could effect
> cross-cpu comparison of vruntime.
> 

It is not clear from the changelog as to what does put_prev_task() do to prevent
the crash from occuring? Why did we pass NULL as curr in the first place to
pick_next_entity?

The patch looks functionally correct as in, it passes curr as the reference
to pick_next_entity() for left and entity_before comparisons.

Balbir Singh
