Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62ED52F4228
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbhAMC67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:58:59 -0500
Received: from mail.loongson.cn ([114.242.206.163]:35318 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726499AbhAMC67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:58:59 -0500
Received: from [10.20.41.29] (unknown [10.20.41.29])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxdbyyYf5f+oQDAA--.3457S2;
        Wed, 13 Jan 2021 10:57:54 +0800 (CST)
Subject: Re: [PATCH] drm: Improve the output_poll_changed description
To:     Daniel Vetter <daniel@ffwll.ch>
References: <20210112104644.341345-1-zhangzhijie@loongson.cn>
 <X/2wNLjupzAS7O5c@phenom.ffwll.local>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   "zhangzhijie@loongson.cn" <zhangzhijie@loongson.cn>
Message-ID: <1e9f3753-48b8-ac65-57a8-2c364b5c8fac@loongson.cn>
Date:   Wed, 13 Jan 2021 10:57:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X/2wNLjupzAS7O5c@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxdbyyYf5f+oQDAA--.3457S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4ftw1kGF15Zw17AF18Zrb_yoW8uryUpr
        W3A3yYkr4qgFs09F4xKa4IgF18Jws3JFW8tFsYgw4Ykrn8KrnFvFyDGr15uF9xXrZrJr42
        qayS9F98uw18CrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
        xK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
        uYvjxUqEoXUUUUU
X-CM-SenderInfo: x2kd0wx2klyx3h6o00pqjv00gofq/1tbiAQAAAF3QvM14lwABsT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/21 10:20 PM, Daniel Vetter wrote:
> On Tue, Jan 12, 2021 at 06:46:44PM +0800, ZhiJie.Zhang wrote:
>> From: zhangzhijie <zhangzhijie@loongson.cn>
>>
>> codeview the implementation of few Drivers.
> 
> I'm not really understanding what you're trying to say here.
> 
I exc "make  htmls" and read the gpu's html via browser.
then founded that drm_fb_helper_hotplug_changed not a tag in kernel.
then I touch this callback been called via drm_kms_helper_hotplug_event().

Sorry， I will delete this words at next push

>> this callback was used by drm_kms_helper_hotplug_event()
>>
>> Signed-off-by: zhangzhijie <zhangzhijie@loongson.cn>
>> ---
>>   include/drm/drm_mode_config.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
>> index ab424ddd7665..e01c4d0f07d1 100644
>> --- a/include/drm/drm_mode_config.h
>> +++ b/include/drm/drm_mode_config.h
>> @@ -104,7 +104,7 @@ struct drm_mode_config_funcs {
>>   	 * changes.
>>   	 *
>>   	 * Drivers implementing fbdev emulation with the helpers can call
>> -	 * drm_fb_helper_hotplug_changed from this hook to inform the fbdev
>> +	 * drm_kms_helper_hotplug_event() from this hook to inform the fbdev
>>   	 * helper of output changes.
> 
> I think since we touch this, maybe better to revamp it complete. The best
> way to handle all this is by registering a struct drm_client, since that
> provides the &drm_client_funcs.hotplug callback. Also for fbdev support
> drivers shouldn't even use that, but instead use the
> drm_fbdev_generic_setup() function, which takes care of everything.
> 
> I think we can also remove the FIXME below, since with the drm_client
> infrastructure and the generic fbdev emulation we've resolved this all
> very neatly now.
> 
> Can you please respin with my suggestions taking into account somehow?
> 
> Thanks, Daniel
> 
Could i copy this words to comment of output_poll_changed?
I want better reading the gpu's chapter at kernel doc

Thanks，ZhiJie
>>   	 *
>>   	 * FIXME:
>> -- 
>> 2.29.2
>>
> 

