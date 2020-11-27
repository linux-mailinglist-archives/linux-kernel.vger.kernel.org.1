Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9F82C6BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 20:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgK0TYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 14:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730340AbgK0TNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:13:49 -0500
Received: from localhost.localdomain (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1D8A221F7;
        Fri, 27 Nov 2020 19:12:58 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Youling Tang <tangyouling@loongson.cn>,
        Will Deacon <will@kernel.org>
Cc:     James Morse <james.morse@arm.com>, Ingo Molnar <mingo@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: vmlinux.lds.S: Drop redundant *.init.rodata.*
Date:   Fri, 27 Nov 2020 19:12:57 +0000
Message-Id: <160650437074.21981.17625844073240816613.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1605750340-910-1-git-send-email-tangyouling@loongson.cn>
References: <1605750340-910-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 09:45:40 +0800, Youling Tang wrote:
> We currently try to emit *.init.rodata.* twice, once in INIT_DATA, and once
> in the line immediately following it. As the two section definitions are
> identical, the latter is redundant and can be dropped.
> 
> This patch drops the redundant *.init.rodata.* section definition.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: vmlinux.lds.S: Drop redundant *.init.rodata.*
      https://git.kernel.org/arm64/c/344f2db2a18a

-- 
Catalin

