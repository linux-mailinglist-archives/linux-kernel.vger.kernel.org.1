Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB10C1A4AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 21:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgDJTlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 15:41:32 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36243 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726783AbgDJTl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:41:29 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:39:39 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 68E18B2D1A;
        Fri, 10 Apr 2020 15:39:43 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 36/36] objtool: mcount: Remove wordsized endian wrappers
Date:   Fri, 10 Apr 2020 12:35:59 -0700
Message-ID: <a08788c1bcb5a0a67906b15cf68a936ed48bc970.1586468801.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1586468801.git.mhelsley@vmware.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that they're no longer used we can remove these endian wrappers.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 63 ------------------------------------
 1 file changed, 63 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 50834b065e16..fd66e26f21a8 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -149,53 +149,6 @@ static int make_nop_arm64(struct section *txts, size_t const offset)
 	return 0;
 }
 
-/* w8rev, w8nat, ...: Handle endianness. */
-
-static uint64_t w8rev(uint64_t const x)
-{
-	return   ((0xff & (x >> (0 * 8))) << (7 * 8))
-	       | ((0xff & (x >> (1 * 8))) << (6 * 8))
-	       | ((0xff & (x >> (2 * 8))) << (5 * 8))
-	       | ((0xff & (x >> (3 * 8))) << (4 * 8))
-	       | ((0xff & (x >> (4 * 8))) << (3 * 8))
-	       | ((0xff & (x >> (5 * 8))) << (2 * 8))
-	       | ((0xff & (x >> (6 * 8))) << (1 * 8))
-	       | ((0xff & (x >> (7 * 8))) << (0 * 8));
-}
-
-static uint32_t w4rev(uint32_t const x)
-{
-	return   ((0xff & (x >> (0 * 8))) << (3 * 8))
-	       | ((0xff & (x >> (1 * 8))) << (2 * 8))
-	       | ((0xff & (x >> (2 * 8))) << (1 * 8))
-	       | ((0xff & (x >> (3 * 8))) << (0 * 8));
-}
-
-static uint32_t w2rev(uint16_t const x)
-{
-	return   ((0xff & (x >> (0 * 8))) << (1 * 8))
-	       | ((0xff & (x >> (1 * 8))) << (0 * 8));
-}
-
-static uint64_t w8nat(uint64_t const x)
-{
-	return x;
-}
-
-static uint32_t w4nat(uint32_t const x)
-{
-	return x;
-}
-
-static uint32_t w2nat(uint16_t const x)
-{
-	return x;
-}
-
-static uint64_t (*w8)(uint64_t);
-static uint32_t (*w)(uint32_t);
-static uint32_t (*w2)(uint16_t);
-
 /* Names of the sections that could contain calls to mcount. */
 static int is_mcounted_section_name(char const *const txtname)
 {
@@ -579,22 +532,12 @@ static int do_file(char const *const fname)
 		goto out;
 	}
 
-	w = w4nat;
-	w2 = w2nat;
-	w8 = w8nat;
 	switch (lf->ehdr.e_ident[EI_DATA]) {
-		static unsigned int const endian = 1;
 	default:
 		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
 			lf->ehdr.e_ident[EI_DATA], fname);
 		goto out;
 	case ELFDATA2LSB:
-		if (*(unsigned char const *)&endian != 1) {
-			/* objtool is big endian, file.o is little endian. */
-			w = w4rev;
-			w2 = w2rev;
-			w8 = w8rev;
-		}
 		ideal_nop4_arm = ideal_nop4_arm_le;
 		bl_mcount_arm = bl_mcount_arm_le;
 		push_arm = push_arm_le;
@@ -602,12 +545,6 @@ static int do_file(char const *const fname)
 		push_bl_mcount_thumb = push_bl_mcount_thumb_le;
 		break;
 	case ELFDATA2MSB:
-		if (*(unsigned char const *)&endian != 0) {
-			/*  objtool is little endian, file.o is big endian. */
-			w = w4rev;
-			w2 = w2rev;
-			w8 = w8rev;
-		}
 		ideal_nop4_arm = ideal_nop4_arm_be;
 		bl_mcount_arm = bl_mcount_arm_be;
 		push_arm = push_arm_be;
-- 
2.20.1

