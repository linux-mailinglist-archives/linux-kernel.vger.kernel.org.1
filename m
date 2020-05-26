Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193211A9B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 12:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896621AbgDOKrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 06:47:15 -0400
Received: from foss.arm.com ([217.140.110.172]:42116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896604AbgDOKqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:46:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 716E81063;
        Wed, 15 Apr 2020 03:46:11 -0700 (PDT)
Received: from [10.37.12.1] (unknown [10.37.12.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C5C73F68F;
        Wed, 15 Apr 2020 03:46:09 -0700 (PDT)
Subject: Re: [PATCH 7/8] arm64: cpufeature: Relax checks for AArch32 support
 at EL[0-2]
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        saiprakash.ranjan@codeaurora.org, dianders@chromium.org,
        kernel-team@android.com
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-8-will@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <714f124c-7eb7-b750-e98c-63da64ddae75@arm.com>
Date:   Wed, 15 Apr 2020 11:50:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200414213114.2378-8-will@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/2020 10:31 PM, Will Deacon wrote:
> We don't need to be quite as strict about mismatched AArch32 support,
> which is good because the friendly hardware folks have been busy
> mismatching this to their hearts' content.
> 
>    * We don't care about EL2 or EL3 (there are silly comments concerning
>      the latter, so remove those)
> 
>    * EL1 support is gated by the ARM64_HAS_32BIT_EL1 capability and handled
>      gracefully when a mismatch occurs
> 
>    * EL1 support is gated by the ARM64_HAS_32BIT_EL0 capability and handled

s/EL1/EL0

>      gracefully when a mismatch occurs
> 
> Relax the AArch32 checks to FTR_NONSTRICT.

Agreed. We should do something similar for the features exposed by the
ELF_HWCAP, of course in a separate series.

> 
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
