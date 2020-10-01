Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5B280874
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbgJAU1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:27:40 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:44033 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726855AbgJAU1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:27:40 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2020 16:27:39 EDT
Received: from cust-43cce789 ([IPv6:fc0c:c1a4:736c:9c1a:15d2:fd0f:664c:4844])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id O540kayi6v4gEO541kJ5Bj; Thu, 01 Oct 2020 22:20:32 +0200
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] locking/atomics: Check atomic-arch-fallback.h too
Date:   Thu,  1 Oct 2020 22:20:28 +0200
Message-Id: <20201001202028.1048418-1-pebolle@tiscali.nl>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfL1KVqYyXbaX7zO+ws9qUDccFqqq77NrLS9AfUC/2WCehb0rvzjAfe57HphD0vBSfJAFMLRpZn9lbCIGhYiypkKlTrrHVee4BwVsRPeL67pJS33IigwY
 wlQ7t9kmH+i7tzhnF3EHxB4hnNp8rPyQmEA/X5oisyVl6UL8OOCrHt9S3Wo/z9jBVss2nQd+BpKkTY3dY1IxD7jjZm19brT+rJVOfkKJNiDjZuswlU/Vuy0a
 aIHI0DHj5S8gBrgpdLyUXKEbidZGDl5r4yo1eeF/rWFhHi0R5TBrb3SHb4ET//vuqQjAUfMCrBvPTGas+ded1VMJ+qRDP9gHxhZQ8Si4DuRODfYeIVjvAsX4
 9fAoMPMJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sha1sum of include/linux/atomic-arch-fallback.h isn't checked by
check-atomics.sh. It's not clear why it's skipped so let's check it too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
It seems it never has been checked. So this does cast some doubt about
the usefulness of these tests. But I'm clueless about this atomic stuff
so what do I know?

 scripts/atomic/check-atomics.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
index 8378c63a1e09..82748d42ecc5 100755
--- a/scripts/atomic/check-atomics.sh
+++ b/scripts/atomic/check-atomics.sh
@@ -16,6 +16,7 @@ fi
 cat <<EOF |
 asm-generic/atomic-instrumented.h
 asm-generic/atomic-long.h
+linux/atomic-arch-fallback.h
 linux/atomic-fallback.h
 EOF
 while read header; do
-- 
2.26.2

