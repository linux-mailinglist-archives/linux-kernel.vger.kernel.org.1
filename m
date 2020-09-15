Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A2D26A07F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgIOIRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:17:42 -0400
Received: from foss.arm.com ([217.140.110.172]:57674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgIOIQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:16:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A653930E;
        Tue, 15 Sep 2020 01:16:52 -0700 (PDT)
Received: from [10.57.48.219] (unknown [10.57.48.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 813B83F68F;
        Tue, 15 Sep 2020 01:16:51 -0700 (PDT)
Subject: Re: [PATCH v5] perf: arm_dsu: Support DSU ACPI devices
To:     tuanphan@amperemail.onmicrosoft.com
Cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1599694141-16056-1-git-send-email-tuanphan@os.amperecomputing.com>
 <202009102143.A4pW4A7I%lkp@intel.com>
 <C7729DCE-57C3-4ADD-AFD4-3992798F1FF9@amperemail.onmicrosoft.com>
 <6b04416d-497b-4687-2c79-08d029cf758d@arm.com>
 <05A48968-34CD-41DA-9699-0FC051D8553B@amperemail.onmicrosoft.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <01794d54-4aeb-431d-dd67-d56ec231a19e@arm.com>
Date:   Tue, 15 Sep 2020 09:21:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <05A48968-34CD-41DA-9699-0FC051D8553B@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tuan

On 09/14/2020 05:21 PM, Tuan Phan wrote:

>>>> Reported-by: kernel test robot <lkp@intel.com <mailto:lkp@intel.com>>
>>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>>>>> drivers/perf/arm_dsu_pmu.c:799:36: warning: unused variable 
>>>>>> 'dsu_pmu_acpi_match' [-Wunused-const-variable]
>>>>   static const struct acpi_device_id dsu_pmu_acpi_match[] = {
>>>>                                      ^
>>>>   1 warning generated.
>>>>
>>> Do you need me to fix this warning when CONFIG_ACPI not defined?
>>
>> Yes, please. The kernel should compile fine in any config. Any compiler
>> warning is not good (unless the compiler is wrong).
> 
> I will fix it. I asked because with no CONFIG_ACPI, i saw the same 
> message on other drivers.

Please could you share the logs here, we could fix them too. Or patches
welcome.

Cheers
Suzuki
