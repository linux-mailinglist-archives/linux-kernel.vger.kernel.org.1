Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3478A2ED388
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 16:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbhAGP24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 10:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbhAGP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:28:54 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851DAC0612F4;
        Thu,  7 Jan 2021 07:28:14 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id x23so1654950oop.1;
        Thu, 07 Jan 2021 07:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4LDT2sH0B+UBh7Y3dMo9WT33hdKEn5IEUpEgVUr2to0=;
        b=eSDoQXF9dd+bZAgLgivUW84lcUKnPknMnMPzXqpVwlt9FICQUTnRIwAZjMhjmNOh4Y
         7t77rMfcBLVOKCUOkQaRjBG6hLh8/CW6YZVYB44TTTX68wEnMprjlJEStRc/OAqUlHk2
         NLU7bO3TQe8Dm9kCASettdgomFNaQZt82vBnbTAxfLdqSutePRGqqAtIz4ckJGCZjZRf
         PG8gIXzYMZxds/HFibVFDXdQ+v6U213XHfLsibUqEbVqYXTGNa3iCQ+cM3Ck4Xy17Rji
         tYEpzE8POOovZPbfOyuk/xGw/47XSynbeXI73+lJudtgDkdxnFyg5HEMyDwZ5K4NZ3pn
         cE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4LDT2sH0B+UBh7Y3dMo9WT33hdKEn5IEUpEgVUr2to0=;
        b=liiGPwLKYPBq6EfjfOuodwPY1w2jmi0KVjf1d7NsCwuAZiaf9zpZBYW0nqxEUItGie
         b3/igq3nxUabtmDqmIIo2/Mbfx7pcbZTznjJEkEyG+msIene2LBhY5DBq7qD+YboDmEK
         2M7XhCCjqUBkllYdkUMMi1G6pjqBQL4GKsTk0wxIH3iyeh5G6eGelNHmrXUPUFjfW6EP
         pbybwfuKoVNswf/LL9ncF72lGq0l10r7socMRF4248mPKyvM47cpK1Wfik8abrWuOIya
         y+2KPgZGLZz2tpIpxRQicbJyK/IojT4B0HjTEhynb6wNiwl6K2Tteu6xyneLSLvK+Zi0
         /s0w==
X-Gm-Message-State: AOAM533DTDDAkXcKtG0dvcmDYQBIc5dnQONxsIy3jhjqmkH7SjWRYPsa
        t5GwSLKu2DHPvuZwcVR5dBs=
X-Google-Smtp-Source: ABdhPJwres0yuv4uyI3mSNbdX4KGFH6KlYRlbnWVsEYZNmZ0Ha/wyjmIIV0sMRTk9WLbwbmdbZbhZQ==
X-Received: by 2002:a4a:ded4:: with SMTP id w20mr1440491oou.49.1610033293863;
        Thu, 07 Jan 2021 07:28:13 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y65sm1327187oie.39.2021.01.07.07.28.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jan 2021 07:28:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 7 Jan 2021 07:28:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        jdelvare@suse.com, mark.thoren@analog.com, ardeleanalex@gmail.com
Subject: Re: [PATCH v3 0/4] hwmon: (ltc2945): add support for sense resistor
Message-ID: <20210107152811.GD13040@roeck-us.net>
References: <20210107103417.16010-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107103417.16010-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 12:34:13PM +0200, Alexandru Ardelean wrote:
> Changeset adds support for sense resistor.
> 
> Changelog v2 -> v3:
> * https://lore.kernel.org/linux-hwmon/20201111091259.46773-1-alexandru.ardelean@analog.com/
> * dropped patch 'docs: hwmon: (ltc2945): change type of val to ULL in ltc2945_val_to_reg()'
> * add patch 'hwmon: (ltc2945): clamp values before converting'
> * for patch 'hwmon: (ltc2945): add support for sense resistor'
>   - sense-resistor is represented in milli-ohms internally; this
>     risks of any other potential overflows with the multiplication to
>     1000; the scaling in the driver becomes simpler, but we can't allow
>     a lower resistor value that 1 mOhm, and all resistor values
>     need to be integer in mOhm.
>   - added max power and max amps limits, adjusted to sense resistor
> * for patch 'dt-bindings: hwmon: ltc2945: add device tree doc for ltc2945 '
>   added 'Reviewed-by: Rob Herring <robh@kernel.org>'
> 
> Alexandru Ardelean (4):
>   hwmon: (ltc2945): wrap regmap into an ltc2945_state struct
>   hwmon: (ltc2945): clamp values before converting
>   hwmon: (ltc2945): add support for sense resistor
>   dt-bindings: hwmon: ltc2945: add device tree doc for ltc2945
> 

As mentioned in patch 3/3, this series solves a generic problem
affecting all hwmon drivers, but it only solves it for one of those
drivers. We should work on a generic solution (in-kernel scaling)
instead, one that works for all hwmon drivers, not just one.

Thanks,
Guenter

>  .../bindings/hwmon/adi,ltc2945.yaml           |  49 +++++++
>  drivers/hwmon/ltc2945.c                       | 128 +++++++++++++++---
>  2 files changed, 156 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
> 
> -- 
> 2.17.1
> 
