Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95152C0486
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgKWL1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:27:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728484AbgKWL1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:27:19 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A64120720;
        Mon, 23 Nov 2020 11:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606130838;
        bh=ZbTVe8JuOPy9U3l9o4DCREiwzbJuN+/HSdayW1qd8MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0wPVosmSlMoUBxwYPKSuzzcjPzzmnO5BF6bl0jzA+85oZcqa8w6AynZ+4jAOHNOYY
         0WEerG598UqIhTdnwAq/id1sl0CVH0MqDt89a6EV14B81oWouq4UqGeTNx3dw6DmdK
         gUn6zrQ4p/7docGbZtsfWpvepqfYua5B6CRMKCBM=
From:   Will Deacon <will@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] arm64/fpsimd: add <asm/insn.h> to <asm/kprobes.h> to fix fpsimd build
Date:   Mon, 23 Nov 2020 11:27:12 +0000
Message-Id: <160612914098.1150235.14778282129098390811.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201123044510.9942-1-rdunlap@infradead.org>
References: <20201123044510.9942-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Nov 2020 20:45:10 -0800, Randy Dunlap wrote:
> Adding <asm/exception.h> brought in <asm/kprobes.h> which uses
> <asm/probes.h>, which uses 'pstate_check_t' so the latter needs to
> #include <asm/insn.h> for this typedef.
> 
> Fixes this build error:
> 
>   In file included from arch/arm64/include/asm/kprobes.h:24,
>                     from arch/arm64/include/asm/exception.h:11,
>                     from arch/arm64/kernel/fpsimd.c:35:
>   arch/arm64/include/asm/probes.h:16:2: error: unknown type name 'pstate_check_t'
>       16 |  pstate_check_t *pstate_cc;
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/fpsimd: add <asm/insn.h> to <asm/kprobes.h> to fix fpsimd build
      https://git.kernel.org/arm64/c/03659efe4287

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
