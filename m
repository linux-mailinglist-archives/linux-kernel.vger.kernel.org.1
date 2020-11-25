Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666B52C4AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 23:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgKYWjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 17:39:07 -0500
Received: from foss.arm.com ([217.140.110.172]:48958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgKYWjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 17:39:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24DEA31B;
        Wed, 25 Nov 2020 14:39:07 -0800 (PST)
Received: from [10.57.56.151] (unknown [10.57.56.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 559213F70D;
        Wed, 25 Nov 2020 14:39:04 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Adding help for coresight subsystem
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        gregkh@linuxfoundation.org, leo.yan@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20201125223519.734388-1-mathieu.poirier@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b0353dbd-06e5-5bde-a8fb-5ad5d431c560@arm.com>
Date:   Wed, 25 Nov 2020 22:38:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201125223519.734388-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/20 10:35 PM, Mathieu Poirier wrote:
> With the steady stream of new features coming into the subsystem
> it has been clear for some time now that help is needed.
> 
> Suzuki and Leo have worked extensively on various parts of the
> project and have agreed to help.
> 
> While at it add the new location for the coresight git tree.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   MAINTAINERS | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b75f29..8d0b008c7781 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1723,11 +1723,13 @@ F:	arch/arm/mach-ep93xx/micro9.c
>   
>   ARM/CORESIGHT FRAMEWORK AND DRIVERS
>   M:	Mathieu Poirier <mathieu.poirier@linaro.org>
> -R:	Suzuki K Poulose <suzuki.poulose@arm.com>
> +M:	Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by : Suzuki K Poulose <suzuki.poulose@arm.com>
