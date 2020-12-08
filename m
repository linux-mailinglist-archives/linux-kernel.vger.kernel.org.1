Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12F52D2E3D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgLHP3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:29:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729936AbgLHP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607441268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xr5jQ17tI5rLCWomlbBlC+vVMUJYwNJfuplB6ldKqjw=;
        b=fpLSsQ3jCfZNSIwzpel2zxvDuetQQ1WHk9mjrG2vUe90nIxGw1iE2XLFy1UCVKM+YQXYVf
        fsI7T7FbhmJF6jR2c11A6zcwXXlXoQX+TZB55PTRpxSwhjFZaQj26JO3GaqQVaBvxTb5VV
        ldZ5I2/EIYS/QxAzUwTHm7N6glh8ghI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-vxPK1_rsOaqVVeAbgTnPJQ-1; Tue, 08 Dec 2020 10:27:45 -0500
X-MC-Unique: vxPK1_rsOaqVVeAbgTnPJQ-1
Received: by mail-ej1-f72.google.com with SMTP id k15so5299635ejg.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 07:27:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xr5jQ17tI5rLCWomlbBlC+vVMUJYwNJfuplB6ldKqjw=;
        b=aZ8Wf4uql6iBMrlz+K1sbmllelTlDX5lzW56zMijXWNRcrVg62Y2k7/swl44zKdrtf
         8tyvBJmuk8aCoFGXwYMxNfXXVpi0fCNP0O5yxwdh7l+zgdYS6d55Pae85q0PCO7wsvG2
         GDGqzWSmW3Csz3bH2JaBqLLFRFd91CtkpJi/YnZ11Op4QWB1dqJpUhW+fUldiLE9Pn8F
         40AzJSF1MvHskqomO8OIafoCjyt17GTs8hCTux/UEfC3+sH3iNUaOkccmYM5TMKPYi8M
         j2AXudTIytO7BX/zjgKXNgaF4ojfs4LwWwKmxAB03l09eX8FYCYk8BJFL26cdGR8+D8I
         /Hug==
X-Gm-Message-State: AOAM531j6rr6mKJhQcxDaEK4h9woAg/PgEmPrvAo1/8k6SoFwS3Fimty
        AzECyEGoMZ3QujGSjXObHYH6jLZaaht+RI9sFoTH1FXrly/tQpET7rndHEv/4l3SzeSwPyCJCns
        YSRGdh982hzvL+6lfN7nvEVAY6++gY+ckyJvNQk2w2S8AxF3FHAjYGsJbd5ykg9Oqga9PAl1yEJ
        UV
X-Received: by 2002:a17:906:b20f:: with SMTP id p15mr9459754ejz.542.1607441264319;
        Tue, 08 Dec 2020 07:27:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXjJbN5M9gONlp70KY56vz5xTWbiybJRXvIYLl+C7UFgBkWJVGw26sjytDWrUHJwlOqWECGw==
X-Received: by 2002:a17:906:b20f:: with SMTP id p15mr9459731ejz.542.1607441264052;
        Tue, 08 Dec 2020 07:27:44 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id a10sm14794203ejk.92.2020.12.08.07.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 07:27:43 -0800 (PST)
Subject: Re: [PATCH -next] platform/x86: ISST: Mark mmio_range_devid_0 and
 mmio_range_devid_1 with static keyword
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1607430489-116200-1-git-send-email-zou_wei@huawei.com>
 <194d5a3c2c0f99345454004eb81c08d94181b7d7.camel@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <179b9e9c-5f38-b6e9-2135-636bdb275989@redhat.com>
Date:   Tue, 8 Dec 2020 16:27:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <194d5a3c2c0f99345454004eb81c08d94181b7d7.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/8/20 4:22 PM, Pandruvada, Srinivas wrote:
> On Tue, 2020-12-08 at 20:28 +0800, Zou Wei wrote:
>> Fix the following sparse warnings:
>>
>> drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c:23:24:
>> warning: symbol 'mmio_range_devid_0' was not declared. Should it be
>> static?
>> drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c:28:24:
>> warning: symbol 'mmio_range_devid_1' was not declared. Should it be
>> static?
>>
> Yesterday I sent a patch "[PATCH v2 2/3] platform/x86: ISST: Allow
> configurable offset range" to fix.

And I replied to that v2 with the following:

"I've already added v1 of these to the for-next branch of:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/

Please send the changes in this v2 as (a) follow-up
patch(es)."

https://lore.kernel.org/platform-driver-x86/2f663d89-184b-f52e-6156-f485205f27f5@redhat.com/T/#t

But I guess you may not have seen this because Intel's mail-servers
seem to have gone completely foobar lately and are bouncing most
of my emails it seems. I strongly suggest that you subscribe to
the platform-driver-x86 lists, so that you at least get replies
to your patches through the list.

So are the changes in this patch from Zou Wei the only changes in v2
of your ISST changes? If that is the case then I'll just merge
Zou Wei's patch and then we're done.

Regards,

Hans



>> Signed-off-by: Zou Wei <zou_wei@huawei.com>
>> ---
>>  drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git
>> a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
>> b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
>> index 2906cfe..ff49025 100644
>> --- a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
>> +++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
>> @@ -20,12 +20,12 @@ struct isst_mmio_range {
>>         int end;
>>  };
>>  
>> -struct isst_mmio_range mmio_range_devid_0[] = {
>> +static struct isst_mmio_range mmio_range_devid_0[] = {
>>         {0x04, 0x14},
>>         {0x20, 0xD0},
>>  };
>>  
>> -struct isst_mmio_range mmio_range_devid_1[] = {
>> +static struct isst_mmio_range mmio_range_devid_1[] = {
>>         {0x04, 0x14},
>>         {0x20, 0x11C},
>>  };
> 

