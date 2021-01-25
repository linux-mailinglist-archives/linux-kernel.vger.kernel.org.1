Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785EB30388D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 10:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390778AbhAZJDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 04:03:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbhAYSrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:47:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E213822B3F;
        Mon, 25 Jan 2021 18:46:23 +0000 (UTC)
Date:   Mon, 25 Jan 2021 18:46:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kfence: fix header inclusion
Message-ID: <20210125184621.GA32727@gaia>
References: <20210125125025.102381-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125125025.102381-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 01:50:20PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Randconfig builds started warning about a missing function declaration
> after set_memory_valid() is moved to a new file:
> 
> In file included from mm/kfence/core.c:26:
> arch/arm64/include/asm/kfence.h:17:2: error: implicit declaration of function 'set_memory_valid' [-Werror,-Wimplicit-function-declaration]
> 
> Include the correct header again.
> 
> Fixes: 9e18ec3cfabd ("set_memory: allow querying whether set_direct_map_*() is actually enabled")
> Fixes: 204555ff8bd6 ("arm64, kfence: enable KFENCE for ARM64")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(it should go via the mm tree with the other kfence patches)
