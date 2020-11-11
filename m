Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD402AF60A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgKKQR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgKKQR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:17:58 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8669C0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:17:57 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id o11so2809838ioo.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hIBjUOhCL4FamySv2BSK1WhnluetPINBm9sx/SODghk=;
        b=E+UT7uDKzv8M0Zf2lZ8UIYK1hcqMDMAvoGTdUr0tHYghvlxNxqiQgOW/5iqLyKbRZS
         zVvYZGeU4MSOIwiwwYIlWhf/37CVkuzMdXfkbJgAuUAynl3foV2aD2CgntKM01Eag1w6
         pQ8HBth/OBv12+fhMJKQGc1NkC3aSg3Ood/4QEvHAIURwz7xRQ3LiqHo+gH4kHkz/Tzz
         kGrYC8QFOWBAL14ps4gGvDC3EJQ6RukmqNG7qjjJB2x3L16pNJsAI7fQJAXbZiNkIOyF
         gOqtjfkreX6lm/ivN+Yhkt5U9rTka4eIy5SeWvarGIF0s96mi2fbJkGPVSL4J27D/Boc
         p0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hIBjUOhCL4FamySv2BSK1WhnluetPINBm9sx/SODghk=;
        b=et8UP+y7FSb0cC/d/+m9FqjdtFIWJKrLZm2U50F9XUv036P4ESYxYxZkGU6C8LJaHr
         uh8neoM97fZQ8r589iEmsVeDL/bCVqnBJl7YiA5JcCBIsY2hepqqfOrXh1m5leZewhfj
         6iADq7LXVD9vTbO7Px0+ik6MkiJdprMm3+JnN/znmsw+NWu50zDxPODyA6QQmLfBwLSx
         q0++o+pGsfuAWD1j6TTgNHVqYILBKNwSgavqcpWTlJQ3vt5akghs8zs1o/cqG7ab8gGC
         G8c7+Gwjf1QUjq26R+x0BWuvvqgb16ISRgSFT31QDDwPA++2vn7NfdC8W42Zl0lewsTt
         +iJg==
X-Gm-Message-State: AOAM5335lvg7GoyX0bsr1oczdnnvxB4WE4miDcAZR/TwgCnntABaVumP
        mFJhXj+yOx4WBHu9OuN2PjGbeQ==
X-Google-Smtp-Source: ABdhPJyWFXPFFosbpi7Mw4IBURM5g2Va17wNDYQIiOuR5s1zvzKiVX4DBgORaOVic1unFcvUrR9Xmg==
X-Received: by 2002:a6b:7114:: with SMTP id q20mr18531488iog.16.1605111477264;
        Wed, 11 Nov 2020 08:17:57 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v63sm1404927ioe.52.2020.11.11.08.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 08:17:56 -0800 (PST)
Subject: Re: simplify gendisk lookup and remove struct block_device aliases v4
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
References: <20201029145841.144173-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <92e869be-9717-8d97-a962-a630a2517f00@kernel.dk>
Date:   Wed, 11 Nov 2020 09:17:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029145841.144173-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/20 8:58 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series removes the annoying struct block_device aliases, which can
> happen for a bunch of old floppy drivers (and z2ram).  In that case
> multiple struct block device instances for different dev_t's can point
> to the same gendisk, without being partitions.  The cause for that
> is the probe/get callback registered through blk_register_regions.
> 
> This series removes blk_register_region entirely, splitting it it into
> a simple xarray lookup of registered gendisks, and a probe callback
> stored in the major_names array that can be used for modprobe overrides
> or creating devices on demands when no gendisk is found.  The old
> remapping is gone entirely, and instead the 4 remaining drivers just
> register a gendisk for each operating mode.  In case of the two drivers
> that have lots of aliases that is done on-demand using the new probe
> callback, while for the other two I simply register all at probe time
> to keep things simple.
> 
> Note that the m68k drivers are compile tested only.

Applied, thanks.

-- 
Jens Axboe

