Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A842730060F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbhAVOvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:51:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbhAVOun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:50:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05765239EE;
        Fri, 22 Jan 2021 14:50:00 +0000 (UTC)
Date:   Fri, 22 Jan 2021 14:49:58 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v3 1/2] arm64: Improve kernel address detection of
 __is_lm_address()
Message-ID: <20210122144958.GF8567@gaia>
References: <20210122143748.50089-1-vincenzo.frascino@arm.com>
 <20210122143748.50089-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122143748.50089-2-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 02:37:47PM +0000, Vincenzo Frascino wrote:
> Currently, the __is_lm_address() check just masks out the top 12 bits
> of the address, but if they are 0, it still yields a true result.
> This has as a side effect that virt_addr_valid() returns true even for
> invalid virtual addresses (e.g. 0x0).
> 
> Improve the detection checking that it's actually a kernel address
> starting at PAGE_OFFSET.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

The question is whether we leave this for 5.12 or we merge it earlier.

-- 
Catalin
