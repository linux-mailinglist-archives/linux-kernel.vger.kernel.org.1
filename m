Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E3126AE72
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 22:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgIOUJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 16:09:26 -0400
Received: from mail.efficios.com ([167.114.26.124]:59662 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgIOUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 16:08:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B106C29E6BB;
        Tue, 15 Sep 2020 16:08:28 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ys0kA5UKFAJc; Tue, 15 Sep 2020 16:08:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7B90C29E6BA;
        Tue, 15 Sep 2020 16:08:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7B90C29E6BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600200508;
        bh=uRifFxx51fDjZwszuX1Hpmeb9WoFn46VpGDQuzPBtu4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ULokTAloE4GdFgQV9FI1gNPYXT5NiKJTpwznGHIY/2zwq0vqtA4BK2JxT3ZbRTVQ9
         RFPAPwsSyUWLnucmjPk9Vs2pTIPursb3vHxCdZDza+BQf3y+TTWaumkmbXcb+8pdhq
         nq4YqG/0WyGi1d3G0+vK0ps7WwGGmTSZl60paO5E/ebL7myKPIzK9CxyFA577T5rmC
         aQtxCZa1QDrFNNxT0nXMSY+aed+n0eFgZ2bpGh8LAKFFtCfAT5IU5FMux8tEqoBQtX
         SkNr/ZMAWe9/Vl+Ua+0KGAm19cUapVNOeppAx3yHsAp9ialchDfkksNZO9xKMSQQfg
         Qp8YlbMzAqdmg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id w_V4XZgNHwiU; Tue, 15 Sep 2020 16:08:28 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 6D50A29E65F;
        Tue, 15 Sep 2020 16:08:28 -0400 (EDT)
Date:   Tue, 15 Sep 2020 16:08:28 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>
Message-ID: <1703212153.12161.1600200508335.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200915185541.1565837-1-posk@google.com>
References: <20200915185541.1565837-1-posk@google.com>
Subject: Re: [PATCH 1/2 v7] rseq/membarrier: add
 MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
Thread-Index: 6fJXaDeXdPkbeXecg7bBmG22vozGug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 15, 2020, at 2:55 PM, Peter Oskolkov posk@google.com wrote:
[...]
> 
> -static int membarrier_private_expedited(int flags)
> +static int membarrier_private_expedited(int flags, int cpu_id)
> {
> -	int cpu;
> 	cpumask_var_t tmpmask;
> 	struct mm_struct *mm = current->mm;
> +	smp_call_func_t ipi_func = ipi_mb;
> 
> -	if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
> +	if (flags == MEMBARRIER_FLAG_SYNC_CORE) {
> 		if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
> 			return -EINVAL;
> 		if (!(atomic_read(&mm->membarrier_state) &
> 		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY))
> 			return -EPERM;
> +	} else if (flags == MEMBARRIER_FLAG_RSEQ) {
> +		if (!IS_ENABLED(CONFIG_RSEQ))
> +			return -EINVAL;
> +		if (!(atomic_read(&mm->membarrier_state) &
> +		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY))
> +			return -EPERM;
> +		ipi_func = ipi_rseq;
> 	} else {
> +		BUG_ON(flags != 0);

Usually BUG_ON() is really for utterly unrecoverable situations, which is not the
case here. I am tempted to just use WARN_ON_ONCE(flags) instead to make dmesg
yell (once) if an unexpected flags parameter is received. This is not a user-space
input, so it should never trigger unless we change the code.

The rest looks good to me, thanks!

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
