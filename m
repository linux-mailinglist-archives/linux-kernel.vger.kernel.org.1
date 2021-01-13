Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C0C2F4F92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbhAMQIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:08:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbhAMQIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:08:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4580423434;
        Wed, 13 Jan 2021 16:07:40 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Theodore Ts'o <tytso@mit.edu>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
Date:   Wed, 13 Jan 2021 16:07:38 +0000
Message-Id: <161055398865.21762.12236232732054213928.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210112224832.10980-1-will@kernel.org>
References: <20210112224832.10980-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021 22:48:32 +0000, Will Deacon wrote:
> GCC versions >= 4.9 and < 5.1 have been shown to emit memory references
> beyond the stack pointer, resulting in memory corruption if an interrupt
> is taken after the stack pointer has been adjusted but before the
> reference has been executed. This leads to subtle, infrequent data
> corruption such as the EXT4 problems reported by Russell King at the
> link below.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] compiler.h: Raise minimum version of GCC to 5.1 for arm64
      https://git.kernel.org/arm64/c/1f1244a5ddb7

-- 
Catalin

