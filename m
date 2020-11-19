Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4A32B8A89
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 04:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgKSD4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 22:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgKSD4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 22:56:18 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FFCC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 19:56:18 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q5so3160773pfk.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 19:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BOteje9PH47uKCSyYyf55iejg5lOWXYs0usYUAikQg0=;
        b=SSnGGTaeHY2j5KC8zA/q/XVO30eAZaOWZlRYqaNOfQ/Wxc8o+vbZuv5fU6y9ffIyBF
         fBCqGi59KT4ZSN45eeRT36wT9hxplLmIW7cF1/GqgKgqNdwMDmcyu6OI5QUllL0Zqlna
         3bGgq4u5gAQ36BHtv5lGPfSOR3YRGSdggWYCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BOteje9PH47uKCSyYyf55iejg5lOWXYs0usYUAikQg0=;
        b=htI8nNuWhqclel1e6J6pby/CiVJsFCVpm0sO5ZPzlms9uRiWLlsqHLK+LMO/wJiXbL
         Ururabpsu6uoxPI3lPgiB0NbfAetgnAchaOyLgAhNb3agn0GLfDfqNoxFp9kfUUpDU65
         UwFHvxhrRCYUs29Lp8hRVOskwdkNh/9Kh4zdUvT9g80/DbsifdaLPt9rhU/PGYhQd70A
         NwVEpVTmeEsXe+i+qplCRiBKKcI+o9mmuGm2kuK7QIYKyPrvdUztmO2tb/lPyBAOKSjv
         PkWPWheaM3rZJ/hd5xyH+9mFG13XtVNNykC7e/aOCIeNIxJo0ljMovPbCA8ZfFaldIRa
         3LVA==
X-Gm-Message-State: AOAM530Zyqu7LZqqVQhg8Hewt2eHlq/S3IL+8xYwhfoa+HlCtsntEhlg
        zy9VYC+LIVDBkM+OthGU62q8OA==
X-Google-Smtp-Source: ABdhPJzzlJBDX5uoSe/RZBOuq6Q1+/DD0zss9SQmTjtfA09CLM+4AhDzrLmwXbncGTUgThya0w5UEA==
X-Received: by 2002:a17:90b:3583:: with SMTP id mm3mr2384617pjb.118.1605758178101;
        Wed, 18 Nov 2020 19:56:18 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id 26sm24231635pgm.92.2020.11.18.19.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 19:56:17 -0800 (PST)
Date:   Wed, 18 Nov 2020 19:56:16 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v3 00/11] chrome/platform: cros_ec_typec: Register
 cables, partner altmodes and plug altmodes
Message-ID: <20201119035616.GC3652649@google.com>
References: <20201116201150.2919178-1-pmalani@chromium.org>
 <X7UMvw7wnMapkAk8@kroah.com>
 <X7UQsaoNfziThXQs@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7UQsaoNfziThXQs@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Nov 18, 2020 at 01:16:49PM +0100, Greg KH wrote:
> On Wed, Nov 18, 2020 at 12:59:59PM +0100, Greg KH wrote:
> > On Mon, Nov 16, 2020 at 12:11:36PM -0800, Prashant Malani wrote:
> > > This patch series adds support for the following bits of functionality,
> > > parsing USB Type C Power Delivery information from the Chrome Embedded Controller
> > > and using the Type C connector class:
> > > - Register cable objects (including plug type).
> > > - Register "number of altmodes" attribute for partners.
> > > - Register altmodes and "number of altmodes" attribute for cable plugs.
> > > 
> > > The functionality was earlier part of multiple series ([1], [2], [3]), but
> > > I've combined it into 1 series and re-ordered the patches to hopefully make
> > > it easier to peruse. I've maintained the patch Acked-by/Reviewed-by tags where
> > > they were received.
> > > 
> > > Patches 1/11, 2/11, 3/11 introduce the changes needed in the USB subsystem (PD VDO
> > > header update, sysfs attribute additions) and hence the first three patches
> > > can go through Greg's tree.
> > 
> > I've taken the first 2 patches in my usb tree now, waiting for Heikki's
> > response on patch 3 before I touch that.
> 
> Ok, now taken patch 3 too.
> 

Thanks!

> I can take the rest in my usb-next tree if the platform people don't
> object as well, but would need an ack for that.

Will defer to Enric on this, but Patch 4/11 and onwards have a
dependency on some patches which are already in the chrome-platform
tree [1], so they may have to go through there.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/log/?h=for-next

Best regards,

-Prashant
