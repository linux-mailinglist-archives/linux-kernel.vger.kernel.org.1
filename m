Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09412DD57C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 17:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgLQQt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 11:49:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbgLQQtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:49:55 -0500
Date:   Thu, 17 Dec 2020 16:49:11 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, mark.rutland@arm.com,
        matthias.bgg@gmail.com, will@kernel.org, yj.chiang@mediatek.com
Subject: Re: [PATCH] arm64: Kconfig: Add SYS_SUPPORTS_APM_EMULATION
Message-ID: <20201217164911.GB20278@gaia>
References: <20201216155820.GH2511@gaia>
 <20201216164147.9854-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216164147.9854-1-lecopzer.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 12:41:47AM +0800, Lecopzer Chen wrote:
> so there is two points
> 1. out-of-tree function can't be approved
>     I totally agree with this :) so we may have a driver upstream in the future.

It may not be upstreamable if it relies on the old APM interface ;).

> 2. APM not make sense on arm64
> Could you please let me konw the reason why APM on ARM64 doesn't make sense?

It's a very old interface, even on x86 it is disabled in the distro
kernels. There are more modern alternatives and you should update your
driver and user space to use them (e.g. /sys/power/).

-- 
Catalin
