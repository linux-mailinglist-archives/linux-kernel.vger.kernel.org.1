Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007E91F778F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 13:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFLL4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 07:56:30 -0400
Received: from sym2.noone.org ([178.63.92.236]:40482 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgFLL4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 07:56:30 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49jzhr5Jnbzvjc1; Fri, 12 Jun 2020 13:56:28 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: Free memory in error case in special_get_alts
Date:   Fri, 12 Jun 2020 13:56:28 +0200
Message-Id: <20200612115628.8992-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a memory leak in case get_alt_entry returns an error.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/objtool/special.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index e74e0189de22..f6f7dee1ba77 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -188,8 +188,10 @@ int special_get_alts(struct elf *elf, struct list_head *alts)
 			memset(alt, 0, sizeof(*alt));
 
 			ret = get_alt_entry(elf, entry, sec, idx, alt);
-			if (ret)
+			if (ret) {
+				free(alt);
 				return ret;
+			}
 
 			list_add_tail(&alt->list, alts);
 		}
-- 
2.27.0

