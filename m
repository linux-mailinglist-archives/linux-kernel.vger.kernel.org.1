Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3312526E6CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgIQUfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:35:52 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52557 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726192AbgIQUfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:35:52 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 16:35:51 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 06AF95C01B6;
        Thu, 17 Sep 2020 16:27:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 17 Sep 2020 16:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:reply-to:mime-version
        :content-transfer-encoding; s=fm1; bh=OgM+VF1MUscTM176XDGGZc3l3g
        r9Nz8gshk7U7FB/5c=; b=fcyv2HJLCiceEQXgNvAJS/jvaz6H2AFqYnzMSADXyB
        k0r8QYAbCvRhAVaFcZAq7NbLQTlNJwTMaJNZOictdMPi4uuUFT+O8QyGSx4ryjyc
        6TdMGoxwYVk3opHKOHkBBtBVsf6mkcZbLDg+7pojFqjm+371rMWNKKOkEEpyBfEJ
        cHUzJl/GRhtdVxSyPdBHjI8eKUEUZtJ+IG/hcDkWg2XNBfEL0xi6U75PO5DtBsx/
        Bp+/a0kUG1w/XjxDjS+IXeHwg5azTC+nrnZCjzaYu1Tz3LeIo8TzfMtZS2jLNkAj
        sQvWMPsorKSBbLBTwAtVQhwSkONW+KbUvlW4gRXDiCSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:reply-to:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=OgM+VF
        1MUscTM176XDGGZc3l3gr9Nz8gshk7U7FB/5c=; b=CzR8aukLuvb1RHmYqBsg7R
        Fgp0yw4zZ5OQdujDFdzTSGcwOFg9Lzt3EbV3NXsZvBxUPSZy2Yl1hZ8apSdpVeUE
        geIYvzrfV7gscwCO96PEfTRIQeCXl17q16Kd9rsy4hxSxSK6SFZQa+IDlQN1kVWv
        SsX/q7MbnHZS9vujaoynJ4GGHCTRudSK6QXNTYlRmE+8DzReymcc7EoyKY+LNWyq
        TRX+B+fv3EkpK5O3uzVcffr4K99YqaslMTkpA/nkDPt1xaHqIfO6z5vCi3EjLu7Z
        Mj4Yz/wysXnG/hK2b03FRBx3tvT4DyOVTvv/DGh6Ui0+06q8Or7CNjgW9rxw9ZZQ
        ==
X-ME-Sender: <xms:zsZjXwlEIEC-X8G9-s2V9_8VJovX_jYM1up8PVjx0G83TgyIcXz2tQ>
    <xme:zsZjX_0pHxn0tNfuEM1LX6Gep6Pbf7LYrhQ0qy3qIZKWRM3yyh8_nyeXX6qu8mPaQ
    HbgQheaExK4HzxIdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeggdduheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfforhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepgfellefhvd
    eitdehffejheelgfehtdevheejhffgledtieehtdejffefveeijeehnecukfhppeduvddr
    geeirddutdeirdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:zsZjX-qGmsSqmol3y0ailwqclKjyyh9pdLOqjCzwxUnEoN9kThytkQ>
    <xmx:zsZjX8kZnRvIXwQQeiJt10Gt7ZvdPDZj3C8gxJN6VO5IGc8giB8BHw>
    <xmx:zsZjX-1Unjb4Yqqoo4Ek0ibFyjqLI51aQ5Fx7yEkE73Rznm3JMJBSg>
    <xmx:z8ZjXzwl0Z7tjTDEWlkEoPw3waGw_u1yz55qv4E8Qxf58ogHnOI4uQ>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id E9CF53064683;
        Thu, 17 Sep 2020 16:27:57 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH] mm/migrate: correct thp migration stats.
Date:   Thu, 17 Sep 2020 16:27:29 -0400
Message-Id: <20200917202729.1460743-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

PageTransHuge returns true for both thp and hugetlb, so thp stats was
counting both thp and hugetlb migrations. Exclude hugetlb migration by
setting is_thp variable right.

Fixes: 1a5bae25e3cf ("mm/vmstat: add events for THP migration without split")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 941b89383cf3..d1ad964165e5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1445,7 +1445,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			 * Capture required information that might get lost
 			 * during migration.
 			 */
-			is_thp = PageTransHuge(page);
+			is_thp = PageTransHuge(page) && !PageHuge(page);
 			nr_subpages = thp_nr_pages(page);
 			cond_resched();
 
-- 
2.28.0

