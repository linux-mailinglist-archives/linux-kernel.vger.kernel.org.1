Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83EF2858F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgJGHBh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Oct 2020 03:01:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40007 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgJGHBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:01:37 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kQ3SA-0007FE-I5
        for linux-kernel@vger.kernel.org; Wed, 07 Oct 2020 07:01:34 +0000
Received: by mail-pl1-f197.google.com with SMTP id k4so719559plk.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 00:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aDHyXgdm7hfW/ykfIHC0qVcjekojXJSCsJVjtCVF1oQ=;
        b=rbMeDrYdEjjyJMPx0ySun43k/BLFrW/KqrP8/DmugJunj7EG0ouANwHdOBVMjuvFbM
         forJJcNHJJbPzUgeAuTxiZtxee9fkTm10GPP0hMhFiSWyiEBozWNrjMe2FnXvLmwARt0
         GOMDgXefsmh9htU88QxEaFedQ/3CyGbV3QHejiyBGJoucv8FsWtquGQEbRmIiXBrNse4
         PeTTT4xi5XGJvqyZHESEtQdQ/D5hjtlukVn/Yi3xLhFjzOweHihyDH1cyM9NUdkVFwEb
         xiy5x09zVLbIExOsE+2Q0xE4RcznkgCRDB0RWZ4Olwn+hoUQ5wo07VWVNSfAqKgEhhTp
         s+bQ==
X-Gm-Message-State: AOAM531CW+G5lEJI7fh/ZYaA56abMAQEjnDEYvllBFRowM88ocCBSM2v
        2DBFU/qWEGPA5LKDznMTIRDkIDEQ48M7Xv4qQdxgEjJyMw7Dt+n8bTpSux7xPfs5bbGI9R+CCeA
        gz/y4nCDpP3t5HNGOgo3wrSzF/DzXc1BY6pxuBy8CRw==
X-Received: by 2002:a63:d841:: with SMTP id k1mr1795046pgj.59.1602054093133;
        Wed, 07 Oct 2020 00:01:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDljykDoJqTzxAjBt18ADgzxnYunTaOiFk7PoEw1AcsgiPaYLQ3RAoRNnmkHOyz/1LFkWBCw==
X-Received: by 2002:a63:d841:: with SMTP id k1mr1795028pgj.59.1602054092790;
        Wed, 07 Oct 2020 00:01:32 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id b2sm1603211pfp.3.2020.10.07.00.01.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 00:01:32 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] drm/i915: Force DPCD backlight mode for HP Spectre x360
 Convertible 13t-aw100
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <87mu7migqq.fsf@intel.com>
Date:   Wed, 7 Oct 2020 15:01:29 +0800
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        mripard@kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <7436CB1B-FB93-4D74-84E2-B7CCB9E6C38C@canonical.com>
References: <20200323053528.3147-1-kai.heng.feng@canonical.com>
 <41FD4AD2-81F9-45E8-B5D6-9CC255D0581B@canonical.com>
 <1F57CA05-3E23-4CA8-A138-6785906ED465@canonical.com>
 <87mu7migqq.fsf@intel.com>
To:     David Airlie <airlied@linux.ie>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 8, 2020, at 15:22, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> 
> On Tue, 07 Apr 2020, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>> On Mar 27, 2020, at 19:03, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>> 
>>> Hi,
>>> 
>>>> On Mar 23, 2020, at 13:35, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>>> 
>>>> There's another OLED panel needs to use DPCD aux interface to control
>>>> backlight.
>>>> 
>>>> BugLink: https://bugs.launchpad.net/bugs/1860303
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> 
>>> Would it be possible to review this?
>>> I'd like to send a similar quirk for a new panel, and I want to avoid causing any merge conflict.
>> 
>> Another gentle ping...
> 
> Can't really review, but if you say that's needed...
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>

David, 

Can you please merge this patch? Thanks.

Kai-Heng

> 
>> 
>>> 
>>> Kai-Heng
>>> 
>>>> ---
>>>> drivers/gpu/drm/drm_dp_helper.c | 2 ++
>>>> 1 file changed, 2 insertions(+)
>>>> 
>>>> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
>>>> index 8ba4531e808d..a0d4314663de 100644
>>>> --- a/drivers/gpu/drm/drm_dp_helper.c
>>>> +++ b/drivers/gpu/drm/drm_dp_helper.c
>>>> @@ -1301,6 +1301,8 @@ static const struct edid_quirk edid_quirk_list[] = {
>>>> 	 * only supports DPCD backlight controls
>>>> 	 */
>>>> 	{ MFG(0x4c, 0x83), PROD_ID(0x41, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
>>>> +	/* HP Spectre x360 Convertible 13t-aw100 */
>>>> +	{ MFG(0x4c, 0x83), PROD_ID(0x42, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
>>>> 	/*
>>>> 	 * Some Dell CML 2020 systems have panels support both AUX and PWM
>>>> 	 * backlight control, and some only support AUX backlight control. All
>>>> -- 
>>>> 2.17.1
>>>> 
>>> 
>> 
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center

