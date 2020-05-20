Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233621DB5B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 15:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgETNyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 09:54:14 -0400
Received: from foss.arm.com ([217.140.110.172]:56844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgETNyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:54:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17B7830E;
        Wed, 20 May 2020 06:54:13 -0700 (PDT)
Received: from [10.37.8.206] (unknown [10.37.8.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7975A3F52E;
        Wed, 20 May 2020 06:54:11 -0700 (PDT)
Subject: Re: [PATCH V4 17/17] arm64/cpuinfo: Add ID_MMFR4_EL1 into the
 cpuinfo_arm64 context
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
References: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
 <1589881254-10082-18-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <7ec45dbb-f1f5-6ee9-9fbc-d5da4b97a1ea@arm.com>
Date:   Wed, 20 May 2020 14:58:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1589881254-10082-18-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/19/2020 10:40 AM, Anshuman Khandual wrote:
> ID_MMFR4_EL1 has been missing in the CPU context (i.e cpuinfo_arm64). This
> just adds the register along with other required changes.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
