Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316012A9760
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgKFODU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:03:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40166 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgKFODU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:03:20 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A6E3EUv127757;
        Fri, 6 Nov 2020 08:03:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604671394;
        bh=5+kSDz856W1qx9cgvwWKSlzBi71LyL62j0NDBZaEQl0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=O2WSFqsFIMe0Q1RSP2MCw3LBR7/jynlpK8Bsc0sn52XZ1/TE1GpkdpB/jGG6FCXwG
         FD8n4kIsQ5cc/B9YoO1p4ojNYkzCjcmQdXynVKkXU/Rf2ZX5NkkdRLNgkRQ+oRt8v+
         gEXlCrvoznkcWRUKnYGCEnXKMZoPnbPke7DNPvao=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A6E3E6n100939
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Nov 2020 08:03:14 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 6 Nov
 2020 08:03:13 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 6 Nov 2020 08:03:13 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A6E3BJf004038;
        Fri, 6 Nov 2020 08:03:12 -0600
Subject: Re: [PATCH 08/19] gpu: drm: omapdrm: dss: dsi: Rework and remove a
 few unused variables
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <dri-devel@lists.freedesktop.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-9-lee.jones@linaro.org>
 <74399fab-6af5-77d3-e0eb-749774eb2837@ti.com> <20201105180725.GO4488@dell>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <e48964e6-4a94-4495-0217-90db19fff629@ti.com>
Date:   Fri, 6 Nov 2020 16:03:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105180725.GO4488@dell>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2020 20:07, Lee Jones wrote:
> On Thu, 05 Nov 2020, Tomi Valkeinen wrote:
> 
>> On 05/11/2020 16:45, Lee Jones wrote:
>>> Fixes the following W=1 kernel build warning(s):
>>>
>>>  drivers/gpu/drm/omapdrm/dss/dsi.c: In function ‘_dsi_print_reset_status’:
>>>  drivers/gpu/drm/omapdrm/dss/dsi.c:1131:6: warning: variable ‘l’ set but not used [-Wunused-but-set-variable]
>>>  drivers/gpu/drm/omapdrm/dss/dsi.c: In function ‘dsi_update’:
>>>  drivers/gpu/drm/omapdrm/dss/dsi.c:3943:10: warning: variable ‘dh’ set but not used [-Wunused-but-set-variable]
>>>  drivers/gpu/drm/omapdrm/dss/dsi.c:3943:6: warning: variable ‘dw’ set but not used [-Wunused-but-set-variable]
>>>
>>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> Cc: David Airlie <airlied@linux.ie>
>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>> Cc: dri-devel@lists.freedesktop.org
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>  drivers/gpu/drm/omapdrm/dss/dsi.c | 9 ++-------
>>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> I'd use "drm/omap: dsi: " subject prefix, the current one is fine too:
>>
>> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>
>> Should I pick this up or do you want to keep the series intact?
> 
> If you are in a position to take it, please do so.
> 
> I rebase every day, so it will just vanish from my working set.

I have a 56 patch series on dsi.c that I sent yesterday, and it conflicts with this one. I'll pick
this one on top of my series.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
