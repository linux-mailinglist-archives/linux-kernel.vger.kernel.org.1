Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3092F31B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbhALN1k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jan 2021 08:27:40 -0500
Received: from mx1.emlix.com ([136.243.223.33]:60022 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbhALN1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:27:39 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jan 2021 08:27:39 EST
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 408DD5F7ED;
        Tue, 12 Jan 2021 14:19:37 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] Documentation: fix typos in split page table lock description
Date:   Tue, 12 Jan 2021 14:19:36 +0100
Message-ID: <2338863.uUFqZTUbry@devpool47>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 Documentation/vm/split_page_table_lock.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/vm/split_page_table_lock.rst b/Documentation/vm/split_page_table_lock.rst
index ff51f4a5494d..c08919662704 100644
--- a/Documentation/vm/split_page_table_lock.rst
+++ b/Documentation/vm/split_page_table_lock.rst
@@ -32,7 +32,7 @@ There are helpers to lock/unlock a table and other accessor functions:
 
 Split page table lock for PTE tables is enabled compile-time if
 CONFIG_SPLIT_PTLOCK_CPUS (usually 4) is less or equal to NR_CPUS.
-If split lock is disabled, all tables guaded by mm->page_table_lock.
+If split lock is disabled, all tables are guarded by mm->page_table_lock.
 
 Split page table lock for PMD tables is enabled, if it's enabled for PTE
 tables and the architecture supports it (see below).
-- 
2.29.2

-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



