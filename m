Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF1A2EEEBE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 09:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbhAHIoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 03:44:32 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:48918 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbhAHIoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 03:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610095472; x=1641631472;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wPUU4hxGZftqzKMbOXy5+qbuH+mXG/oBGd8Kkh7MHRw=;
  b=s3+fNSC7H+l9W/Jtd8y2qy2FCwtDfy4l9+U02/YJzxIok6s9PLwSUDO/
   GHdqQ9RNAoezC+zPGriyn8I98YCgx3I54+rA8YVk9EDSvf0bNvypCaScG
   ZZXiruq4QnfuIbqzsrDwn7fGYo3+AruaoUIaP84G5fpb89CH39IkQNdE9
   sg7mqqEm7gX2UFU3gR6dKpTE4P3xDCAxK/3w9fIBfkSF7FBODz76Fvban
   3mbaTQ5KEm1ZoCuNSqXZXqvGTr0ksFxuMuVZTo+ARqqGMBypxkAoF15he
   CUFNHGokABRWqPyN3qDJ8DSK6SseyuSYs9Yx5rZaqSDqa03Qpf3mWZl4f
   w==;
IronPort-SDR: I3KEiww94MEM0CgiaavhMTAjweX4p814HED3ZZmPd6QkGZaMUVTuUFLxRIzJb2MpzgJtnPI9+9
 YsDx2eEJ0vMMS6AJeWcMC5F2HnCJ0gMOOysPEJ+yrpT6XmH+st4XnJkmksZKQpr7Un5oIb823b
 7m8muL47OK96I2NWOsL6eqpEa4ssJmjV6sxgJPU206LfvgHAcnGQ2mo2JB/6UuEzdjlsSadtwJ
 ydooDX+SIo0Y3Jml0ZJlcv+Tk/zkeVZcxytp0judAFQSIwYYThLFP+oLm2p7wSbQly0B5ppRSz
 el0=
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="39761463"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jan 2021 01:43:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 8 Jan 2021 01:43:10 -0700
Received: from [10.171.246.100] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 8 Jan 2021 01:43:07 -0700
Subject: Re: [PATCH 3/3] MAINTAINERS: add myself as maintainer for mcp16502
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1610028927-9842-1-git-send-email-claudiu.beznea@microchip.com>
 <1610028927-9842-4-git-send-email-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <922dcaa0-b845-7f91-6c5a-5aad1b4341c3@microchip.com>
Date:   Fri, 8 Jan 2021 09:43:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1610028927-9842-4-git-send-email-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2021 at 15:15, Claudiu Beznea wrote:
> Andrei is no longer with Microchip. Add myself as maintainer for
> MCP16502. Along with this change the status from maintained to
> supported.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

For the record:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Claudiu!

Regards,
   Nicolas

> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6eff4f720c72..1cd9914b95eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11690,9 +11690,9 @@ F:	drivers/video/fbdev/atmel_lcdfb.c
>   F:	include/video/atmel_lcdc.h
>   
>   MICROCHIP MCP16502 PMIC DRIVER
> -M:	Andrei Stefanescu <andrei.stefanescu@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -S:	Maintained
> +S:	Supported
>   F:	Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
>   F:	drivers/regulator/mcp16502.c
>   
> 


-- 
Nicolas Ferre
