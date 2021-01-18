Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721A62FA4F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393466AbhARPkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:40:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406015AbhARPgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610984075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2WOcH2sAlxSDYztdNWhAanF/6BOxfPY+GLFNO1HBj8=;
        b=UZ7PUCwQsE/qIe501NccOrljaC8GmfRqQ63ksCZoaYKc7AYi3QmGVYKU0pTsbVnTIHm1+3
        Ev1W90r3Ia5IWfoh8SSJGY0A69XG3GiaxcmbSlw8ltSfYRFV8fIrqUoHuC6MiW0Mw4Tdkn
        2+x6tixnJ3abFm4QIcDtflOHIFF+DLs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478--4YqwQRSNpaCyl1ohFj-5Q-1; Mon, 18 Jan 2021 10:34:33 -0500
X-MC-Unique: -4YqwQRSNpaCyl1ohFj-5Q-1
Received: by mail-ed1-f69.google.com with SMTP id w4so4268421edu.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E2WOcH2sAlxSDYztdNWhAanF/6BOxfPY+GLFNO1HBj8=;
        b=QkNpAWqh3/nPu4ca8xCq+jJ5BlgBn2ZbPnNRIdlJByZP5I7a+rQASZ7n4O6sIm4n64
         k3BOzc+1HhmJgwIwVsZibw4N5MBKnpugtycDX9qPFUN8L/OURxTV2qN33p76VPXOBLjU
         GpaqG8YN+ZBd+J7Eh9ZaoSh0fxK6o+TuOsjZTl85CRVkFkLzgnaQP1/vym7GNT2q8NCp
         93rXmoLWHZRPur9beX5fHPrptn8jeTXi8G9XhgDU4964KwyjITl0xSGnkmi6P15QYb+Q
         A9jd2g+wn8nQvt9xcFBMhTxsmtaO2COaOSrP8AvCWbG+uW8YMpIT3/sLzEuQHLq9mcYF
         Pf+g==
X-Gm-Message-State: AOAM533ymtBhs0F+2MQS6MtEK+HvBCtOqnd4w62st6LB61GOZW88CRh5
        lNCU5QybEK9oROAWL8nMX+cnqCHr7/13Y+3X9NDUIaiFn8jY+Iu4s9KuVKRkWLu9pLhmNhmo+er
        0VQXYJtGARv5tyqpXQA4HvQUeO26ZIHJjEgjHUHq0eXNVULJkWuZOk+310IGxx9NS+LpICzVkzT
        ei
X-Received: by 2002:aa7:dcc9:: with SMTP id w9mr57908edu.22.1610984071980;
        Mon, 18 Jan 2021 07:34:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw02JFryf0pfjcU+qzkH4HrcM27o9bACrUwT3ugAhYU+d1oXH6ExNbHb2GlKSoLveXqbvzWmg==
X-Received: by 2002:aa7:dcc9:: with SMTP id w9mr57891edu.22.1610984071847;
        Mon, 18 Jan 2021 07:34:31 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id b26sm9105099eds.48.2021.01.18.07.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 07:34:31 -0800 (PST)
Subject: Re: [PATCH v1 1/2] ACPI: scan: Rearrange memory allocation in
 acpi_device_add()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <3494203.VBaj39JGmp@kreacher> <2999734.9HhbEeWEHR@kreacher>
 <8218eff4-6629-ac20-ec3f-a66aad445bb6@redhat.com>
 <CAJZ5v0hv2FX2wtuwu9Jd1zZiGut9kUzQvCH5vXLMyFpqvvYOkA@mail.gmail.com>
 <20210118153218.GX4077@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <09c19a25-bf03-28f0-48d2-d5eea1a800cb@redhat.com>
Date:   Mon, 18 Jan 2021 16:34:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210118153218.GX4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/21 4:32 PM, Andy Shevchenko wrote:
> On Mon, Jan 18, 2021 at 04:16:16PM +0100, Rafael J. Wysocki wrote:
>> On Sat, Jan 16, 2021 at 1:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>> On 1/14/21 7:46 PM, Rafael J. Wysocki wrote:
> 
> ...
> 
>>> When I have cases like this, where 2 mallocs are necessary I typically do it like this:
>>>
>>>         const char *bus_id;
>>>
>>>         ...
>>>
>>>         } else {
>>>                 acpi_device_bus_id = kzalloc(sizeof(*acpi_device_bus_id),
>>>                                              GFP_KERNEL);
>>>                 bus_id = kstrdup_const(acpi_device_hid(device), GFP_KERNEL);
>>>                 if (!acpi_device_bus_id || !bus_id) {
>>>                         kfree(acpi_device_bus_id);
> 
> 
>>>                         kfree(bus_id);
> 
> Just to be sure, shouldn't it be kfree_const() ?

Yes I beleive it should, my bad.

Regards,

Hans


> 
>>>                         result = -ENOMEM;
>>>                         goto err_unlock;
>>>                 }
>>>                 acpi_device_bus_id->bus_id = bus_id;
>>>                 list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
>>>         }
>>>
>>>         ...
>>>
>>> So that there is only one if / 1 error-handling path for both mallocs.
>>> I personally find this a bit cleaner.
> 

