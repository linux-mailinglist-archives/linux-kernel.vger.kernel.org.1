Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA90C19F26E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 11:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgDFJZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 05:25:23 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44767 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgDFJZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:25:23 -0400
Received: by mail-vk1-f196.google.com with SMTP id s194so3764489vkb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 02:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Jkl5CwkBjT6BLZjWifTBiWjf1dpkao6vvkn1JtNrnw=;
        b=epaSpNY0AlXvZtQT8gmSkq7YCfCu+H9+4NsGD1EHtUBhiLj7GDKMDP1ju49fLI5pyq
         pCfSD8KQrN8wMk0FTuTi2fnZ4h0Pl8oDK+75YZP2xKILvVSQ3minilK9OH1HY/2YgtYm
         pUJ/DhYHYK9Dc6Ak3LSqf7BfvYkxmegzELpkt/yCCPAC6ry0lHe2lNsC/shqs5Rez1SL
         v/rQ54yfzAVQjvCw8wjwJ/enwXxnVSh+emOgr25K8vE6pmslN3F88JkGQ6h987Qe5lZ+
         9in6Ft3/bkoh+LkqRPVXSvCoGTJD1LDrdL0hZucIf+Rm8VUlfZMDXFwICxkBeNpRXcwh
         KHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Jkl5CwkBjT6BLZjWifTBiWjf1dpkao6vvkn1JtNrnw=;
        b=nzddxZCG4XbcH59mCZ6vjJalmz3YJv5bFAoRMh/8GtkwHZK4dHPochNzhRNETcqM1e
         DPeP2MKXuPRstUIWSD/CdyCI16zlqvyic3OFv/pFOE/+uZHlj9ms15tBGsJx0tjRSARO
         ltv8Pq/Oy/9/HKxac953+/cprfM2ooCSr/ts/UPIJB4piI+p0RwsOqjDi7t/W4pw+jFV
         IA6oskszXPe9fVUQnwacyQlmLCr7ouubaUUFs9kGobuwAf/5EJfgoDSVycV0mOS2D90g
         jC9tZXcXcYN7tXWB/sDZxaq7fuNfmixStRL21BnIDsJn8yBJ4c+IC9jwCd3vesf6GXFp
         ZYuw==
X-Gm-Message-State: AGi0PuYkcSK4L1pIICQfq2mFdxmo+i3akrnmvB4xnQOwYtwj2nI8Psmu
        TSmhpzvK4IfH02swJpxd4721ETQEC3jWxVjkmBr6Tw==
X-Google-Smtp-Source: APiQypKpm1gkz/VBP6SAjtAx9r42DgH9i0s4xigEtfNsRFSmfNHG/Q1uFdvjjIAzSO9t3OLqXNPvmud55FNmNrc1fSk=
X-Received: by 2002:a1f:1e11:: with SMTP id e17mr2996833vke.73.1586165122498;
 Mon, 06 Apr 2020 02:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <a7e8287d-72be-7ab0-697a-9de40eb3f81f@linaro.org> <20200402142116.22869-1-daniel.lezcano@linaro.org>
In-Reply-To: <20200402142116.22869-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 6 Apr 2020 14:55:11 +0530
Message-ID: <CAHLCerPOVouQfK4iqMc4xQpok=XTHj4d1hsLTsb9N5r=ZUBs8Q@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Send a sysfs notification on trip points
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, vincent.whitchurch@axis.com,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 7:53 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Currently the userspace has no easy way to get notified when a
> specific trip point was crossed. There are a couple of approaches:
>
> - the userspace polls the sysfs temperature with usually an
>   unacceptable delay between the trip temperature point crossing and
>   the moment it is detected, or a high polling rate with an
>   unacceptable number of wakeup events.
>
> - the thermal zone is set to be managed by an userspace governor in
>   order to receive the uevent even if the thermal zone needs to be
>   managed by another governor.
>
> These changes allow to send a sysfs notification on the
> trip_point_*_temp when the temperature is getting higher than the trip
> point temperature. By this way, the userspace can be notified
> everytime when the trip point is crossed, this is useful for the
> thermal Android HAL or for notification to be sent via d-bus.
>
> That allows the userspace to manage the applications based on specific
> alerts on different thermal zones to mitigate the skin temperature,
> letting the kernel governors handle the high temperature for hardware
> like the CPU, the GPU or the modem.
>
> The temperature can be oscillating around a trip point and the event
> will be sent multiple times. It is up to the userspace to deal with
> this situation.

Thinking about this a bit more, userspace might want a notification
when the temperature reduces and crosses the threshold on its way down
too.

Currently, we're only sending the notification on the way up. How
should userspace know when to stop mitigation activity other than
constantly polling the TZ temperature?

> The following userspace program allows to monitor those events:
>
> struct trip_data {
>        int fd;
>        int temperature;
>        const char *path;
> };
>

[snip]
