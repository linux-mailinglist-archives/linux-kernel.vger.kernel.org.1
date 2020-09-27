Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B43427A094
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 13:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgI0LMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 07:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50199 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbgI0LMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 07:12:54 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601205172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=grNRHn8J14/DqTRAmM7aKq7BCmqssKY/pLOK1/sHVHE=;
        b=Ih/e+5ZWPLEbiPD71rtoKQ9WnwTv9lUYYdZf0KPjlqjPC10XFMArxmWhuZy6ThWrO8MaFD
        ClF0UaoKrvmCUDmbn34HDKqVb2NJyuKZrQz+qE7SaV5+cUv4VYHavmbVt3FR/vLTOpecXa
        WlUV118gbeE17QpQSO3IyM0FU6VZPwU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-autvAe7FMjK_dl8bPY191w-1; Sun, 27 Sep 2020 07:12:50 -0400
X-MC-Unique: autvAe7FMjK_dl8bPY191w-1
Received: by mail-ed1-f70.google.com with SMTP id 63so3146217edy.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 04:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=grNRHn8J14/DqTRAmM7aKq7BCmqssKY/pLOK1/sHVHE=;
        b=ovyHhS8Ca+fNQjccvduT2LpLyVLdY0Im4yxpORN9INrq8b3HufBIqrfhxecKt0EjO3
         1afNrlv7ekYU3EQNVlOJwh3bhSZFB8EtkFJB54JNJqZVKL0UgfUEWBiMHFnRjznZVBzG
         st9sdpPJD9HvKYaqsmGWWBnSydIwkN62kul64bT+1Br2ClspWWpea5MQyMxLuWU5nB4A
         pPrHuAkdtsLEqqPHF8zIAEFEMid9nvYS9nacOtxwYomud/rxeP5I7GG/3vBwuNdU8PLW
         O++mgphk7pqtJiw83bYXax17WKBc/EsuhKllqWDUyRRuqWe5Kzllg7AVLsEG8O6Qnc4z
         zIOg==
X-Gm-Message-State: AOAM5306dzLl+OXKx3VsdTXapkchq9gDS4mEu2CRX0Xzh/REdSiCSOn9
        fJQfF4lF3d0tOxjzxt+EZc78Qgd22uyJ+btjuDQU8IStQ0TsWfeXAiCTL5Ob9/De6FmSXzc289J
        600HXXOJ++dY2xAnwxNpcuHB5
X-Received: by 2002:a05:6402:16c9:: with SMTP id r9mr10449403edx.27.1601205168868;
        Sun, 27 Sep 2020 04:12:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySeeuO8FyXe7xU8cNB6VWElLHoV4AEfMELKyWrzNGbfZTKaQiaMrJTknuPLGC/Z7v59DDJxA==
X-Received: by 2002:a05:6402:16c9:: with SMTP id r9mr10449380edx.27.1601205168602;
        Sun, 27 Sep 2020 04:12:48 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id q13sm6920852edr.27.2020.09.27.04.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 04:12:47 -0700 (PDT)
Subject: Re: [PATCH 0/3] Add support for F3A
To:     Vincent Huang <vincent.huang@tw.synaptics.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Andrew Duggan <aduggan@synaptics.com>,
        Benjamin Tissoires <btissoir@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Chris Heiny <chris.heiny@synaptics.com>
References: <20200924094628.1085000-1-vincent.huang@tw.synaptics.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <05140fb1-19a5-d740-2c57-e39e450142ec@redhat.com>
Date:   Sun, 27 Sep 2020 13:12:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924094628.1085000-1-vincent.huang@tw.synaptics.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/24/20 11:46 AM, Vincent Huang wrote:
> RMI4 F3A supports the touchpad GPIO function, it's designed to support
> more GPIOs and used on newer touchpads. The patches add support of
> touchpad buttons and rename f30_data to avoid confusion.

Thank you for the patch. So as already mentioned patches 1 and 2
need to be combined into a single patch.

Otherwise the patches look good to me and I can confirm that
they fix clickpad clicks not registering when using rmi4 for the touchpad
on the Lenovo T14 gen 1.

So for version 2 (with patches 1 and 2 combined into a single patch)
you may add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> 
> Vincent Huang (3):
>    Input: synaptics-rmi4 - rename f30_data to gpio_data
>    HID: rmi - rename f30_data to gpio_data
>    Input: synaptics-rmi4 - add support for F3A
> 
>   drivers/hid/hid-rmi.c           |   2 +-
>   drivers/input/mouse/synaptics.c |   2 +-
>   drivers/input/rmi4/Kconfig      |   8 ++
>   drivers/input/rmi4/Makefile     |   1 +
>   drivers/input/rmi4/rmi_bus.c    |   3 +
>   drivers/input/rmi4/rmi_driver.h |   1 +
>   drivers/input/rmi4/rmi_f30.c    |  14 +-
>   drivers/input/rmi4/rmi_f3a.c    | 241 ++++++++++++++++++++++++++++++++
>   include/linux/rmi.h             |  11 +-
>   9 files changed, 269 insertions(+), 14 deletions(-)
>   create mode 100644 drivers/input/rmi4/rmi_f3a.c
> 

