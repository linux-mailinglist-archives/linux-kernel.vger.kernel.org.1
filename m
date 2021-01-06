Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139BD2EC24E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbhAFRco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:32:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbhAFRcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B2E82313F;
        Wed,  6 Jan 2021 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954282;
        bh=JYj2LMs+gMqMyW1HIgcQJ2iOrX/fCVoIDJLCEp5uIyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YxhT6ZriFimMCWqVLJm0YRM+CafiywS4T/dPQ4yoCwlRvfrNrtqr6+qaFI9s/dB9F
         cv9oXhhNpeGjzF1x8H/CzP4Vkg+2FTOte6eq/ksjblcNqSqqbeIwGWSYNV/z6Nl2iW
         Xpx3qcLD3xKgvCrr42MErjpQTM5HHHDIlBATPxIezVIIcyaH1t8TUQbab0UtiBixjR
         BhD72SCqBCJTlu0So9VezNDx3Z8GBZoK1RlVsfQYSZaIFRvV09ZPct9TC0g6+VgVfK
         8ePpcVQ7JPDkYkpF/NHU5+u3XnRgeUeY6fsKUwpwF5nu3q98G3t5Pb0cIs5er97+ed
         fqU0KnE4xlIXw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/18] torture: Enable torture.sh argument checking
Date:   Wed,  6 Jan 2021 09:31:08 -0800
Message-Id: <20210106173119.23159-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit uncomments the argument checking for the --duration argument
to torture.sh.  While in the area, it also corrects the duration units
from seconds to minutes.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index e13dacf..8e66797 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -157,17 +157,17 @@ do
 		fi
 		;;
 	--duration)
-		# checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(s\|m\|h\|d\|\)$' '^error'
-		mult=60
-		if echo "$2" | grep -q 's$'
+		checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(m\|h\|d\|\)$' '^error'
+		mult=1
+		if echo "$2" | grep -q 'm$'
 		then
 			mult=1
 		elif echo "$2" | grep -q 'h$'
 		then
-			mult=3600
+			mult=60
 		elif echo "$2" | grep -q 'd$'
 		then
-			mult=86400
+			mult=1440
 		fi
 		ts=`echo $2 | sed -e 's/[smhd]$//'`
 		duration_base=$(($ts*mult))
-- 
2.9.5

