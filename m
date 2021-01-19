Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556982FBCFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbhASQxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:53:19 -0500
Received: from esa10.hc324-48.eu.iphmx.com ([207.54.69.29]:32351 "EHLO
        esa10.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389514AbhASQwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:52:43 -0500
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2021 11:52:42 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1611075162; x=1642611162;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MPS69wDC3jOWHDYcJZNJkUyR3I+TbN1xtQtEplkhjf8=;
  b=J+Xe/JNPF1x1u5OaPvz4CWfjUYmTbru7853IMq+SMOgPXKVkjJlQAJlh
   ogag8fbe28Ai/R8SlW6sPBQi+jHIcg8voAXlFCz9FmJLewRpQDGL2TdbL
   Cgzc1En4MrRM6kGSMIxdlZ+LcMBsWjUPm+xJVmdCMpYFDeWHl2NV/w3V5
   Y=;
Received: from esagw4.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
 esa10.hc324-48.eu.iphmx.com with ESMTP/TLS; 19 Jan 2021 17:43:52 +0100
Received: from esabb3.muc ([160.50.100.30])  by esagw4.muc with ESMTP/TLS;
 19 Jan 2021 17:43:52 +0100
Received: from smucm10m.bmwgroup.net (HELO smucm10m.europe.bmw.corp) ([160.48.96.49])
 by esabb3.muc with ESMTP/TLS; 19 Jan 2021 17:43:52 +0100
Received: from greenhouse.bmw-carit.intra (192.168.221.38) by smucm10m.europe.bmw.corp
 (160.48.96.49) with Microsoft SMTP Server (TLS;
 Tue, 19 Jan 2021 17:43:52 +0100
From:   Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Subject: [RFC PATCH 0/2] Tracing bursts of latencies
Date:   Tue, 19 Jan 2021 17:43:42 +0100
Message-ID: <20210119164344.37500-1-Viktor.Rosendahl@bmw.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SMUCM30K.europe.bmw.corp (160.46.167.47) To
 smucm10m.europe.bmw.corp (160.48.96.49)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This series contains two things:

1. A fix for a bug in the Ftrace latency tracers that appeared with Linux 5.7.

2. The latency-collector, a tool that is designed to work around the
   limitations in the ftrace latency tracers. It needs the bug fix in order to
   work properly.

I have sent a patch series with the latency-collector before.

I never got any comments on it and I stopped pushing it because I thought that
BPF tracing would be the wave of the future and that it would solve the problem
in a cleaner and more elegant way.

Recently, I tried out the criticalstat script from bcc tools but it did not
fulfill all of my hopes and dreams.

On the bright side, it was able to capture all latencies in a burst. The main
problems that I encountered were:

1. The system became unstable and froze now and then. The man page of
   criticalstat has a mention of it being unstable, so I assume that this is a
   known problem.

2. Sometimes the stack traces were incorrect but not in an obvious way. After it
   happened once, all subsequent ones were bad.
   
3. If two instances were run simultaneously (to capture both preemptoff and irq
   off), there seemed to be a quite large performance hit but I did not measure
   this exactly.
   
4. The filesystem footprint seemed quite large. The size of libbcc seemed to be
   quite large for a small embedded system.

For these reasons, I take the liberty of resending the latency-collector again.

I would hope to get some comments regarding it, or some suggestion of an
alternative approach of how to solve the problem of being able to capture
latencies that systematically occur close to each other.

Admittedly, it may from a developer's perspective be somewhat of a niche
problem, since removing one latency will reveal the next but when one is doing
validation with a fleet of devices being tested in a long and expensive test
campaign, then it is quite desirable to not lose any latencies.

best regards,

Viktor

Viktor Rosendahl (2):
  Use pause-on-trace with the latency tracers
  Add the latency-collector to tools

 kernel/trace/trace_irqsoff.c      |    4 +
 tools/Makefile                    |   14 +-
 tools/tracing/Makefile            |   20 +
 tools/tracing/latency-collector.c | 1212 +++++++++++++++++++++++++++++
 4 files changed, 1244 insertions(+), 6 deletions(-)
 create mode 100644 tools/tracing/Makefile
 create mode 100644 tools/tracing/latency-collector.c

-- 
2.25.1

