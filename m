Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B0D26BF4D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgIPIaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:30:14 -0400
Received: from mail1.perex.cz ([77.48.224.245]:54522 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgIPIaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:30:10 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 891FBA0040;
        Wed, 16 Sep 2020 10:30:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 891FBA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1600245007; bh=TQ91kqqBQQybpadn/+Q9Y8FSsSvI6ypsdUv0cosU3CM=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=IiaEKTyCnpjT8j/yhk3609FCgP8g6kueBlGDF+od8ixsS6wI/CmngbZHYNSjkl36E
         gzxvA3w1VHj2zJvTbiuBXwiggWrTZR1iszIGZrWABsUnuHQ0kvFlLPhpDqvRf1gQG7
         tTGEvhi/xScRmH8+2wg37cNYh9JzWFob+6RY/hWI=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed, 16 Sep 2020 10:29:52 +0200 (CEST)
Subject: Re: [PATCH] soundwire: Add generic bandwidth allocation algorithm
From:   Jaroslav Kysela <perex@perex.cz>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, gregkh@linuxfoundation.org,
        ranjani.sridharan@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, hui.wang@canonical.com,
        srinivas.kandagatla@linaro.org, bard.liao@intel.com,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, linux-kernel@vger.kernel.org
References: <20200908131520.5712-1-yung-chuan.liao@linux.intel.com>
 <fdf22a3c-457f-09ef-8dc5-c0f3871cf2ce@perex.cz>
Message-ID: <02abf228-f331-61fb-d8f6-d1df4b2f54a3@perex.cz>
Date:   Wed, 16 Sep 2020 10:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <fdf22a3c-457f-09ef-8dc5-c0f3871cf2ce@perex.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 09. 09. 20 v 8:26 Jaroslav Kysela napsal(a):
> Dne 08. 09. 20 v 15:15 Bard Liao napsal(a):
>> This algorithm computes bus parameters like clock frequency, frame
>> shape and port transport parameters based on active stream(s) running
>> on the bus.
>>
>> Developers can also implement their own .compute_params() callback for
>> specific resource management algorithm, and set if before calling
>> sdw_add_bus_master()
>>
>> Credits: this patch is based on an earlier internal contribution by
>> Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. All hard-coded
>> values were removed from the initial contribution to use BIOS
>> information instead.
>>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> ---
>>  drivers/soundwire/Kconfig                     |   5 +
>>  drivers/soundwire/Makefile                    |   3 +
>>  drivers/soundwire/bus.c                       |   6 +
>>  drivers/soundwire/bus.h                       |  46 +-
>>  .../soundwire/generic_bandwidth_allocation.c  | 427 ++++++++++++++++++
>>  drivers/soundwire/intel.c                     |   3 +
>>  drivers/soundwire/stream.c                    |  12 +
>>  include/linux/soundwire/sdw.h                 |   3 +
>>  8 files changed, 503 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/soundwire/generic_bandwidth_allocation.c
> 
> I did testing and I've not found any issues. The abstraction looks good.
> 
> Acked-by: Jaroslav Kysela <perex@perex.cz>
> 

Vinod, ping.... This is the last patch which is missing to get the soundwire
audio working on some Intel hardware platforms (laptops) which are already on
the market.

				Thank you,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
