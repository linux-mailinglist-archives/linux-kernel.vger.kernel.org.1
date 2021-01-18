Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBEA2FA1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392190AbhARNld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:41:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404669AbhARNkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610977131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AYQO73uwXR/ZL0KjvgARb0aP86zDIIQGfBxMVvC8Sn4=;
        b=N0lXgeVps9CwauWJT3GtC8jEm/NhWljmL0uIJa/fpFB6FPmXwl2WdH3hwFGUNXM8d1GCug
        h4irreTdhTenLRf3jVw/h0fxa34HO6t4KkYqIiyUYurGgZbm1SCYoN5g3eToo7BDl5e1yk
        v+f3SKi77Lwu2gpmjxEXL2Dje9LXxGc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-Tt_6qF2FMfWIah65hz09qg-1; Mon, 18 Jan 2021 08:38:49 -0500
X-MC-Unique: Tt_6qF2FMfWIah65hz09qg-1
Received: by mail-ej1-f70.google.com with SMTP id f26so5190567ejy.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:38:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AYQO73uwXR/ZL0KjvgARb0aP86zDIIQGfBxMVvC8Sn4=;
        b=kvOBDo00I7mit6Fjmib4gLa9kjKN/IK0hCEFfwIaWgyPJflphkTeklz+y3iW2BCT7/
         fKAemCwWak1kCl5W0DbRnDZm9mtPsQpinl5UB0dH8blRDhQ3xnvPR9mdn9bZhM3JtCRA
         Q8YCqqUjrrXmYj2Aq9LdzxE0iv57W0kEbctqbB+ta/rusV5lf4ww8J2WAQ5o1LQgqfsw
         NCd0kHeyQnc9ePm4+h/rX9MDrmHhjlwam4ClvIesyTWswCYy/hskiXMiJLS2T2BRacYk
         flY0YlHg7ZdcawiLuF9SWnQw7Fl0/BVCxg6GREzABV6jiB5aqaWetP66DajpRPS2Dh7R
         ORmQ==
X-Gm-Message-State: AOAM5332aiQqh66eCpK7GF/d3xk4djA64EQciQGowwnDQh0ckiA6zEGT
        J6zQctFbbhXX4TN9CLJCYAdrP4fx/8YtuY3hiUbEjsDjsLDw6uteEI73acchGMbf0Mq5G4Avucs
        lq28jMYQZrRXUoiDtY0wnYoVp
X-Received: by 2002:a17:906:1701:: with SMTP id c1mr17201946eje.395.1610977128397;
        Mon, 18 Jan 2021 05:38:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzs9Mb0hyp3+/u1P/YLkrfyR15h8tNHy4A8YnxJgQj8rrfaGCKzEE7napeuqoudh9UX1EuRhw==
X-Received: by 2002:a17:906:1701:: with SMTP id c1mr17201937eje.395.1610977128246;
        Mon, 18 Jan 2021 05:38:48 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id n6sm2542455ejg.102.2021.01.18.05.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 05:38:47 -0800 (PST)
Subject: Re: [PATCH v3 3/5] mfd: arizona: Add support for ACPI enumeration of
 WM5102 connected over SPI
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org,
        Christian Hartmann <cornogle@googlemail.com>
References: <20210117212252.206115-1-hdegoede@redhat.com>
 <20210117212252.206115-4-hdegoede@redhat.com>
 <20210118130227.GI4455@sirena.org.uk>
 <5ccf48f4-45dc-3a30-3d6a-cce066f01270@redhat.com>
 <20210118133449.GL4455@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <45a5de45-d7d9-8505-9009-3774a444f70f@redhat.com>
Date:   Mon, 18 Jan 2021 14:38:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210118133449.GL4455@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/21 2:34 PM, Mark Brown wrote:
> On Mon, Jan 18, 2021 at 02:13:50PM +0100, Hans de Goede wrote:
> 
>> More in general I'm not aware of any (recent-ish) x86 GPIO controllers
>> not being able to do active low interrupts. In theory we could hit this
>> code path on ARM devices using ACPI enumeration, but I don't think it
>> is likely we will see a combination of ARM + ACPI enumeration +
>> WM5102 + GPIO controller not capable of active-low interrupts.
> 
> I've not seen this issue on any ARM based systems.
> 
>> This overriding of the flags definitely is necessary on the Lenovo
>> devices in question. I could add a
>> "if (dmi_name_in_vendors("LENOVO"))" guard around it, but that
>> seems unnecessary.
> 
> Possibly just an update to the comment to make it clear that some
> firmwares might legitimately set the flag
That seems sensible, I will wait a bit to so if you (or someone)
has any more review remarks to this series and then send out
a v4 with the comment updated.

Regards,

Hans

