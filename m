Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369692EB21D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbhAESJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:09:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbhAESJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:09:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D336F22CB3;
        Tue,  5 Jan 2021 18:08:37 +0000 (UTC)
Date:   Tue, 5 Jan 2021 18:08:35 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Remove unused variable in arch_show_interrupts
Message-ID: <20210105180835.GF11802@gaia>
References: <20210105180314.64613-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105180314.64613-1-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 06:03:14PM +0000, David Brazdil wrote:
> Commit 5089bc51f81f ("arm64/smp: Use irq_desc_kstat_cpu() in
> arch_show_interrupts()") removed the only user of variable `irq`.
> Remove the unused variable.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>

Please search the list for similar patches. I can count 5-6 and the
number is growing ;) (and I queued one already).

-- 
Catalin
