Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FFA1E120B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391105AbgEYPsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 11:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388791AbgEYPsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:48:21 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0271C207D8;
        Mon, 25 May 2020 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590421701;
        bh=N64AAieCFNKsupOv15QMm5WksqcdlYTBULH/wOivY3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTcXyzee8xvOIAzI1WDooZ0r8m41ecZFYxpKyNiZCAx0DTGhGOLphpJNU2rsSpMaO
         huIbYmZGchpA8yS4dd5XpkeK3YLzdObE4kkqv1lk1u8AprxmA8Tr3RFcryRVCmNR9p
         BjN9grh7za0o+INyqftI7YYmxaZV/Ip66TamIX0A=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jdFKt-00FCJb-Ep; Mon, 25 May 2020 16:48:19 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kvm: Fix incorrect comment on kvm_get_hyp_vector()
Date:   Mon, 25 May 2020 16:48:14 +0100
Message-Id: <159042163819.423883.8265784934325308577.b4-ty@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515152550.83810-1-dbrazdil@google.com>
References: <20200515152550.83810-1-dbrazdil@google.com>
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

On Fri, 15 May 2020 16:25:50 +0100, David Brazdil wrote:
> The comment used to say that kvm_get_hyp_vector is only called on VHE systems.
> In fact, it is also called from the nVHE init function cpu_init_hyp_mode().
> Fix the comment to stop confusing devs.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20200515152550.83810-1-dbrazdil@google.com
> 
> [...]

Applied to kvmarm-master/next, thanks!

[1/1] KVM: arm64: Fix incorrect comment on kvm_get_hyp_vector()
      commit: 438f711ce1d889632467be80779c8f5762b107d7

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


