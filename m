Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C3E2E71E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 16:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgL2Plx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 10:41:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbgL2Plw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 10:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609256425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=St5ow6BktJ+43KSijX9WxkANnyFhd1WZD38g7LbRQnU=;
        b=iwSngT4rZjPNOWOyxfL/huB2+G4VFslQc2NYtHGRpcKkXhLX9r/Gmv5oLqLx57TktmNR1F
        aIuoLOocFZF9Z6MucsIZYThBd06RfdW6lng3w/J0/5RCb0h1ZeW3gpVlVXOiASXaMqwj55
        2VD/45g17JBX3uiqKmI8dx0NERoKOKk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-Bzbe4ZoKN_mNtRyd1qZdCg-1; Tue, 29 Dec 2020 10:40:22 -0500
X-MC-Unique: Bzbe4ZoKN_mNtRyd1qZdCg-1
Received: by mail-ej1-f71.google.com with SMTP id lw15so5035376ejb.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 07:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=St5ow6BktJ+43KSijX9WxkANnyFhd1WZD38g7LbRQnU=;
        b=K/qlBiP3wD3iBCjgGFbVcjf4oBBp7NfTrhsk7KtVvo5Gshr8J7KM1Zi466apl9NbHK
         tk17uViQ1INc6JzVSJAQqJyJyDLrfHKmzFxEQh5Y/K6XhKEUlpTJaD3trq2yCva60xtv
         jYOUkZh4PzXPy3e5nM5zYCfw7RD0V/qS1QCVCPqUVsI5a5zird4NwJ9yP6dQlQ0zUuCZ
         qVPe8DY/LkVSb6ORFj1vfP2iRSrOH7/yyLXOEcpliQ6NzpLPgorxRnfp2maAGX2oS1In
         ErwVxcDzatDeMuepNCn/Ddol8s0YNMN6dsFgF+lXVOhbEgS6Zt5SiQIVZ2VoKXK11eoH
         v3lQ==
X-Gm-Message-State: AOAM5313xiqeKdMQeakwr83F4AflE/gK77d6SU5WX1/EcqvA+lpa4VxZ
        MBY9R1zBBsBZr8e2cMjAu52VaiPp9/OSRUfhNyZhpe8lFVjgIAH6qVXmYqXF/6LKoUhXQ6RuLXa
        RkPwR5hV4y1hvSiuu+oIlimR0
X-Received: by 2002:a17:907:c05:: with SMTP id ga5mr44328061ejc.32.1609256420747;
        Tue, 29 Dec 2020 07:40:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwm7L2MghW6vxcPj16+RHJrGVR3ouARaHp79/K0nTwsWgjSGaF4SkRll8L+4h3Qy/71rVr3HA==
X-Received: by 2002:a17:907:c05:: with SMTP id ga5mr44328049ejc.32.1609256420559;
        Tue, 29 Dec 2020 07:40:20 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id n20sm18116708ejo.83.2020.12.29.07.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 07:40:19 -0800 (PST)
Subject: Re: [PATCH 01/14] mfd: arizona: Add jack pointer to struct arizona
To:     Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-2-hdegoede@redhat.com>
 <20201228122138.GA5352@sirena.org.uk>
 <44f84485-8efc-39f9-d0a7-cb8db2ea3faa@redhat.com>
 <20201228162807.GE5352@sirena.org.uk>
 <20201229130657.GN9673@ediswmail.ad.cirrus.com>
 <19c2d056-4f71-2c4c-c243-cdcc0115876c@redhat.com>
 <20201229150635.GP9673@ediswmail.ad.cirrus.com>
 <20201229151548.GG4786@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1d982dd1-eb02-e7c7-357e-83cf5003c624@redhat.com>
Date:   Tue, 29 Dec 2020 16:40:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201229151548.GG4786@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/29/20 4:15 PM, Mark Brown wrote:
> On Tue, Dec 29, 2020 at 03:06:35PM +0000, Charles Keepax wrote:
> 
>> There is maybe more argument for porting the Arizona code across
>> anyways, since for a long time Android didn't properly support extcon
>> either. It supported the earlier out of tree switch stuff, extcon
> 
> Completely moving the driver doesn't cause the same problems as the
> current proposal (unless it drops functionality I guess, there were
> issues with adding new detection types into the input layer but I can't
> remember if this hardware was impacted by that or not).

The input-layer supports the following switches:

SW_HEADPHONE_INSERT
SW_MICROPHONE_INSERT
SW_LINEOUT_INSERT 
SW_JACK_PHYSICAL_INSERT

Which is a 1:1 mapping with the cable-types currently exported by
extcon-arizona.c .

I'm fine with fully moving extcon-arizona.c over to only using
sound/core/jack.c functionality and it no longer exporting an
extcon device.

I guess we should move it out of drivers/extcon then though.
I suggest using: sound/soc/cirrus/arizona-jack-detect.c
Note that sound/soc/cirrus is a new dir here. Would that work
for you ?

And I guess we probably also want to change the MFD instantiated
platform-dev's name to which it binds then?

I suggest using: "arizona-jack-detect" as new pdev name.

It will take me some time before I can make time to implement this,
but this is a plan which I can get behind.

Regards,

Hans

