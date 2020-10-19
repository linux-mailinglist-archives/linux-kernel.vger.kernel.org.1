Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2652925A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgJSKVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:21:38 -0400
Received: from mailout05.rmx.de ([94.199.90.90]:43232 "EHLO mailout05.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgJSKVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:21:36 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout05.rmx.de (Postfix) with ESMTPS id 4CFCTm6QzMz9yVq;
        Mon, 19 Oct 2020 12:21:32 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4CFCTQ21kpz2xqM;
        Mon, 19 Oct 2020 12:21:14 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.91) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 19 Oct
 2020 12:21:07 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Peter Zijlstra <peterz@infradead.org>, <tglx@linutronix.de>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: sched: system doesn't boot since  "sched: Add new migrate_disable() implementation"
Date:   Mon, 19 Oct 2020 12:21:06 +0200
Message-ID: <1654655.1jrfHnk7pZ@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.91]
X-RMX-ID: 20201019-122118-4CFCTQ21kpz2xqM-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have problems with the latest 5.9-rt releases on i.MX6ULL (!CONFIG_SMP):

-rc8-rt13 works fine
-rc8-rt14 doesn't compile (due to CONFIG_FRACE, already fixed in -rt16)
-rt15 dito.
-rt16 compiles, but doesn't boot (no console output at all)

After reverting (on -rt16)

de1c0755e6f9 ("tracing: fix compile failure on RT with PREEMPT_RT off")
30763ce6c15d ("sched: Add new migrate_disable() implementation")

the system boots fine again.

Tracking the problem down showed that calls to wait_for_completion_timeout() 
(e.g. during imx_rngc_probe) will never return. The IRQ routine which should 
fire the completion is not executed, and the call doesn't return after the 
timeout. The IRQ flag on the ARM is not set before entering 
wait_for_completion_timeout(), so CPU interrupts seem to be on.

When building with CONFIG_SMP, the system boots fine.

Any hints?

Best regards
Christian



