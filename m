Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B9C2FF1BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbhAURYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388678AbhAURX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:23:59 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8629C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:23:18 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m1so1836890wrq.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jrQ117e9rKdRX0ggNjZWyvNJf7Q2Kd1ZAAwvvs88o4k=;
        b=iq7gVo/2cAaYIqYQJzx28kvPUq73Rw/nAppQC219L/Bmt00/uixnyV96uaYqkcckIz
         wVMD7SkbKz4/YrsZS6ahohiHfFEzvK7jhr2oITBAiicAjnpEI8B+Tsfxq92beaqALsaB
         SWhiCC942ofZXDabA5nNZlbHvyteuybUiwb3RoVvEZKz6h99KP7FhcXbnQdsEv7cEnsQ
         4/1I2DOiXGO1ctT2CgwD2+vmh86Yy6OrvLivvbEirAMgObCTMtk4zCQIu9GGlpaW2r+x
         hisxfBEofvgcceOTEX3xO+RlO0YxJOI23Ek9FiAL58ZIIMe0GUyV9796y39lgCTZisoQ
         Yfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jrQ117e9rKdRX0ggNjZWyvNJf7Q2Kd1ZAAwvvs88o4k=;
        b=U96soigC7CgKeZl2uMU4d3O9Q3+qn+z571hcVHHz+lgBFdz8naA0vSV+I0k5yiQ5ZB
         tvUYVbsecEQWJc7JP1O0q7dPZje0XEJjQCXRpWxt09VXuzDHiw9Q9bcAwwUc5zxd0jDU
         C6uvO8wQG3IhodPtqYcoA5TiE2d/a01cyjFBtMIS25u2Ja7/dw8W3XybNUKo38CyIQfW
         vqbP/auAlLEZyC1ZqYQjHlrAJcMFcGR0Buqocas3t5nFt9S8qmgC0ObG0AM+m2qJCpG2
         HvHKQ7ZI4bm1qQcyNFxAYETFfWAhIyUAoa5SKA/10997p1qWaphSIWxKjLWgzXsQ/YJk
         xLNg==
X-Gm-Message-State: AOAM531Q/ZHRISfUp8D7VBZUg18gu+jZlYwI8hhLl+P3kpDb+ybwsMvl
        8tGzDWvvMta1SwSGHZlgFe3N2g==
X-Google-Smtp-Source: ABdhPJzmpWKgxYOZNlDSS3ZCFf6nw/9Ar/frrAx9xmYIIlhoRyyCK4qnpFdKAMe+eBXYENSH8CaTiA==
X-Received: by 2002:adf:dc89:: with SMTP id r9mr531623wrj.52.1611249797530;
        Thu, 21 Jan 2021 09:23:17 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id r126sm9110206wma.48.2021.01.21.09.23.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 09:23:16 -0800 (PST)
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org,
        sanyog.r.kale@intel.com
References: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
 <20210119145220.GS2771@vkoul-mobl>
 <45300dc3-00b0-497b-804e-f7f1e857f32a@linux.intel.com>
 <57d5f1bd-50fa-30ab-03c0-260460e45d61@linaro.org>
 <6d4d4a6b-f28c-81db-4e67-2b5b94116fa4@linux.intel.com>
 <1fad2388-27d0-7014-818d-1272fa70ed9b@linaro.org>
 <33fe8455-01b4-f867-4974-a3e867c930f0@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <feee8676-33fe-7929-8b6c-6abe3a09159a@linaro.org>
Date:   Thu, 21 Jan 2021 17:23:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <33fe8455-01b4-f867-4974-a3e867c930f0@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/01/2021 15:12, Pierre-Louis Bossart wrote:
> 
> 
> On 1/21/21 6:03 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 19/01/2021 19:09, Pierre-Louis Bossart wrote:
>>>
>>>> currently we have
>>>> /sys/kernel/debug/soundwire/master-*
>>>>
>>>> Are you suggesting that we have something like this:
>>>>
>>>> /sys/kernel/debug/soundwire/xyz-controller/master-<LINK-ID> ??
>>>
>>> Yes this is what I was thinking about.
>>
>> Vinod/Pierre,
>>
>> One Question here,
>>
>> Why is link_id part of "struct sdw_bus", should it not be part of 
>> "struct sdw_master_device " ?
>>
>> Given that "There is one Link per each Master"
> 
> it's true that link == master == bus at the concept level.
> 
> but we have an existing code base with different structures and we can't 
> break too many things at once.
> 
> In the existing flow, the 'bus' is created and setup first, the 
> sdw_bus_master_add() routine takes a 'bus' argument, and the link_id is 
> already set. This routine only creates a device and in the rest of the 
> code we keep using the 'bus' pointer, so there's no real short-term 
> scope for moving the information into the 'sdw_master_device' structure 
> - that would be a lot of surgery when nothing is really broken.

I totally agree!

If I understand it correctly in Intel case there will be only one Link 
ID per bus.


Does this change look good to you?

---------------->cut<---------------

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index b6cad0d59b7b..f22868614f09 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -19,13 +19,14 @@ void sdw_bus_debugfs_init(struct sdw_bus *bus)
                 return;

         /* create the debugfs master-N */
+       bus->controller_debugfs = debugfs_create_dir(dev_name(bus->dev), 
sdw_debugfs_root);
         snprintf(name, sizeof(name), "master-%d", bus->link_id);
-       bus->debugfs = debugfs_create_dir(name, sdw_debugfs_root);
+       bus->debugfs = debugfs_create_dir(name, bus->controller_debugfs);
  }

  void sdw_bus_debugfs_exit(struct sdw_bus *bus)
  {
-       debugfs_remove_recursive(bus->debugfs);
+       debugfs_remove_recursive(bus->controller_debugfs);
  }

  #define RD_BUF (3 * PAGE_SIZE)
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index b198f471bea8..242bde30d8bd 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -877,6 +877,7 @@ struct sdw_bus {
         struct sdw_master_prop prop;
         struct list_head m_rt_list;
  #ifdef CONFIG_DEBUG_FS
+       struct dentry *controller_debugfs;
         struct dentry *debugfs;
  #endif
         struct sdw_defer defer_msg;

---------------->cut<---------------

With this change I get something like this on my board:

~# find /sys/kernel/debug/soundwire/
/sys/kernel/debug/soundwire/
/sys/kernel/debug/soundwire/sdw-master-2
/sys/kernel/debug/soundwire/sdw-master-2/master-0
/sys/kernel/debug/soundwire/sdw-master-2/master-0/sdw:0:217:2110:0:4
/sys/kernel/debug/soundwire/sdw-master-2/master-0/sdw:0:217:2110:0:4/registers
/sys/kernel/debug/soundwire/sdw-master-2/master-0/sdw:0:217:2110:0:3
/sys/kernel/debug/soundwire/sdw-master-2/master-0/sdw:0:217:2110:0:3/registers
/sys/kernel/debug/soundwire/sdw-master-1
/sys/kernel/debug/soundwire/sdw-master-1/master-0
/sys/kernel/debug/soundwire/sdw-master-1/master-0/sdw:0:217:10d:0:3
/sys/kernel/debug/soundwire/sdw-master-1/master-0/sdw:0:217:10d:0:3/registers
/sys/kernel/debug/soundwire/sdw-master-0
/sys/kernel/debug/soundwire/sdw-master-0/master-0
/sys/kernel/debug/soundwire/sdw-master-0/master-0/sdw:0:217:10d:0:4
/sys/kernel/debug/soundwire/sdw-master-0/master-0/sdw:0:217:10d:0:4/registers



Thanks,
srini
