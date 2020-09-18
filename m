Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AD726F8B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIRIwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgIRIwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:52:15 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFD09208B8;
        Fri, 18 Sep 2020 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600419135;
        bh=rKisPjDcmfV5Y7QS4YkfoNfuiK9rKEU16zZPwmoN24o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iG5JeqZS9trmWFAsqjIbc8ABpHQWBBUeULYrCCH3Wi+w2BEgIrhpZ2PNX7rVJcTxY
         w5qRxifGZ3wWXJc7crZOr/pd9vVWNoKDRfUayCyoe6Ik/Zn7KznVpm0a9pC1V6PQGw
         UqT19dj9kCVYHfebEwJumFzr2DNGdYBZds3NQ4Mg=
Date:   Fri, 18 Sep 2020 09:52:09 +0100
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
Subject: Re: [PATCH v3 02/11] kvm: arm64: Move nVHE hyp namespace macros to
 hyp_image.h
Message-ID: <20200918085207.GB30834@willie-the-truck>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-3-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916173439.32265-3-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:34:30PM +0100, David Brazdil wrote:
> Minor cleanup to move all macros related to prefixing nVHE hyp section
> and symbol names into one place: hyp_image.h.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/hyp_image.h | 12 ++++++++++++
>  arch/arm64/include/asm/kvm_asm.h   |  8 +-------
>  arch/arm64/kernel/image-vars.h     |  2 --
>  3 files changed, 13 insertions(+), 9 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
