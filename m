Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945FC277538
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgIXP0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:26:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:52937 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgIXP0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:26:13 -0400
IronPort-SDR: Q1QgdfoFTjES77cpSnZOMml8lOBxo12t0xdEmlanTkQpFP+5n4s4WFu2h/X+1vz6j6rr39ezAn
 jfaChtGigH/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="140682072"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="140682072"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 08:26:13 -0700
IronPort-SDR: B0aRA+X0VcnD4Kv9nyTI3ri6M6OhVSh5exjBqLT3Lh4qNYPaR4St9y42RoFkfshJ4sGuSWnoTN
 DPhAw0JTSDKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="336024808"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2020 08:26:13 -0700
Subject: Re: [RESEND PATCHv1] MAINTAINERS: altera: change maintainer for
 Altera drivers
To:     mchehab+huawei@kernel.org, davem@davemloft.net, robh@kernel.org,
        gregkh@linuxfoundation.org, thor.thayer@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
References: <1595606355-1329-1-git-send-email-richard.gong@linux.intel.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <0d445238-fcf5-39f4-92b3-69346e681efa@linux.intel.com>
Date:   Thu, 24 Sep 2020 10:45:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595606355-1329-1-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for asking.

This patch was submitted on July and is pending for approval. Would you 
mind reviewing that?

Regards,
Richard

On 7/24/20 10:59 AM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Thor is moving to a new position and I will take over the maintainership.
> Add myself as maintainer for 3 Altera drivers below:
> 1. Altera I2C driver
> 2. Altera System Manager driver
> 3. Altera System Resource driver
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>   MAINTAINERS | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b4a43a9..d87a307 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -750,7 +750,7 @@ R:	Pali Rohár <pali@kernel.org>
>   F:	drivers/input/mouse/alps.*
>   
>   ALTERA I2C CONTROLLER DRIVER
> -M:	Thor Thayer <thor.thayer@linux.intel.com>
> +M:	Richard Gong <richard.gong@linux.intel.com>
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/i2c/i2c-altera.txt
>   F:	drivers/i2c/busses/i2c-altera.c
> @@ -767,13 +767,13 @@ S:	Maintained
>   F:	drivers/gpio/gpio-altera.c
>   
>   ALTERA SYSTEM MANAGER DRIVER
> -M:	Thor Thayer <thor.thayer@linux.intel.com>
> +M:	Richard Gong <richard.gong@linux.intel.com>
>   S:	Maintained
>   F:	drivers/mfd/altera-sysmgr.c
>   F:	include/linux/mfd/altera-sysmgr.h
>   
>   ALTERA SYSTEM RESOURCE DRIVER FOR ARRIA10 DEVKIT
> -M:	Thor Thayer <thor.thayer@linux.intel.com>
> +M:	Richard Gong <richard.gong@linux.intel.com>
>   S:	Maintained
>   F:	drivers/gpio/gpio-altera-a10sr.c
>   F:	drivers/mfd/altera-a10sr.c
> 
