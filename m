Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3352426A758
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 16:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgIOOli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 10:41:38 -0400
Received: from foss.arm.com ([217.140.110.172]:36896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbgIOO2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:28:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D46A101E;
        Tue, 15 Sep 2020 07:28:09 -0700 (PDT)
Received: from [10.57.48.219] (unknown [10.57.48.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE18A3F68F;
        Tue, 15 Sep 2020 07:28:07 -0700 (PDT)
Subject: Re: [PATCH v6] perf: arm_dsu: Support DSU ACPI devices
To:     tuanphan@os.amperecomputing.com
Cc:     patches@amperecomputing.com, will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1600106656-9542-1-git-send-email-tuanphan@os.amperecomputing.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <7219baa4-e813-9177-4a17-3aece89ae851@arm.com>
Date:   Tue, 15 Sep 2020 15:32:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1600106656-9542-1-git-send-email-tuanphan@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/2020 07:04 PM, Tuan Phan wrote:
> Add support for probing device from ACPI node.
> Each DSU ACPI node and its associated cpus are inside a cluster node.
> 
> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
  ---
> Changes in v6:
> - Fixed warning with no CONFIG_ACPI.
> 
> Changes in v5:
> - Used CONFIG_ACPI to fix compiling issue.
> 
> Changes in v4:
> - Addressed Will's comments.
> 
> Changes in v3:
> - Based on the latest ARM ACPI binding at: https://developer.arm.com/documentation/den0093/c/
> 
> Changes in v2:
> - Removed IRQF_SHARED.
> - Fixed ACPI runtime detection.
> 
>   drivers/perf/arm_dsu_pmu.c | 63 +++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 57 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> index 96ed93c..98e68ed 100644
> --- a/drivers/perf/arm_dsu_pmu.c
> +++ b/drivers/perf/arm_dsu_pmu.c


Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

