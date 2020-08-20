Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C513C24C37C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 18:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgHTQmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 12:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgHTQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:42:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7AAC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=n6wthIhm7EoTN1b0pHSh96gJiJzqBpjUf1yHTv5MKlc=; b=ll4Mr1xyZg6BZuSzg+G/6nUfYF
        b7XD/oStlmttWxJuwjghyReYl0DDhNtBIPjHWbnXaJUhaNi53LJD9/otSFFvscA4kGP/SCOzMfjx4
        7N5nrx7XASX+ITWMMAHXEIMaQerIv1kkd4W444WAmFBrJeBVskIji+3tjpGM9F8O6C51uiY3rYHJj
        Dkhdf98EMBfM4iZZneMNSrvYJNf/q4EvHCUu1YM6h1sEHPOoYF5sK55ei+pGRRh/YCIiNj9zcLZPv
        0zXBFAQXf2jtF9RXlpRpmgNROx1coDPD7ZEn8+SFtIXRjP5kKeuLBmcJeB5s2sc8gEgizeSLlEI8A
        n2/kjsxg==;
Received: from [2001:4bb8:198:f3b2:8d02:73eb:b79f:5fd] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8ndY-0002Vf-Lv; Thu, 20 Aug 2020 16:42:01 +0000
Date:   Thu, 20 Aug 2020 18:41:58 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fixes for 5.9
Message-ID: <20200820164158.GA2186695@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a1d21081a60dfb7fddf4a38b66d9cef603b317a9:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2020-08-13 20:03:11 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.9-1

for you to fetch changes up to d7e673ec2c8e0ea39c4c70fc490d67d7fbda869d:

  dma-pool: Only allocate from CMA when in same memory zone (2020-08-14 16:27:05 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.9

 - fix out more fallout from the dma-pool changes
   (Nicolas Saenz Julienne, me)

----------------------------------------------------------------
Christoph Hellwig (1):
      dma-pool: fix coherent pool allocations for IOMMU mappings

Nicolas Saenz Julienne (1):
      dma-pool: Only allocate from CMA when in same memory zone

 drivers/iommu/dma-iommu.c   |   4 +-
 include/linux/dma-direct.h  |   3 -
 include/linux/dma-mapping.h |   5 +-
 kernel/dma/direct.c         |  13 ++--
 kernel/dma/pool.c           | 145 ++++++++++++++++++++++++--------------------
 5 files changed, 92 insertions(+), 78 deletions(-)
