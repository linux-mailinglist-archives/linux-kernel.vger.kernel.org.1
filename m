Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9C9220D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 14:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbgGOMtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 08:49:07 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60282 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731347AbgGOMs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:48:59 -0400
Received: from Q.local (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 37AD3564;
        Wed, 15 Jul 2020 14:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594817337;
        bh=I4Mi3hs9NzKXoN4u5HKTknj7JJzfm1Unvue8SQk/r+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEyGvFr3RO7xu/J+6VreJBQ5ZtcQPnwEkULqvlM5kU9EIQHiCKZ3qflop0xn26IxG
         b08yppSnjuwzbnlVsFZC/yd7Ek0RD7WCFfgmLordwgA/9TobI3gcr9ynMNrjGcCWGW
         6+LnjZghY07uvepiv0f/Fv+z1fzYH+5tAp0pGUKs=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     trivial@kernel.org
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Xiong <xndchn@gmail.com>, SeongJae Park <sjpark@amazon.de>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 8/8] scripts/spelling.txt: Add descriptors correction
Date:   Wed, 15 Jul 2020 13:48:39 +0100
Message-Id: <20200715124839.252822-9-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com>
References: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After coming across the s/decriptors/descriptors/ spelling error twice,
a scan of the tree showed it was a pervasive mistake.

Update the spelling suggestions database to prevent it in both singular
and plural form.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

---
v2:
 - Use both singular and plural form.
---
 scripts/spelling.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index c45e9afaab2d..c56a6c36e6f2 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -406,6 +406,8 @@ decendants||descendants
 decompres||decompress
 decsribed||described
 decription||description
+decriptor||descriptor
+decriptors||descriptors
 dectected||detected
 defailt||default
 deferal||deferral
-- 
2.25.1

