Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C932E242C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 05:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgLXEYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 23:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLXEYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 23:24:47 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEF6C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 20:24:07 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n25so882251pgb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 20:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=eFNIDdfQMEQDT5VxT7UvlOTQkhuP0UlcVF5/8a1oZVw=;
        b=FIiIaF8Y2qiTVMo9ROp0f2zFUknPhBk7Hyq2hBZiQTKyunSIF8Vb87uYOzuqmyYc/Y
         Bn8cvZ9bTvq1nESCGy6EmfdfMpv+NmOH9zZ8vL+8EJSHcp9ScLfspxR5Oe00erHWAJNH
         XhoAcDmX4TUfFQLeYZMITcq60hiQxC2eRPLTXtUeIN9lpTOM3SvNqf2yWd2xXMyPfxrb
         2OC5np46ppFJmXdXmRApgs3V73YPdIQI49Xs/usuakEsBBn66OAwpiwEC4l1jEUdddRU
         5FuGmuHRufiS/2be/30OlhFNahDKWdonV1cNmkmFzwiGVMT9vrEhi+UFd3r40UGD/CL+
         +sRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=eFNIDdfQMEQDT5VxT7UvlOTQkhuP0UlcVF5/8a1oZVw=;
        b=FccNjVFnKGyFpgnf6ZZLLvATt3FjsBycgVRBehPzeaT+BvAQveEkul6YHXlTkAnS+u
         oSPjUynqls7jw3ACUDdmw2Us4R3bo6Hfuac3EcdiHb8yQGmIVW92ZRDi5TCvgOgN+FN9
         BUIIkthFW8x4C2XTNQNaJPINV/c0nRTC0fYDrUKvK443rE82agc8Jd/2YobFplh0dKzj
         gQBdXouq8htuqDuq8AQHN1BNfm1PD12CoFkDSwFsDxmKQHfHnb2wiA/O6CbPjkEboi0b
         uDOd8Y2qfm7lOJ6OC82pnA/R8/dzA1W4I93L0Etpgab04gePyjbs1f9LpgPAyc5wqn77
         r5pw==
X-Gm-Message-State: AOAM530NyoD++gC0zWxqx2XfXIQaRRdYlKpK85QQSkkyL6+9DqSXNJLp
        3CJbPf+z/4QHo4mLLfYS3ReRsCEHVTR5vw==
X-Google-Smtp-Source: ABdhPJxEKQn2mqdHvl3fjDZEpX4U6V7iktUQsILQrETYO1uYQ3wOX2SBIPyj3cwUngkvfHP+yOYs+g==
X-Received: by 2002:a62:d142:0:b029:19e:62a0:ca1a with SMTP id t2-20020a62d1420000b029019e62a0ca1amr26275067pfl.80.1608783846600;
        Wed, 23 Dec 2020 20:24:06 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b6sm23421973pfd.43.2020.12.23.20.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 20:24:05 -0800 (PST)
Date:   Wed, 23 Dec 2020 20:24:05 -0800 (PST)
X-Google-Original-Date: Wed, 23 Dec 2020 20:23:59 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.11-rc1 (or rc2, if it's too late)
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-ab52db2e-d084-4a51-b804-ae41d45ca8db@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'riscv-for-linus-5.11-mw0'
The following changes since commit e2ae634014d3a8839a99f8897b3f6346a133a33b:

  Merge tag 'riscv-for-linus-5.11-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2020-12-18 10:43:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-rc1

for you to fetch changes up to de043da0b9e71147ca610ed542d34858aadfc61c:

  RISC-V: Fix usage of memblock_enforce_memory_limit (2020-12-21 21:02:14 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.11-rc1

* A fix that avoids trying to initialize memory regions outside the
  usable range.

---

I know it's an odd time, but I figured it'd be better to just send this out.
There's a few other fixes on the list that I was considering including, but
there's enough discussion that I didn't want to rush those over the holidays.
I don't see any reason to delay this one any longer, though, as it's relevant
to the ongoing QEMU work.

----------------------------------------------------------------
Atish Patra (1):
      RISC-V: Fix usage of memblock_enforce_memory_limit

 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
