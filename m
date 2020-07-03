Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4585213A24
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 14:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgGCMdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 08:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgGCMdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:33:51 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 397AC20CC7;
        Fri,  3 Jul 2020 12:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593779631;
        bh=yOf8DplJ2kxhEXBBRPsWmMVjM7TUcjznNe+bxS9EXjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3xFIbzUSj0mAOMtA/yIAaiQrscQcuFABU/AvgWwDuzlcJYeNmYgENMjkSrQsiCO/
         6GoaSHyCLY0+3jTb8856XAH4eXKBC++lrp5T0XA7mbtLshR4ld8B32c+WNP1mM10FU
         5CMSZAeSRo6fiQhwwDqklrrDjw2Uw1xFCs6WNgMs=
Date:   Fri, 3 Jul 2020 13:33:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: perf: add support for Cortex-A55/A75/A76
Message-ID: <20200703123346.GB18953@willie-the-truck>
References: <20200619184423.5e61a838@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619184423.5e61a838@xhacker.debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 06:44:37PM +0800, Jisheng Zhang wrote:
> The Cortex-A55/A75/A76 use some implementation defined perf events.
> Add the support.
> 
> Jisheng Zhang (3):
>   arm64: perf: add support for Cortex-A55
>   arm64: perf: add support for Cortex-A75
>   arm64: perf: add support for Cortex-A76
> 
>  arch/arm64/kernel/perf_event.c | 49 +++++++++++++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 4 deletions(-)

Do we really need this? I'd prefer for this stuff to live in userspace
now that the perf tool has supported JSON event descriptions for a while,
and the in-kernel driver advertises the architected events advertised
by PMCEID*.

Will
