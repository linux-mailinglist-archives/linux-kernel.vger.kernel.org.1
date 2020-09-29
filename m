Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259AB27D0F0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgI2OT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725786AbgI2OT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:19:57 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601389195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GbOhA7dETznnU47oMu8iv09uBMBo+WyhN222/EBjUDU=;
        b=A3FSlLpfN5SIKDER3ZA8gnLhZNs0NupkRB5P1A1OUreHvrccALyfKgMITyE9W9IkQyBira
        KWIpGZJzoV+xJaRjb0vNcGTDofQDb5q79btnnSavQwGIsEnhdjIaUDogKboZ2l3YBaP7zK
        vChBWnY8r/HZtiWDOqmD02zI4WfXlx0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-_XEr8m4wMiSzNGpO2cC61g-1; Tue, 29 Sep 2020 10:19:53 -0400
X-MC-Unique: _XEr8m4wMiSzNGpO2cC61g-1
Received: by mail-ed1-f69.google.com with SMTP id 63so2219747edy.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 07:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GbOhA7dETznnU47oMu8iv09uBMBo+WyhN222/EBjUDU=;
        b=AbBj4g45F7fkJu6zdIMwMI/zoPlNcU5QGL1aNzq0pvj+paWmq/nXwwawPCMwy7+hPz
         gg93LbWOZekYEvw8unpN594RYuc5Z2RjuzZr81rn0pG8SGkXbrNV/jWTwFgnvyXN+7Q1
         mDWIs3qeS0JJHAW2dNXN8bsVBdlUs4mJz5Ea2p0D7yEBN5Ii0Y1Hybs98xN9FXW0bSiM
         H441as7u0YExpH5xyvWA73xuCt9e9C8jAGL6l6zbgv/Y7xJi3JOgzowkU6paufnubT/l
         Dd7AXG0/mJI5tkMoCtu8Jr2NyVpTT1D0wDLmjT6OcPDhI9MnFUjUl/nGHxOMzQE/gQSN
         cJcw==
X-Gm-Message-State: AOAM533VKg1d3cQLFjHKPY2SRZ1RqXMb1r9Oyc2hhE80DSn/D0r11xEK
        c1bPxCKJwDKxvl7yG/YKz5LNhJUE6y8nVYy1Clzwy9ZjRbU6w2CnJjvw9qt0p6gQUPMo3x0t/DC
        w/Prbot5VZJOBUMH/VdMEpKJM
X-Received: by 2002:a17:907:207a:: with SMTP id qp26mr1919500ejb.387.1601389191214;
        Tue, 29 Sep 2020 07:19:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo/0aJL1kbHYrnJTiHqgJ1do9J781QCy88rCrihZ8UYlg1pzJravhuqfGHA4nTdFqJ3AhOmg==
X-Received: by 2002:a17:907:207a:: with SMTP id qp26mr1919475ejb.387.1601389190973;
        Tue, 29 Sep 2020 07:19:50 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id lc2sm2096497ejb.86.2020.09.29.07.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:19:48 -0700 (PDT)
Subject: Re: Keyboard regression by intel-vbtn
From:   Hans de Goede <hdegoede@redhat.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
References: <s5hft71klxl.wl-tiwai@suse.de>
 <bedb9d1b-3cca-43e2-ee44-1aac0e09a605@redhat.com>
Message-ID: <d43d3049-64d5-1904-bea4-437956375d7a@redhat.com>
Date:   Tue, 29 Sep 2020 16:19:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bedb9d1b-3cca-43e2-ee44-1aac0e09a605@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/29/20 11:21 AM, Hans de Goede wrote:

<snip>

> Since the problem of wrongly reporting SW_TABLET_MODE=1 in combination
> with libinput, leads to a non-usable system. Where as OTOH many people will
> not even notice when SW_TABLET_MODE is not being reported, I believe it
> is best to move to a dmi based allow-list approach here, as we recently
> did for SW_TABLET_MODE reporting by the asus-wmi driver. Allowing:
> 
> dmi chassis-types: 8 /* Portable */,  31 /* Convertible */, 32 /* Detachable */
> and the HP Stream x360 11-p000nd which has working intel-vbtn SW_TABLET_MODE
> support combined with a chassis-type of 10 /* Notebook */.
> 
> I will prepare a patch for this right away.

Quick status update on this, it is taking a bit longer then
I was hoping for since I'm trying to make sure that I get
things right this time.

Checking the dmidecode-dumps database from:
https://github.com/linuxhw/DMI

It seems that a whole ton of Dell laptop models use 8 ("Portable") as
chassis-type. Most of which are NOT 2-in-1s. So the new plan is to only
put the 31 ("Convertible") and 32 ("Detachable") chassis-types on
the whitelist. I do have 1 Dell 2-in-1, a Dell Venue 11 Pro 7130
with the Portable chassis-type and a working tablet-mode-sw
through intel-vbtn. So I will put that specific model on the
allow-list separately.

> Note this patch will effectively replace:
> "platform/x86: intel-vbtn: Fix SW_TABLET_MODE always reporting 1 on the HP Pavilion 11 x360"
> We will no longer need this workaround with the allow list and I believe
> that it would be better to drop that one.
> 
> Andy can you drop that one from your review-andy branch please?

Regards,

Hans

