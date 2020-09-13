Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B5B267FA0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 15:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgIMNP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 09:15:57 -0400
Received: from foss.arm.com ([217.140.110.172]:54488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgIMNPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 09:15:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E36C106F;
        Sun, 13 Sep 2020 06:15:44 -0700 (PDT)
Received: from [192.168.0.21] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCD023F68F;
        Sun, 13 Sep 2020 06:15:40 -0700 (PDT)
Subject: Re: [PATCH v10 14/24] coresight: allow funnel driver to be built as
 module
To:     tingwei@codeaurora.org, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com, mike.leach@linaro.org
Cc:     kim.phillips@arm.com, gregkh@linuxfoundation.org,
        leo.yan@linaro.org, rdunlap@infradead.org, linux@armlinux.org.uk,
        ykaukab@suse.de, tsoni@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, jinlmao@codeaurora.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-15-tingwei@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <5d2bdce2-2ad1-db31-8807-bf5dd41b20d2@arm.com>
Date:   Sun, 13 Sep 2020 14:20:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200821034445.967-15-tingwei@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/2020 04:44 AM, Tingwei Zhang wrote:
> From: Kim Phillips <kim.phillips@arm.com>
> 
> Allow to build coresight-funnel as module, for ease of development.
> 
> - combine static and dynamic funnel init into single
>    module_init/exit call
> - add funnel_remove functions, for module unload
> - add a MODULE_DEVICE_TABLE for autoloading on boot
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Co-developed-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Tested-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
