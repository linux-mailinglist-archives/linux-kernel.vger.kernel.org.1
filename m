Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960A02D3716
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 00:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgLHXqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 18:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbgLHXqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:46:01 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A59C061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 15:45:21 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id o5so13710585pgm.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 15:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yOCVuAKud10PIJTv8iPXgZJtUqb9EqW2D73UVatsILw=;
        b=C4+PcK+/ORS0a1Oi66iXuWdF7Y2wtYlDIWlmqI0PZ13LoKh1blc3FfywDyGJoB6dZB
         BRbNxBDjq1k292vaxBzqvRan3cstZFCKHtKw088dn3QRHhBaCcIx9afmRcBkuoCAXhdL
         PzYwO5BkDS6swOkFgzQpl/8OCqRxpBK6zXpOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yOCVuAKud10PIJTv8iPXgZJtUqb9EqW2D73UVatsILw=;
        b=Mr1hDlhF3PRWh3/zb/2gJCLzWwE0jRsnKd43l4DDllQ+GyVlTwGR1G7E9XLzFFQJbA
         xZB/NBmZDDtNgpLIMx0szsmzZ2/7Fxu4hDzYo75QAhgzeVPtTr/YxUJUWwKYNCdg5ipK
         V+1yzPT9CyAmY1Yt/JGVcS8Ymc50I9lnPEkhLB15I2l/XsJpZDEeiPiflrx7ZI8+hSSe
         1P/bc+nSqvsgxBhbTHHpd0V2SGlPMp1YZbe3Yv5xua4tkoqlPuQYcHTN0YljN+E8WicT
         W+F9foAw/4SlCdIFBHSFiKdDJrIuyx0TJXok1Zutt9uxueTsmOxIXGEBy+eFk3ktQT9/
         LTLw==
X-Gm-Message-State: AOAM532bJHCRjd2vMPYxHz8JBdJ7+rFYrdgFcHtSUPOb2IjMs+ogHriv
        qxCYYLVhkNCjIb6ar3DO+t1hwQ==
X-Google-Smtp-Source: ABdhPJyvPcCiKEX7ONzVKFWom43k5I7abeSnOkUhBj4DSzT25k5f2V4W40gIC5h6VbUPiGiqfeD7Rw==
X-Received: by 2002:a63:5a52:: with SMTP id k18mr400053pgm.407.1607471120842;
        Tue, 08 Dec 2020 15:45:20 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id u12sm280658pfn.88.2020.12.08.15.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 15:45:20 -0800 (PST)
Date:   Tue, 8 Dec 2020 15:45:19 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: Add bus type for plug alt modes
Message-ID: <CACeCKaehg=HTuQNLtQaJZWvTnOFYM9b1BWfM+WX_ebiZ-_i8JQ@mail.gmail.com>
References: <20201203030846.51669-1-pmalani@chromium.org>
 <20201208093734.GD680328@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208093734.GD680328@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

Thanks a lot for looking at the patch.

On Tue, Dec 8, 2020 at 1:37 AM Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:
>
> On Wed, Dec 02, 2020 at 07:08:47PM -0800, Prashant Malani wrote:
> > Add the Type C bus for plug alternate modes which are being
> > registered via the Type C connector class. This ensures that udev events
> > get generated when plug alternate modes are registered (and not just for
> > partner/port alternate modes), even though the Type C bus doesn't link
> > plug alternate mode devices to alternate mode drivers.
>
> I still don't understand how is the uevent related to the bus? If you
> check the device_add() function, on line 2917, kobject_uevent() is
> called unconditionally. The device does not need a bus for that event
> to be generated.

My initial thought process was to see what is the difference in the adev device
initialization between partner altmode and plug altmode (the only difference I saw in
typec_register_altmode() was regarding the bus field).

Yes, kobject_uevent() is called unconditionally, but it's return value isn't checked,
so we don't know if it succeeded or not.

In the case of cable plug altmode, I see it fail with the following error[1]:

[  114.431409] kobject: 'port1-plug0.0' (000000004ad42956): kobject_uevent_env: filter function caused the event to drop!

I think the filter function which is called is this one: drivers/base/core.c: dev_uevent_filter() [2]

static int dev_uevent_filter(struct kset *kset, struct kobject *kobj)
{
	struct kobj_type *ktype = get_ktype(kobj);

	if (ktype == &device_ktype) {
		struct device *dev = kobj_to_dev(kobj);
		if (dev->bus)
			return 1;
		if (dev->class)
			return 1;
	}
	return 0;
}

So, both the "if (dev->bus)" and "if (dev->class)" checks are failing here. In the case of partner alt modes, bus is set by the class.c code
so this check likely returns 1 in that case.

In case the provided fix is not right or acceptable, an alternative I can think of is:
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index c13779ea3200..ecb4c7546aae 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -517,6 +517,9 @@ typec_register_altmode(struct device *parent,
        if (is_typec_partner(parent))
                alt->adev.dev.bus = &typec_bus;
 
+       if (is_typec_plug(parent))
+               alt->adev.dev.class = typec_class;
+
        ret = device_register(&alt->adev.dev);
        if (ret) {
                dev_err(parent, "failed to register alternate mode (%d)\n",

This too ensures that the filter function returns a 1.

Kindly LMK which way (if any) would you prefer.

>
> Also, I don't understand how are the cable plug alt modes now
> prevented from being bind to the alt mode drivers?

Sorry about this; I am unable to test this out. I just based the observation on the line in Documentation/driver-api/usb/typec_bus.rst
(Cable Plug Alternate Modes) : "The alternate mode drivers are not bound to cable plug alternate mode devices,
only to the partner alternate mode devices" . I don't completely understand the bus.c code yet, so assumed that the code
there checked for the partner type during bind attempts.

Of course, based on what the eventual solution is, this statement may no longer be required and I can remove it from the commit message <or>
I can amend the Documentation to specify that cable plug alt modes can bind to alt mode drivers.

Thanks,

-Prashant

[1] https://elixir.bootlin.com/linux/v5.10-rc7/source/lib/kobject_uevent.c#L516
[2] https://elixir.bootlin.com/linux/v5.10-rc7/source/drivers/base/core.c#L1840
