Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC1A2FE7C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbhAUKji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbhAUKh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:37:27 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894BFC061794
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bXZfebvO2vLCGhp+r2lf7zKVLqedZP/+m93/7Wk5BBA=; b=V6+6fGMYOTHBdrgdRWp/SAkP70
        RbZQ0VcEt8pancileYZtFzlI87z5kcxP9s4wlxh9EWzLspWDH6t9SKOFXtqjUD8YjmzrCgHp3i52z
        /HsFePezMPmTQMwtVWNDZ6isTxOl5wajkOKJX9dbRBYMiuIbStpKje54hachs/gcFVHeayxk5bwEt
        VOzVuEbQHLl3EU//ViWKviA48htyJAFRQxfFcGPL0972vl5K+tClVJIyg3N6aCYzh5V4Dl7uQVMgx
        HP8otb0AUxNinyo+DXUXvcZVng8S8mj/7VhEkUFfJ1hum1Bs8nSK5mMODFLWs1QiYnVAENnI9QKmW
        Oj6n94kA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2XKN-0007Oe-Il; Thu, 21 Jan 2021 10:36:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58EBB30769C;
        Thu, 21 Jan 2021 11:36:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4A6B620C8680E; Thu, 21 Jan 2021 11:36:28 +0100 (CET)
Message-ID: <20210121101702.402798862@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 21 Jan 2021 11:17:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH -v3 0/9] sched: Fix hot-unplug regression
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some cautious optimism lets me post v3 of these patches. They (knock on wood)
fix the regression introduced by commit:

  1cf12e08bc4d ("sched/hotplug: Consolidate task migration on CPU unplug")

These patches survived overnight runs for both me and Valentin, but I'll let it
run for at least another 12 hours before committing these patches.

New in this version is patch #7.

Much thanks to Valentin for his continued support and debugging efforts.

