Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF45A2DC7AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgLPUS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgLPUS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:18:29 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666F3C0617A7;
        Wed, 16 Dec 2020 12:17:49 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id k9so6105184oop.6;
        Wed, 16 Dec 2020 12:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Y/tsQuNUO80igK4KNvXh6nO6Q/vpF+yjzC6mZ8Xdek=;
        b=usD8AkujNhHrt/O5ePwJ/XRRAAt+GTvIUUHkw2HpVHuJMBw4sFCGMmeVeI1MNbLFO1
         XU6jHxsy2KdyUWbVxQzqKBuEumbJJI6Ui1V6agKV1zYRDbEbdOyT3nz2bRWTq3pa70qV
         Pg06HT501qWmu1SP/wpC83Knth9cVq4OGFclPuDStMKPScemToe6vBXDbeLbZNEZmBAT
         urffYFs7hbRICktO9Kci9cdPNY2QtSdVcJFJHu9OSZ+MKY820dKjnx+HVLp02hQz9l9o
         Dw3yxrgbO6tzi9tD52UkTwa5I2PCIYCnrsaRLomm+PBTFVSmvVMA1/Ltj3c//6hK4kBS
         /uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Y/tsQuNUO80igK4KNvXh6nO6Q/vpF+yjzC6mZ8Xdek=;
        b=M3XIAnGAxp095S9VI9TqjwsA9SQpkMVOe41MkiALzZumyi/bg8ZW5RD/v/KneAx3S+
         yqs66FsCYiz1zr8LC9WG6N6B7y6GGpAbFm1CL2IqrbY3fNpTTWCB6TI/Sg8kQX8KQ0lB
         i5LbnllmFjPuDAMjRnCbxmkhp+NMnE0xsBl9cyicXEomzc7iDE++jBV0k/V24fdF2fZi
         JabsBON5PJtVNWz287GN+6Npw6K+bsnqA8ptHcnANkJmRdh52LJdhmw7s8IhuPElCXL2
         7+kRLdg4pKRgBXyaM8xAK4fIvVmvVfYovqf5i19dSlvQ7Od4UrEFogxuVKGlEhSRZYWW
         5Kaw==
X-Gm-Message-State: AOAM532GFMvUd1Mi3bWYAMR8VOsCY0oMkYYa5qW26MmLITA7w3MlphFc
        vNDUOqn4FO9mUJWlWOxhZxU=
X-Google-Smtp-Source: ABdhPJwE7WMEKnFum8kRAsOkF2haOd8Atp5Ch62jaCl9p40ld6QA4FfeZfAIoSw5rPRtygqON+y/YQ==
X-Received: by 2002:a4a:11c2:: with SMTP id 185mr3605874ooc.85.1608149868854;
        Wed, 16 Dec 2020 12:17:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v23sm678025otj.68.2020.12.16.12.17.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Dec 2020 12:17:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 16 Dec 2020 12:17:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kun Yi <kunyi@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: SENSORS_SBTSI should depend on X86
Message-ID: <20201216201747.GB68047@roeck-us.net>
References: <20201216163103.GA59351@roeck-us.net>
 <CAGMNF6V-w47SDAUgVAtG+Xrp0ECNOvVV1Xy5=FsXTwqc-c3NbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGMNF6V-w47SDAUgVAtG+Xrp0ECNOvVV1Xy5=FsXTwqc-c3NbQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 09:27:28AM -0800, Kun Yi wrote:
> On Wed, Dec 16, 2020 at 8:31 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Wed, Dec 16, 2020 at 02:46:41PM +0100, Geert Uytterhoeven wrote:
> > > The AMD SB Temperature Sensor Interface (SB-TSI) is only present on AMD
> > > X86 SoCs.  Hence add a dependency on X86, to prevent asking the user
> > > about this driver when configuring a kernel without AMD X86 platform
> > > support.
> 
> Sorry, I think there is some confusion. AMD SoC is a 'remote sensor',
> or the client, whereas the device using the SB-TSI hwmon driver is the
> master.
> In industry, a typical scenario is ARM-based Board Management
> Controllers (BMCs) using SB-TSI to monitor the host CPU temperature.
> 
Ah, good point. I'll drop this patch.

Thanks,
Guenter
