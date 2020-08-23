Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4A24EB15
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 06:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgHWEEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 00:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHWEEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 00:04:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DD3C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 21:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=23jrrPFyNJvlaPrF0eO0nEFnHnerjAyGE3H05xFP2tA=; b=25wTBR+nOz9OAL09z6MS0ZTsyV
        us6O0G5EF8IrkLrPK59V5JJAXCTY4bDIspfNdmQGipnJJtvdgQ4SbZyuwVc9qmgUL4LPHuRASPNfq
        NqRv+bvHCXgr6Rz3CY9alprRPGz0T8OGLfSgYskDVO3Gng+w/a+gtYR2pCNarYme/XDoJFslfnqNO
        zE9M0lc6wEYoGpSLyvg5u9uDkNWOJADYukO+TzP+cZdHlLS38eK6ds/q5UaGDSoNFTXQ4PrVaHcMB
        kTtlM2agY8rRYXDsxPppsf9iFablXAzIlMv4lWpep4iqgphjwl+heQUaDNzvsu5ocsMlj3X7QGv7Q
        +5nZkx6Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9hFI-0004om-Vn; Sun, 23 Aug 2020 04:04:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Lasse Collin <lasse.collin@tukaani.org>
Subject: [PATCH] lib: decompress_bunzip2: delete duplicated words
Date:   Sat, 22 Aug 2020 21:04:36 -0700
Message-Id: <20200823040436.25852-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "how".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Lasse Collin <lasse.collin@tukaani.org>
---
 lib/decompress_bunzip2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/lib/decompress_bunzip2.c
+++ linux-next-20200730/lib/decompress_bunzip2.c
@@ -390,7 +390,7 @@ static int INIT get_next_block(struct bu
 		j = (bd->inbufBits >> bd->inbufBitCount)&
 			((1 << hufGroup->maxLen)-1);
 got_huff_bits:
-		/* Figure how how many bits are in next symbol and
+		/* Figure how many bits are in next symbol and
 		 * unget extras */
 		i = hufGroup->minLen;
 		while (j > limit[i])
