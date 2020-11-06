Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD572A921C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgKFJHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:07:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgKFJHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:07:45 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F177A20936;
        Fri,  6 Nov 2020 09:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604653663;
        bh=/WyFgfLiGBaivhLHjIz34mnY1A6swv5xaVPIuWmwMgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnOhTeDRPNs0Thwdi2AySf3T1uexugRszfvWjTL6d9s7t8NaLOaMvcWnq9sQYeJUc
         GbacubcrP0u+B7mW9YZ5SSiBCSKuabvXr3h71sH3dJLaHkvvV+JpmBESXmXrb5rVte
         /PVOJcyd5irAOomsEe/Wr/aFsSvgpxQ1Brbh0h18=
Date:   Fri, 6 Nov 2020 09:07:38 +0000
From:   Will Deacon <will@kernel.org>
To:     tangyouling <tangyouling@loongson.cn>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, ardb@kernel.org
Subject: Re: [PATCH] arm64: Change the location of DISCARDS
Message-ID: <20201106090737.GA9496@willie-the-truck>
References: <1604486932-18889-1-git-send-email-tangyouling@loongson.cn>
 <20201105214738.GB8600@willie-the-truck>
 <759a51ad-8b2e-24bd-52f5-99769ff5557c@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <759a51ad-8b2e-24bd-52f5-99769ff5557c@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 09:06:42AM +0800, tangyouling wrote:
> In the include/asm-generic/vmlinux.lds.h:978, the description is as follows:
> DISCARDS must be the last of output section definitions so that such archs
> put those in earlier section definitions.

Sure, I see that text, but I don't get why it matters. It would be nice to
have some rationale as to what could go wrong if they aren't at the end,
so we can improve that comment and avoid the inevitable regression in the
future when things get shuffled around.

Will
