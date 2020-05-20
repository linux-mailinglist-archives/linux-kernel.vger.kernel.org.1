Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877A31DBC08
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 19:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgETRys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 13:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgETRyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:54:46 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD330207D3;
        Wed, 20 May 2020 17:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589997286;
        bh=LwxTBNwVwq8v+Z3EBK8Zb+aYAe0AVV8dq4zcV/fvDC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFq5+gFik+r6kGeqmyDWMKqEgZalTs7c4tPsNNhQaX/MPA8BMIV672M3qkbbA9ZDQ
         27uhRAS9YPmjakvM6KuqrfY2I4LD9GHc/miBeCKwQtsFFp7gOUwchYkOUzmuSE6foo
         tpr7SsjsgdfdXkm0DB9u1TBpd5zg/WWX5pPxmrwI=
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V3] arm64/cpufeature: Validate hypervisor capabilities during CPU hotplug
Date:   Wed, 20 May 2020 18:54:37 +0100
Message-Id: <158998676494.231372.15074477766045633803.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1589248647-22925-1-git-send-email-anshuman.khandual@arm.com>
References: <1589248647-22925-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 07:27:27 +0530, Anshuman Khandual wrote:
> This validates hypervisor capabilities like VMID width, IPA range for any
> hot plug CPU against system finalized values. KVM's view of the IPA space
> is used while allowing a given CPU to come up. While here, it factors out
> get_vmid_bits() for general use.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-kernel@vger.kernel.org

Applied to arm64 (for-next/cpufeature), thanks!

[1/1] arm64/cpufeature: Validate hypervisor capabilities during CPU hotplug
      https://git.kernel.org/arm64/c/c73433fc630c

But please note that I made some changes to verify_hyp_capabilities() so
that it's (a) static and (b) uses IS_ENABLED to avoid the dummy function
definition. I also extended the IS_ENABLED_check so that it doesn't
conflict with the KVM kconfig changes from Fuad. Please shout if you think
I'm still missing something.

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
