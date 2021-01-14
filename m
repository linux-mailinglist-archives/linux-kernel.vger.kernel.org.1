Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94372F6D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbhANVbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:31:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbhANVbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:31:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35C8523977;
        Thu, 14 Jan 2021 21:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610659825;
        bh=h8P7pkHW9enuPNWSJCLbaVlV9uAnMB00zjxhwDU+PqA=;
        h=From:To:Cc:Subject:Date:From;
        b=tQNkbEvxLFPw5FoBp/nUfgnpQeUHoD7rTUMpGX7Qz11m6B6KVT4ZSqjk54iobrWyF
         6V9HTeFO4i8XBoUCIjF9fRGXt4Pae9tWLguMcMBakFEtp+PNYUtgeCok0oCuOtEbqH
         zndAFzox6Wg30xzRxG7i+m/ivNfs5iCgjiRkUeHVTDAyGN+pOu24/szSjoqRbxEKvW
         Eecl2SFrbo2Bolr8F1huq89l938kE1tk5GleGaf3liMDcXYh+duSQ2A4K/q/6jItUB
         kwYWGN2WZTcbgrwxNyCM1L4FeQvpqDq/1XXexXWnNw/fOTuvcXfmoMuzPzgQFBvkqo
         GGjz+RBMtaTWQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Richard Weinberger <richard@nod.at>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wang Hai <wanghai38@huawei.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] ubifs: replay: Fix high stack usage, again
Date:   Thu, 14 Jan 2021 22:30:11 +0100
Message-Id: <20210114213020.4108485-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

An earlier commit moved out some functions to not be inlined by gcc, but
after some other rework to remove one of those, clang started inlining
the other one and ran into the same problem as gcc did before:

fs/ubifs/replay.c:1174:5: error: stack frame size of 1152 bytes in function 'ubifs_replay_journal' [-Werror,-Wframe-larger-than=]

Mark the function as noinline_for_stack to ensure it doesn't happen
again.

Fixes: f80df3851246 ("ubifs: use crypto_shash_tfm_digest()")
Fixes: eb66eff6636d ("ubifs: replay: Fix high stack usage")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ubifs/replay.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 79801c9a5b87..0f8a6a16421b 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -559,7 +559,9 @@ static int is_last_bud(struct ubifs_info *c, struct ubifs_bud *bud)
 }
 
 /* authenticate_sleb_hash is split out for stack usage */
-static int authenticate_sleb_hash(struct ubifs_info *c, struct shash_desc *log_hash, u8 *hash)
+static int noinline_for_stack
+authenticate_sleb_hash(struct ubifs_info *c,
+		       struct shash_desc *log_hash, u8 *hash)
 {
 	SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
 
-- 
2.29.2

