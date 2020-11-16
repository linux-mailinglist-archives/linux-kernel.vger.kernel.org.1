Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5162B459B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgKPOOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:14:36 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53038 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgKPOOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:14:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AGEECjG098332;
        Mon, 16 Nov 2020 08:14:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605536052;
        bh=CesylDhKL5F2RLO21Mz02Qpf8QzNoQ/J7g1qiBS/bhk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WgMz8DPq7tarq6XoqKf+09VI1CV/IylTOh3eRy4neU4iGFxwlpzL+JYRGLn6nwLJD
         r+len0k2/7TlqmXVEq028HR8JT6yI8M5qz5N27t0rM9P71V1PTskiVeREfth+v5LpI
         14RyGKzaKeX+PeKX5W7C8RRX9n5j+TAQfkdwIn3s=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AGEEBNq087815
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 08:14:11 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 16
 Nov 2020 08:14:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 16 Nov 2020 08:14:11 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AGEE7b8075117;
        Mon, 16 Nov 2020 08:14:08 -0600
Subject: Re: [PATCH v1 0/4] Add bus format negotiation support for Cadence
 MHDP8546 driver
To:     Yuti Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <maxime@cerno.tech>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <mark.rutland@arm.com>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>
CC:     <nsekhar@ti.com>, <jsarha@ti.com>, <nikhil.nd@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>
References: <1605260794-29806-1-git-send-email-yamonkar@cadence.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <90d19291-f0ca-df64-1687-3b25fbf418de@ti.com>
Date:   Mon, 16 Nov 2020 16:14:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1605260794-29806-1-git-send-email-yamonkar@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/11/2020 11:46, Yuti Amonkar wrote:
> This patch series add bus format negotiation support for Cadence MHDP8546 bridge
> driver.
> 
> The patch series has four patches in the below sequence:
> 1. drm: bridge: cdns-mhdp8546: Add output bus format negotiation
> Add minimal output bus format negotiation support.
> 2. drm: bridge: cdns-mhdp8546: Modify atomic_get_input_bus_format bridge function.
> Get the input format based on output format supported.
> 3. drm: bridge: cdns-mhdp8546: Remove setting of bus format using connector info
> Remove the bus format configuration using connector info structure.
> 4. drm: bridge: cdns-mhdp8546: Retrieve the pixel format and bpc based on bus format
> Get the pixel format and bpc based on negotiated output bus format.
> 
> This patch series is dependent on tidss series [1] for the new connector model support.
> 
> [1]
> https://patchwork.kernel.org/project/dri-devel/cover/20201109170601.21557-1-nikhil.nd@ti.com/ 

Can you explain how this works?

Afaics, what we should be doing is:

- We don't have proper bus formats for DP output, so we need to use MEDIA_BUS_FMT_FIXED as the
output format. This is what you do in the first patch. (But is that patch even needed, if
MEDIA_BUS_FMT_FIXED is the default anyway)

- In cdns_mhdp_get_input_bus_fmts, the function should exit if the given output format is not
MEDIA_BUS_FMT_FIXED.

- In cdns_mhdp_get_input_bus_fmts, the driver should return all the RGB bus formats, if MHDP is able
to upscale/downscale RGB (e.g. RGB 8-bpc to RGB 12-bpc).

- If the monitor supports YUV modes according to the display_info, cdns_mhdp_get_input_bus_fmts can
also return those.

- Then later, in atomic_check and commit, mhdp driver has the negotiated bus format, which it should
use to program the registers.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
