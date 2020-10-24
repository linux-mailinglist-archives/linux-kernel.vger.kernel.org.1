Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF80297BBD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 11:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756944AbgJXJwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 05:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756798AbgJXJwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 05:52:03 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D781C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 02:52:02 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 140so4006449qko.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 02:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=K/ba/jW93Ys33M7ftMMlA24g1qx8ROGAPNPI5/AojQM=;
        b=dODb9ySxyhVId+8csNjydZzBnEsuSt+bak4te3dPslo7BG3gh3oHyWquOVc0m5a5+D
         W8MqvP0BOnrQmJVd0B7/tKmnYlx2j2Vx01Q5AgBqzfx3t/Ob74F99ButrAISp2Fi2aN4
         fpn/SJ4fMYktxeAo6h+ZJmPmncg3xcP4VBaH0Di5EX/7YXv8kAViIrM76WlejijcB0mq
         67ejFyiJaQch524+Fpj8QODY1KNVGQn17h+Jae9A7dr6Cxh46p99sPLzf6IL+6AgDVaS
         9g/JdALxnJO1vHYtq2x6CU9v0n2X565mDTY8llcu0pLMXi86phyTnHBNACtszTs70Xr6
         ovyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=K/ba/jW93Ys33M7ftMMlA24g1qx8ROGAPNPI5/AojQM=;
        b=n/xPeNQEFyAB1uKQZyh29p+hCfY6Qu0te8zBiKsMDG4kfdZ25wf/8/VZr1wLn2ySAf
         anQ09qV4g6i1wo8OC31juExA5jL6bzTTCV/dVO88ozdWRtXkvv6+gJNfdP0j6H58jpHz
         KV6cTgenl7vtB6tmYXoLkOM94h2Blf/vTlaS7tBr7yETM92vkZcCJh/0adBOM+OxwEH2
         LHyDcwq0egt7ILRA41zaEmYB3+KAZ83zJG/0lCid0rXstCPeiNE1vUp4hcInzXtnJW2s
         Dokq1IiohOa7+8Q6p5AkKuUzltMlOWZJ+NeJGg9PjQbaxIspBEPDJUNsQucMVuOFZfIp
         wuuw==
X-Gm-Message-State: AOAM5331/5BqOKtGIM7HOKhqF7u8f1glX7KSiGjyvfLnPEXISzcssQZv
        Gh6YM48WdmjK9cJRywsLVhMFd5qFe2sb+O139ttAjQ==
X-Google-Smtp-Source: ABdhPJziUYlDGSoitQPjxpnCXvKUmgJD9jDUtPCddJLBR3y6ZVOxWt87OV8G+dQMw2R08ABBa9EiQHIpyaqj9BQiMf8=
X-Received: by 2002:a37:63cb:: with SMTP id x194mr228826qkb.350.1603533121168;
 Sat, 24 Oct 2020 02:52:01 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 24 Oct 2020 11:51:49 +0200
Message-ID: <CACT4Y+aAzoJ48Mh1wNYD17pJqyEcDnrxGfApir=-j171TnQXhw@mail.gmail.com>
Subject: Does LOCKDEP work on ARM64?
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ARM64/LOCKDEP maintainers,

I've started experimenting with running syzkaller on ARM64 using
QEMU/TCG. Total execution speed is very low and it ran just a handful
of tests, but I am seeing massive amounts of locking bugs. Most of
these were not observed on x86_64, while x86_64 ran gazillions of
tests by now and most of these are trivial to trigger (depend only on
call stack) and they do not look ARM64-specific. So I wonder:
1. Are there any known issues with LOCKDEP on ARM64?
2. Or are all these real and it's x86_64 LOCKDEP that's misbehaving?
3. Or are both x86_64 and ARM64 fine and these are just somehow ARM64-specific?

Here are details. Kernel is on
f9893351acaecf0a414baf9942b48d5bb5c688c6 (recent upstream HEAD).
Kernel config:
https://gist.githubusercontent.com/dvyukov/c92a1e08f3f7e22b1f0387096d98b18b/raw/9f79f83c3b018ac27a040649f7d0fef36b63b960/gistfile1.txt

Here is one "Invalid wait context". It looks like just a put_user
inside of syscall function:
https://gist.githubusercontent.com/dvyukov/15639a949278a981c8eb125b3088a6b8/raw/286117bc292578c07c8afbf0fa563cd5528821e7/gistfile1.txt

Here is one "bad unlock balance detected". The looks well balanced and
the code path is well exercised:
https://gist.githubusercontent.com/dvyukov/805f867823b9f77a26c2ebedec5b9b9e/raw/2e6605fb5c90f56ebd1ccda78d613b5c219dfb82/gistfile1.txt

Here is one "workqueue leaked lock". Again, lock/unlock are very local
and there is no control flow in between:
https://gist.githubusercontent.com/dvyukov/4d18d35a79d7e74bf66d6e7ec3794ec0/raw/1ff3e2a5d3a825eb0d196af1f81c67a47fa3a2f6/gistfile1.txt

Here is one confusing "bad unlock balance detected":
https://gist.githubusercontent.com/dvyukov/e222fa34e04104678c52a5b5b1ad15a3/raw/943c6ebbc022418b89fa63b6282fa1f1f40a276a/gistfile1.txt

Here is one confusing "suspicious RCU usage":
https://gist.githubusercontent.com/dvyukov/77b0ec246e1db86e549a80e4a11ec218/raw/0bce97be186c0a6617d8835a694443ed1aa2a98a/gistfile1.txt

Overall I have more than 50 of these now.
