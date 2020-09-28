Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD8F27AEAC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 15:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgI1NGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 09:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1NGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 09:06:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CBBC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 06:06:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrewsh)
        with ESMTPSA id 0DFA529A5F5
From:   Andrej Shadura <andrew.shadur@collabora.co.uk>
To:     linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] mailmap: add Andrej Shadura
Date:   Mon, 28 Sep 2020 15:06:21 +0200
Message-Id: <20200928130621.449023-1-andrew.shadur@collabora.co.uk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrej Shadura <andrew.shadura@collabora.co.uk>

Add a mapping for my old work email for BelDisplayTech to the personal
email, and make sure the Collabora email has the correct spelling
of the first name.

Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index a780211468e4..392c3dc2f98b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -35,6 +35,8 @@ Al Viro <viro@zenIV.linux.org.uk>
 Andi Kleen <ak@linux.intel.com> <ak@suse.de>
 Andi Shyti <andi@etezian.org> <andi.shyti@samsung.com>
 Andreas Herrmann <aherrman@de.ibm.com>
+Andrej Shadura <andrew.shadura@collabora.co.uk>
+Andrej Shadura <andrew@shadura.me> <andrew@beldisplaytech.com>
 Andrew Morton <akpm@linux-foundation.org>
 Andrew Murray <amurray@thegoodpenguin.co.uk> <amurray@embedded-bits.co.uk>
 Andrew Murray <amurray@thegoodpenguin.co.uk> <andrew.murray@arm.com>
-- 
2.25.1

