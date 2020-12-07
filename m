Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AC52D0A48
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 06:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgLGFhY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Dec 2020 00:37:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51824 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgLGFhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 00:37:24 -0500
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1km9CT-0000KE-96
        for linux-kernel@vger.kernel.org; Mon, 07 Dec 2020 05:36:41 +0000
Received: by mail-pf1-f200.google.com with SMTP id b11so8500061pfi.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 21:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YwGMi9iNd6O/Jb8LuzDIfb7n8JTTcq96cUgR5LZJ6ho=;
        b=augC6/yloI1L55LkMD7qitOwHN4UW+bVFBduxwaJD72aF4P3QDkjJ05HU81QqKvWcM
         olxAWV8F3wlXjsyEW5krmOL6fohvN4AeX8YYqLB/cB3xt2YOc2KTn43gExJ9ZjdJtrwm
         5mvSd3HC5ZJVmJbRg2rdbMuV+kQ2FAx+FxuHIbp9oLENa8HVfeEAbucVG+3RIgqzLmRX
         r2SGxZhb/NLyNZHNa/BmiHfZb3oiFa0X3g/87c2NHch3FY9h5VlMYfbihiVKPixL2YMU
         BWVRYMBKuNG0iiguDO0uhdMAoo1GqoUg4f480dUsF4DLcP8dyy7zyRlO57TzV4qIxBd0
         J4Og==
X-Gm-Message-State: AOAM532oFFKz8QLIGZLiq4su9BDa+4757z8hG9JT9gkbO0RwvFr0Nztp
        QXndQC8urFkk39k7YJEIUxc0sS+DC5LOwMKx3Evhj7MArvpjO86S6YyHvTgqk5bTtgGWaeoNNCz
        AifZSy8f3dRgBDfQiwzpsr7XEc+EpA5gq1otPx+g4RQ==
X-Received: by 2002:a17:902:830a:b029:da:df3b:459a with SMTP id bd10-20020a170902830ab02900dadf3b459amr8931037plb.75.1607319399824;
        Sun, 06 Dec 2020 21:36:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOvWqW1KGPx37vxNpQuOkkh0LYbbhwGCUnQvxzO9fmn844rtNnaDBgPn+0nSp9WkuOTdXViQ==
X-Received: by 2002:a17:902:830a:b029:da:df3b:459a with SMTP id bd10-20020a170902830ab02900dadf3b459amr8931014plb.75.1607319399534;
        Sun, 06 Dec 2020 21:36:39 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 22sm12021202pfn.190.2020.12.06.21.36.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 21:36:38 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH 1/3] thermal: core: Add indication for userspace usage
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <f863f2e1e322a8819c660f5eefbbc4acf7522990.camel@linux.intel.com>
Date:   Mon, 7 Dec 2020 13:36:35 +0800
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, amitk@kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <FCFE1F21-2EC6-4D3A-8B2E-32C653816D58@canonical.com>
References: <20201128175450.12456-1-kai.heng.feng@canonical.com>
 <004fe225-1009-06d8-b297-c03a4c67550f@linaro.org>
 <860126B8-1152-4EE3-B15E-B4E45EFE879F@canonical.com>
 <fc67ad02826fb3adfd8457e1a0baf234a8fa3fce.camel@linux.intel.com>
 <34348B03-5E27-49A0-A704-6332BAC00758@canonical.com>
 <585bb5d3ee5bea063795682108576c3464ba72b6.camel@linux.intel.com>
 <D53454A1-5ED0-4B4D-B22F-8663C9970ECD@canonical.com>
 <f863f2e1e322a8819c660f5eefbbc4acf7522990.camel@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 1, 2020, at 02:39, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> On Tue, 2020-12-01 at 02:22 +0800, Kai-Heng Feng wrote:
>>> On Dec 1, 2020, at 02:13, Srinivas Pandruvada <
>>> srinivas.pandruvada@linux.intel.com> wrote:
>> 
>> [snipped] 
>> 
>>>>> What about creating an new callback
>>>>> 
>>>>> enum thermal_trip_status {
>>>>> 	THERMAL_TRIP_DISABLED = 0,
>>>>> 	THERMAL_TRIP_ENABLED,
>>>>> };
>>>>> 
>>>>> int get_trip_status(struct thermal_zone_device *, int trip,
>>>>> enum
>>>>> thermal_trip_status *state);
>>>>> 
>>>>> Then in 
>>>>> static void handle_thermal_trip(struct thermal_zone_device *tz,
>>>>> int
>>>>> trip)
>>>>> {
>>>>> 
>>>>> /* before tz->ops->get_trip_temp(tz, trip, &trip_temp); */
>>>>> if (tz->ops->get_trip_status) {
>>>>> 	enum thermal_trip_status *status;
>>>>> 
>>>>> 	if (!tz->ops->get_trip_status(tz, trip, &status)) {
>>>>> 		if (status == THERMAL_TRIP_DISABLED)
>>>>> 			return;	
>>>>> 	}
>>>>> }
>>>>> ...
>>>>> ...
>>>>> 
>>>>> }
>>>>> 
>>>>> 
>>>>> This callback will help the cases:
>>>>> - Allows drivers to selectively disable certain trips during
>>>>> init
>>>>> state
>>>>> or system resume where there can be spikes or always. int340x
>>>>> drivers
>>>>> can disable always.
>>>> 
>>>> This sounds really great. This is indeed can happen on system
>>>> resume,
>>>> before userspace process thaw.
>>>> 
>>>>> - Still give options for drivers to handle critical trip even
>>>>> if
>>>>> they
>>>>> are bound to user space governors. User space process may be
>>>>> dead,
>>>>> so
>>>>> still allow kernel to process graceful shutdown
>>>> 
>>>> To make the scenario happen, do we need a new sysfs to let
>>>> usespace
>>>> enable it with THERMAL_TRIP_ENABLED?
>>> This should be drivers call not user space.
>> 
>> Understood. So after thermal_zone_device_register(), the driver can
>> decide to what to return on get_trip_temp().
> get_trip_status()
> 
>> Let me work on a new patch if there's no other concern.
> Better to wait for confirmation from Daniel and others.

Daniel,

Do you like Srinivas' proposed solution?

I hope we can find a solution in upstream kernel soon.

Kai-Heng

> 
> Thanks,
> Srinivas
> 
>> 
>> Kai-Heng
>> 
>>> Thanks,
>>> Srinivas

