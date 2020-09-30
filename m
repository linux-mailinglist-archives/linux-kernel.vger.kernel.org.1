Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB227E963
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgI3NVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41532 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728043AbgI3NVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:21:49 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601472108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SIUeHCg4ObFBTzNeRmXqLyzNztGL/qF7cJVPSEqtDtU=;
        b=LX8VSr7OHBIvsFqoe9zoPF9yyYkjZWhMH3oCkEQysBpAaJ7hanFOjzQ7O5yYbmVabpdKl0
        4XjQwWrAy9fZvmHh22baeNWpZq0ZqwuZXDVGnTYAMhDn3RKltaqP+l+D7asd3OUZYfABLO
        aN1+F8eE2Bf3rWY5QqHh4CUx0ZNDWTQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-yLKuudrBOjCsxRmfYjiLtA-1; Wed, 30 Sep 2020 09:21:33 -0400
X-MC-Unique: yLKuudrBOjCsxRmfYjiLtA-1
Received: by mail-ej1-f72.google.com with SMTP id i14so804130ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SIUeHCg4ObFBTzNeRmXqLyzNztGL/qF7cJVPSEqtDtU=;
        b=ormXcoM4BNE3Rzcb1gYhESbHo38g0nlzh2Wno7L26GB1F4yKupWIUmGn4/xI667HYy
         wm1LaiaOGMm+uGFD+b5lSeLYDZi73/ACwV621hi/hE1p9LaHPQ/f53LPMdWMsBWjIad0
         qwR5v5AioBbIVMpFD59tNEdLUwupbjh5R1qANKxNO0NbXg8ZMG/tCB36EpAnnMyAzgGx
         4KQ/2q043twlSG/ld5s/qCJxbZhtYh8QOPNrdoBNf4uDHfJGQeK8tFLniXcQdUncMqD0
         I5zxiowlAPm77N/Ff7kv8c4lMuGVcXfTTiBbyU6dzW5hTOJJ8616n6K0iQPc+5Ks4zty
         4JkQ==
X-Gm-Message-State: AOAM533HzsSeAcx/Pz8r2ai57Jhx3XJLcGIJAuqvUlIuR53FX7bfkiMz
        SqKOq/sHkE4UJD1TA6CiZ31EMsrQVNLnuz2byTDogeEbd8xAYYH3rqKYiQZBcaNWqfMuZLoDb6Y
        7ZlZyJJ91ykVEwzYJ0YIYxo9m
X-Received: by 2002:a17:906:d9c3:: with SMTP id qk3mr2738277ejb.207.1601472090482;
        Wed, 30 Sep 2020 06:21:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU0z5x3UIZ7XSqZzFVFHBydKV2JxTLnRCowJqy0RsogsLlCJfIjc8uzEUjl4oT2cTC5M0WFA==
X-Received: by 2002:a17:906:d9c3:: with SMTP id qk3mr2738260ejb.207.1601472090294;
        Wed, 30 Sep 2020 06:21:30 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id m10sm1537087edf.11.2020.09.30.06.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 06:21:26 -0700 (PDT)
Subject: Re: Keyboard regression by intel-vbtn
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <s5hft71klxl.wl-tiwai@suse.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <036dbbe8-dbf9-76c6-d8f7-9761bee58a8f@redhat.com>
Date:   Wed, 30 Sep 2020 15:21:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <s5hft71klxl.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/29/20 10:48 AM, Takashi Iwai wrote:
> Hi Hans,
> 
> it seems that the recent update of intel-vtn broke the keyboard input
> on some laptops with libinput:
>    https://bugzilla.opensuse.org/show_bug.cgi?id=1175599
> 
> Blacklisting intel-vtn fixes the issue, so it's likely the falsely
> reported tablet mode switch that leads libinput misbehaving.  The
> affected machines are Acer E5-511 and ASUS X756UX laptops, and they
> shouldn't have the tablet mode at all, AFAIK.
> 
> Could you take a look?  I guess it's the commit cfae58ed681c that
> broke.  The chassis type is Notebook on those, and this type should be
> excluded as well as Laptop.
> 
> The dmidecode outputs and other info are found in the bugzilla above:
>    https://bugzilla.opensuse.org/attachment.cgi?id=841999
>    https://bugzilla.opensuse.org/attachment.cgi?id=842039
> 
> The one for ASUS is embedded in hwinfo outpt:
>    https://bugzilla.opensuse.org/attachment.cgi?id=841157

Ok, you should have just received a patch fixing this, sorry
that creating it took a bit longer then I had hoped.

Andy, can you drop the:

"platform/x86: intel-vbtn: Fix SW_TABLET_MODE always reporting 1 on the HP Pavilion 11 x360"

Patch from your review-andy branch, plug in the new one and
then send it out to Linus for merging into 5.9 please ?

Regards,

Hans

