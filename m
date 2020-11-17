Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907EB2B6DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgKQSzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgKQSzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:55:09 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 158B224181;
        Tue, 17 Nov 2020 18:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605639309;
        bh=Y038uP7ZmK0OgVTrSPxcTbp4HJmlOnmzfn1DGhUpwzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gJc+yO30XfLbM5fHLoIjw2WFot+3s9M7MQwMQX4e8ZXlGvcevLiPtBnK6ROzAYe6T
         vuhsgzTSamnbCG5jRvECoiUvMziSPV1N7aBYKRVRE7MxnfFsqHbmPzHI4N/yCFNeiZ
         BMq7xIHyCl2MbnVIc7DRm6opaL2oGtsKELm/Bz4g=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kf68A-00BSb2-Rv; Tue, 17 Nov 2020 18:55:07 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: vgic-v3: Drop the reporting of GICR_TYPER.Last for userspace
Date:   Tue, 17 Nov 2020 18:55:01 +0000
Message-Id: <160563920752.4179306.18040812749709622838.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201117151629.1738-1-yuzenghui@huawei.com>
References: <20201117151629.1738-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 23:16:29 +0800, Zenghui Yu wrote:
> It was recently reported that if GICR_TYPER is accessed before the RD base
> address is set, we'll suffer from the unset @rdreg dereferencing. Oops...
> 
> 	gpa_t last_rdist_typer = rdreg->base + GICR_TYPER +
> 			(rdreg->free_index - 1) * KVM_VGIC_V3_REDIST_SIZE;
> 
> It's "expected" that users will access registers in the redistributor if
> the RD has been properly configured (e.g., the RD base address is set). But
> it hasn't yet been covered by the existing documentation.
> 
> [...]

Applied to kvm-arm64/fixes-5.10, thanks!

[1/1] KVM: arm64: vgic-v3: Drop the reporting of GICR_TYPER.Last for userspace
      commit: 23bde34771f1ea92fb5e6682c0d8c04304d34b3b

I have added a Cc stable, as this definitely wants to be backported.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


