Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40DE2A02E0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgJ3K36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgJ3K36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:29:58 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBA4C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:29:57 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id n5so6037004ile.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9sx1pWoZJXcLY5Wm9TAUSmY3vOK4DUm68sL/ca16vuM=;
        b=NR8L81S9+Q2rXA+eNj78mO7XRQt/RQds0XcWiIlxQrVyNS5GfvcsC4N6yEaw/f8ASU
         s1m7i8Y+7SbD4J7dAmapYnZlltdUG/gVaPWBLa5DciSelzGlDb4qFKHJxhhksIajQ3P1
         OH23wga6hVxGgb6M9F79k86YLkAf7XIVFvrwyt9Kc8eK7/KC+hcZCMuGZzLBPO4jZG1m
         XzFwzagCmUmBPdx62fq2AGUwhruZGjTYo6sVz7mgGW+X9iJaETPm1vsTB0wnvj1mig2g
         MeJ0D+uWfjT8t9XQsPkACY7Mdbu3JT+qtdhKxL8YfQ48DWL0j6q07HPYCE9rNVhbYR9m
         1W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9sx1pWoZJXcLY5Wm9TAUSmY3vOK4DUm68sL/ca16vuM=;
        b=HJ/6P9NoT1kv8HOvUgY12lz9afJgfjCqOAf7tSjjaY48VkWnCzPXqiUU5lxqMwQneh
         DVbAhmbTYbYzQiJJTqQ2+/zgZbHOz/leA+HTiKez03NFoWLk6joRpPGqXS+KeM6HGkEk
         HqUxiQfEFB5WbqcZkNgJDmUiuF4O6HxVTc4hPiTjnSRET8HDAaoZfs4BZsDikzQhcWmL
         hC6TIY0CI+s3OU6fohgF6+2+z7jknAQvVMsXyuaWbJ0eQLE4SOjFvd1A5sGWuRR27X7T
         C4eRJjCbfCJNvcV5layIp9wQl+m15mvyZw6lQ38Y7X6OKdqnyXUPPLuMvbPU5wxuQf4Q
         qbwg==
X-Gm-Message-State: AOAM531dK83UvF02wiZwGgQ84Y48n2WbII6Es27pJayGsTfwKi1Go+dn
        zcMXupJoyunPDLj4iqDYN4eoY8yZNdXkwWEMAQ8eEwzOQ0E9mzE9
X-Google-Smtp-Source: ABdhPJwKPzdHqKZmTe0eTTdzPBkY2P1Ps01r+uZ6c9N+iLdEzFKoIHdfBMck7ydrFn1gCt7CIdg8r7pdE9inLUPmDxw=
X-Received: by 2002:a92:9ed1:: with SMTP id s78mr1294883ilk.71.1604053796854;
 Fri, 30 Oct 2020 03:29:56 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 30 Oct 2020 15:59:45 +0530
Message-ID: <CA+G9fYth+F1TnG6GQNKtrxvChvX9m+nGa8LKFG18WCzsqNJg5w@mail.gmail.com>
Subject: arc: kernel/entry.S:310: Error: inappropriate arguments for opcode 'and'
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, lkft-triage@lists.linaro.org
Cc:     Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arc defconfig build failed on linux next 20201030 with gcc-8 and gcc-9.

make -sk KBUILD_BUILD_USER=TuxBuild -C/linux -j16 ARCH=arc
CROSS_COMPILE=arc-elf32- HOSTCC=gcc CC="sccache arc-elf32-gcc" O=build
uImage
#
../arch/arc/kernel/entry.S: Assembler messages:
../arch/arc/kernel/entry.S:310: Error: inappropriate arguments for opcode 'and'
make[3]: *** [../scripts/Makefile.build:364:
arch/arc/kernel/entry-arcv2.o] Error 1

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

-- 
Linaro LKFT
https://lkft.linaro.org
