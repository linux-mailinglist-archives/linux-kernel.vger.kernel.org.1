Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874CA28BF2B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390794AbgJLRqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390753AbgJLRqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:46:16 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D32AC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:46:15 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qp15so24379559ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=I5OLSAl0Kb52nHJ2H2C+Kg8d1C8liTlrJ3MX/qfqsRo=;
        b=is9JOZf53B9BIPCxFTTHwty7KBdviVqEDkgXfEz+VcWdxrwudBSeSwBDdu6l38c7o8
         ZSZeqD+plXAKB8HKs2N2tCLitIJdqOYqfhGJMtxxJAINRiNPf/+L/geDPlVgbJqF1OIr
         LAQkRofzk2Tz87afvRpg4IJiQslPQ3E2ET1E5GLOv58UmKekRiPiYnNpIAFs1uCyBx1Y
         7X8ulRvvXhrS+Tej9+c3qeVN154A6sHAsNXFO98Xv80ryCjA4fe3NoA0apawhSyZkds9
         pKNwZGJubJia/iFaD+bLXhKG3W8oC7agEB+3Ahppk7aDs3K6DrC9r6nY040yg46KwiXe
         5ZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=I5OLSAl0Kb52nHJ2H2C+Kg8d1C8liTlrJ3MX/qfqsRo=;
        b=rQ29cfEVNiG0HRwRaE8Q3IIeoZCAfuZjKU+rnsA/yAUqR9ALGg6vBfmezUZpaIY25G
         q9nfWJ6s4VRK71MZ/snn9zPFcdoEi71Wsuq9GVr6WJ8AK/efgPq59BCP+tx3ASwre7xv
         jfKlRHZR9vUESTJSI1LyBgugsJb4ZDB41eO5hPb0oDeZKh/o1Iu86RhR2deJjaZ8MjUV
         1Jv2X3t07k4TS9t1/MFN0Z7g3qCidLFWgRw6E6VHL9H4UdLgph9h4DtkJPijV1coAim0
         e6hK2nkoV1WU8vwln/ciOL5toyGlJwoGrEFVwW6TOSctdpJCvrCjreB/KtmOd19SuMmV
         zDMA==
X-Gm-Message-State: AOAM533rs1QBzjt+16egmyy/knb66+DrLPjtlCcabCdHZoTkMFZ6+oPp
        j3pqkllG0jh/FFuKZUO0tgOI6o0QHt8=
X-Google-Smtp-Source: ABdhPJxTQRB01Lkl+oWblKrL1MFmmbOWSBm/evh64c+Yr63d6fZ3DRTnRzvY9h1xsVEqdrzJ4rwPIA==
X-Received: by 2002:a17:906:4bc2:: with SMTP id x2mr2835011ejv.525.1602524774100;
        Mon, 12 Oct 2020 10:46:14 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id w13sm4088117ede.89.2020.10.12.10.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 10:46:13 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 19:46:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/hyperv change for v5.10
Message-ID: <20201012174611.GA3060077@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/hyperv git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-hyperv-2020-10-12

   # HEAD: dfc53baae3c6a165a35735b789e3e083786271d6 x86/hyperv: Remove aliases with X64 in their name

A single commit harmonizing the x86 and ARM64 Hyper-V constants namespace.

 Thanks,

	Ingo

------------------>
Joseph Salisbury (1):
      x86/hyperv: Remove aliases with X64 in their name


 arch/x86/hyperv/hv_init.c          |  8 ++++----
 arch/x86/hyperv/hv_spinlock.c      |  2 +-
 arch/x86/include/asm/hyperv-tlfs.h | 33 ---------------------------------
 arch/x86/kernel/cpu/mshyperv.c     |  8 ++++----
 arch/x86/kvm/hyperv.c              | 20 ++++++++++----------
 5 files changed, 19 insertions(+), 52 deletions(-)

