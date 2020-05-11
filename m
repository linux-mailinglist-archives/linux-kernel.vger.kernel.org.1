Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A2D1CE5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbgEKUnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 16:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731912AbgEKUnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:43:03 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1A9A20752;
        Mon, 11 May 2020 20:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589229783;
        bh=IELFRTK7HzHvdTKRU1swiKNrpZjsyvk2PavKChy8MRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0806oV9ItZvs/GIQngJuNjwDPIHQXyUVeZ4EL2ZGOiTpCE4KQAwjNJqt4RrgOGJf
         dfdLurY9VeRcNhBKnMPDuI41rRooqq+7yW0dOjhRw6+wof4bvy9kDvygqZqKln+AoO
         q20MSdkwNn+SrqLgqYwdcypu7VTahyZCNYa+PZr8=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH v5 18/18] linux/compiler.h: Remove redundant '#else'
Date:   Mon, 11 May 2020 21:41:50 +0100
Message-Id: <20200511204150.27858-19-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511204150.27858-1-will@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '#else' clause after checking '#ifdef __KERNEL__' is empty in
linux/compiler.h, so remove it.

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/compiler.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index d21a823e73c6..741c93c62ecf 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -318,8 +318,6 @@ unsigned long read_word_at_a_time(const void *addr)
 	return *(unsigned long *)addr;
 }
 
-#else
-
 #endif /* __KERNEL__ */
 
 /*
-- 
2.26.2.645.ge9eca65c58-goog

