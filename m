Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A9F2EBFE0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbhAFOxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:53:48 -0500
Received: from foss.arm.com ([217.140.110.172]:42048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbhAFOxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:53:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D06DCD6E;
        Wed,  6 Jan 2021 06:53:01 -0800 (PST)
Received: from [10.57.37.195] (unknown [10.57.37.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F6913F719;
        Wed,  6 Jan 2021 06:52:59 -0800 (PST)
Subject: Re: [PATCH v5 00/25] coresight: etm4x: Support for system
 instructions
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Jonathan Zhou <jonathan.zhouwen@huawei.com>
References: <20201214173731.302520-1-suzuki.poulose@arm.com>
 <CAJ9a7Vgx10RD-8UCaDR1UgGqsOAEjiu2RoxOTcToWkcr6HvT5A@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <daea65cc-2447-2996-528c-a4dfe790c67b@arm.com>
Date:   Wed, 6 Jan 2021 14:52:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAJ9a7Vgx10RD-8UCaDR1UgGqsOAEjiu2RoxOTcToWkcr6HvT5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 1/6/21 2:48 PM, Mike Leach wrote:
> Hi Suzuki,
> 
> In addition to altering patch 18, to put the newly accessible
> TRCDEVARCH register into the more appropriate 'mgmt' subdir for
> CoreSight management registers, an update is needed to
> ./Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x to add a
> reference for this new sysfs file to reflect the location and purpose
> of the register.

Ack. I will do this for the next version.

Cheers
Suzuki
