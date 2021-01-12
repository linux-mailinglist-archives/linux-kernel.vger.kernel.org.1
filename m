Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B642A2F3903
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406168AbhALSj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:39:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390101AbhALSj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610476679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=opNx5wYPreAGLB0h8OM+jsyPJRNOl+U0BtgbfxWf+EM=;
        b=N1lJvs+oqkjDEDJep/DilWxBiA7q8albolfNzW+zWrO/laEtoMCuJIS3bdhRixzTnycH2b
        sjOnpDtAidVfZ0d1gAY2sYW13OdnyYKn1mPdUQvNmWc0jkO9BYR6jDm95pMSAZngxYXzLf
        SeijtBcj3l3KsnNm3HzJR+ErhUpyjHU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-6aVbq9enNtG5Km_ZOkXwAA-1; Tue, 12 Jan 2021 13:37:58 -0500
X-MC-Unique: 6aVbq9enNtG5Km_ZOkXwAA-1
Received: by mail-ej1-f71.google.com with SMTP id gs3so1332688ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=opNx5wYPreAGLB0h8OM+jsyPJRNOl+U0BtgbfxWf+EM=;
        b=ofKtpcACFYWywLk9oFTReVHBkLGeo+RbpvmxzmD2uOzEPp9wv8dJnXr6t/y3HSgrY2
         MLEHNhijCClTs17Zmc4Lpd4DcRsvXj97rhTpe5LQlYriMx0Ox5JOCtGecDHhhw81257K
         Ka0MVg2oAYvM4OIlj2I638VUCXWEABrHnbc2/bfePsgi0PD9xpwWsT+wkM/tOKai03Ny
         najH3ZnUf7bZwrf2Gyvrpz1Iv5S0B5JAh4wOAlLNE1ObaQbzVJp5ilHBZixF3j01QObR
         /SoaPHC3Qt5+RI/9kIze77STlYblQraHcUcOq0+LE7Y5efxsB8Sk1mn8xh4ko0NEYixu
         eWQw==
X-Gm-Message-State: AOAM531G62fTvhVhl1p5Te397gccaJx6BXyepFfKGXGuuSUnSyJZia2W
        jFBcjwCSkl8rh7Ot/Zvk/ytr9W4Ko7DSRHplh+7LSZDXcFVMxF5+sxpLcqAS2kKgut9VeDXpDJu
        +z+lJONNZnRmFQXq8wByJzN7C
X-Received: by 2002:a17:907:104c:: with SMTP id oy12mr97434ejb.503.1610476676847;
        Tue, 12 Jan 2021 10:37:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1zlG/vvxotr6BIhf0GkjiHxokuholFcp3aGpgAVLgK4qTq2J6gL1gkW/Vi7LEwoM2lkqYmA==
X-Received: by 2002:a17:907:104c:: with SMTP id oy12mr97428ejb.503.1610476676716;
        Tue, 12 Jan 2021 10:37:56 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id a2sm1506236ejt.46.2021.01.12.10.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 10:37:56 -0800 (PST)
Subject: Re: [PATCH v2 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     Perry Yuan <perry979106@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Perry Yuan <Perry.Yuan@dell.com>
Cc:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Limonciello Mario <Mario.Limonciello@dell.com>
References: <20201228132855.17544-1-Perry_Yuan@Dell.com>
 <mXtNUreCVsPKizG-fnNKPId9_lQGit0S6pYEpk-aNT1hGQjVwblZDiO4E-YX3hxnrbbNN1-6hSntiv13wz66RxbhXjPJhpAVOIlZmmwUI7w=@protonmail.com>
 <7def1cdc-e275-9ae6-4941-55517359bb1e@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ce598a92-73ef-e9a6-d772-59f5da3d251e@redhat.com>
Date:   Tue, 12 Jan 2021 19:37:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <7def1cdc-e275-9ae6-4941-55517359bb1e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I know there already is a v3 out and I will try to get around to reviewing
that soon, still 1 remark about the discussion surrounding v2:

On 1/11/21 2:42 PM, Perry Yuan wrote:

<snip>

>>> *The flow is like this:
>>> 1) User presses key. HW does stuff with this key (timeout is started)
>>> 2) Event is emitted from FW
>>> 3) Event received by dell-privacy
>>> 4) KEY_MICMUTE emitted from dell-privacy
>>> 5) Userland picks up key and modifies kcontrol for SW mute
>>> 6) Codec kernel driver catches and calls ledtrig_audio_set, like this:
>>> 	ledtrig_audio_set(LED_AUDIO_MICMUTE,
>>> 		rt715->micmute_led ? LED_ON :LED_OFF);
>>> 7) If "LED" is set to on dell-privacy notifies ec,
>>>   and timeout is cancelled,HW mic mute activated.
>>>
>> Please proofread the commit message again, and pay attention to capitalization
>> and spacing.
> I want to reformat it and move the commit info to cover letter.

Please also put a copy of this as a comment in either the wmi or the
acpi driver (with a comment pointing to the comment in the other) this is
important info to have for someone reading the code and trying to understand
how this all fits together.

Regards,

Hans

