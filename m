Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC127D742
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgI2Ttk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:49:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47040 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgI2Ttj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:49:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id 95so5627197ota.13;
        Tue, 29 Sep 2020 12:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PzCaUNqysgEnTwvGeABBPTRtJRNx1R8CoMvMr2bX+p0=;
        b=GijYO/JV/CRXFk7YcazOoIgLU48G4GmoV2TiUkxv5L7tdD5t4RIxovYGIfsFgsqhGe
         2kJ7tlILSXH2/lTwARreFZyBt4tkLaAzBzFy0ZAxnF684UXvWf2DoznsEpef41k664/9
         Rztm2DiBcmIrU5S+vqCSeTAb/Lr/N6nv2NaaW6dbbEUAQnbSA/S4pcvNXAQDESkLm+v2
         1b9yJbsRd3Fabu5j9OUyIueDqWraQOBL8AutaYZzlb5e/JnuRz3DZ5aNQXcntUsRoZs8
         M0xB3PiaaeIbXfyg4DasNHq65RJePYRgX8kX1q1grmntGVIx7I8/9erNkfhqSQZVYcuc
         UhYA==
X-Gm-Message-State: AOAM532TXi1SqcqwUx0XDvFBvg3UPFAgLZXgFJ3nvHOdtYa2M6yiKGa9
        R8UU6neUhgYqTIlD7v3ur9oc/AhWJZPU
X-Google-Smtp-Source: ABdhPJzbdNohssdId6Ay0RYezHnS3+x1bQ9iiytAaIkGHGjFfXlebmZ3QmzGhtq6BReC7gAAGlorYA==
X-Received: by 2002:a05:6830:1e30:: with SMTP id t16mr3994469otr.18.1601408978854;
        Tue, 29 Sep 2020 12:49:38 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n13sm1248201oic.14.2020.09.29.12.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:49:38 -0700 (PDT)
Received: (nullmailer pid 1048006 invoked by uid 1000);
        Tue, 29 Sep 2020 19:49:37 -0000
Date:   Tue, 29 Sep 2020 14:49:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Reinhard Pfau <pfau@gdsys.de>,
        Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH] hwmon: add support for SMSC EMC2305/03/02/01 fan
 controller
Message-ID: <20200929194937.GA1046240@bogus>
References: <20200928104326.40386-1-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928104326.40386-1-biwen.li@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 06:43:26PM +0800, Biwen Li wrote:
> From: Reinhard Pfau <pfau@gdsys.de>
> 
> Add support for SMSC EMC2305, EMC2303, EMC2302, EMC2301 fan controller
> chips.
> The driver primary supports the EMC2305 chip which provides RPM-based
> PWM control and monitoring for up to 5 fans.
> 
> According to the SMSC data sheets the EMC2303, EMC2302 and EMC2301 chips
> have basically the same functionality and register layout, but support
> less fans and (in case of EMC2302 and EMC2301) less possible I2C addresses.
> The driver supports them, too.
> 
> The driver supports configuration via devicetree. This can also be used
> to restrict the fans exposed via sysfs (see doc for details).
> 
> Signed-off-by: Reinhard Pfau <pfau@gdsys.de>
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
>  .../devicetree/bindings/hwmon/emc2305.txt     |  33 +

Split to a separate patch and should be in DT schema format. 
checkpatch.pl will tell you both of these things.

>  Documentation/hwmon/emc2305.rst               |  34 +
>  MAINTAINERS                                   |   8 +
>  drivers/hwmon/Kconfig                         |  10 +
>  drivers/hwmon/Makefile                        |   1 +
>  drivers/hwmon/emc2305.c                       | 689 ++++++++++++++++++
>  6 files changed, 775 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/emc2305.txt
>  create mode 100644 Documentation/hwmon/emc2305.rst
>  create mode 100644 drivers/hwmon/emc2305.c
