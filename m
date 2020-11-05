Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49752A840A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbgKEQx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:53:26 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55418 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKEQxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:53:25 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A5GrKSd051762;
        Thu, 5 Nov 2020 10:53:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604595200;
        bh=bJHxWXo+htEqIJck0oZ4xC9NV1O36+j9LjNAzdp58ms=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EGd6RItcFRPVPWaPhXlQOd5+xwYqgh7nzhmM97enuIGayTDI5zeAb/ODpjJuJtHGw
         vy91Z52rqq0U9GKxhM4zQ2SqUPMU0RIj6e1OH5/GEYQMTWFTYp8m0IVFv8yFl5I+Ld
         VnLyhf4c6qoEWv9O2Pzi5JcuR53QGMi24WE/a3dc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A5GrKY6045430
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Nov 2020 10:53:20 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 5 Nov
 2020 10:53:19 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 5 Nov 2020 10:53:20 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A5GrId2050489;
        Thu, 5 Nov 2020 10:53:18 -0600
Subject: Re: [PATCH 08/19] gpu: drm: omapdrm: dss: dsi: Rework and remove a
 few unused variables
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <dri-devel@lists.freedesktop.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-9-lee.jones@linaro.org>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <74399fab-6af5-77d3-e0eb-749774eb2837@ti.com>
Date:   Thu, 5 Nov 2020 18:53:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105144517.1826692-9-lee.jones@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2020 16:45, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/omapdrm/dss/dsi.c: In function ‘_dsi_print_reset_status’:
>  drivers/gpu/drm/omapdrm/dss/dsi.c:1131:6: warning: variable ‘l’ set but not used [-Wunused-but-set-variable]
>  drivers/gpu/drm/omapdrm/dss/dsi.c: In function ‘dsi_update’:
>  drivers/gpu/drm/omapdrm/dss/dsi.c:3943:10: warning: variable ‘dh’ set but not used [-Wunused-but-set-variable]
>  drivers/gpu/drm/omapdrm/dss/dsi.c:3943:6: warning: variable ‘dw’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/omapdrm/dss/dsi.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

I'd use "drm/omap: dsi: " subject prefix, the current one is fine too:

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Should I pick this up or do you want to keep the series intact?

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
