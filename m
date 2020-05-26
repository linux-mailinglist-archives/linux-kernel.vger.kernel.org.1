Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756A41C0BE2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 04:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgEACCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 22:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727889AbgEACCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 22:02:20 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4A3C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 19:02:20 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r14so971326pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 19:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id;
        bh=xA0+ztltjFSmlxto0oGrs/28x8dQq3lRcLWb+lb2nnI=;
        b=CarECDVW+6KLvf/YyEzSNITvnJPj0ybvXe2NxRdC1e07BJ5Wzhrm9MnEpFVjJZX7kE
         AwSajPjRdMdF0h8zUllcxmIy5i2ceyZbmkevlmDHXGOxVjdaZJuDGWRh8r7k9Ok+Enbz
         mGPfKsaD8R4c4uSPSv6J5/mxtLCMQpUX6zVHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xA0+ztltjFSmlxto0oGrs/28x8dQq3lRcLWb+lb2nnI=;
        b=l9+qog/rNSURHmDBeNpzYJJAMGte7wP0fZx1pPWNIcHkh4r1fmhqOeUGzmqbjPP0Xu
         3K4/vFPFXwBJgm5xVcooNWdiHjC9j4lpPHkO6Lc1KJuyjNFnFBFrz7U9+rO1FnSFoIBE
         mUDAk9mk3/SHzLI5KoeDFwxxc2AJItV8N4d/jG6qZE8HfT6WAxW6CQYDP0WQLgEFAhFI
         VOofODMksRoQlhTkwn/gELWheSNIJZ6azl11wHcaELi7Cr1/SOabRBI6tVwWNGiawATU
         Emr9r0ZLrPxp10Yw491kSc8uKN9i1c+LqDEiF24RQuHRQFIuFx57d507ErDHq9tTRRKx
         5fMA==
X-Gm-Message-State: AGi0PuY2MJwKw+Fha5fyWvie+8M+Q0kx9KTmrtxqdqil8jM6uyUOPYRK
        4u8S4VULT1q6Z6U/KdbbTuPpIg==
X-Google-Smtp-Source: APiQypJhA82+WhNBkkgzPwnXofGL1GnfNooa4CgxEhzB9JSc3x78tYjLRLZVYOiIolegraWmwYU2Qg==
X-Received: by 2002:a65:4645:: with SMTP id k5mr1943443pgr.115.1588298539843;
        Thu, 30 Apr 2020 19:02:19 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id fy21sm802915pjb.25.2020.04.30.19.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 19:02:19 -0700 (PDT)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf 0/2] bpf, arm: Small JIT optimizations
Date:   Thu, 30 Apr 2020 19:02:08 -0700
Message-Id: <20200501020210.32294-1-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Daniel suggested to us, we ran our formal verification tool, Serval,
over the arm JIT. The bugs we found have been patched and applied to the
bpf tree [1, 2]. This patch series introduces two small optimizations
that simplify the JIT and use fewer instructions.

[1] https://lore.kernel.org/bpf/20200408181229.10909-1-luke.r.nels@gmail.com/
[2] https://lore.kernel.org/bpf/20200409221752.28448-1-luke.r.nels@gmail.com/

Luke Nelson (2):
  bpf, arm: Optimize emit_a32_arsh_r64 using conditional instruction
  bpf, arm: Optimize ALU ARSH K using asr immediate instruction

 arch/arm/net/bpf_jit_32.c | 14 +++++++++-----
 arch/arm/net/bpf_jit_32.h |  2 ++
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.17.1

