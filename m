Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD3F2D1245
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgLGNig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:38:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgLGNig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:38:36 -0500
Date:   Mon, 7 Dec 2020 14:37:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607348275;
        bh=tpi4FrWn9qJ8WeL3TVIABxxC99KnkRW8SfGpO/EOKyw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=FqHagQBvLTKXkqWij/pjjNG5SjFuIJ0zLmVR3+PpPV50tkUGoUH+HRsOC74gjk+Vx
         b9ZPqZanKpfv9ElKKOxOsihYRA7k8qd5y3cwIuj7mS8w27TtfXHF+hEXoRUONaMj4d
         AVEmSQ+aqFpoVaCaUdAvcUCsEWzUt0DSHi7rUKFGsm7vR31HeiND0Aa8Kh6xERUHb7
         2CxuRt+bKrPwzIbyQEj5nTk42ALvLA09dvtHyHtYZbDxQSt+NrfXqsNDy1znSUnTee
         uEINEq3TzsZKGmTlF6JgfInWHR+TEo/d6leYjaRx/XoMGyn8S+JHiradKRbeJEU+gq
         pKjyiCe1UNXvw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 3/9] softirq: Move various protections into inline
 helpers
Message-ID: <20201207133752.GD122233@lothringen>
References: <20201204170151.960336698@linutronix.de>
 <20201204170805.004816169@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204170805.004816169@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:01:54PM +0100, Thomas Gleixner wrote:
> To allow reuse of the bulk of softirq processing code for RT and to avoid
> #ifdeffery all over the place, split protections for various code sections
> out into inline helpers so the RT variant can just replace them in one go.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
