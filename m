Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010AC2AD6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgKJMyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:54:41 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57278 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJMyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:54:41 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AACsAJ5020651;
        Tue, 10 Nov 2020 06:54:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605012850;
        bh=jCWkNxwtZ43dEYnId2Q7mpdUlLKFvEBlwgl1acIy4mg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dEbOAZrfCv1qN/Lf7Eopxdbwbls4kEeqsRqHSt+wVoJ4wha77LARhNlxMql11XEKW
         4aCavO4j+I0eIKuWTI0IibnxtmAt4OAmAnU+Qd3QYXA0wHK67XvLFtqbHXuf6jg0Il
         IFLZzhla1U4pQksY218L/SN8hWT8ihpVSRe8xVxU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AACsAP2057958
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 06:54:10 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 10
 Nov 2020 06:54:10 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 10 Nov 2020 06:54:10 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AACs6Q6101201;
        Tue, 10 Nov 2020 06:54:07 -0600
Subject: Re: [PATCH] [v2] drm/omap: Fix runtime PM imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, <kjlu@umn.edu>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        zhengbin <zhengbin13@huawei.com>, Jyri Sarha <jsarha@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20200822065743.13671-1-dinghao.liu@zju.edu.cn>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <1457eb91-eefe-acd1-e605-5f018437fe70@ti.com>
Date:   Tue, 10 Nov 2020 14:54:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200822065743.13671-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2020 09:57, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter
> even when it returns an error code. However, users of its
> direct wrappers in omapdrm assume that PM usage counter will
> not change on error. Thus a pairing decrement is needed on
> the error handling path for these wrappers to keep the counter
> balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: - Fix 5 additional similar cases in omapdrm.

Thanks, I'll apply to drm-misc-next.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
