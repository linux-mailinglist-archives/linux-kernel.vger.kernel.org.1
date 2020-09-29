Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7F227D4DC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgI2RtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:49:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbgI2RtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:49:14 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D85F1207F7;
        Tue, 29 Sep 2020 17:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601401754;
        bh=YaGpwYM4wHlLVZrnm0P7uWY9V+NN6+GoMAAn4esffgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwz05uUMoXx4p9WCvb1j8pJ1aOL64KjEzq8nlGxVCFWzCUdEkXJeQ5m9m6ecVKr7m
         dSiVTTWIROrMfMbuLCf+jRSbCKn1+DzQv+0Vt0LRpjqjROJFs1K1Z2xfL/g1mWh4Q9
         QpbOm2G/Y1rXMxYXaqASjbWXrR6Lz99Ydjz7pLSs=
Date:   Tue, 29 Sep 2020 18:49:08 +0100
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
        kernel-team@android.com, Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v4 10/10] kvm: arm64: Remove unnecessary hyp mappings
Message-ID: <20200929174908.GE14317@willie-the-truck>
References: <20200922204910.7265-1-dbrazdil@google.com>
 <20200922204910.7265-11-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922204910.7265-11-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:49:10PM +0100, David Brazdil wrote:
> With all nVHE per-CPU variables being part of the hyp per-CPU region,
> mapping them individual is not necessary any longer. They are mapped to hyp
> as part of the overall per-CPU region.
> 
> Acked-by: Andrew Scull<ascull@google.com>

^^^ Missing space between "Scull" and "<".

> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h | 20 --------------------
>  arch/arm64/kvm/arm.c             | 16 ----------------
>  2 files changed, 36 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
