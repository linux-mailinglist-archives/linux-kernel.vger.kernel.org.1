Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074BC2B061F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgKLNRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:17:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbgKLNRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:17:45 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 518D12085B;
        Thu, 12 Nov 2020 13:17:43 +0000 (UTC)
Date:   Thu, 12 Nov 2020 13:17:40 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     tangyouling <tangyouling@loongson.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, ardb@kernel.org
Subject: Re: [PATCH] arm64: Change the location of DISCARDS
Message-ID: <20201112131740.GN29613@gaia>
References: <1604486932-18889-1-git-send-email-tangyouling@loongson.cn>
 <20201105214738.GB8600@willie-the-truck>
 <759a51ad-8b2e-24bd-52f5-99769ff5557c@loongson.cn>
 <20201106090737.GA9496@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106090737.GA9496@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 09:07:38AM +0000, Will Deacon wrote:
> On Fri, Nov 06, 2020 at 09:06:42AM +0800, tangyouling wrote:
> > In the include/asm-generic/vmlinux.lds.h:978, the description is as follows:
> > DISCARDS must be the last of output section definitions so that such archs
> > put those in earlier section definitions.
> 
> Sure, I see that text, but I don't get why it matters. It would be nice to
> have some rationale as to what could go wrong if they aren't at the end,
> so we can improve that comment and avoid the inevitable regression in the
> future when things get shuffled around.

Maybe on other architectures or some old toolchains made a difference in
the resulting binary image size. It doesn't seem to be the case for
arm64.

-- 
Catalin
