Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993FE1F6876
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 15:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFKNAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 09:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgFKNAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:00:03 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A23EB20760;
        Thu, 11 Jun 2020 13:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591880403;
        bh=SiWEIuDwccQFA0WHZIHqDuo/VrtYMBlSulJ0fd6R69o=;
        h=From:To:Cc:Subject:Date:From;
        b=ZX7C/Xcm6IPa0jhffV29qW0gcKeRM1AxZVSXLxu5TZ32khfnyVmKhoYqKOzvL1hMy
         IcPp37xJX2DYxqQwpHXL5rFlSg18HbpoqJeZMIMQUgMT6yg0fzLy+RDKZY1WB5D5MM
         AM2XW2RzIJkbxcCwCTXj74xfwnBbi+SB91e7F5r8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, Matteo Croce <mcroce@redhat.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] checkpatch.pl: perform commit ID check from external to git folder
Date:   Thu, 11 Jun 2020 15:59:57 +0300
Message-Id: <20200611125957.1993741-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The execution of scripts/checkpatch.pl in folder outside of git produces
complains about invalid commit ID, despite having valid one.

➜  /tmp /home/leonro/src/kernel/scripts/checkpatch.pl \
	--root=/home/leonro/src/kernel \
	--color=always \
	--summary-file /tmp/0001-RDMA-core-Annotate-CMA-unlock-helper-routine.patch

WARNING: Unknown commit id 'e83f195aa45c', maybe rebased or not pulled?
Fixes: e83f195aa45c ("RDMA/cm: Pull duplicated code into cm_queue_work_unlock()")

/tmp/0001-RDMA-core-Annotate-CMA-unlock-helper-routine.patch total: 0 errors, 1 warnings, 7 lines checked

Fixes: a8dd86bf7462 ("checkpatch.pl: warn on invalid commit id")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index eac40f0abd56..286bc78dc6fc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -966,7 +966,7 @@ sub seed_camelcase_includes {
 sub git_commit_info {
 	my ($commit, $id, $desc) = @_;

-	return ($id, $desc) if ((which("git") eq "") || !(-e ".git"));
+	return ($id, $desc) if ((which("git") eq "") || !(-e "$root/.git"));

 	my $output = `${git_command} log --no-color --format='%H %s' -1 $commit 2>&1`;
 	$output =~ s/^\s*//gm;
--
2.26.2

