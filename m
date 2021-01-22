Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7F52FF977
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 01:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbhAVA3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 19:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbhAVA3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:29:45 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BCEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 16:29:05 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e6so2760886pjj.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 16:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=iF694mVegDqKfi3Z26c6YspuPq0RpCL5dkGRinSRl7U=;
        b=iHXjhXwd1W/PjBrrNlHlmRkUkqpaq06V+dHYJ/WoIz0hqRJo4+YsRnv1zwlR+f4CIg
         2fgXBDsf8cIp19rTIUAh74GLorCBgFMOOehO8JePoOj4n+mrDueSQNxp6tXj1jROAC74
         Q3rK1OTEmMQSaJSI/NwQqLAumus6YpNVX2SBEsIdZlJW0hsUKfuP/KNEXNchIlvgAF6a
         RbQsjv9Re274vGgT+mKvB3xeIQ0B6JohjXEPTcPu9XCQTk3mz/vqFF/GOsQn0yYPaaLB
         ENvI/TdnPSH18xAwo8mby4pSVYNMWALpM8Sr6Mqv1aXDEv4YIctYAEmDR2W5WXUi1lLT
         ynJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iF694mVegDqKfi3Z26c6YspuPq0RpCL5dkGRinSRl7U=;
        b=SL1FW2b2QN+rPwHyBOxejACU8caPeOA9c//cF1tc2sTMbxjGNFUDnZX/XVQSUjeI7Q
         r6psH6rNO4vU9rdJEdYZtWsdPIq8T/WNZc+ypEUImYPa0d9+TdXAQnULzq8ADCHIOHYM
         JZGd9Ls5uytZJe6fgHdp/TYTAIUYdB7L3CIIik9WIx2LucweB+nznGr/Kkhvs4iOQ1Ps
         fK+qPHWnNQViUtLvxAnhl8/rBKwpxpy27RYcczbaXRc0gxEnJdPgGqWXCERDa65Ag8nc
         iz5j5N88hNPuSBd1hI5VEEWy1UQvHl7iKPG2/tRvnWHVVASFFa/trwB+drRxngXE7NxR
         idJA==
X-Gm-Message-State: AOAM531VV9Lp1PFiVXqpVTlW7nYCPnqjytXtzzDQoN1tMQsJOvd1nrNr
        lfvETNlGoRIK1uklDwdXyoFn9VxoK50=
X-Google-Smtp-Source: ABdhPJydUoeN926duEX55yDN9jyHJOwRkUb6/kNss+rGisAc71AkIgSRV77sGpdGZZcLClXK78gW+g==
X-Received: by 2002:a17:90a:bb81:: with SMTP id v1mr2231270pjr.119.1611275345221;
        Thu, 21 Jan 2021 16:29:05 -0800 (PST)
Received: from localhost (g238.115-65-210.ppp.wakwak.ne.jp. [115.65.210.238])
        by smtp.gmail.com with ESMTPSA id c11sm6195952pfl.185.2021.01.21.16.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 16:29:04 -0800 (PST)
Date:   Fri, 22 Jan 2021 09:29:02 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Subject: [GIT PULL] OpenRISC fixes for 5.11
Message-ID: <20210122002902.GP2002709@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pull:

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 031c7a8cd6fc565e90320bf08f22ee6e70f9d969:

  openrisc: io: Add missing __iomem annotation to iounmap() (2021-01-20 06:14:26 +0900)

----------------------------------------------------------------
OpenRISC fixes for 5.11

Fixes include:
 * Compiler warning fixup for new Litex SoC driver
 * Sparse warning fixup for iounmap

----------------------------------------------------------------
Geert Uytterhoeven (1):
      openrisc: io: Add missing __iomem annotation to iounmap()

Stafford Horne (1):
      soc: litex: Fix compile warning when device tree is not configured

 arch/openrisc/include/asm/io.h     | 2 +-
 arch/openrisc/mm/ioremap.c         | 2 +-
 drivers/soc/litex/litex_soc_ctrl.c | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

-Stafford
