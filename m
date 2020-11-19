Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A9D2B9924
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgKSRSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:18:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbgKSRSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:18:06 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A7782468B;
        Thu, 19 Nov 2020 17:18:04 +0000 (UTC)
Date:   Thu, 19 Nov 2020 17:18:01 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, jonathan.zhouwen@huawei.com,
        coresight@lists.linaro.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 24/25] arm64: Add TRFCR_ELx definitions
Message-ID: <20201119171801.GE4376@gaia>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-25-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119164547.2982871-25-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:45:46PM +0000, Suzuki K Poulose wrote:
> @@ -988,6 +991,14 @@
>  /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
>  #define SYS_MPIDR_SAFE_VAL	(BIT(31))
>  
> +#define TRFCR_ELx_TS_SHIFT		5
> +#define TRFCR_ELx_TS_VIRTUAL		((0x1) << TRFCR_ELx_TS_SHIFT)
> +#define TRFCR_ELx_TS_GUEST_PHYSICAL	((0x2) << TRFCR_ELx_TS_SHIFT)
> +#define TRFCR_ELx_TS_PHYSICAL		((0x3) << TRFCR_ELx_TS_SHIFT)

For consistency, I'd use 0x1UL etc. in case the shift goes beyond 32
(not the case here though).

Otherwise:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
