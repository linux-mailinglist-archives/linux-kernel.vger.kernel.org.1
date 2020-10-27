Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B515329C7D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443696AbgJ0Swe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:52:34 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36695 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411289AbgJ0Swd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:52:33 -0400
Received: by mail-pj1-f65.google.com with SMTP id d22so1204836pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Tpkgz2e33QfbIy3ykZgu8wQi/Ryyb2YLuIrLSaMHJGA=;
        b=oIlc1YiT1Thl5Ogg1/FGTT5iL1yxJ3I4EdIHEACXQJ08tDKibbvyiZ45UD/s3ACZyX
         dzceQ8sSRpxC5pVP4Bs4KIDNHHCTKHu/IWiux8dZpcmThcsAA96kgMuyoHRCRJXZ+h8+
         Ary+6AjpFeGvR3q8tk3Np4e8f5HPCDMSFoAJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Tpkgz2e33QfbIy3ykZgu8wQi/Ryyb2YLuIrLSaMHJGA=;
        b=OV5e/SAv6HCDgWVOg9/erwLzCNeBycOG61E68LxL590V3otTwc7yKRwRJww98SMtx1
         d3VX9/1ZnRsWEiTIEzLZWwQCa4OuNXSs1jNfU/KDe38aJrMFbj1METiPzB12a1ScOBzw
         PQLoY5LN5o/iv1DGlShy/Fuge2NkvmqUxyapbvSFezEBEIxeaOSHcbiHK+BXf13xfKK/
         OmYi+rz8wMpGufA7lQ3y/CMKN4YZi2F8Qo2yNR7HBZDUVUe/Cxw9D5lEEMvcJMBw3HQi
         KpTOUYjrCUwJH11O4K/4cJhpfn0jaWxTBR/Vgq75c0ATQ/r+QjY+bRvyrHpC5p19dHnv
         CQsQ==
X-Gm-Message-State: AOAM533EhM/cMOmIKmKBd7eauahVWWacLbrFpZmK69iZKJKgd/pQ9kRE
        kfletLsKfS2mE3hTM2RMkhIQEQ==
X-Google-Smtp-Source: ABdhPJxMvj/HDcc7fiJ81LoEkJi56wl5hzjvZj7NFK+GgfVwii92QbtueGPMRw92JBG5BVAt0jVFQw==
X-Received: by 2002:a17:90a:ab92:: with SMTP id n18mr3121462pjq.233.1603824752355;
        Tue, 27 Oct 2020 11:52:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e11sm3029363pfl.58.2020.10.27.11.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:52:31 -0700 (PDT)
Date:   Tue, 27 Oct 2020 11:52:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] orphan-handling fixes for v5.10-rc2
Message-ID: <202010271151.0FC20740A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these orphan-handling fixes for v5.10-rc2. A couple corner
cases were found from the link-time orphan section handling series that
landed via -tip in -rc1. As other folks are busy with other things, I've
collected this to send.

Thanks!

-Kees

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/orphan-handling-v5.10-rc2

for you to fetch changes up to c39866f268f89868df17724cd2262d121552d8c9:

  arm/build: Always handle .ARM.exidx and .ARM.extab sections (2020-10-27 11:32:21 -0700)

----------------------------------------------------------------
orphan-handling fixes for v5.10-rc2

- arm: handle .ARM.exidx and .ARM.extab sections (Nathan Chancellor)

- x86: collect .ctors.* with .ctors (Kees Cook)

----------------------------------------------------------------
Kees Cook (1):
      vmlinux.lds.h: Keep .ctors.* with .ctors

Nathan Chancellor (1):
      arm/build: Always handle .ARM.exidx and .ARM.extab sections

 arch/arm/kernel/vmlinux.lds.S     | 4 ++++
 include/asm-generic/vmlinux.lds.h | 1 +
 2 files changed, 5 insertions(+)

-- 
Kees Cook
