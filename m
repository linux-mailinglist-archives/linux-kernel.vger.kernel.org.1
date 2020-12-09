Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671C22D4127
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbgLILba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:31:30 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58346 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgLILba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:31:30 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B9BTifS040113;
        Wed, 9 Dec 2020 05:29:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607513384;
        bh=nblWMGQ16OJM7DmaPdQGFyABikxEEhJsMojqXVqqzL4=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=HQKa9c6soKzCympF2k6sX7WVEzu7sHydX3RlMUbfLC4JZ3cOGaMcLWkzQo4dCmwGe
         YgnI2+479j35nCMG5JKuAA16spTKO/v3zZNjs+pnUM48FY7Bkfa2lAnuh9uJgZVx1a
         klJ2OjLoFXXgS9uP/s05YT83GGXmEAZxJ16TtEzk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B9BTiwg043866
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Dec 2020 05:29:44 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 9 Dec
 2020 05:29:43 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 9 Dec 2020 05:29:44 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B9BTgSi027307;
        Wed, 9 Dec 2020 05:29:43 -0600
Subject: Re: [PATCH] drm/tidss: Use the new api devm_drm_irq_install
To:     Tian Tao <tiantao6@hisilicon.com>, <jsarha@ti.com>,
        <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <1607413859-63365-1-git-send-email-tiantao6@hisilicon.com>
 <20201209004828.GN401619@phenom.ffwll.local>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <06c1dee7-488d-8a74-a55c-74043cb060cd@ti.com>
Date:   Wed, 9 Dec 2020 13:29:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209004828.GN401619@phenom.ffwll.local>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2020 02:48, Daniel Vetter wrote:
> On Tue, Dec 08, 2020 at 03:50:59PM +0800, Tian Tao wrote:
>> Use devm_drm_irq_install to register interrupts so that
>> drm_irq_uninstall is not needed to be called.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> 
> There's another drm_irq_install in the error path. But I'm not sure this
> is safe since you're chaning the order in which things get cleaned up now.
> So leaving this up to Tomi.

Right, I don't think this works. tidss irq_uninstall uses runtime_get/put, which needs to happen
before pm_runtime_disable. With devm_drm_irq_install that's not the case.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
