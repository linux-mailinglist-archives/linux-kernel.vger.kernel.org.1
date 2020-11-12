Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3DC2AFC8D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgKLBi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:38:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbgKLAhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:37:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3BB922203;
        Thu, 12 Nov 2020 00:33:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kd0YR-0002Eg-NV; Wed, 11 Nov 2020 19:33:35 -0500
Message-ID: <20201112003335.623379134@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Nov 2020 19:33:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [for-next][PATCH 17/17] MAINTAINERS: assign ./fs/tracefs to TRACING
References: <20201112003244.764326960@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

A check with ./scripts/get_maintainer.pl --letters -f fs/tracefs/ shows
that the tracefs is not assigned to the TRACING section in MAINTAINERS.

Add the file pattern for the TRACING section to rectify that.

Link: https://lkml.kernel.org/r/20201109122250.31915-1-lukas.bulwahn@gmail.com

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b516bb34a8d5..5c714c19fadc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17751,6 +17751,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
 F:	Documentation/trace/ftrace.rst
 F:	arch/*/*/*/ftrace.h
 F:	arch/*/kernel/ftrace.c
+F:	fs/tracefs/
 F:	include/*/ftrace.h
 F:	include/linux/trace*.h
 F:	include/trace/
-- 
2.28.0


