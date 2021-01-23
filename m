Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60F0301688
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 17:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbhAWQBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 11:01:02 -0500
Received: from foss.arm.com ([217.140.110.172]:47752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbhAWQA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 11:00:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 977DB11D4;
        Sat, 23 Jan 2021 08:00:12 -0800 (PST)
Received: from [10.57.40.145] (unknown [10.57.40.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 605AD3F68F;
        Sat, 23 Jan 2021 08:00:07 -0800 (PST)
Subject: Re: [PATCH v4 09/21] arm64: cpufeature: Add global feature override
 facility
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        kernel-team@android.com
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-10-maz@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a820f460-83dc-f957-2a8c-97ee66129406@arm.com>
Date:   Sat, 23 Jan 2021 15:59:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210118094533.2874082-10-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/21 9:45 AM, Marc Zyngier wrote:
> Add a facility to globally override a feature, no matter what
> the HW says. Yes, this sounds dangerous, but we do respect the
> "safe" value for a given feature. This doesn't mean the user
> doesn't need to know what they are doing.
> 
> Nothing uses this yet, so we are pretty safe. For now.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
