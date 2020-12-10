Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4942F2D606D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391873AbgLJPuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:50:13 -0500
Received: from foss.arm.com ([217.140.110.172]:49334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391207AbgLJPuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:50:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8F431FB;
        Thu, 10 Dec 2020 07:49:27 -0800 (PST)
Received: from [10.57.1.60] (unknown [10.57.1.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C4A53F68F;
        Thu, 10 Dec 2020 07:49:26 -0800 (PST)
Subject: Re: [PATCH v2 1/4] thermal/core: Rename passive_delay and
 polling_delay with units
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20201207190902.30464-1-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <515c6301-0f52-2975-2ef0-1efda6fffdba@arm.com>
Date:   Thu, 10 Dec 2020 15:49:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201207190902.30464-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/20 7:08 PM, Daniel Lezcano wrote:
> The input unit used by the thermal framework is the msec but it uses
> the jiffies to set the timers.
> 
> As it is stored in the thermal zone device structure, everytime the
> timer is setup at each polling interval, the msecs to jiffies
> conversion happens. The jiffies is the unit the thermal framework is
> using, so keeping it under the jiffies instead of msecs will save some
> pointless conversion.

Make sense

> 
> Set the scene to directly store the delays under their jiffies
> form by adding to the variable name the 'ms' suffix.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
