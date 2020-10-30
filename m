Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E45E29FED1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgJ3Hmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgJ3HlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:05 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF052415A;
        Fri, 30 Oct 2020 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043664;
        bh=fDqsojMQXaXU2zybp/ZgveYNlutB+XD1RHDYBF/LUWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDApKqsYH5zqyZRq+2HZrxIJKm6kdo+nIu+SatK1lr5dB99Dd8x2s34S9n+q8XJry
         kIN9fGgRW0f62Fp5+VgWjWtW0rX2J51nXS3eUSR0LahmJnyDIFHql4vYWUrKQIdzG6
         ss/ems9Wt8KGFw+onEqPJCQB6m57E/MHbMr9RpWk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1x-004Ogt-WA; Fri, 30 Oct 2020 08:41:02 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rodolfo Giometti <giometti@linux.it>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 36/39] docs: ABI: sysfs-c2port: remove a duplicated entry
Date:   Fri, 30 Oct 2020 08:40:55 +0100
Message-Id: <4ea2b31ddc76161fbae004f2f2ed91dfb757703f.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As warned by scripts/get_abi.pl:
	Warning: /sys/class/c2port/c2portX/flash_erase is defined 2 times:  Documentation/ABI/testing/sysfs-c2port:60  Documentation/ABI/testing/sysfs-c2port:68

This entry was added twice at the same patch. Probalby a
cut-and paste issue.

Fixes: 4e17e1db9647 ("Add c2 port support")

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-c2port | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-c2port b/Documentation/ABI/testing/sysfs-c2port
index 716cffc457e9..f7b8cf6e4398 100644
--- a/Documentation/ABI/testing/sysfs-c2port
+++ b/Documentation/ABI/testing/sysfs-c2port
@@ -66,13 +66,6 @@ Description:
 		the "erase" command on the on-board flash of the connected
 		micro.
 
-What:		/sys/class/c2port/c2portX/flash_erase
-Date:		October 2008
-Contact:	Rodolfo Giometti <giometti@linux.it>
-Description:
-		The /sys/class/c2port/c2portX/flash_erase file show the
-		on-board flash size of the connected micro.
-
 What:		/sys/class/c2port/c2portX/reset
 Date:		October 2008
 Contact:	Rodolfo Giometti <giometti@linux.it>
-- 
2.26.2

