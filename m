Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BC526A3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 13:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgIOLM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 07:12:29 -0400
Received: from foss.arm.com ([217.140.110.172]:33064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgIOLKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:10:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C8BB1FB;
        Tue, 15 Sep 2020 04:03:28 -0700 (PDT)
Received: from [10.57.48.219] (unknown [10.57.48.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B886B3F718;
        Tue, 15 Sep 2020 04:03:25 -0700 (PDT)
Subject: Re: [PATCH v11 06/24] coresight: add try_get_module() in
 coresight_grab_device()
To:     tingwei@codeaurora.org, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com, mike.leach@linaro.org
Cc:     gregkh@linuxfoundation.org, leo.yan@linaro.org,
        rdunlap@infradead.org, linux@armlinux.org.uk, kim.phillips@arm.com,
        ykaukab@suse.de, tsoni@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, jinlmao@codeaurora.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200915104116.16789-1-tingwei@codeaurora.org>
 <20200915104116.16789-7-tingwei@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <12e78abe-f5e0-0016-8984-f16aed77c755@arm.com>
Date:   Tue, 15 Sep 2020 12:08:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200915104116.16789-7-tingwei@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/15/2020 11:40 AM, Tingwei Zhang wrote:
> When coresight device is in an active session, driver module of
> that device should not be removed. Use try_get_module() in
> coresight_grab_device() to prevent module to be unloaded.
> Use get_device()/put_device() to protect device data
> in the middle of active session.
> 
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Tested-by: Mike Leach <mike.leach@linaro.org>
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

