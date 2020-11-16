Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7989A2B3B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 02:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgKPBJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 20:09:25 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7501 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgKPBJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 20:09:25 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CZ9vb0T4Qzhb83;
        Mon, 16 Nov 2020 09:09:15 +0800 (CST)
Received: from [10.174.177.160] (10.174.177.160) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 09:09:15 +0800
Subject: Re: [PATCH] drm/sun4i: dw-hdmi: fix error return code in
 sun8i_dw_hdmi_bind()
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <chenzhou10@huawei.com>
References: <1605186891-47282-1-git-send-email-wangxiongfeng2@huawei.com>
 <6119042.uhm7frSX9h@jernej-laptop>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <fc7c7191-52d2-2a00-57b3-7b19f4e72955@huawei.com>
Date:   Mon, 16 Nov 2020 09:09:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6119042.uhm7frSX9h@jernej-laptop>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.160]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2020/11/14 2:01, Jernej Škrabec wrote:
> Hi!
> 
> Thanks for the patch.
> 
> Dne četrtek, 12. november 2020 ob 14:14:51 CET je Xiongfeng Wang napisal(a):
>> Fix to return a negative error code from the error handling case instead
>> of 0 in function sun8i_dw_hdmi_bind().
>>
>> Fixes: b7c7436a5ff0 ("drm/sun4i: Implement A83T HDMI driver")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>> b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c index d4c0804..f010fe8 100644
>> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>> @@ -208,6 +208,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct
>> device *master, phy_node = of_parse_phandle(dev->of_node, "phys", 0);
>>  	if (!phy_node) {
>>  		dev_err(dev, "Can't found PHY phandle\n");
>> +		ret = -ENODEV;
> 
> That should be EINVAL because DT node doesn't have mandatory property.
> 
> With that fixed, you can add:
> Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Thanks for your review! I will fix it in the next version.

Thanks,
Xiongfeng

> 
> Best regards,
> Jernej
> 
>>  		goto err_disable_clk_tmds;
>>  	}
> 
> 
> 
> 
> .
> 
