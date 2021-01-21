Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDE12FF26A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbhAURr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:47:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389052AbhAURrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:47:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BE78207C5;
        Thu, 21 Jan 2021 17:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611251182;
        bh=MqX1kerCnT40Z0xUUgTg70OGnK4xYYiDNavID8LlQrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NGspuxFUB31C87kP59HWiHNPgyq/YeRGDTPlXo8XWQtnyPGQgSfZBEmO69dZUZ1zS
         tXU+b8PaH4/ecjgOk4iL7UdtFg9GLMPwhGoBWHRkIzImvJfs8fQlUdSjdZDpBXJhAR
         vGEfEWujxyFISdtdYeu0d/ewV5zvrM2pD01Dqn/uLWbXa/6tST84Qd72JoQ0A1MjbH
         ggp8y0yeznRsAIdM5eVd8cTMTSHxgm+4Z778aHW3A5CuMmXBQx4P/OkLaHPWjaIupk
         xAEtdnV69D0RGFgYLwBYnu8UXTVilbn24R/dbRvrTSegnUN+maQITF9F4JAMMQdZh3
         ZotB5XHRCj0YQ==
Date:   Thu, 21 Jan 2021 17:46:16 +0000
From:   Will Deacon <will@kernel.org>
To:     Prathu Baronia <prathubaronia2011@gmail.com>
Cc:     linux-kernel@vger.kernel.org, chintan.pandya@oneplus.com,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "glider@google.com" <glider@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/1] mm: Optimizing hugepage zeroing in arm64
Message-ID: <20210121174616.GA22740@willie-the-truck>
References: <20210121165153.17828-1-prathu.baronia@oneplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121165153.17828-1-prathu.baronia@oneplus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 10:21:50PM +0530, Prathu Baronia wrote:
> This patch removes the unnecessary kmap calls in the hugepage zeroing path and
> improves the timing by 62%.
> 
> I had proposed a similar change in Apr-May'20 timeframe in memory.c where I
> proposed to clear out a hugepage by directly calling a memset over the whole
> hugepage but got the opposition that the change was not architecturally neutral.
> 
> Upon revisiting this now I see significant improvement by removing around 2k
> barrier calls from the zeroing path. So hereby I propose an arm64 specific
> definition of clear_user_highpage().

Given that barrier() is purely a thing for the compiler, wouldn't the same
change yield a benefit on any other architecture without HIGHMEM? In which
case, I think this sort of change belongs in the core code if it's actually
worthwhile.

Will
