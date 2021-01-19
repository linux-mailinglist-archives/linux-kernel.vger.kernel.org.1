Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54F72FB8A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393350AbhASN2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 08:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392468AbhASNSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:18:35 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C1DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:17:33 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 43E8B1F451B8
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] xor-neon: Remove GCC warn & pragmas
Date:   Tue, 19 Jan 2021 15:17:22 +0200
Message-Id: <20210119131724.308884-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

In v4 a Clang-specific vectorization warning was added at
Arnd suggestion.

This series does not address the Clang vectorize not working
bug itself which is a known pre-existing issued documented
at [1] [2] [3]. Clang vectorization needs to be investigated
in more deepth and fixed separately. The purpouse of this is
to only fix some low-hanging-fruit GCC related isues.

Tested on next-20210118 using GCC 10.2.0 and Clang 10.0.1.

[1] https://bugs.llvm.org/show_bug.cgi?id=40976
[2] https://github.com/ClangBuiltLinux/linux/issues/503
[3] https://github.com/ClangBuiltLinux/linux/issues/496

Kind regards,
Adrian

Adrian Ratiu (1):
  arm: lib: xor-neon: move pragma options to makefile

Nathan Chancellor (1):
  arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning

 arch/arm/lib/Makefile   |  2 +-
 arch/arm/lib/xor-neon.c | 18 +++++-------------
 2 files changed, 6 insertions(+), 14 deletions(-)

-- 
2.30.0

