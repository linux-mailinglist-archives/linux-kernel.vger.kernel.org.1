Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716EE20F114
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 11:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbgF3JAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 05:00:40 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60462 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731591AbgF3JAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:00:39 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05U903vZ093413;
        Tue, 30 Jun 2020 04:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593507603;
        bh=0HQcsWAVWf3W2shwVfdnWwI1iQ57DD5fcjRBXcqcjFA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=t/F4Y9mz2e0EHQnkCHsvLyZAPFsmdc2DskZt3ySis6nDHjwJQwyzUSaw9iHAFpe7G
         WLLBbQxj157MQVFkmtXYSZpR4gGMeBvZuQWwi9qh4y3ZL1tuTtjgGwj8qWqIF7EQjL
         Wm6IFKsWuEBWGI+x+rlrknX17PwHJTyaY3CW0Vxs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05U902UX116084
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 04:00:03 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 30
 Jun 2020 04:00:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 30 Jun 2020 04:00:02 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05U8xw6f084990;
        Tue, 30 Jun 2020 03:59:58 -0500
Subject: Re: [PATCH v6 2/4] driver core: add deferring probe reason to
 devices_deferred property
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20200626100103.18879-1-a.hajda@samsung.com>
 <CGME20200626100110eucas1p2c5b91f2c98a5c6e5739f5af3207d192e@eucas1p2.samsung.com>
 <20200626100103.18879-3-a.hajda@samsung.com>
 <5f159e00-44fd-515b-dd8c-4db9845dc9e6@ti.com>
 <7e3c924b-c025-a829-6868-78e2935c70eb@samsung.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <66faa188-5ef6-d449-07fe-28c8be5e559c@ti.com>
Date:   Tue, 30 Jun 2020 11:59:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7e3c924b-c025-a829-6868-78e2935c70eb@samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 29/06/2020 14:28, Andrzej Hajda wrote:
> Hi Grygorii,
> 
> (...)
> 
>>>    /*
>>>     * deferred_devs_show() - Show the devices in the deferred probe
>>> pending list.
>>>     */
>>> @@ -221,7 +241,8 @@ static int deferred_devs_show(struct seq_file *s,
>>> void *data)
>>>        mutex_lock(&deferred_probe_mutex);
>>>          list_for_each_entry(curr, &deferred_probe_pending_list,
>>> deferred_probe)
>>> -        seq_printf(s, "%s\n", dev_name(curr->device));
>>> +        seq_printf(s, "%s\t%s", dev_name(curr->device),
>>> +               curr->device->p->deferred_probe_reason ?: "\n");
>>>          mutex_unlock(&deferred_probe_mutex);
>>>
>>
>> Sry, may be i missing smth, but shouldn't it be optional
>> (CONFIG_DEBUG_FS is probably too generic).
>>
> 
> I am not sure what exactly are you referring to, but this patch does not
> add new property, it just extends functionality of existing one.

Sry, needed to be more specific.

You've added  device_set_deferred_probe_reson(dev, &vaf);
which expected to be used on every EPROBE_DEFER in dev_err_probe() in combination with

+       } else {
+               device_set_deferred_probe_reson(dev, &vaf);
                 dev_dbg(dev, "error %d: %pV", err, &vaf);

^^ dev_dbg() does not add any runtime overhead during boot unless enabled
+       }

But:

+void device_set_deferred_probe_reson(const struct device *dev, struct va_format *vaf)
+{
+       const char *drv = dev_driver_string(dev);
+
+       mutex_lock(&deferred_probe_mutex);
+
+       kfree(dev->p->deferred_probe_reason);
+       dev->p->deferred_probe_reason = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
+
+       mutex_unlock(&deferred_probe_mutex);
+}

^^ Adds locking, kfree() and kasprintf() for every deferred probe during boot and can't be disabled.

Right?


-- 
Best regards,
grygorii
