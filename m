Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753061B4A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 18:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgDVQ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 12:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDVQ1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:27:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B2C82076E;
        Wed, 22 Apr 2020 16:27:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jRIE2-000O3m-AS; Wed, 22 Apr 2020 12:27:50 -0400
Message-Id: <20200422162539.808362933@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 12:25:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        jpoimboe@redhat.com, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, jthierry@redhat.com, alexandre.chartre@oracle.com
Subject: [PATCH 0/3] x86/ftrace: Make created trampolines not call direct code
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

These three patches are built on top of your patch series.

This is what I was thinking of having. This isn't fully tested
(as your patch series is still running on my test suite).

-- Steve


Steven Rostedt (VMware) (3):
      x86/ftrace: Make non direct case the default in ftrace_regs_caller
      x86/ftrace: Only have the builtin ftrace_regs_caller call direct hooks
      x86/ftrace: Do not jump to direct code in created trampolines

----
 arch/x86/kernel/ftrace.c    | 14 +++++++++++---
 arch/x86/kernel/ftrace_64.S | 29 ++++++++++++++---------------
 kernel/trace/ftrace.c       |  8 ++++++++
 3 files changed, 33 insertions(+), 18 deletions(-)
