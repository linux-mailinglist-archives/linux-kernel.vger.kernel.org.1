Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7022FEFB3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbhAUQBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:01:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732963AbhAUP7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611244698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gxg++XI0YPfZVOGn773w0joNP2UVCis1+mi7+/xwU2g=;
        b=ZyXTDxa1cX9245qtM5oMQHjxMGsOHuYJrVdV52bIIEa1/N17OiJWnas1ZlJpONUg0vGBM3
        DWSOhHNAKJ7qAoxhUJ3Kkemq/nx1f6G2IiWfKbVicJKk0zkL8H+YPrIdN6a33261eqakhq
        ZajOex70tGYSIdh/kZrTjpBxuiCvpPk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-d6s2q8BtMAq5_365r5Fuag-1; Thu, 21 Jan 2021 10:58:16 -0500
X-MC-Unique: d6s2q8BtMAq5_365r5Fuag-1
Received: by mail-ej1-f69.google.com with SMTP id q11so942477ejd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 07:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gxg++XI0YPfZVOGn773w0joNP2UVCis1+mi7+/xwU2g=;
        b=ub44RFLftU8zzyoPAgElxOz1f/TiqfHInjxqi6CH1WCgg3cNwvwOkQE34niyqX9gdf
         FvvGKJceVOvjzYDF6PAmGmmf7ukVo58IamynO2plsyPHeSI2/tVHkQ5Tr3IVRHuOE5cm
         OadxCMYTXUNGugFbYAmzStHw/4KzEvIZ8vC4i0bYuywSxrrX2KABu8mCp7gD9MivJy1K
         PgcYZAwN9dHklR2IQWde6T9b4loVFFc0WV/HYLs8SxGwqgg+Wcfs7XCGBnZjV1s/aPuh
         U1MhZ8fa2WTlXL9xduZ1kuJVR94NZGDORwIGV2CPguBk2BpvYyRVNpHZknsr5qeaN7Mu
         1icQ==
X-Gm-Message-State: AOAM531HU0HSQskE3Q8haW4JMFNjE9Yy4m1l4lgWMQxcWto/FQh4Kxkc
        0a+bvSdAVJzGnbCit1g97Tiy26DnEPmZrWG3Z9HzeLEoShlMkEmITL/8/dmGHs+y4i0FIkJ21mg
        z3t2ezJQxQYIhXG6ZxOezGa5V
X-Received: by 2002:a17:906:52c1:: with SMTP id w1mr110727ejn.214.1611244695365;
        Thu, 21 Jan 2021 07:58:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+xUZbRk6EKYn3AmKWraZ7fUxA/I8QOIemNGQ8/RMaZjEd/rbynq44e11lmTCnRs86KDPPDg==
X-Received: by 2002:a17:906:52c1:: with SMTP id w1mr110715ejn.214.1611244695129;
        Thu, 21 Jan 2021 07:58:15 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id ar1sm2372508ejc.30.2021.01.21.07.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 07:58:14 -0800 (PST)
Subject: Re: [PATCH v2 03/12] ASoC: arizona-jack: Fix some issues when HPDET
 IRQ fires after the jack has been unplugged
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210117160555.78376-4-hdegoede@redhat.com>
 <20210118124747.GH4455@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <32d709f7-211e-6cce-a83e-318061e36609@redhat.com>
Date:   Thu, 21 Jan 2021 16:58:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210118124747.GH4455@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/21 1:47 PM, Mark Brown wrote:
> On Sun, Jan 17, 2021 at 05:05:46PM +0100, Hans de Goede wrote:
>> When the jack is partially inserted and then removed again it may be
>> removed while the hpdet code is running. In this case the following
>> may happen:
> 
> Fixes like this should be sent at the start of the series (prior to
> things like the move) so they can go to stable as bug fixes.

Ok, I'll reshuffle the series for v3 to put these first and have
them apply to drivers/extcon/extcon-arizona.c before it is
moved to sound/soc/codecs/arizona-jack.c

Regards,

Hans

