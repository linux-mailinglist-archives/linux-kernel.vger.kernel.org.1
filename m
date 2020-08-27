Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591482544EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 14:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgH0MYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 08:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbgH0MF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:05:27 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFBFC207F7;
        Thu, 27 Aug 2020 10:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598525648;
        bh=kvzTJa+NwN8iQ7TDAjUBOUhTffu2W6eeI3qd7QRV89I=;
        h=From:To:Cc:Subject:Date:From;
        b=GF4UTlLOSoie6hxYuCLTVxOzpi2eX6PyIZIoVzbElI+LcEx+UEqs8Vbg/bNvjPfVY
         0ovpIAWW9TEGEel9GBBHXCW2C3lwLAt+RsSEa4IK6cu93qX4pQTRvJfmmhCyOP3394
         bc9c8Y/qqjXyV9oBrqkohQWA6tMhBiTgBxfrW99U=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brooke Basile <brookebasile@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] docs: process: Add cross-link to security-bugs
Date:   Thu, 27 Aug 2020 12:53:18 +0200
Message-Id: <20200827105319.9734-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The submitting patches mentions criteria for a fix to be called
"security fix".  Add a link to document explaining the entire process
of handling security bugs.

Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/process/submitting-patches.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 5219bf3cddfc..d5b3c5a74d5d 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -299,7 +299,8 @@ sending him e-mail.
 If you have a patch that fixes an exploitable security bug, send that patch
 to security@kernel.org.  For severe bugs, a short embargo may be considered
 to allow distributors to get the patch out to users; in such cases,
-obviously, the patch should not be sent to any public lists.
+obviously, the patch should not be sent to any public lists. See also
+:ref:`Documentation/admin-guide/security-bugs.rst <security-bugs>`.
 
 Patches that fix a severe bug in a released kernel should be directed
 toward the stable maintainers by putting a line like this::
-- 
2.17.1

