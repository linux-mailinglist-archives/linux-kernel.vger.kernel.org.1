Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF011C3DA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 16:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgEDOyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 10:54:07 -0400
Received: from foss.arm.com ([217.140.110.172]:46662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgEDOyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:54:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BA381FB;
        Mon,  4 May 2020 07:54:06 -0700 (PDT)
Received: from [10.163.71.79] (unknown [10.163.71.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 332DE3F305;
        Mon,  4 May 2020 07:54:00 -0700 (PDT)
Subject: Re: [PATCH] arm64/cpuinfo: Drop boot_cpu_data
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
References: <1588595400-4560-1-git-send-email-anshuman.khandual@arm.com>
 <20200504124321.GA73375@C02TD0UTHF1T.local>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <224296d1-086a-5516-95a8-8f4ad5c533d9@arm.com>
Date:   Mon, 4 May 2020 20:23:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200504124321.GA73375@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2020 06:13 PM, Mark Rutland wrote:
> On Mon, May 04, 2020 at 06:00:00PM +0530, Anshuman Khandual wrote:
>> A global boot_cpu_data is not really required. Lets drop this.
> 
> I don't think it's true that this isn't required today.
> 
> One reason that we have both boot_cpu_data and a cpu_data variable for
> CPU0 is that CPU0 itself can be hotplugged out then back in, and this
> allows us to detect if CPU0's features have changed (e.g. due to FW
> failing to configure it appropriately, or real physical hotplug
> occurring).

Understood. After hotplug, CPU0 will come back via secondary_start_kernel()
where it's current register values will be checked against earlier captured
values i.e boot_cpu_data.

But wondering why should CPU0 be treated like any other secondary CPU. IOW
in case the fresh boot CPU register values dont match with boot_cpu_data,
should not the online process just be declined ? AFAICS, current approach
will let the kernel run with taint in case of a mismatch.

> 
> So NAK to the patch as it stands. If we're certain we capture all of
> those details even without boot_cpu_data, then we should make other
> changes to make that clear (e.g. removing it as an argument to
> update_cpu_features()).

There might not be another way, unless we can override CPU0's cpu_data
variable when the boot CPU comes back in after vetting against existing
values. Is there any particular reason to store the very first boot CPU0
info for ever ?

Passing on CPU0's cpu_data variable in update_cpu_features() for secondary
CPUs during boot still make sense. It helps in finalizing register values.
Re-entering CPU0's test against boot_cpu_data seems different.
