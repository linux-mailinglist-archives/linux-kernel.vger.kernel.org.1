Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD191D2FEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 14:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgENMii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 08:38:38 -0400
Received: from foss.arm.com ([217.140.110.172]:35686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgENMii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:38:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08A3A1042;
        Thu, 14 May 2020 05:38:38 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7A003F305;
        Thu, 14 May 2020 05:38:35 -0700 (PDT)
Subject: Re: [PATCH 1/2] firmware: arm-smccc: define identifier for Arm SMCCC
 v1.2
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, tglx@linutronix.de, alexios.zavras@intel.com,
        will@kernel.org, maz@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20200514082109.27573-1-etienne.carriere@linaro.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <b8661499-6ecc-2adc-9ed6-b7c428a8aa35@arm.com>
Date:   Thu, 14 May 2020 13:38:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514082109.27573-1-etienne.carriere@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2020 09:21, Etienne Carriere wrote:
> Define identifier value reported by secure firmware when its
> supports Arm SMCCC specification v1.2.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>

FYI Sudeep has already posted a patch to do this[1].

Steve

[1] 
https://lore.kernel.org/linux-arm-kernel/20200430114814.14116-3-sudeep.holla@arm.com/

> ---
>   include/linux/arm-smccc.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index 59494df0f55b..1cf221f3f07a 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -56,6 +56,7 @@
>   
>   #define ARM_SMCCC_VERSION_1_0		0x10000
>   #define ARM_SMCCC_VERSION_1_1		0x10001
> +#define ARM_SMCCC_VERSION_1_2		0x10002
>   
>   #define ARM_SMCCC_VERSION_FUNC_ID					\
>   	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> 

