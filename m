Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65842FDBBA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436502AbhATU6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:58:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732502AbhATNqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611150307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/a6CMcIutcxErUCcxPrh94A+MqdbANj7G9XZs65vz9Q=;
        b=I2O6LMOZ4yRYOjRa9J+XKJreLgtMBkY0yYVMMRvDsXTaWuWddMQySh2onoeV6Vp9hh/j3A
        o6EPsnM56B9yYfiLgSnMxjoO6i5nsBBfqxlKNuHVgfc5GcZwPnZmKhQPLfxkfqK+pl+zTK
        Il8cOgTqyRAlA0pQAPa4oWx8JuZHcNE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-tUQNQEJ1MuapvxXiJxChNg-1; Wed, 20 Jan 2021 08:45:05 -0500
X-MC-Unique: tUQNQEJ1MuapvxXiJxChNg-1
Received: by mail-ed1-f69.google.com with SMTP id j12so6905656edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/a6CMcIutcxErUCcxPrh94A+MqdbANj7G9XZs65vz9Q=;
        b=pTl8nRk4XSXGBvR9ahw3Xf+CMIEV5Y+Bpd+XFrBwWnfTVDoiidyK8NlJb78K45H2sa
         jVVzCn8uNz9eHx+uq+yza6h4DUFFYUs/4hthDwb9sIK6qJCYgcQhjo3q885TykRH+KHY
         UYm+mdwyRcMwIuikhh9m1W/LWHt8l8y1P7nS/84Pw3noQ6K3HZ/BYVz9t/aYKC/1CfFf
         5HVsAZWSLoqAf9GVT/ocUFJI8atmmJCdGmG6qhfqSM/+cCMkuqqsCAENiUyR6anaB5b6
         Dv2OR4eRmvUzRu9CZi+JQE7QfZll9HP9S0UT1RVEiC2EqCsZCQREBYuo7GaEsooO4pws
         B/jw==
X-Gm-Message-State: AOAM530G8tNAVTuTJvS7L8GpNiMbGG6MwRqSwT0bGnvI/cyhNNlUtlDr
        5hhEicyENVIhwvwRZVtastkxh0Dq5T08oM/Dd2PhPIJqG+WNaB/PT4VtwDaXHjSXLIPw0KFm8xx
        1GYD1MEnfjVPlaQsoHaePhjTmF3IBI8vTccK9dEOvgVlLcbWX+R7pnIqKhJl3ccm8Ubxue3yJI0
        4u
X-Received: by 2002:a17:906:70d4:: with SMTP id g20mr6413194ejk.361.1611150304020;
        Wed, 20 Jan 2021 05:45:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQJh4Egq/glOcE6MZI5rNwkQL84wDaqZyhxpS5NT0fhW5MprNFEufOH89StjuNZVodtBi72Q==
X-Received: by 2002:a17:906:70d4:: with SMTP id g20mr6413175ejk.361.1611150303762;
        Wed, 20 Jan 2021 05:45:03 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id u23sm1121993edt.78.2021.01.20.05.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 05:45:03 -0800 (PST)
Subject: Re: [PATCH v6 0/3] AMS, Collision Avoidance, and Protocol Error
To:     Kyle Tso <kyletso@google.com>, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210114145053.1952756-1-kyletso@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2211ad43-b76c-fbe9-2cc8-bb40c4ee4e89@redhat.com>
Date:   Wed, 20 Jan 2021 14:45:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210114145053.1952756-1-kyletso@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/14/21 3:50 PM, Kyle Tso wrote:
> v5 https://lore.kernel.org/r/20210105163927.1376770-1-kyletso@google.com
> 
> "usb: typec: tcpm: AMS and Collision Avoidance"
>  - removed the signed-off
>  - modified the coding style suggested from Heikki
>  - added FR_SWAP AMS handling
> 
> "usb: typec: tcpm: Protocol Error handling"
>  - removed the signed-off
>  - modified the coding style suggested from Heikki
>  - modified more coding style problems (line wrapping limit)
> 
> "usb: typec: tcpm: Respond Wait if VDM state machine is running"
>  - no change

I've finally gotten around to testing this. I'm happy to
report that the power-role swapping regression seen in one
of the older versions of this patch-set is gone.

So the entire series is:
Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> 
> -------------------------------------------------------------------
> 
> Kyle Tso (3):
>   usb: typec: tcpm: AMS and Collision Avoidance
>   usb: typec: tcpm: Protocol Error handling
>   usb: typec: tcpm: Respond Wait if VDM state machine is running
> 
>  drivers/usb/typec/tcpm/tcpm.c | 1001 +++++++++++++++++++++++++++------
>  include/linux/usb/pd.h        |    2 +
>  include/linux/usb/tcpm.h      |    4 +
>  3 files changed, 829 insertions(+), 178 deletions(-)
> 

