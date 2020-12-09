Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891452D41C5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbgLIMIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:08:41 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37330 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730684AbgLIMIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:08:40 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B9C6wN0051829;
        Wed, 9 Dec 2020 06:06:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607515618;
        bh=mIpHVh2qPHQSeuk+90pyphGYM7X8n3ixmwucyLP1T58=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BZb8u+dUMklulvZJKxRFdXPYCwrpVN5mENgFKSrCRJI7/jB8siSWsZDrZTqs7BlmG
         w8GQi+uyaGpIfx5eiY1Ai7FEtwZnStUXl55hRKVH1XnYqOUxlE3hIxIinvl0RkSnNH
         JCsweOxUJvdutmzcsSOqQPUhnzs8ikB0SsJvYRCE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B9C6wc6073903
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Dec 2020 06:06:58 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 9 Dec
 2020 06:06:57 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 9 Dec 2020 06:06:57 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B9C6tWv091010;
        Wed, 9 Dec 2020 06:06:56 -0600
Subject: Re: [PATCH] drm/tidss: Use the new api devm_drm_irq_install
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     Tian Tao <tiantao6@hisilicon.com>, Jyri Sarha <jsarha@ti.com>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1607413859-63365-1-git-send-email-tiantao6@hisilicon.com>
 <20201209004828.GN401619@phenom.ffwll.local>
 <06c1dee7-488d-8a74-a55c-74043cb060cd@ti.com>
 <CAKMK7uFsDPH3+CHGwkgtnDOc6pJY=_SocyaghETZda+RgjAJnQ@mail.gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <327508b7-2c63-8f2c-36a7-362c83b4243d@ti.com>
Date:   Wed, 9 Dec 2020 14:06:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uFsDPH3+CHGwkgtnDOc6pJY=_SocyaghETZda+RgjAJnQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2020 13:56, Daniel Vetter wrote:
> On Wed, Dec 9, 2020 at 12:29 PM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>
>> On 09/12/2020 02:48, Daniel Vetter wrote:
>>> On Tue, Dec 08, 2020 at 03:50:59PM +0800, Tian Tao wrote:
>>>> Use devm_drm_irq_install to register interrupts so that
>>>> drm_irq_uninstall is not needed to be called.
>>>>
>>>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>>>
>>> There's another drm_irq_install in the error path. But I'm not sure this
>>> is safe since you're chaning the order in which things get cleaned up now.
>>> So leaving this up to Tomi.
>>
>> Right, I don't think this works. tidss irq_uninstall uses runtime_get/put, which needs to happen
>> before pm_runtime_disable. With devm_drm_irq_install that's not the case.
> 
> Hm I don't spot devm_ versions of these, surely we're not the only
> ones with this problem?

drm-misc-next has these. hisilicon uses it, but doesn't have an irq_uninstall hook, so possibly late
uninstall is fine there.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
