Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB16027016F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRP5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgIRP5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:57:10 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB3862388B;
        Fri, 18 Sep 2020 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600444630;
        bh=2EcilAACSbcT3KfzwvAMLm256NPLtnuVhaE7x3Kd5wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r7OmBssupkefNfijGMbXJiT+4FuYHSElNGvtA0F8+A60+dddq7CKHQ8z7LDTpH4uD
         aNbEkyy6Een/oh4BVqfJIyOwjMOuQI1qozPRPWnb0BL4JMadHzxgLuB9gGTZEExOBH
         9waVyD/LFsZBoCLU1Gg9P+rT+vyyrpMPujpxoihM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kJIl2-00D3F2-Fl; Fri, 18 Sep 2020 16:57:08 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] KVM: arm64: vgic-debug: convert to use DEFINE_SEQ_ATTRIBUTE macro
Date:   Fri, 18 Sep 2020 16:56:59 +0100
Message-Id: <160044458392.1301915.930807383105035280.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916025023.3992679-1-liushixin2@huawei.com>
References: <20200916025023.3992679-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu, catalin.marinas@arm.com, james.morse@arm.com, suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com, will@kernel.org, liushixin2@huawei.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 10:50:23 +0800, Liu Shixin wrote:
> Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

Applied to next, thanks!

[1/1] KVM: arm64: vgic-debug: Convert to use DEFINE_SEQ_ATTRIBUTE macro
      commit: cb62e0b5c8db778cd29e63c2f844f36caf6859ed

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


