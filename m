Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2E42AFA30
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 22:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgKKVKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 16:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:10:40 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9902BC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 13:10:40 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 3so2428061qtx.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 13:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DwowmHeOF5hB8SgYxSfDIWmDR6goWK654K10ZP4Xiw0=;
        b=w+W2Yhg8OjZUUrqe7AlCDU6t7QJJRytmKewAlGJCJCXZs1zV5UXCfTAvjpY4bKxswm
         K4KBoy+Uelnxh14Dv8DOvsTsWhK97XfKECHmUIz7oOO6tQCFLVYNMyZx+l1xpPZVb8Hg
         TxZXSBk/jSOczSRxBiHH5dKJZ2NuTVepCwzmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DwowmHeOF5hB8SgYxSfDIWmDR6goWK654K10ZP4Xiw0=;
        b=eB+wkYzoVFBIp58tCI2vsiIGyW5MZf++dNHhtnfQqj8Bcx4uGoUGiLwHs9p71RVWjU
         MdpH74K45oD4al3ieaolTc1JNIuNkBLPXPqVQyr8XkGWEfSeMMaiy9MmV6E4xvTJkd18
         Ic2g3JMdKTFCeRO2ZHbk2JY7F6W/Xdfz8Nhg377vciY3cIytbWhFDHnOU6xJDYvE+7By
         +R8tRVCZNj9UME+H3ffYyoiDWXUoBut7BK2Lo1vgG6KWQbWlDrj1Q340J5dtm2ToVjBh
         p8CkXNpdyOz7vMsNwUNRp6PMDkFxojuKHsPuYRm8oSq5ZD6JO4nG8BIpV0dzV+0a9dOh
         0VDw==
X-Gm-Message-State: AOAM530CAvrJeu8tIrylAMuye+P/ZUU/LflijsVYMrsVbVh/t3AKGK/c
        PAPgA/t0QO89paotmpGXgf0MeQ==
X-Google-Smtp-Source: ABdhPJzUmqR7UaXA+izOB79g+2RYT1W1/HkLbohcVWdJ8v1xStGJsQKzBWVm1aSoAtA6Af09oJf8yA==
X-Received: by 2002:ac8:5557:: with SMTP id o23mr24766068qtr.252.1605129039714;
        Wed, 11 Nov 2020 13:10:39 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d66sm2112389qke.132.2020.11.11.13.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 13:10:39 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
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
        amistry@google.com, Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
        thomas.lendacky@amd.com, Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [RFC 0/2] Do not slow down some AMD devices with coresched
Date:   Wed, 11 Nov 2020 16:10:09 -0500
Message-Id: <20201111211011.1381848-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are 2 patches I am thinking of sending with next coresched series. Let me
know what you think. These are for not slowing down certain AMD devices if they
don't have vulnerabilities that require coresched.

1/2 - keep coresched disabled if device doesn't have vulnerability.
2/2 - add debug information.

In the future, if needed we could add more options to make it possible to
force-enable coresched. But right now I don't see a need for that, till a
usecase arises.

Joel Fernandes (Google) (2):
x86/bugs: Disable coresched on hardware that does not need it
sched/debug: Add debug information about whether coresched is enabled

arch/x86/kernel/cpu/bugs.c | 8 ++++++++
kernel/sched/core.c        | 7 +++++++
kernel/sched/debug.c       | 4 ++++
kernel/sched/sched.h       | 5 +++++
4 files changed, 24 insertions(+)

--
2.29.2.222.g5d2a92d10f8-goog

