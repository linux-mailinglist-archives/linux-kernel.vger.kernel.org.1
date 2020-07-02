Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E504212C82
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 20:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgGBSrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 14:47:01 -0400
Received: from foss.arm.com ([217.140.110.172]:53146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgGBSrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:47:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F26411FB;
        Thu,  2 Jul 2020 11:47:00 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19B2D3F71E;
        Thu,  2 Jul 2020 11:46:59 -0700 (PDT)
References: <20200701190656.10126-1-valentin.schneider@arm.com> <20200701190656.10126-7-valentin.schneider@arm.com> <fb226a93-dda0-4f41-3b12-8bf41e61088c@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org, morten.rasmussen@arm.com
Subject: Re: [PATCH v3 6/7] sched/topology: Introduce SD metaflag for flags needing > 1 groups
In-reply-to: <fb226a93-dda0-4f41-3b12-8bf41e61088c@arm.com>
Date:   Thu, 02 Jul 2020 19:46:57 +0100
Message-ID: <jhja70h92la.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/07/20 19:29, Dietmar Eggemann wrote:
> On 01/07/2020 21:06, Valentin Schneider wrote:
>
> [...]
>
>> @@ -105,16 +122,18 @@ SD_FLAG(SD_SERIALIZE,           8, SDF_SHARED_PARENT)
>>   * Place busy tasks earlier in the domain
>>   *
>>   * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
>> - * up, but currently assumed to be set from the base domain upwards (see
>> - * update_top_cache_domain()).
>> + *               up, but currently assumed to be set from the base domain
>> + *               upwards (see update_top_cache_domain()).
>>   */
>> -SD_FLAG(SD_ASYM_PACKING,        9, SDF_SHARED_CHILD)
>> +SD_FLAG(SD_ASYM_PACKING,        9, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
>>
>>  /*
>>   * Prefer to place tasks in a sibling domain
>>   *
>>   * Set up until domains start spanning NUMA nodes. Close to being a SHARED_CHILD
>>   * flag, but cleared below domains with SD_ASYM_CPUCAPACITY.
>> + *
>> + * NEEDS_GROUPS: Load balancing flag.
>>   */
>>  SD_FLAG(SD_PREFER_SIBLING,      10, 0)
>
> Related to my comment in [PATCH v3 5/7], maybe you wanted to add
> SDF_NEEDS_GROUPS for SD_PREFER_SIBLING as well ? This comment
> 'NEEDS_GROUPS: Load balancing flag.' makes me wondering.
>
> Currently, SD_PREFER_SIBLING isn't in SD_DEGENERATE_GROUPS_MASK=0xaef.
>

You're right, that's a fail from my end. Thanks (and sorry)!

> [...]
