Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7372F267F9E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 15:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgIMNNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 09:13:47 -0400
Received: from foss.arm.com ([217.140.110.172]:54446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgIMNNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 09:13:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C242106F;
        Sun, 13 Sep 2020 06:13:42 -0700 (PDT)
Received: from [192.168.0.21] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05FD33F68F;
        Sun, 13 Sep 2020 06:13:38 -0700 (PDT)
Subject: Re: [PATCH v10 10/24] coresight: etm4x: allow etm4x to be built as a
 module
To:     tingwei@codeaurora.org, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com, mike.leach@linaro.org
Cc:     kim.phillips@arm.com, gregkh@linuxfoundation.org,
        leo.yan@linaro.org, rdunlap@infradead.org, linux@armlinux.org.uk,
        ykaukab@suse.de, tsoni@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, jinlmao@codeaurora.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-11-tingwei@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <6d15ba79-2cd8-9428-e9f2-0b5e7b29f833@arm.com>
Date:   Sun, 13 Sep 2020 14:18:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200821034445.967-11-tingwei@codeaurora.org>
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
> Allow to build coresight-etm4x as a module, for ease of development.
> 
> - Kconfig becomes a tristate, to allow =m
> - append -core to source file name to allow module to
>    be called coresight-etm4x by the Makefile
> - add an etm4_remove function, for module unload
> - add a MODULE_DEVICE_TABLE for autoloading on boot
> - delay advertising the per-cpu etmdrvdata
> - protect etmdrvdata[] by modifying it on relevant CPU
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Tested-by: Mike Leach <mike.leach@linaro.org>
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
