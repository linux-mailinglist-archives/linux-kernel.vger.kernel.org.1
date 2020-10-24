Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F44A297CC7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 16:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761956AbgJXOTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 10:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761949AbgJXOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 10:19:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FCBC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sEUK5AB+cZzLDZ8v3U1z1qBO8qdntzRB3qX7knShG1Q=; b=D5r/Kwk8dGKkS/BjOJEZiZnad2
        +LF/d27dOMNIpkFvt7V5U1zrwb7OFLkQBMNohXeq6n9WU6Pi6XCrVH67IMSsVXOdLr1EzXeHHC28m
        0ObND1AL4AN/fjWLjdgJ/74mEKr+s06w/CKCWVNOvTOwzzy2PL0859//spuQADB/mIWGwrssvk0A+
        EL6DbZB1B9oEv9CmPXzp5CPivm0lf6HTYnXPuyM5j/W3oxGPco6i7oLDstlmv3+SK2jIz46DxTGHz
        qWSYxknswglGxqiTpQzU9esibOGiVi9OVs9djIvPwt8Lc+vr4MqI/gBC7UI+rzSF2xtBsU9WIiZkn
        49uVIS3Q==;
Received: from [2001:4bb8:18c:20bd:dc4a:c0cd:d943:64ae] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWKOQ-0007gM-OL; Sat, 24 Oct 2020 14:19:39 +0000
Date:   Sat, 24 Oct 2020 16:19:35 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fixes for 5.10
Message-ID: <20201024141935.GA3556641@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 270315b8235e3d10c2e360cff56c2f9e0915a252:

  Merge tag 'riscv-for-linus-5.10-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2020-10-19 18:18:30 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.10-1

for you to fetch changes up to 6857a5ebaabc5b9d989872700b4b71dd2a6d6453:

  dma-mapping: document dma_{alloc,free}_pages (2020-10-23 12:07:46 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.10:

 - document the new document dma_{alloc,free}_pages API
 - two fixups for the dma-mapping.h split

----------------------------------------------------------------
Christoph Hellwig (3):
      ARM/sa1111: add a missing include of dma-map-ops.h
      dma-mapping: move more functions to dma-map-ops.h
      dma-mapping: document dma_{alloc,free}_pages

 Documentation/core-api/dma-api.rst | 49 +++++++++++++++++++++++++++++++++-----
 arch/arm/common/sa1111.c           |  2 +-
 include/linux/dma-map-ops.h        | 23 ++++++++++++++++++
 include/linux/dma-mapping.h        | 24 -------------------
 kernel/dma/remap.c                 |  2 +-
 5 files changed, 68 insertions(+), 32 deletions(-)
