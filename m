Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB6C22C332
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 12:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgGXKhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 06:37:02 -0400
Received: from foss.arm.com ([217.140.110.172]:59778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgGXKhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:37:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6709330E;
        Fri, 24 Jul 2020 03:37:01 -0700 (PDT)
Received: from [10.163.85.90] (unknown [10.163.85.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC33F3F66E;
        Fri, 24 Jul 2020 03:36:55 -0700 (PDT)
Subject: Re: [PATCH -next] arm64: Export __cpu_logical_map
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hulk Robot <hulkci@huawei.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200724030433.22287-1-wangkefeng.wang@huawei.com>
 <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
 <7998529f-da52-5e46-dd09-b9b11d83ec1a@arm.com> <20200724093054.GA23388@gaia>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <bd2e3029-f561-8aab-6772-1be91d457f9d@arm.com>
Date:   Fri, 24 Jul 2020 16:06:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200724093054.GA23388@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/24/2020 03:00 PM, Catalin Marinas wrote:
> On Fri, Jul 24, 2020 at 01:46:18PM +0530, Anshuman Khandual wrote:
>> On 07/24/2020 08:38 AM, Kefeng Wang wrote:
>>> On 2020/7/24 11:04, Kefeng Wang wrote:
>>>> ERROR: modpost: "__cpu_logical_map" [drivers/cpufreq/tegra194-cpufreq.ko] undefined!
>>>>
>>>> ARM64 tegra194-cpufreq driver use cpu_logical_map, export
>>>> __cpu_logical_map to fix build issue.
>> Commit 887d5fc82cb4 ("cpufreq: Add Tegra194 cpufreq driver") which adds
>> this particular driver is present just on linux-next. But as expected,
>> the driver does not use __cpu_logical_map directly but instead accesses
>> it via cpu_logical_map() wrapper. Wondering, how did you even trigger
>> the modpost error ?
> Since the wrapper is a macro, it just expands to __cpu_logical_map[].
> 

Ahh, right. Existing cpu_logical_map() is not a true wrapper and it
makes sense to convert that into one.
