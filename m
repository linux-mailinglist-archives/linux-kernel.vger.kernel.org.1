Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335B52EF105
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbhAHLAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbhAHLAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:00:41 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA1DC0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 03:00:00 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id lt17so14022493ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 03:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=b8TjwQx2juGDT0sQZHOQEuzIta4ce4spRHp2FOYWyVg=;
        b=IMKP7ujgtr0mi63cQ+MSA4yJlU3LlrFA86t2c9jnc5pMCJNhPDXuGVB8/dy0/IcZ8Y
         c8RQnh3zEM+nV32jtxU2lW+NLZ4DFnsJdUo24KOJfrZhpmGNaeycf1sXZSmmLjq0AWYq
         vjx/De8a0S+3TP7THRN+tYMHfK969ROUTpJ0QUx++xvgPbkascjafz1EGJFG6H8Z4tYw
         0g45u6X2t/TGzCXlWVVmT4yjTQNJAhjYl2/Ylz38tTV6d8ab59rLSeIZPe8jDyF/xsYn
         1vc5BmPq0ujc0Udwtxni9E8KXrTGF5ik8rI5aKQnYp7ApZXHy8Y90Boa12WkMdUs+DEC
         a5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=b8TjwQx2juGDT0sQZHOQEuzIta4ce4spRHp2FOYWyVg=;
        b=nDGnZQ5cyssijsrN3V5Ca2OR5nzfAN4CW304Ykt5YjJqoL7rE2hJPWjio/dRFBna3X
         +obFPl9laKGP/MPIb38z3SF2J+2+PQmM5YLSjzvPXunwuEfi/MfigOgNHrlL6VHzekLn
         Gue54rXku39PC8g+64TVD50LXK1XUTz1UviK8AyFvQrDbzcNqNBmszpiWyG6vQN0f3GW
         QW2pf4KwATfMwT/VmuC6SuyifAdlBMrKy1JS17g1ZSHw5HmWVhFfjKgJhah3O0YYm3Ma
         KiY/roEtOBKjBSx5671Zi8L9mpbWdpt2bhh2m6S/SQy9hPvo2IP5M8TW0tZz8B1anUjh
         7RiQ==
X-Gm-Message-State: AOAM5308AB8oq5YjUyeNoxeLPXoO9A2X09Ixg12MfBP1dBIBWtmoDma6
        O0J1LQ4r7W0kqOWVNI/DjpZ5/p29r0Q=
X-Google-Smtp-Source: ABdhPJyvGiWd4bwI/PaGcTYyXmoHmckciOREflEG57snRKfk4P7hOutMuCjNHsC1aq2FArLDVrdbpQ==
X-Received: by 2002:a17:906:5952:: with SMTP id g18mr2146382ejr.506.1610103599421;
        Fri, 08 Jan 2021 02:59:59 -0800 (PST)
Received: from [89.138.250.57] (89-138-250-57.bb.netvision.net.il. [89.138.250.57])
        by smtp.gmail.com with ESMTPSA id qu21sm3389215ejb.95.2021.01.08.02.59.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 08 Jan 2021 02:59:58 -0800 (PST)
Message-ID: <5FF83B02.5000000@gmail.com>
Date:   Fri, 08 Jan 2021 12:59:14 +0200
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: xillybus: Add driver for XillyUSB (Xillybus variant
 for USB)
References: <20201213170503.59017-1-eli.billauer@gmail.com> <X/Rt+bUJ9Hs2F8nF@kroah.com> <5FF5C31C.6050804@gmail.com> <X/XH5Q6APKKt4kRR@kroah.com> <5FF6EDED.40408@gmail.com> <X/bzBobubF1C5x3Q@kroah.com>
In-Reply-To: <X/bzBobubF1C5x3Q@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Greg.

On 07/01/21 13:39, Greg KH wrote:
> My point is, do NOT have different file names.  Userspace should not
> care about the backing transport layer of a device.
>    
Regarding sound cards and such -- we agree perfectly. For a driver like 
XillyUSB, it's not necessarily clear what is correct formally. Either 
way, for XillyUSB the choice on this matter was practical.

First thing, this is what users expect. Xillybus is an FPGA project, and 
its users are hardware oriented. They've spent time designing the FPGA 
logic, and the connection with the host has been part of the effort. As 
the connection via PCIe or USB is part of the design, they definitely 
see these as different things, and don't expect them to appear to be the 
same.

Also, the application software is virtually always written specially for 
the project. Even if a specific hardware application is designed with 
both connection options possible (USB or PCIe), it will be very much 
desired to distinguish between them. For example, because odds are that 
the PCIe option will allow a much higher bandwidth capacity.

Another thing is that it's quite possible that some users will connect 
an FPGA board to a host through USB and PCIe simultaneously. For 
example, when developing an FPGA to work with the USB variant, but at 
the same time using the PCIe variant for passing debug data. In this 
case, using the same namespace for both variants will cause confusion.

So yes, calling the new XillyUSB device files xillyusb_* instead of 
xillybus_* may appear awkward. But I'm quite sure that no single user 
will ever thank me or anyone else for merging them. Maybe the formality 
is still important enough to do this anyhow...?

Thanks and regards,
    Eli
