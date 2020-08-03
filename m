Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC96723A806
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgHCOEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 10:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgHCOEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:04:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FB7C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 07:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=gTTQ+k5+2E7d33724Mo57KePcyEpNLEkOEMp978Lhv4=; b=u4dJE934OMFFVoziRbpEJZOz3J
        /1cIu9/NHfxl4IfPSXX1fpF0OeR1QSriszouRmhHaA8SY1ORk39CsePT8586hfn1llT1URZOhDwpr
        PIjZrFslHlIg14IfMEQkCSVnumQaXn4BHZz5n0IWrEeXQaxJqqXDjfWlbE32uTcm7Dqz/VLcjb+7T
        szWqh/ss7hrpM4tbUCHY2NKzR0z58ijVObNN4QNHax+5zI83k95/2t2U42HzFBfNEGFSon2ECbQL2
        F+7JRMcwiS/ARhqUpSP26hq7riRoPcaqjjMR73T8yuO/FKeGz6TzYV0xwVI+8e9LkioRugQwQ1he1
        wKHwmJ8w==;
Received: from 93-43-212-104.ip93.fastwebnet.it ([93.43.212.104] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2b4q-0002c4-Uf; Mon, 03 Aug 2020 14:04:33 +0000
Date:   Mon, 3 Aug 2020 16:04:32 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] uuid update for 5.9
Message-ID: <20200803140432.GA751849@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5714ee50bb4375bd586858ad800b1d9772847452:

  copy_xstate_to_kernel: Fix typo which caused GDB regression (2020-07-19 17:09:10 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/uuid.git tags/uuid-for-5.9

for you to fetch changes up to 3c8387d234f75887a2d78972ab0f764fe9f756e4:

  uuid: remove unused uuid_le_to_bin() definition (2020-07-20 15:04:32 +0200)

----------------------------------------------------------------
uuid updates for 5.9

 - remove a now unused helper (Andy Shevchenko)

----------------------------------------------------------------
Andy Shevchenko (1):
      uuid: remove unused uuid_le_to_bin() definition

 include/linux/uuid.h | 2 --
 1 file changed, 2 deletions(-)
