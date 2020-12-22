Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC02E0D15
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 17:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgLVQHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 11:07:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbgLVQHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:07:34 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD36422955;
        Tue, 22 Dec 2020 16:06:53 +0000 (UTC)
Received: from 91-161-240-24.subs.proxad.net ([91.161.240.24] helo=localhost.localdomain)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1krkBX-0037LH-K0; Tue, 22 Dec 2020 16:06:51 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>, kvmarm@lists.cs.columbia.edu
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH 0/6] Fixes and cleanups of PSCI relay for kvmarm/next
Date:   Tue, 22 Dec 2020 16:06:33 +0000
Message-Id: <160865317053.248882.14763900616940105510.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208142452.87237-1-dbrazdil@google.com>
References: <20201208142452.87237-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.161.240.24
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, will@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 14:24:46 +0000, David Brazdil wrote:
> Small batch of improvements for the 'Opt-in always-on nVHE hypervisor'
> series, now merged in kvmarm/next.
> 
> Patch #1 fixes potential use of invalid v0.1 functions IDs reported
> by Mark Rutland, patch #2 fixes a warning reported by Qian Cai.
> Patch #3 avoids a code path not used in VHE, can be dropped if any
> concerns arise. The remaining patches are minor cleanups from review.
> 
> [...]

Applied to next, thanks!

[1/6] kvm: arm64: Prevent use of invalid PSCI v0.1 function IDs
      commit: ff367fe473a9857160c17827931375a899076394
[2/6] kvm: arm64: Use lm_alias in nVHE-only VA conversion
      commit: 7a96a0687b80a1870c689418d7b72012c8bdd53d
[3/6] kvm: arm64: Skip computing hyp VA layout for VHE
      commit: c3e181aec96f6ada84df1cb72a72be8970f8b284
[4/6] kvm: arm64: Minor cleanup of hyp variables used in host
      commit: 61fe0c37af57ac35472a870581a7d0bb5ac2f63a
[5/6] kvm: arm64: Remove unused includes in psci-relay.c
      commit: e6829e0384a49efe68537298132230bebd8bd1b3
[6/6] kvm: arm64: Move skip_host_instruction to adjust_pc.h
      commit: 860a4c3d1e04a3c3e62bacbbba64417bf49768e2

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


