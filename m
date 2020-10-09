Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEA8289045
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 19:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbgJIRwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 13:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388603AbgJIRwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 13:52:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA138C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 10:52:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 132so905233pfz.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 10:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=wVsQ9q5Q7s1s2K/FqK048q1RDnfVI41to7Mmyngot/U=;
        b=XhIyavq8e/26hIs74uPffC+5QFXoQULQ7hdbrnAqZ1ilmOUyi3gcaCVmzNwEpzLX2b
         rKdCg9+tqIsMw+K2pOKGx5xvlHB2OOdPs4Eq8q/gRJDTXXXLZsJgigJWuDrj6IYY0BuW
         yI0C4N3AZQ/ZaL8lBoPMR1tgZYBBGCnfbxbk7bNlQ+n6Nw5y4n8E1eqDyJLfr+rbiU5W
         aclex6pKaax2Gwve3s3NMXqQq/s9i90/CTaeN3JCP1UmZ5ARmEidDYEWviaUgkRHwMBH
         okzei8cKuXRjIZCncGfKjXJ99nvn/ejIv89XDGvHLgz06IYJ3SviWV6CPka/g+gTNI95
         fuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=wVsQ9q5Q7s1s2K/FqK048q1RDnfVI41to7Mmyngot/U=;
        b=QrfEMeLavSVEBabUIsR+gdAqSSXuzggNfdV4/pqJq1BK27kIX3nU5WEmS6J3diSmOY
         HNXGnbBouWnv+SEs6ns3Y73/M2OTu/XpeREiD2XMP5nfasC0bob0/HFAOnnn74xaNbrB
         yGGl4f3J6jJQuDGaPp6/Ul8oP1VvIQldDBddyzwbpBQDrBahTsW7Dfy6ds5STnSUW+Dt
         q0/UGfY7CPTwg1W7SGtfJ/XPswd4aZXhoHbGuRoMYBkKP7U9v39rcP7CvNoO/0i6MGOo
         R+QCKbUO+/Cs6+XHrIW3eNjekVEl2DoO0MhtSbvjegNJrQ6V8pRhbJjYttxrhKH2EJ3K
         NawQ==
X-Gm-Message-State: AOAM531UUIqcHkFAv2bpcWjVf1U7QMlIr9SCrR4stMCBL/ktz3NAPPXF
        4yXIkjsYPTQCdRvOUDd/ex4Ajg4DisePYNGo
X-Google-Smtp-Source: ABdhPJw1UfBrhjq/v8VFLEsMgIVl2JkDSyZFhDM9kj9WzdsuIxN1Qahc4T3xKTzOzmdFNEtgVaGoeg==
X-Received: by 2002:a63:4f5e:: with SMTP id p30mr4176607pgl.6.1602265930214;
        Fri, 09 Oct 2020 10:52:10 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k25sm1207735pfi.42.2020.10.09.10.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 10:52:09 -0700 (PDT)
Date:   Fri, 09 Oct 2020 10:52:09 -0700 (PDT)
X-Google-Original-Date: Fri, 09 Oct 2020 10:52:06 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.9
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-9c92c420-8192-474d-906c-3f43e1f4d7e0@palmerdabbelt-glaptop1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 549738f15da0e5a00275977623be199fbbf7df50:

  Linux 5.9-rc8 (2020-10-04 16:04:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9

for you to fetch changes up to 84814460eef9af0fb56a4698341c9cb7996a6312:

  riscv: Fixup bootup failure with HARDENED_USERCOPY (2020-10-06 18:34:00 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.9

I have two fixes this week:

* A fix to actually reserve the device tree's memory.  Without this the device
  tree can be overwritten on systems that don't otherwise reserve it.  This
  issue should only manifest on !MMU systems.
* A workaround for a BUG() that triggers when the memory that originally
  contained initdata is freed and later repurposed.  This triggers a BUG() on
  builds that with HARDENED_USERCOPY enabled.

----------------------------------------------------------------
Atish Patra (1):
      RISC-V: Make sure memblock reserves the memory containing DT

Guo Ren (1):
      riscv: Fixup bootup failure with HARDENED_USERCOPY

 arch/riscv/kernel/vmlinux.lds.S | 5 +++--
 arch/riscv/mm/init.c            | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)
