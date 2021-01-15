Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05632F77B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbhAOLe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:34:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbhAOLe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:34:27 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49258221F7;
        Fri, 15 Jan 2021 11:33:46 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l0NMO-007j6G-3L; Fri, 15 Jan 2021 11:33:44 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>, kvmarm@lists.cs.columbia.edu
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] KVM: arm64: Allow PSCI SYSTEM_OFF/RESET to return
Date:   Fri, 15 Jan 2021 11:33:40 +0000
Message-Id: <161071039698.2624485.5615829758205647389.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201229160059.64135-1-dbrazdil@google.com>
References: <20201229160059.64135-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, will@kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, kernel-team@android.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, sudeep.holla@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Dec 2020 16:00:59 +0000, David Brazdil wrote:
> The KVM/arm64 PSCI relay assumes that SYSTEM_OFF and SYSTEM_RESET should
> not return, as dictated by the PSCI spec. However, there is firmware out
> there which breaks this assumption, leading to a hyp panic. Make KVM
> more robust to broken firmware by allowing these to return.

Applied to next, thanks!

[1/1] KVM: arm64: Allow PSCI SYSTEM_OFF/RESET to return
      commit: 2c91ef39216149df6703c3fa6a47dd9a1e6091c1

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


