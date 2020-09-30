Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9054027E956
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgI3NTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728270AbgI3NTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:19:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C11420738;
        Wed, 30 Sep 2020 13:19:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kNc0n-002M79-57; Wed, 30 Sep 2020 09:19:13 -0400
Message-ID: <20200930131845.346190751@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 30 Sep 2020 09:18:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: A couple of fixes for 5.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/urgent

Head SHA1: b40341fad6cc2daa195f8090fd3348f18fff640a


Steven Rostedt (VMware) (2):
      tracing: Fix trace_find_next_entry() accounting of temp buffer size
      ftrace: Move RCU is watching check after recursion check

----
 kernel/trace/ftrace.c |  6 ++----
 kernel/trace/trace.c  | 10 ++++++----
 2 files changed, 8 insertions(+), 8 deletions(-)
