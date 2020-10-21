Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80DF294C58
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442262AbgJUMRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411465AbgJUMRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:17:31 -0400
Received: from mail.kernel.org (ip5f5ad5a8.dynamic.kabel-deutschland.de [95.90.213.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB6C22224B;
        Wed, 21 Oct 2020 12:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603282650;
        bh=8mKeoT70W2C80dpgS/0uhSrxkN5L//sEcSOYWAnufuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Zo/zOlOzUxTV6fY0xDyQRg6scPQrOVwn4rcsKAWMKvMIP/kKb9sA5IACgoiMQx8x
         xbm2L0QUelhmru//nBYzokq2SUnAMVhroaBO4oxl0VYfIZ5XXPvezXJ9j4NxZGGljM
         x9U9lpXKEOJ/bgwpx1tKJE3NIioD4CV2vUYPv0ds=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kVD3Y-001U2j-Hj; Wed, 21 Oct 2020 14:17:28 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        David Sterba <dsterba@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] docs: fs: api-summary.rst: get rid of kernel-doc include
Date:   Wed, 21 Oct 2020 14:17:27 +0200
Message-Id: <6db2c1901e5a7061de9507c8be1d2a1deae382d2.1603282193.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603282193.git.mchehab+huawei@kernel.org>
References: <cover.1603282193.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The direct-io.c file used to have just two exported symbols:

	- dio_end_io()
	- __blockdev_direct_IO()

The first one was removed by changeset
c33fe275b530 ("fs: remove no longer used dio_end_io()")

And the last one is used on most places indirectly, via
the inline macro blockdev_direct_IO() provided by fs.h.
Yet, neither the macro or the function have kernel-doc
markups.

So, drop the inclusion of fs/direct-io.c at the docs.

Fixes: c33fe275b530 ("fs: remove no longer used dio_end_io()")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/api-summary.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/filesystems/api-summary.rst b/Documentation/filesystems/api-summary.rst
index bbb0c1c0e5cf..a94f17d9b836 100644
--- a/Documentation/filesystems/api-summary.rst
+++ b/Documentation/filesystems/api-summary.rst
@@ -86,9 +86,6 @@ Other Functions
 .. kernel-doc:: fs/dax.c
    :export:
 
-.. kernel-doc:: fs/direct-io.c
-   :export:
-
 .. kernel-doc:: fs/libfs.c
    :export:
 
-- 
2.26.2

