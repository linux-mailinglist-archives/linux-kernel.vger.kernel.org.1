Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1B621846E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 11:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgGHJyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 05:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgGHJyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:54:22 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DF7D20720;
        Wed,  8 Jul 2020 09:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594202062;
        bh=ViQyriT6zYMVZteZMrrOLH8UM/MooWK1S2AOhq0H7B4=;
        h=From:To:Cc:Subject:Date:From;
        b=e4NxKw9funPzs+5rOEGul7RpkEa7k+5PPpJ3RHGSgrBLwNHi7RDLflbuF3zO0Cikc
         I51jl1gdjJxV2AEhNR0qt6Vr9VbHFEH86KAtA/kpKNwTvmqJ4YJpBI7FgcM4DgMjr1
         3LFLyp/1+/owoM1+0fKyreB3RXxKnS62gtBCAuxk=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] mailmap: add entry for Mike Rapoport
Date:   Wed,  8 Jul 2020 12:54:14 +0300
Message-Id: <20200708095414.12275-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Add an entry to connect my email addresses.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
Hi Andrew,

I hope you don't mind routing this trough mm tree

Thanks,
Mike.

 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index c69d9c734fb5..2395c64c594d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -193,6 +193,9 @@ Maxime Ripard <mripard@kernel.org> <maxime.ripard@free-electrons.com>
 Mayuresh Janorkar <mayur@ti.com>
 Michael Buesch <m@bues.ch>
 Michel Dänzer <michel@tungstengraphics.com>
+Mike Rapoport <rppt@kernel.org> <mike@compulab.co.il>
+Mike Rapoport <rppt@kernel.org> <mike.rapoport@gmail.com>
+Mike Rapoport <rppt@kernel.org> <rppt@linux.ibm.com>
 Miodrag Dinic <miodrag.dinic@mips.com> <miodrag.dinic@imgtec.com>
 Miquel Raynal <miquel.raynal@bootlin.com> <miquel.raynal@free-electrons.com>
 Mitesh shah <mshah@teja.com>
-- 
2.26.2

