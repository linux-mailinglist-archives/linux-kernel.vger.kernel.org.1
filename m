Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95442974AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbgJWQii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbgJWQds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:48 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66D8824681;
        Fri, 23 Oct 2020 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470827;
        bh=DkQPfqmarGLDfJetUgwz5TgWReIHtbqYm7uER2L8pCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FsAtcwMiQkBC5lIORYoN2TzrdIafHzX4AAHZMI+FtgxrZqmTUc5dg+LZolgd/4LTE
         Mf0MTQw4jsvOTE+oAaEfbgE5J2gfNCFxAbJqTTKPDJjUVeFkArKF1HNGARZ7z867/g
         XWet86fSunBpzPFtnwKnH8EBOAV0WlXwEasX4l4A=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00e-002AvO-LF; Fri, 23 Oct 2020 18:33:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/56] scripts: kernel-doc: fix typedef parsing
Date:   Fri, 23 Oct 2020 18:32:48 +0200
Message-Id: <d0b2146c4ced3121342583bb3d962628fc96759b.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The include/linux/genalloc.h file defined this typedef:

	typedef unsigned long (*genpool_algo_t)(unsigned long *map,unsigned long size,unsigned long start,unsigned int nr,void *data, struct gen_pool *pool, unsigned long start_addr);

Because it has a type composite of two words (unsigned long),
the parser gets the typedef name wrong:

.. c:macro:: long

   **Typedef**: Allocation callback function type definition

Fix the regex in order to accept composite types when
defining a typedef for a function pointer.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 99cd8418ff8a..311d213ee74d 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1438,7 +1438,7 @@ sub dump_typedef($$) {
     $x =~ s@/\*.*?\*/@@gos;	# strip comments.
 
     # Parse function prototypes
-    if ($x =~ /typedef\s+(\w+)\s*\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
+    if ($x =~ /typedef\s+(\w+\s*){1,}\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
 	$x =~ /typedef\s+(\w+)\s*(\w\S+)\s*\s*\((.*)\);/) {
 
 	# Function typedefs
-- 
2.26.2

