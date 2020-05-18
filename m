Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F641D8B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 01:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgERXEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 19:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgERXEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:04:20 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97D012081A;
        Mon, 18 May 2020 23:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589843060;
        bh=FivWSGA5nKr+8BVNRlfId66BwqKvfngHdf0PvsDY1Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VHXwzWPUne9lNRLze2eVuRdHvkAB3cprbaBFfewEjJY46dL74bSD6c43meXBwefFz
         8Ff13vNT0YVAVYK6ZuLCiCBb/hKd8p1jjr5DR7uackt2nEf7mrkdz1hmvgIJkixlww
         eBns6vIZvKw6GHKnaVdx54+jKGUPcy+BwXaxDiHs=
From:   Will Deacon <will@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, sumit.garg@linaro.org,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        jinho lim <jordan.lim@samsung.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Alexios Zavras <alexios.zavras@intel.com>, liwei391@huawei.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] arm64: Call debug_traps_init() from trap_init() to help early kgdb
Date:   Tue, 19 May 2020 00:04:04 +0100
Message-Id: <158982068109.260335.5582031208894337234.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513160501.1.I0b5edf030cc6ebef6ab4829f8867cdaea42485d8@changeid>
References: <20200513160501.1.I0b5edf030cc6ebef6ab4829f8867cdaea42485d8@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 16:06:37 -0700, Douglas Anderson wrote:
> A new kgdb feature will soon land (kgdb_earlycon) that lets us run
> kgdb much earlier.  In order for everything to work properly it's
> important that the break hook is setup by the time we process
> "kgdbwait".
> 
> Right now the break hook is setup in debug_traps_init() and that's
> called from arch_initcall().  That's a bit too late since
> kgdb_earlycon really needs things to be setup by the time the system
> calls dbg_late_init().
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Call debug_traps_init() from trap_init() to help early kgdb
      https://git.kernel.org/arm64/c/b322c65f8ca3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
