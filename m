Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F328AB0D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 01:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbgJKXBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 19:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387791AbgJKXBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 19:01:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB3DC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 16:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/SmX1rf42AFciihmx5mExGuKYPWmjWxmU8bHlEGVC/A=; b=KZ92qkKx3S5NvDRn3N+UWYf8Nm
        4JoYfRd/t2Z+I90nbAPF03Qp5OUqQ6SjHdF3sz3Wi6daAB0xMS282XHEITDe4BPdvVeTWtxtqTQ7b
        IP6Xj5V/o7QXlnU70rD0UmHQH60ZMlYNlxKxcvGZ/UE9cJ71275POBcaP6/0zpHqO1JWVufTrtraw
        TahAsmb2Ep//NxFfwTb3JhqgyXC2r1vaJ/5FXF8enwhMAt8XWZdf2YV1DxpZCCMVjL+lzq5yzZsSg
        Nnrh0+BfCA1XvbRNg08jRqjcddobG/cGK1z4bo5ggkJZe+59j6JgSQ4KjiiJKOETJi/tocsl7ZBcU
        356jIS2Q==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRkLT-000817-CQ; Sun, 11 Oct 2020 23:01:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Michal Simek <monstr@monstr.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH RESEND] drm/aspeed: fix Kconfig warning & subsequent build errors
Date:   Sun, 11 Oct 2020 16:01:31 -0700
Message-Id: <20201011230131.4922-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported build errors (undefined references)
that didn't make much sense. After reproducing them, there is also
a Kconfig warning that is the root cause of the build errors, so
fix that Kconfig problem.

Fixes this Kconfig warning:
WARNING: unmet direct dependencies detected for CMA
  Depends on [n]: MMU [=n]
  Selected by [m]:
  - DRM_ASPEED_GFX [=m] && HAS_IOMEM [=y] && DRM [=m] && OF [=y] && (COMPILE_TEST [=y] || ARCH_ASPEED) && HAVE_DMA_CONTIGUOUS [=y]

and these dependent build errors:
(.text+0x10c8c): undefined reference to `start_isolate_page_range'
microblaze-linux-ld: (.text+0x10f14): undefined reference to `test_pages_isolated'
microblaze-linux-ld: (.text+0x10fd0): undefined reference to `undo_isolate_page_range'

Fixes: 76356a966e33 ("drm: aspeed: Clean up Kconfig options")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: linux-mm@kvack.org
Cc: linux-aspeed@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
---
First sent on 2020-09-07.
Feel free to fix the Kconfig warning some other way...

 drivers/gpu/drm/aspeed/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20201009.orig/drivers/gpu/drm/aspeed/Kconfig
+++ linux-next-20201009/drivers/gpu/drm/aspeed/Kconfig
@@ -3,6 +3,7 @@ config DRM_ASPEED_GFX
 	tristate "ASPEED BMC Display Controller"
 	depends on DRM && OF
 	depends on (COMPILE_TEST || ARCH_ASPEED)
+	depends on MMU
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DMA_CMA if HAVE_DMA_CONTIGUOUS
