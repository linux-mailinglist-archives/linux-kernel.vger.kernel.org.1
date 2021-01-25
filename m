Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C077C302801
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbhAYQgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbhAYQev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:34:51 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F168C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:34:11 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cq1so8720598pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+AO/2UPHVqA76MbynGpJlAANlIGJYjkKh16kwZOTMC4=;
        b=PPuMnezYxZLU1GBR+XJo640F4pBzFCyqglGIccvXWXFTVkFWv4ReNDC50805k1Q+nN
         pg0DQnB7qe+yrM1z7ppEcUd9bW/ChiB4vxXRzkzhUFsXQbt6+HqLueR1PpleCHp0c3pE
         VS7XyrD9pmDq5XtEJmdajsibreM5BjGvnu4eI9SFUcOUJ7IzNTPJMOrqD9CdCL8bhNyz
         Ppq4soczUAo+KR1vtq9dkSzMdQc/8Y+bqH/LBZ4ewmrVyrOhMRaN2mQlq9NesO6kJEzi
         wEBpjYjv9baKkyed1m9vmxn9jX1ytG4JdEyVeNCnI6n7WoatKuz6huBO1vedAH1wolo1
         LdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+AO/2UPHVqA76MbynGpJlAANlIGJYjkKh16kwZOTMC4=;
        b=ZLcMB/W/G+6Zq8+vxS+iTs93UCn7L3SwXB4S3QLQwrX5areWrKtyP7Z4k41po5K4xV
         WbXQQA1h5zNff+HZa0pQETuT1jkBge9L8YcjG1CmIjCOuBpi9ki9KfBMuSmMCJjEprS/
         BhaZnBQHJf3Yq6XHlQ937LrH2ADaCEtfTCuHmMDKyba5tBsj7h7xzJ+Bn656rldNf+/n
         AtmFS+GDXkxbYreTptBqBp4DVy0igxvvISM/fz+6d3W6YICTvxdYwLHz2sSxgbIGv3cw
         4Lpx/ImMm4cI1710PlBFrj6Hs+xHPa73jOT2b/1vsKXdToimQGXAHrVxPwyN9J/MCG08
         XzyA==
X-Gm-Message-State: AOAM530QpVklES6mHfXUiD2ehx1s9opAZtRvhTbC6LUoihkEz5trFjT8
        v6hHWJKZAxhDJ6C2ofEWnd1m2GiGkDdgtA==
X-Google-Smtp-Source: ABdhPJzybYKA1znlHXhhGgXLMk93uctVdNxPhUeXsQAQ+YB8kNQc0MgFmE1hR0jx322y1i0gJkPw9Q==
X-Received: by 2002:a17:902:70c6:b029:df:d62a:8c69 with SMTP id l6-20020a17090270c6b02900dfd62a8c69mr1518424plt.20.1611592450638;
        Mon, 25 Jan 2021 08:34:10 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id gt21sm18568189pjb.56.2021.01.25.08.34.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 08:34:09 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH V2 0/6] x86: don't abuse tss.sp1
Date:   Tue, 26 Jan 2021 01:34:28 +0800
Message-Id: <20210125173444.22696-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <CALCETrWPnvNr9S2hsxL+pbhNWv0OOL7tBq1XmABPjYK7zZSJbw@mail.gmail.com>
References: <CALCETrWPnvNr9S2hsxL+pbhNWv0OOL7tBq1XmABPjYK7zZSJbw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

In x86_64, tss.sp1 is reused as cpu_current_top_of_stack.  But we can
directly use percpu since CR3 and gs_base is correct when it is used.

In x86_32, tss.sp1 is resued as thread.sp0 in three places in entry
code.  We have the correct CR3 and %fs at two of the places.  The last
one is sysenter.  This patchset makes %fs available earlier so that
we can also use percpu in sysenter.  And add a percpu cpu_current_thread_sp0
for thread.sp0 instead of tss.sp1

Changed from V1
	Requested from Andy to also fix sp1 for x86_32.
	Update comments in the x86_64 patch as Andy sugguested.

Lai Jiangshan (6):
  x86_64: move cpu_current_top_of_stack out of TSS
  x86_32: use percpu instead of offset-calculation to get thread.sp0
    when SWITCH_TO_KERNEL_STACK
  x86_32/sysenter: switch to the task stack without emptying the entry
    stack
  x86_32/sysenter: restore %fs before switching stack
  x86_32/sysenter: use percpu to get thread.sp0 when sysenter
  x86_32: use cpu_current_thread_sp0 instead of cpu_tss_rw.x86_tss.sp1

 arch/x86/entry/entry_32.S          | 38 +++++++++++++++++-------------
 arch/x86/include/asm/processor.h   | 12 ++--------
 arch/x86/include/asm/switch_to.h   |  9 ++-----
 arch/x86/include/asm/thread_info.h |  6 -----
 arch/x86/kernel/asm-offsets.c      |  1 -
 arch/x86/kernel/asm-offsets_32.c   | 10 --------
 arch/x86/kernel/cpu/common.c       | 12 +++++++++-
 arch/x86/kernel/process.c          |  7 ------
 arch/x86/mm/pti.c                  |  7 +++---
 9 files changed, 40 insertions(+), 62 deletions(-)

-- 
2.19.1.6.gb485710b

