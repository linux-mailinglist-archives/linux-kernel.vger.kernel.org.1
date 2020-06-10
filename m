Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2908A1F5531
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 14:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgFJMv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 08:51:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35308 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbgFJMvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:51:55 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jj0Cv-0004Xc-VX; Wed, 10 Jun 2020 12:51:54 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] .clang-format: update column limit
Date:   Wed, 10 Jun 2020 14:51:47 +0200
Message-Id: <20200610125147.2782142-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The provided clang-format file wraps at 80 chars. If noone minds I'd like
to adjust this limit to 100 similar to what checkpatch (cf. [1]) uses now.

[1]: commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index a0a96088c74f..2b314a14a658 100644
--- a/.clang-format
+++ b/.clang-format
@@ -52,7 +52,7 @@ BreakConstructorInitializersBeforeComma: false
 #BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
 BreakAfterJavaFieldAnnotations: false
 BreakStringLiterals: false
-ColumnLimit: 80
+ColumnLimit: 100
 CommentPragmas: '^ IWYU pragma:'
 #CompactNamespaces: false # Unknown to clang-format-4.0
 ConstructorInitializerAllOnOneLineOrOnePerLine: false

base-commit: abfbb29297c27e3f101f348dc9e467b0fe70f919
-- 
2.27.0

