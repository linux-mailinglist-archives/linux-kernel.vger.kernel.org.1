Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93ADC1E24E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 17:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgEZPBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 11:01:39 -0400
Received: from foss.arm.com ([217.140.110.172]:51970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgEZPBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:01:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8C8A30E;
        Tue, 26 May 2020 08:01:38 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B893B3F52E;
        Tue, 26 May 2020 08:01:37 -0700 (PDT)
Date:   Tue, 26 May 2020 16:01:35 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/cpufeature: Add get_arm64_ftr_reg_nowarn()
Message-ID: <20200526150135.GI17051@gaia>
References: <1590500353-28082-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590500353-28082-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 07:09:13PM +0530, Anshuman Khandual wrote:
> @@ -632,8 +654,6 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
>  	const struct arm64_ftr_bits *ftrp;
>  	struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
>  
> -	BUG_ON(!reg);
> -
>  	for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
>  		u64 ftr_mask = arm64_ftr_mask(ftrp);
>  		s64 ftr_new = arm64_ftr_value(ftrp, new);
> @@ -762,7 +782,6 @@ static int check_update_ftr_reg(u32 sys_id, int cpu, u64 val, u64 boot)
>  {
>  	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id);
>  
> -	BUG_ON(!regp);
>  	update_cpu_ftr_reg(regp, val);
>  	if ((boot & regp->strict_mask) == (val & regp->strict_mask))
>  		return 0;
> @@ -776,9 +795,6 @@ static void relax_cpu_ftr_reg(u32 sys_id, int field)
>  	const struct arm64_ftr_bits *ftrp;
>  	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id);
>  
> -	if (WARN_ON(!regp))
> -		return;

I think Will wanted an early return in all these functions not just
removing the BUG_ON(). I'll let him clarify.

-- 
Catalin
