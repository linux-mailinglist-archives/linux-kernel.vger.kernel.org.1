Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A778E1DB59B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 15:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgETNv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 09:51:27 -0400
Received: from foss.arm.com ([217.140.110.172]:56758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgETNv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:51:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A25530E;
        Wed, 20 May 2020 06:51:25 -0700 (PDT)
Received: from [10.37.8.206] (unknown [10.37.8.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2B023F52E;
        Wed, 20 May 2020 06:51:23 -0700 (PDT)
Subject: Re: [PATCH V4 14/17] arm64/cpufeature: Add remaining feature bits in
 ID_AA64MMFR2 register
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
References: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
 <1589881254-10082-15-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3be71452-abd3-cd6f-c859-697447657a3f@arm.com>
Date:   Wed, 20 May 2020 14:56:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1589881254-10082-15-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/19/2020 10:40 AM, Anshuman Khandual wrote:
> Enable EVT, BBM, TTL, IDS, ST, NV and CCIDX features bits in ID_AA64MMFR2
> register as per ARM DDI 0487F.a specification.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Please note that there other series addressing TTL. So might
have conflicts.


Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
