Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05881E120C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391093AbgEYPsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 11:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388764AbgEYPsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:48:21 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA7D207CB;
        Mon, 25 May 2020 15:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590421700;
        bh=+XKSimPGeCz0W1CMEwgJoWin6kbwXNT1qTSNuAPAw24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YqvGp0CSkmi7E99dorkU+Ghw2OZpOExzchApOcn49k0dIN041CDW/IkeIYyprRnN6
         lQniwUChGNVBImRKPKHciFDG/Z6PQS4VYAK8HtZeqJ1B2mjrXf11xSkvsq/Ef8pBQE
         cT7DQc8BBvcF8UYEHhDa23EtameHdjpvZeNy9aLo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jdFKt-00FCJb-4L; Mon, 25 May 2020 16:48:19 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kvm: Clean up cpu_init_hyp_mode()
Date:   Mon, 25 May 2020 16:48:13 +0100
Message-Id: <159042163820.423883.9671590581057422816.b4-ty@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515152056.83158-1-dbrazdil@google.com>
References: <20200515152056.83158-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 16:20:56 +0100, David Brazdil wrote:
> Pull bits of code to the only place where it is used. Remove empty function
> __cpu_init_stage2(). Remove redundant has_vhe() check since this function is
> nVHE-only. No functional changes intended.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20200515152056.83158-1-dbrazdil@google.com
> 
> [...]

Applied to kvmarm-master/next, thanks!

[1/1] KVM: arm64: Clean up cpu_init_hyp_mode()
      commit: 71b3ec5f221b8b3ff545639be83ddfcd5d7c9800

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


