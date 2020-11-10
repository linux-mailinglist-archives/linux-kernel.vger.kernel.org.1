Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD00F2ADF21
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgKJTOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:14:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJTOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:14:22 -0500
Received: from localhost.localdomain (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9802920797;
        Tue, 10 Nov 2020 19:14:20 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        gshan@redhat.com
Subject: Re: [PATCH V5 0/3] arm64/mm/hotplug: Improve memory offline event notifier
Date:   Tue, 10 Nov 2020 19:14:17 +0000
Message-Id: <160503561804.1015659.18377585440079797860.b4-ty@arm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <1604896137-16644-1-git-send-email-anshuman.khandual@arm.com>
References: <1604896137-16644-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Nov 2020 09:58:54 +0530, Anshuman Khandual wrote:
> This series brings three different changes to the only memory event notifier on
> arm64 platform. These changes improve it's robustness while also enhancing debug
> capabilities during potential memory offlining error conditions.
> 
> This applies on 5.10-rc3
> 
> Changes in V5:
> 
> [...]

Applied to arm64 (for-next/mem-hotplug), thanks!

[1/3] arm64/mm/hotplug: Register boot memory hot remove notifier earlier
      https://git.kernel.org/arm64/c/cb45babe1b80
[2/3] arm64/mm/hotplug: Enable MEM_OFFLINE event handling
      https://git.kernel.org/arm64/c/9fb3d4a30338
[3/3] arm64/mm/hotplug: Ensure early memory sections are all online
      https://git.kernel.org/arm64/c/fdd99a4103c9

-- 
Catalin

