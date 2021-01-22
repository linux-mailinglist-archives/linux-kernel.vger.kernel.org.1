Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F80300C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbhAVTZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:25:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730578AbhAVS7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:59:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B82A423AC1;
        Fri, 22 Jan 2021 18:58:59 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] arm64: kprobes: Fix Uexpected kernel BRK exception at EL1
Date:   Fri, 22 Jan 2021 18:58:57 +0000
Message-Id: <161134193158.28055.14817552984695990780.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210122110909.3324607-1-qais.yousef@arm.com>
References: <20210122110909.3324607-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 11:09:09 +0000, Qais Yousef wrote:
> I was hitting the below panic continuously when attaching kprobes to
> scheduler functions
> 
> 	[  159.045212] Unexpected kernel BRK exception at EL1
> 	[  159.053753] Internal error: BRK handler: f2000006 [#1] PREEMPT SMP
> 	[  159.059954] Modules linked in:
> 	[  159.063025] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.11.0-rc4-00008-g1e2a199f6ccd #56
> 	[rt-app] <notice> [1] Exiting.[  159.071166] Hardware name: ARM Juno development board (r2) (DT)
> 	[  159.079689] pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO BTYPE=--)
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: kprobes: Fix Uexpected kernel BRK exception at EL1
      https://git.kernel.org/arm64/c/75bd4bff300b

-- 
Catalin

