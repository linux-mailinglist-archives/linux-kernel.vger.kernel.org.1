Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78852FCFA8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbhATLlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:41:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbhATLIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:08:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA26322227;
        Wed, 20 Jan 2021 11:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611140889;
        bh=ZkSlAs02/7hC14cFcb9AOFlcqlA01ivodVMpfU/Ab+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TQbY0JmuoAIgjUO0VgOVDYOm1V/DXzjZhqHDsO+FG9u4at8zmGA47BdGMfPa4cHjE
         xyb2M3SF8eNdC9qjjRjYERHGRTbv7yrU14DeROmeB7SYIt32lm8WEKvjylQRR5V3Ib
         PNnEa4O9iGKW7gIJ3FfqmFBJtVJ0tfr3YEc+5GyJEI4Xrb4TWOjG+QnBgF2HFuKoWr
         v0oBF2TeENoWxNLHCyV3OHzlswE3PLxvTvWvUHxsVwcD2AndkWt4qWmx42zFD70FVt
         kvXMJs3xYtQu3txzO3SOp8oEUQi5tuJTM3bV5OIspzr9Pbma7Zhdj+iyzyv5X2b9Ve
         /37wDXVsSjNxA==
Date:   Wed, 20 Jan 2021 11:08:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Maninder Singh <maninder1.s@samsung.com>, catalin.marinas@arm.com,
        broonie@kernel.org, vincenzo.frascino@arm.com,
        samitolvanen@google.com, ardb@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        v.narang@samsung.com, a.sahrawat@samsung.com
Subject: Re: [PATCH 1/1] arm64/entry.S: check for stack overflow in el1 case
 only
Message-ID: <20210120110803.GB19241@willie-the-truck>
References: <CGME20201211091546epcas5p24511325afff612d57306d733a3307648@epcas5p2.samsung.com>
 <1607678131-20347-1-git-send-email-maninder1.s@samsung.com>
 <20210107112903.GB7523@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107112903.GB7523@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 11:29:03AM +0000, Mark Rutland wrote:
> On Fri, Dec 11, 2020 at 02:45:31PM +0530, Maninder Singh wrote:
> > current code checks for sp bit flip in all exceptions,
> > but only el1 exceptions requires this. el0 can not enter
> > into stack overflow case directly.
> > 
> > it will improve performance for el0 exceptions and interrupts.
> > 
> > Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> > Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> 
> I did consider doing this at the time Ard and I wrote the overflow
> detection, but there was no measureable impact on the workloads that I
> tested, and it seemed worthwhile to have this as a sanity check in case
> the SP was somehow corrupted (and to avoid any surprizing differences
> between the EL0 and EL1 entry paths).
> 
> When you say "it will improve performance for el0 exceptions and
> interrupts", do you have a workload where this has a measureable impact,
> or was this found by inspection? Unless this is causing a real issue,
> I'd prefer to leave it as-is for now.

Maninder -- please could you follow up on Mark's question?

Will
