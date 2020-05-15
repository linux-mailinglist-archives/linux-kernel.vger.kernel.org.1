Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CA51D4E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 14:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgEOMyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 08:54:38 -0400
Received: from [66.170.99.2] ([66.170.99.2]:33594 "EHLO
        sid-build-box.eng.vmware.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbgEOMyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:54:37 -0400
Received: by sid-build-box.eng.vmware.com (Postfix, from userid 1000)
        id 3F1DABA20C5; Fri, 15 May 2020 18:24:37 +0530 (IST)
From:   Siddharth Chandrasekaran <csiddharth@vmware.com>
To:     gregkh@linuxfoundation.org
Cc:     srostedt@vmware.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, srivatsab@vmware.com, csiddharth@vmware.com,
        siddharth@embedjournal.com, dchinner@redhat.com,
        darrick.wong@oracle.com, srivatsa@csail.mit.edu
Subject: [PATCH v2] Backport xfs security fix to 4.9 and 4.4 stable trees 
Date:   Fri, 15 May 2020 18:24:11 +0530
Message-Id: <cover.1589544531.git.csiddharth@vmware.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Lack of proper validation that cached inodes are free during allocation can,
cause a crash in fs/xfs/xfs_icache.c (refer: CVE-2018-13093). To address this
issue, I'm backporting upstream commit [1] to 4.4 and 4.9 stable trees
(a backport of [1] to 4.14 already exists).

Also, commit [1] references another commit [2] which added checks only to
xfs_iget_cache_miss(). In this patch, those checks have been moved into a
dedicated checker method and both xfs_iget_cache_miss() and
xfs_iget_cache_hit() are made to call that method. This code reorg in commit
[1], makes commit [2] redundant in the history of the 4.9 and 4.4 stable
trees. So commit [2] is not being backported.

-- Sid

[1]: afca6c5b2595 ("xfs: validate cached inodes are free when allocated")
[2]: ee457001ed6c ("xfs: catch inode allocation state mismatch corruption")

change log:
v2:
 - Reword cover letter.
 - Fix accidental worong patch that got mailed.

-- 
2.7.4

