Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B224263CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 08:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgIJGBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 02:01:03 -0400
Received: from foss.arm.com ([217.140.110.172]:54754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgIJGAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:00:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B79E31B;
        Wed,  9 Sep 2020 23:00:20 -0700 (PDT)
Received: from [10.163.71.250] (unknown [10.163.71.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65C283F66E;
        Wed,  9 Sep 2020 23:00:18 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64/mm: Remove CONT_RANGE_OFFSET
To:     Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
References: <20200908071931.47767-1-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <67372610-05ce-a75a-b3c0-52e6ebd53063@arm.com>
Date:   Thu, 10 Sep 2020 11:29:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200908071931.47767-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/08/2020 12:49 PM, Gavin Shan wrote:
> The macro was introduced by commit <ecf35a237a85> ("arm64: PTE/PMD
> contiguous bit definition") at the beginning. It's only used by
> commit <348a65cdcbbf> ("arm64: Mark kernel page ranges contiguous"),
> which was reverted later by commit <667c27597ca8>. This makes the
> macro unused.
> 
> This removes the unused macro (CONT_RANGE_OFFSET).
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/pgtable-hwdef.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index d400a4d9aee2..8a399e666837 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -98,8 +98,6 @@
>  #define CONT_PMDS		(1 << (CONT_PMD_SHIFT - PMD_SHIFT))
>  #define CONT_PMD_SIZE		(CONT_PMDS * PMD_SIZE)
>  #define CONT_PMD_MASK		(~(CONT_PMD_SIZE - 1))
> -/* the numerical offset of the PTE within a range of CONT_PTES */
> -#define CONT_RANGE_OFFSET(addr) (((addr)>>PAGE_SHIFT)&(CONT_PTES-1))
>  
>  /*
>   * Hardware page table definitions.
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
