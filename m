Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA0C1F8E57
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 08:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgFOGsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 02:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728461AbgFOGrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:14 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2F5208C7;
        Mon, 15 Jun 2020 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203632;
        bh=3Gxzi3odujNooQsOeSbFi1mnMtuTq2tKDZVxg9QIULA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vbgG0LFXB+Tkvvp78bHWEeUqp8+P9Xhps7SEeJ7dwCbSVmjCCiveFIsJq4NTOlG1V
         EA9Ien2y7gjO90cAL9FEg9YwbrNLp5tX5Ye3+UJ7BhJohT9MhSis/A7q22SVkaALK7
         8UiuO8onFOz0Jcsvq3ltdAMOVW6vE3bnpDzB8B+E=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiti-009nnk-5R; Mon, 15 Jun 2020 08:47:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 24/29] docs: fs: locking.rst: fix a broken table
Date:   Mon, 15 Jun 2020 08:47:03 +0200
Message-Id: <d07587312c105780d2833ac8be0e27ea4a6d88e9.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Sphinx:

Documentation/filesystems/locking.rst:443: WARNING: Malformed table.
Text in column margin in table line 8.

==========              =============   =================       =========
ops                     inode->i_lock   blocked_lock_lock       may block
==========              =============   =================       =========
lm_notify:              yes             yes                     no
lm_grant:               no              no                      no
lm_break:               yes             no                      no
lm_change               yes             no                      no
lm_breaker_owns_lease:  no              no                      no
==========              =============   =================       =========

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/locking.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 318605de83f3..d9116f725818 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -433,15 +433,15 @@ prototypes::
 
 locking rules:
 
-==========		=============	=================	=========
+======================	=============	=================	=========
 ops			inode->i_lock	blocked_lock_lock	may block
-==========		=============	=================	=========
+======================	=============	=================	=========
 lm_notify:		yes		yes			no
 lm_grant:		no		no			no
 lm_break:		yes		no			no
 lm_change		yes		no			no
 lm_breaker_owns_lease:	no		no			no
-==========		=============	=================	=========
+======================	=============	=================	=========
 
 buffer_head
 ===========
-- 
2.26.2

