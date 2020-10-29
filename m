Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C7929F6A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 22:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgJ2VJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 17:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgJ2VJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:09:28 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A716020809;
        Thu, 29 Oct 2020 21:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604005767;
        bh=lf0t0UJFCGB050lo14Z4j7zqhqTTfq2T0veFSPfejV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0lDMhNNTgQFcZhgAYW5AM6t/DcWAhW4A22KnY6O9/botf+3Vqvm0vGApHfmO+y0Gn
         pKfoK1CS5a9mn/a6B/8f5RVk3iDsXMgpeq47gfN1Py3EFMimiQjdkkbMKkJl+ugexQ
         6BUeqzcOFpc2cvJfZ5xQyp6S0ikMUQe1uB7OF3IM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kYFAj-005YNy-QP; Thu, 29 Oct 2020 21:09:25 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, Gavin Shan <gshan@redhat.com>,
        Will Deacon <will@kernel.org>
Cc:     shan.gavin@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Allocate stage-2 pgd pages with GFP_KERNEL_ACCOUNT
Date:   Thu, 29 Oct 2020 21:09:17 +0000
Message-Id: <160400571841.9348.8004046679555935823.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026144423.24683-1-will@kernel.org>
References: <20201026144423.24683-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, gshan@redhat.com, will@kernel.org, shan.gavin@gmail.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 14:44:23 +0000, Will Deacon wrote:
> For consistency with the rest of the stage-2 page-table page allocations
> (performing using a kvm_mmu_memory_cache), ensure that __GFP_ACCOUNT is
> included in the GFP flags for the PGD pages.

Applied to next, thanks!

[1/1] KVM: arm64: Allocate stage-2 pgd pages with GFP_KERNEL_ACCOUNT
      commit: 7efe8ef274024ef1d5c495c79dfcbbff38c5f366

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


