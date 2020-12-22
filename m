Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB2D2E0D00
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 17:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgLVQE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 11:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgLVQEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:04:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE02FC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 08:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=vYjuR6C39CM2C/NhMbP5bhM224OC6G195eg2AmhCL8w=; b=hWOgALDMtjXeBlDBynPJIFCh5W
        FAtYh1fVlR8WQloidDt9l2hmrAmdxEQBm2s9CPNCARyA844xGYmcu06Eh8uHIDdhS1GG7jEtrkwNk
        0kB7tdnXD6nEbjb7y7+wHyhuiuOWKHQQjyGB8+obEhLY4eX6y2Up04Y6vos4DCMyqPnU+dDJWsmUz
        oRidVaK7ZwfGPVP0pTZj69TvAnCdy4pJgrSH/VNdZndYpo/aX8SYkAE+7HA8LF5rNrkWowp5tfa24
        6Zrx4b29vtosrrWMzYSwZ/MhLlCi6gNr6+GrEEUnMZSWz6ZdSmrqd03k4Y1AhAaqcZoDujt5NcZaW
        kFsVHXbg==;
Received: from [2001:4bb8:180:8063:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krk8U-0003Of-7t; Tue, 22 Dec 2020 16:03:42 +0000
Date:   Tue, 22 Dec 2020 17:03:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Subject: [GIT PULL] configfs updates for 5.11
Message-ID: <20201222160341.GA3019774@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f01c30de86f1047e9bae1b1b1417b0ce8dcd15b1:

  Merge tag 'vfs-5.10-fixes-2' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2020-11-13 16:07:53 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-5.11

for you to fetch changes up to 65cdb4a214c0015c19fc1876896746c05396f45d:

  configfs: fix kernel-doc markup issue (2020-11-14 10:22:45 +0100)

----------------------------------------------------------------
configfs updates for 5.11:

 - fix a kerneldoc comment (Alex Shi)

----------------------------------------------------------------
Alex Shi (1):
      configfs: fix kernel-doc markup issue

 fs/configfs/dir.c | 1 +
 1 file changed, 1 insertion(+)
