Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0812B6C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgKQRkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbgKQRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:40:19 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9B3C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:40:18 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id b3so10593727pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iiwx67hxxgxtCCuEa1EzwHVFpWqU1uzHgGryNJZoJco=;
        b=EnjD+jW+kv1TUdbA9VVE/MUiB+sfoy5HxSR3PKjA9z7czDazKAjIws4AWaTwW9VXbr
         zFuZHDEPph3laugWXQylEgfV9XDIX/FK0pvdvakNrEwEmjzpl0TCiy+ZQUGwYTVygMcN
         rsn38lspn4WRnop3BmNqaJyhXubSOI94Ra+hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iiwx67hxxgxtCCuEa1EzwHVFpWqU1uzHgGryNJZoJco=;
        b=Yh8+giD+4DD26mhGnV8rCl9YNEHN87UoPJU6803hCoEZpEkoPF3XAq7ry4XFS+QGnr
         OFQZfZCd43ZtxPjcFFlGde1gA21FWpsG5HDGmjjQ9TdcARMmjBASg3lqHEsQYcBm8Sgq
         kQCDmj0MknBRne7uL3OM7KjG8PlS7Cf4Uu/FeQMldISj2V5EdqeKeLDdpcfplxJqNa1g
         fBp+OZf1kfg71V06FPyQR3uAP5vPXzT08UrDUk7OVOv+rxJMIUuRo39lFB39dy2nPSIH
         q8cpw7As8YQx0EbeawazA4iyuv1SRcBqDVQWXoz8zJhat8rLDCT+AQznoqlReow9a07C
         bjmQ==
X-Gm-Message-State: AOAM531HHHCD53MddWaMSkBqGbFyAWDvvAm9U+smfGOqNm6hcAxnZFQr
        +0kf9HwgW499gK2b+v7JB+rNKg==
X-Google-Smtp-Source: ABdhPJxc0ydiXe3VInfI6J2+5e2WI/955LuSZkxewaWME+8Y6ifHxlwySoocMBHrEYfV5wN7XBv9WQ==
X-Received: by 2002:a17:90a:d252:: with SMTP id o18mr199429pjw.108.1605634817792;
        Tue, 17 Nov 2020 09:40:17 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id q16sm21771433pff.114.2020.11.17.09.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 09:40:17 -0800 (PST)
Date:   Tue, 17 Nov 2020 09:40:16 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, enric.balletbo@collabora.com
Subject: Re: [PATCH v3 03/11] usb: typec: Add plug num_altmodes sysfs attr
Message-ID: <20201117174016.GA1819103@google.com>
References: <20201116201150.2919178-1-pmalani@chromium.org>
 <20201116201150.2919178-4-pmalani@chromium.org>
 <20201117124143.GI3437448@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117124143.GI3437448@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Tue, Nov 17, 2020 at 02:41:43PM +0200, Heikki Krogerus wrote:
> On Mon, Nov 16, 2020 at 12:11:42PM -0800, Prashant Malani wrote:
> > Add a field to the typec_plug struct to record the number of available
> > altmodes as well as the corresponding sysfs attribute to expose this to
> > userspace.
> > 
> > This allows userspace to determine whether there are any
> > remaining alternate modes left to be registered by the kernel driver. It
> > can begin executing any policy state machine after all available
> > alternate modes have been registered with the connector class framework.
> > 
> > This value is set to "-1" initially, signifying that a valid number of
> > alternate modes haven't been set for the plug. The sysfs file remains
> > hidden as long as the attribute value is -1.
> 
> Why couldn't we just keep it hidden for as long as the number of
> alt modes is 0? If you already explained that, then I apologise, I've
> forgotten.
> 

No worries :)

Succinctly, because 0 is a valid value for "number of altmodes
supported".

If we keep the attribute hidden for 0, then there won't
be a way for userspace to determine that PD discovery is done and we
don't expect any more cable plug altmodes to be registered by the kernel
Type C port driver (it can determine this by comparing
"number_of_altmodes" against the actual number of alt modes registered
by the Type C port driver).

If we keep "number_of_altmodes" hidden even for 0, the userspace cannot
differentiate between "this cable doesn't support any altmodes" and
"it does altmodes, but the PD stack hasn't completed PD Discovery
including DiscoverIdentity yet".

For reference, here is the initial patch and mini-discussion around it
back in July for port-partner altmodes [1] (I've followed a similar
logic here).

Hope this helps the rationale a bit more.

Best regards,

-Prashant

[1]:
https://lore.kernel.org/linux-usb/20200701082230.GF856968@kuha.fi.intel.com/
