Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DD52858F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgJGHB5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Oct 2020 03:01:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40024 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGHB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:01:57 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kQ3SV-0007H7-Fj
        for linux-kernel@vger.kernel.org; Wed, 07 Oct 2020 07:01:55 +0000
Received: by mail-pl1-f200.google.com with SMTP id y10so709568plp.14
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 00:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YY+uRp9H9LhgOdIjOkhoHSwMjiC62Tl2vVWx4QZWuVY=;
        b=kY2LlMqhAoBXpArPZMrQYnhE6WT+Y29JKIzyyRQef3wb+nBeUPhWiECBVmb2LV7RPS
         gvAkjYE5K981AENFPRKBzxrK35VWwycAqIJKu8F/P4XSxAU2Ey8L6DP550JeOOt8aEdX
         4BzgfsmnI8BAR+L3B6ZB0CnSlE5iCpniJ711YvYp9Jenyc6MbudAAd3In/IpSvxyp+Ot
         4nN06dgE6sNr9ZxsjCA7vlWHurB4pwaauQ6lrSJgBibi4DvhkjEHKAODcNIxhV2qLoWD
         8wRtA9wEfViGR6oX5LKpPwRyosuNdDSPZjAgs+F0pMaEBe7y9BOXT2X4bXZTEjgiO8rf
         Zeiw==
X-Gm-Message-State: AOAM531zHbbhfwj2vB+X5wYuyIyiB/uZDrjHWIVshNVRSaOWG8i/0FeB
        dQWdYzljGZ+I/ttJisUGuONiVHlx9ou/WvOsoDwvu9SP7sf3DLsMqOAY1DoX7cK4u4Jo7z6u7B4
        MYIZQCKJ70q8lYmx+sGHvyYF6WRLqvLgbyR4w19XTUw==
X-Received: by 2002:a17:90a:fd03:: with SMTP id cv3mr1703132pjb.137.1602054114051;
        Wed, 07 Oct 2020 00:01:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIRZWLnm2Wo/uKpT2AkEa+DSpYn1D+tXclumaSTvgwwKloSqhzPMVO8i0oY6NaCoTpjIkC1Q==
X-Received: by 2002:a17:90a:fd03:: with SMTP id cv3mr1703110pjb.137.1602054113754;
        Wed, 07 Oct 2020 00:01:53 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id b2sm1603211pfp.3.2020.10.07.00.01.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 00:01:53 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] drm/i915: Force DPCD backlight mode for HP CML 2020
 system
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <87k12qigpw.fsf@intel.com>
Date:   Wed, 7 Oct 2020 15:01:51 +0800
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        mripard@kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <3D7AEAE9-AFE4-49C6-A8C0-3F744CC8D529@canonical.com>
References: <20200407075353.12747-1-kai.heng.feng@canonical.com>
 <87k12qigpw.fsf@intel.com>
To:     David Airlie <airlied@linux.ie>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 8, 2020, at 15:23, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> 
> On Tue, 07 Apr 2020, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>> There's another Samsung OLED panel needs to use DPCD aux interface to
>> control backlight.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>

David, 

Can you please merge this patch? Thanks.

Kai-Heng

> 
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/gpu/drm/drm_dp_helper.c | 2 ++
>> 1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
>> index c6fbe6e6bc9d..d0cfee3b7a65 100644
>> --- a/drivers/gpu/drm/drm_dp_helper.c
>> +++ b/drivers/gpu/drm/drm_dp_helper.c
>> @@ -1299,6 +1299,8 @@ static const struct edid_quirk edid_quirk_list[] = {
>> 	 * only supports DPCD backlight controls
>> 	 */
>> 	{ MFG(0x4c, 0x83), PROD_ID(0x41, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
>> +	/* HP CML 2020 system */
>> +	{ MFG(0x4c, 0x83), PROD_ID(0x45, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
>> 	/*
>> 	 * Some Dell CML 2020 systems have panels support both AUX and PWM
>> 	 * backlight control, and some only support AUX backlight control. All
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center

