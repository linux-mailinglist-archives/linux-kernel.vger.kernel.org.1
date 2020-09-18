Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A9926F8D3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIRJAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgIRJAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:00:49 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 683C5206A2;
        Fri, 18 Sep 2020 09:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600419648;
        bh=2IAOKakatUDDRJE0sYixr7yUS7y46V4hsx2cV92RP0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sCBu9MHofJ0ky+tV55bGQWNBKxVZ4cDhZACrm8bfuetbSnzVgWmeWJKfGKH4HkNHV
         Lo2nrSOQY2/aq/8+63hmEb8EBR1ouPwiQEw15YiChgvFQmIfCBkUiuIipgji2xaH0L
         DxVM9K8AEm58venIy0MZyHgueQk4hfXfoTx/6Shc=
Date:   Fri, 18 Sep 2020 10:00:43 +0100
From:   Will Deacon <will@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 03/11] kvm: arm64: Only define __kvm_ex_table for
 CONFIG_KVM
Message-ID: <20200918090042.GD30834@willie-the-truck>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-4-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916173439.32265-4-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:34:31PM +0100, David Brazdil wrote:
> Minor cleanup that only creates __kvm_ex_table ELF section and
> related symbols if CONFIG_KVM is enabled.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 4 ++++
>  1 file changed, 4 insertions(+)

It's also useful because we're about to add another entry here, so:

Acked-by: Will Deacon <will@kernel.org>

Will
