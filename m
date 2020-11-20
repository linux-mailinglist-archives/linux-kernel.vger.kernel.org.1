Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040832BB4F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbgKTTNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732042AbgKTTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:13:54 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65959C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:13:53 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 81so8127403pgf.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=f4oy8hA8+0VkI6V9P3UsdKj1qYzye7Q8Qrm+k2T2ngM=;
        b=oOep55n2xA3d/KWyW4lnBlUoK3V5hP2Gg0sLzIR+hDkVV/YnL3V6kin2DIgMv/YkaK
         y1ymHUxuSTvENC6Rx4UcJ9DYryf+2RH0qJyAXzJIJLI8qxwdqnxmR07cenR4QwtGWcRv
         g0zI00QfUT8szjTEV1tftc7v8CYDdjpP6VU+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=f4oy8hA8+0VkI6V9P3UsdKj1qYzye7Q8Qrm+k2T2ngM=;
        b=Vv9zjABlvQjig+mXZr19A4vLUz+EISLjel111chxW+7DLMUnbb4Vcgp+DPFDhdwptg
         6/f9BFPEOb/c89cCLTJOsPDzFUegBFYJEjPYmFKOCl+6DeZxp/Vrp0sbzBLRwvReipeg
         qy/btHc0oMMJZHj6/0kd1F+llIuvsSVAIfSVFcGNHXPR/ymgKQhn6UEJX6g2UBDok6W2
         PlLKtlDmGmWGC2YnyVAwKGaVmrXXqiLfI5Ad/4NJR0OUwA4cR/MSRsEpWeZ/A+yMJBqB
         oG6libMjV23kBPvq11JoKCCc7jP1FQsBGSwYSTtVTjHSNW3hDJJz19GmhLVGF414e4wZ
         q6Fg==
X-Gm-Message-State: AOAM5319Aw4Ynfqf6Y5ZE/RaqZUesuGX7WCS2Rx1x20xeImzHJVs3mZv
        SBCUyEQQetyHsfVLpqFShFq8Ew==
X-Google-Smtp-Source: ABdhPJw4I4Hccpuf85mP4mX3O9jGouvA5Tu8/SuTRmtKwcyCVuemjT9T579pj8p2ssIEDaQFbaK2nA==
X-Received: by 2002:a17:90a:3c8b:: with SMTP id g11mr11341872pjc.14.1605899632992;
        Fri, 20 Nov 2020 11:13:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q18sm4309808pfs.150.2020.11.20.11.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:13:52 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:13:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Paris <eparis@redhat.com>, Jann Horn <jannh@google.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Will Drewry <wad@chromium.org>
Subject: [GIT PULL] seccomp fixes for v5.10-rc5
Message-ID: <202011201112.C7CFF68B07@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these seccomp fixes for v5.10-rc5. This gets the seccomp
selftests running against on powerpc and sh, and fixes an audit
reporting oversight noticed in both seccomp and ptrace.

Thanks!

-Kees

The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.10-rc5

for you to fetch changes up to 4c222f31fb1db4d590503a181a6268ced9252379:

  selftests/seccomp: sh: Fix register names (2020-11-20 11:03:08 -0800)

----------------------------------------------------------------
seccomp fixes for v5.10-rc5

- Fix typos in seccomp selftests on powerpc and sh (Kees Cook)

- Fix PF_SUPERPRIV audit marking in seccomp and ptrace (Mickaël Salaün)

----------------------------------------------------------------
Kees Cook (2):
      selftests/seccomp: powerpc: Fix typo in macro variable name
      selftests/seccomp: sh: Fix register names

Mickaël Salaün (2):
      ptrace: Set PF_SUPERPRIV when checking capability
      seccomp: Set PF_SUPERPRIV when checking capability

 kernel/ptrace.c                               | 16 +++++-----------
 kernel/seccomp.c                              |  5 ++---
 tools/testing/selftests/seccomp/seccomp_bpf.c |  8 ++++----
 3 files changed, 11 insertions(+), 18 deletions(-)

-- 
Kees Cook
