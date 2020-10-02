Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5C5280EA6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbgJBIUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbgJBIUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:20:14 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1828420874;
        Fri,  2 Oct 2020 08:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601626813;
        bh=LS7DFHMHv0QPOMTFevqOW9pSAWbSairLgB3n2smSWD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHUZwUneIoI7aUQYvSja1w4RxVE0zQfW5/p+Eat/EIPPFD+err6otFee0OmvXa4sI
         bLP6Y28udzsgeFuv2SaMCV50HiqEaNussiGfzRM+QiiAvXGjj1xHcKzGT196YtWkpQ
         Itk2J5kNp+RBdS0cNa1pXXXYp36kpt6LCljTpT3w=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kOGIV-00GeG7-H4; Fri, 02 Oct 2020 09:20:11 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tejun Heo <tj@kernel.org>, kernel-team@android.com,
        Christoph Lameter <cl@linux.com>,
        kernel test robot <lkp@intel.com>,
        Will Deacon <willdeacon@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] KVM: arm64: Ensure user_mem_abort() return value is initialised
Date:   Fri,  2 Oct 2020 09:20:00 +0100
Message-Id: <160162675379.1930042.16468950598631893927.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930102442.16142-1-will@kernel.org>
References: <20200930102442.16142-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, dbrazdil@google.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dennis@kernel.org, catalin.marinas@arm.com, tj@kernel.org, kernel-team@android.com, cl@linux.com, lkp@intel.com, willdeacon@google.com, dan.carpenter@oracle.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 11:24:42 +0100, Will Deacon wrote:
> If a change in the MMU notifier sequence number forces user_mem_abort()
> to return early when attempting to handle a stage-2 fault, we return
> uninitialised stack to kvm_handle_guest_abort(), which could potentially
> result in the injection of an external abort into the guest or a spurious
> return to userspace. Neither or these are what we want to do.
> 
> Initialise 'ret' to 0 in user_mem_abort() so that bailing due to a
> change in the MMU notrifier sequence number is treated as though the
> fault was handled.

Applied to next, thanks!

[1/1] KVM: arm64: Ensure user_mem_abort() return value is initialised
      commit: 84cd7df693f07df94d617049773f7c757a2b7847

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


