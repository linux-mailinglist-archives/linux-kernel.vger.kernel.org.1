Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F91AAF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416446AbgDORMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410715AbgDORK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:10:59 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D82BA21D7E;
        Wed, 15 Apr 2020 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970659;
        bh=WED0g8p0VyucPsEGiI66uD3UYudFeJSY415JzZLv8Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qxIw+Zx/ct1YPIg20lIHBBg3MKTgzwGJ7fNdBKuq5TRtu36drSJfW8kTs/yxeUXLu
         YEyuPtKsgHG5bs1kFACaPG/q4bUucCMyF5JycXMRfXRXDJbtZHRL0LVwU6/9BlYWFR
         DrycPIpYxFh6GNsoqzt8/SHZ2And77cZ2kKBoU8w=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/19] drm: Make drm_dp_mst_dsc_aux_for_port() safe for old compilers
Date:   Wed, 15 Apr 2020 10:10:44 -0700
Message-Id: <20200415171054.9013-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Older compilers either want two extra pairs of curly braces around the
initializer for local variable desc, or they want a single pair of curly
braces with nothing inside.  Because current Linux-kernel practice favors
the latter, this commit makes it so.

Suggested-by: Chris Wilson <chris@chris-wilson.co.uk>
Suggested-by: Joe Perches <joe@perches.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 70c4b7a..c409867 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -5494,7 +5494,7 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
 {
 	struct drm_dp_mst_port *immediate_upstream_port;
 	struct drm_dp_mst_port *fec_port;
-	struct drm_dp_desc desc = { 0 };
+	struct drm_dp_desc desc = { };
 	u8 endpoint_fec;
 	u8 endpoint_dsc;
 
-- 
2.9.5

