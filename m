Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE3A2B7373
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 02:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbgKRBEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 20:04:38 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7927 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgKRBEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 20:04:38 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CbPhz4Ffjz6vPC;
        Wed, 18 Nov 2020 09:04:19 +0800 (CST)
Received: from [10.174.177.160] (10.174.177.160) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 18 Nov 2020 09:04:23 +0800
Subject: Re: [PATCH v2] drm/sun4i: dw-hdmi: fix error return code in
 sun8i_dw_hdmi_bind()
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <chenzhou10@huawei.com>
References: <1605488969-5211-1-git-send-email-wangxiongfeng2@huawei.com>
 <2294800.5ACB0rnJnf@kista>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <2b800d8c-90c0-42a6-8335-acc5e9e84258@huawei.com>
Date:   Wed, 18 Nov 2020 09:04:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2294800.5ACB0rnJnf@kista>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.160]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/18 1:47, Jernej Škrabec wrote:
> Dne ponedeljek, 16. november 2020 ob 02:09:29 CET je Xiongfeng Wang 
> napisal(a):
>> Fix to return a negative error code from the error handling case instead
>> of 0 in function sun8i_dw_hdmi_bind().
>>
>> Fixes: b7c7436a5ff0 ("drm/sun4i: Implement A83T HDMI driver")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> Applied to drm-misc-fixes, thanks!
> 
> In future, please CC all people given by get_maintainer.pl script. In this 
> case you missed Maxime Ripard and Chen-Yu Tsai.

Sure, thanks for reminding me.

Thanks,
Xiongfeng

> 
> Best regards,
> Jernej
> 
> 
> .
> 
