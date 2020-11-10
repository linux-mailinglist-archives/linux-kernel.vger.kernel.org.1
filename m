Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8192AD30D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgKJKDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:03:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgKJKDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605002617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5v2eIsxN4Hq0YzpQxHhzvDLBoDO1wsqtaSQHydAams=;
        b=dJiAoMMs1KX2eiTVsdY7N7/hSRphmTdHiZwLzI9beBKMqA68JydsKXeN8s1OPC5tA9B5j2
        839RdKvPMVP0mC8+cojy+WDQmyWzcHTxrn/AcdMbLDRmQwVQ286DlzcM+BInUjfuflx4fJ
        uT2FHE08u3etLpjGvdvk+CBy9zWqGKY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-gwI_x4uQNxGzyUHiSVFyjw-1; Tue, 10 Nov 2020 05:03:35 -0500
X-MC-Unique: gwI_x4uQNxGzyUHiSVFyjw-1
Received: by mail-ed1-f72.google.com with SMTP id o2so4020456edw.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x5v2eIsxN4Hq0YzpQxHhzvDLBoDO1wsqtaSQHydAams=;
        b=TevtBQW2khEXk2ARIKNTPGeMNN2YYq3Aajk+n+qGYCa/0Rkpy4hxxXbWO526vOBohS
         iFUfCZGdvXpTsdl99hqae1KRViRSDpuQe7v3jQfXE+PkmQDVOSsBTya57EcCKBIoQw0X
         PVP6IWspBTqfznWX3syJswvx92Hlv/KoM374eikCpkJqS0u75zGmWnidmvJJFNaoJX4Y
         7a1OeyZev7E/fkOSxq/F552nDOPbluZPHwyCj1O3GKH5GibWO0km8yeKrOJEBdGDHcvU
         +V7J7eHyMndL2rN/lCneEgfUHH90Zxm3xNZLKpmbl4+ABiROfekRi7Squn+rjUfETX09
         +YBQ==
X-Gm-Message-State: AOAM530HKH0lyB1d3bvbXWLWUC1cGf+QO5aCHzW30a7pS+rCrMQpc1YB
        oFnl8B/61Oa7HPkNACfJE18yRaSBtuxwYBfGK8aPEGpWA0QOLloGodz/AVuejLfEQFfeeu7jO61
        2TKu54O51QU38RxskCg2+1PsbupyR+v9P5xyD/ofNcWq65ow88S1b/bAAvdUnO7jjSA8Rz95h4J
        VT
X-Received: by 2002:a17:906:5fd0:: with SMTP id k16mr19926563ejv.133.1605002614419;
        Tue, 10 Nov 2020 02:03:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHZvItd1F1W85TYQU6gDoci3i+YMPyw05C5APpazQNYseSKGDmKGoDxgRNxTor+d9rP0t7BA==
X-Received: by 2002:a17:906:5fd0:: with SMTP id k16mr19926539ejv.133.1605002614097;
        Tue, 10 Nov 2020 02:03:34 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id h22sm5770975ejt.21.2020.11.10.02.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 02:03:33 -0800 (PST)
Subject: Re: [PATCH] platform/x86: acer-wmi: add automatic keyboard background
 light toggle key as KEY_LIGHTS_TOGGLE
To:     Timo Witte <timo.witte@gmail.com>
Cc:     jlee@suse.com, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:ACER WMI LAPTOP EXTRAS" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200804001423.36778-1-timo.witte@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <097353a1-c4d6-7cba-92fc-dd8652fbaf9f@redhat.com>
Date:   Tue, 10 Nov 2020 11:03:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200804001423.36778-1-timo.witte@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Quick self intro: I have take over drivers/platform/x86
maintainership from Andy; and I'm working my way through
the backlog of old patches in patchwork:
https://patchwork.kernel.org/project/platform-driver-x86/list/

On 8/4/20 2:14 AM, Timo Witte wrote:
> Got a dmesg message on my AMD Renoir based Acer laptop:
> "acer_wmi: Unknown key number - 0x84" when toggling keyboard
> background light
> 
> Signed-off-by: Timo Witte <timo.witte@gmail.com>
> Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I've made one small change I've replaced the (ignored)
KEY_LIGHTS_TOGGLE key-code with KEY_KBDILLUMTOGGLE as that is
the correct code to use for toggling the kbd backlight on/off.
As the comment in input-event-codes.h says KEY_LIGHTS_TOGGLE
is for "/* Reading light on or off */".

Note this will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/acer-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 60c18f21588d..87797f785d6a 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -111,6 +111,7 @@ static const struct key_entry acer_wmi_keymap[] __initconst = {
>  	{KE_KEY, 0x64, {KEY_SWITCHVIDEOMODE} },	/* Display Switch */
>  	{KE_IGNORE, 0x81, {KEY_SLEEP} },
>  	{KE_KEY, 0x82, {KEY_TOUCHPAD_TOGGLE} },	/* Touch Pad Toggle */
> +	{KE_IGNORE, 0x84, {KEY_LIGHTS_TOGGLE} }, /* Automatic Keyboard background light toggle */
>  	{KE_KEY, KEY_TOUCHPAD_ON, {KEY_TOUCHPAD_ON} },
>  	{KE_KEY, KEY_TOUCHPAD_OFF, {KEY_TOUCHPAD_OFF} },
>  	{KE_IGNORE, 0x83, {KEY_TOUCHPAD_TOGGLE} },
> 

