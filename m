Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820762C8CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgK3SXJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Nov 2020 13:23:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56447 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgK3SXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:23:08 -0500
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kjnoh-000174-3P
        for linux-kernel@vger.kernel.org; Mon, 30 Nov 2020 18:22:27 +0000
Received: by mail-pl1-f198.google.com with SMTP id 4so8237832pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lhVOYxI0d+RZORJDgRyHtIR+4lAzrds47IByAtB03zY=;
        b=DLdiLOlxxdIoyvR3UhICjvESU8VD4TyIoHt2vLCd79TD+quD5laZH9Tbk/i7hymkfp
         C7Dmk9rXuPvDIBYkQEQTgTdsmck1/z8Kq/5qYzO/W5urC06zUan1U2sAZ2+I0YJwlf5x
         3KlH3dfiI6HHKX/fjX5OJPGZv9rGwzk54T7Km4Kd74n5bGvlheIneFomXPtMLea2uJTV
         nmf1eRZ4fyww5sG49kPjgslbnGy6yL/PbHtohRpyoDjDnTbFigq0mSsezYQL8m1GsKjM
         aognuRmXZN/vPXaMvE3krZ58Icg9Y7dbyL4vRMNDaFdRznzz74a0+kLb3pwJYuPvqN/X
         9M2g==
X-Gm-Message-State: AOAM533MvkKK6I4dnlODT2JwjBCpxsWrfYjCInYEa0OqlYnl1O2ero+7
        8brIhGRBA28s3jhPEX9E5UdOakmbJGEXscLWr6aJL9OW8/sVVUJNb+zCLKXAfz0doOWelLMISZl
        JzMBN1qfMmT1LUEVsuEnzeTntkEsVO+qY5u30W/5HPw==
X-Received: by 2002:a63:1959:: with SMTP id 25mr19141033pgz.201.1606760545463;
        Mon, 30 Nov 2020 10:22:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwosn9nPeiMfVFf2P1X+WOoUeFTeAly+buFBMcBAfq0GLwXMcoctMTwhPt0d8ozsAnzvXR3cg==
X-Received: by 2002:a63:1959:: with SMTP id 25mr19141009pgz.201.1606760545156;
        Mon, 30 Nov 2020 10:22:25 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id k4sm17057312pfg.130.2020.11.30.10.22.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 10:22:24 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH 1/3] thermal: core: Add indication for userspace usage
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <585bb5d3ee5bea063795682108576c3464ba72b6.camel@linux.intel.com>
Date:   Tue, 1 Dec 2020 02:22:21 +0800
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, amitk@kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D53454A1-5ED0-4B4D-B22F-8663C9970ECD@canonical.com>
References: <20201128175450.12456-1-kai.heng.feng@canonical.com>
 <004fe225-1009-06d8-b297-c03a4c67550f@linaro.org>
 <860126B8-1152-4EE3-B15E-B4E45EFE879F@canonical.com>
 <fc67ad02826fb3adfd8457e1a0baf234a8fa3fce.camel@linux.intel.com>
 <34348B03-5E27-49A0-A704-6332BAC00758@canonical.com>
 <585bb5d3ee5bea063795682108576c3464ba72b6.camel@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Dec 1, 2020, at 02:13, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

[snipped] 

>>> What about creating an new callback
>>> 
>>> enum thermal_trip_status {
>>> 	THERMAL_TRIP_DISABLED = 0,
>>> 	THERMAL_TRIP_ENABLED,
>>> };
>>> 
>>> int get_trip_status(struct thermal_zone_device *, int trip, enum
>>> thermal_trip_status *state);
>>> 
>>> Then in 
>>> static void handle_thermal_trip(struct thermal_zone_device *tz, int
>>> trip)
>>> {
>>> 
>>> /* before tz->ops->get_trip_temp(tz, trip, &trip_temp); */
>>> if (tz->ops->get_trip_status) {
>>> 	enum thermal_trip_status *status;
>>> 
>>> 	if (!tz->ops->get_trip_status(tz, trip, &status)) {
>>> 		if (status == THERMAL_TRIP_DISABLED)
>>> 			return;	
>>> 	}
>>> }
>>> ...
>>> ...
>>> 
>>> }
>>> 
>>> 
>>> This callback will help the cases:
>>> - Allows drivers to selectively disable certain trips during init
>>> state
>>> or system resume where there can be spikes or always. int340x
>>> drivers
>>> can disable always.
>> 
>> This sounds really great. This is indeed can happen on system resume,
>> before userspace process thaw.
>> 
>>> - Still give options for drivers to handle critical trip even if
>>> they
>>> are bound to user space governors. User space process may be dead,
>>> so
>>> still allow kernel to process graceful shutdown
>> 
>> To make the scenario happen, do we need a new sysfs to let usespace
>> enable it with THERMAL_TRIP_ENABLED?
> This should be drivers call not user space.

Understood. So after thermal_zone_device_register(), the driver can decide to what to return on get_trip_temp().
Let me work on a new patch if there's no other concern.

Kai-Heng

> 
> Thanks,
> Srinivas

