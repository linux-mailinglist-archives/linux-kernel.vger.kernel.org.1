Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDEC2F8DDD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbhAPRLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbhAPRK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E008C06138B;
        Sat, 16 Jan 2021 07:10:19 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id t6so6236778plq.1;
        Sat, 16 Jan 2021 07:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=XVfRC3VS1iJhQ2u3rXKF8OukI6C4/RaKCNwIeoBnNA8=;
        b=TAKZGD1onxE+hqw2liMiAR6pLAy2OjUK6G6N0Iidv5+wyIrqq6OfaTex58tm9r6+vk
         zSvUuS8DOWFmwLGjS2vakEq7mSSb8Fq7cw1sySU2K0eUItU1a/9KVo8oCk1o3QpwFlCc
         Egcy6UnFsYM0RSTkRFL+OcymaaSjAO/3klT/VAYStQlabJbGIuuzlmDLR34X2NNYf35Y
         qLFgIAV8aX9J8JYWSSX8oDN9dQ/XcGJAo28V9dcwPV5vVFkNNueb9pUxrQ3KDeL2bSjX
         K7Ek8sWxMv7eHvuhcUAV1Bq7qkOWznHWiZdSyQPIMR53FNKXZfi4NQVaGr9j9dV93H9q
         +vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=XVfRC3VS1iJhQ2u3rXKF8OukI6C4/RaKCNwIeoBnNA8=;
        b=oUAsDZEIzC6io3vi/lS1mejKrfcY5MlRT4Jy6w8EGjSF139q2dIRyhFzHeSthvc4RG
         uqiwiSHiY63KAgMdVvCcBQVHvNUpwb+XTh/txhpW8cOFA904TPUNpeVjBXu57WyTzJce
         R+rPu872N+V2AM12X2nvRoD7eK5QagRk+YzQER5pS4HrAfLYaTnS6QXH2XzdPv3zClxX
         8Haf1gTPuI8XRXZ3tS+Kl/VKu92bkzKFDZWhG3eH2VXBmThFmx96zgI4ZMwHUCU6V3vs
         4PVgxksggemOzZbU7lT/OQP2lIwM/wpy2HgBdgT05WYAc0sRx+jT5rGGeul52Np8sz3r
         swpw==
X-Gm-Message-State: AOAM532urnMDrZRecclXyX8QSXrgioYwzlpiEEgt6hFFEojPm9o82e8C
        ixG+ieySCOkEKhJGb4i878E=
X-Google-Smtp-Source: ABdhPJzzJXE8U3cCbdWQMpki+05Mne2wHUEjtbfMSLerP6XdOZocWIyN/QPq8DEDMPKCHW0rIFYQqQ==
X-Received: by 2002:a17:90a:d70e:: with SMTP id y14mr16163154pju.9.1610809818836;
        Sat, 16 Jan 2021 07:10:18 -0800 (PST)
Received: from [0.0.0.0] (n218250008152.netvigator.com. [218.250.8.152])
        by smtp.gmail.com with ESMTPSA id n195sm11391438pfd.169.2021.01.16.07.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 07:10:18 -0800 (PST)
Subject: Re: [PATCH v3 1/3] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     Randy Dunlap <rdunlap@infradead.org>,
        Perry Yuan <Perry.Yuan@dell.com>, oder_chiou@realtek.com,
        perex@perex.cz, tiwai@suse.com, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Mario.Limonciello@dell.com
References: <20210112171723.19484-1-Perry_Yuan@Dell.com>
 <cc83351b-a19a-9a3e-d511-4553cf4d7ef0@infradead.org>
From:   Perry Yuan <perry979106@gmail.com>
Message-ID: <578023b1-ae22-f21a-3969-62f06557baf1@gmail.com>
Date:   Sat, 16 Jan 2021 23:10:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <cc83351b-a19a-9a3e-d511-4553cf4d7ef0@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/13 1:39, Randy Dunlap wrote:

> On 1/12/21 9:17 AM, Perry Yuan wrote:
>> +config DELL_PRIVACY
>> +	tristate "Dell Hardware Privacy Support"
>> +	depends on ACPI
>> +	depends on ACPI_WMI
>> +	depends on INPUT
>> +	depends on DELL_LAPTOP
>> +	depends on LEDS_TRIGGER_AUDIO
>> +	select DELL_WMI
>> +	help
>> +	This driver provides support for the "Dell Hardware Privacy" feature
>> +	of Dell laptops.
>> +	Support for a micmute and camera mute privacy will be provided as
>> +	hardware button Ctrl+F4 and Ctrl+F9 hotkey
> 	End above with a period '.' please.
>
>> +
>> +	To compile this driver as a module, choose M here: the module will
>> +	be called dell_privacy.
> Please follow coding-style for Kconfig files:
>
> from Documentation/process/coding-style.rst, section 10):
>
> For all of the Kconfig* configuration files throughout the source tree,
> the indentation is somewhat different.  Lines under a ``config`` definition
> are indented with one tab, while help text is indented an additional two
> spaces.
>
>
> thanks.

Thanks for your review feedback.

I will fix this in V4 patch.

