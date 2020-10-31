Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE022A14E4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 10:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgJaJkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 05:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgJaJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:40:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68054C0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 02:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=l/8xBspK/egJQgWp9wEyakLNsvCi5RbuiwpHLDEpSY4=; b=rydcv2zGRMIzbXFsWs84kqi7WF
        9fiCgSfauC3vD2m3KmzfjUoMUS23MPxWccHnS7xE+tLDn2hax5YmWyzSuPkftRmLaCX8PO+90FrmD
        7TQWBAf8Ew/+ECIzADyZjuXNymKQmWnGMR0Ndj/eh0/U6sk4Q9RGB+P49LXKhloltmOZlk6vEw6G4
        cm4lqM+hDy5BYcEQpm3r4ZJ5DamMeSgLexfali5z7PAbqKQmLqiLMUAZj5qavBwMXXPjYOBv8K9Kv
        Jm4ieGeRDAMT+nBZufKCZIOnP7LSaGJUuUSYQwBkgfAcLa1L0QcqO6mCFvN3EGeuf5DXglscBJQeZ
        LEywkMfQ==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYnNC-0000zk-Fa; Sat, 31 Oct 2020 09:40:35 +0000
Date:   Sat, 31 Oct 2020 10:38:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fix for 5.10
Message-ID: <20201031093823.GA453843@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ed8780e3f2ecc82645342d070c6b4e530532e680:

  Merge tag 'x86-urgent-2020-10-27' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2020-10-27 14:39:29 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.10-2

for you to fetch changes up to 48ab6d5d1f096d6fac5b59f94af0aa394115a001:

  dma-mapping: fix 32-bit overflow with CONFIG_ARM_LPAE=n (2020-10-29 16:59:34 +0100)

----------------------------------------------------------------
dma-mapping fix for 5.10:

 - fix an integer overflow on 32-bit platforms in the new DMA range code
   (Geert Uytterhoeven)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      dma-mapping: fix 32-bit overflow with CONFIG_ARM_LPAE=n

 drivers/of/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
