Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE6127B1DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgI1Q2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgI1Q2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:28:42 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2348C061755;
        Mon, 28 Sep 2020 09:28:41 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 185so1947234oie.11;
        Mon, 28 Sep 2020 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6DkxvUBNgBtFpav9mYjrKFIEaWiPqfm8HmcCJgLtJXc=;
        b=Ud3QJS0LcwsuzzN7Wj8mFvl+jXGUi2TB9DDZgdvJClXa97RQgojJaYWjhnKZANTWu4
         ddBRE5jnoHC526IIBjP80lVQZC9pzl46t8EWe0QvMNgcy1n9xm2h0Eg6dfQDWgmME17O
         lFboR1D7L59uHT9Jtpv9yTFEqmXfeaUVqJyKu8cCOQFSLEWFU9unULFH66R4bweztblP
         Gh5bx3NGnOUFLuBMU4zUUz0Vi4HV+RTXeEizk8BQEP7EJuic79Xdzyj5wfsFz9GxEs9H
         zZa0HDKw3Xef9zPbTsxrUFeSiNMiAoqk63cqtFSNe/OcT1DSw/EM7kOXNzCTD1s3M/cj
         KApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6DkxvUBNgBtFpav9mYjrKFIEaWiPqfm8HmcCJgLtJXc=;
        b=IXf8m8sWB95f41Iv3Q6F5U/JOW7+YueCCuYZJ+q50/Ad9bgUSYVvvo+26+XfDgUWX7
         0YfJHLg72NVkmLD+yd3i0IjpraHtbjq69sHbt8IEvYpt4N5jfmj3kZOkQyFq3sZ1RD/G
         VkCjDyB+tyCARPlk/YpjnOiIsJ/dlsRgw3J8QsfOl+Sz6g0rqLKKoHWGNkBJ+sozp9uv
         Z4tcttMryB42jKKrbbbiOcO0w9Ui0dikiZ+Otj4/Q6seRR7EPivbUq0iZjA5yWpFbP2u
         dKWRSQU99K4tslNrJbCXNWae7uXTLV2duKk52fJq4x8npKumtMCE+Osi9RrNGavPkeiH
         x+dg==
X-Gm-Message-State: AOAM533WrLboj9AMFc3957IKGkLEXinkm+lD+TTW9J8yUAI02KV6cyA+
        +hI6rZfNXLmrBg0ycrJFbYU=
X-Google-Smtp-Source: ABdhPJzWLEM4irtaNpR9OSDAn5CowIdeZ46FMAKT4VfxCVRtD0ZCTqiOQvbLK4Qjv0NcuLJmttmfpQ==
X-Received: by 2002:a05:6808:54:: with SMTP id v20mr1333075oic.50.1601310521310;
        Mon, 28 Sep 2020 09:28:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u68sm352911otb.9.2020.09.28.09.28.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Sep 2020 09:28:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 28 Sep 2020 09:28:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Reinhard Pfau <pfau@gdsys.de>,
        Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH] hwmon: add support for SMSC EMC2305/03/02/01 fan
 controller
Message-ID: <20200928162839.GB106276@roeck-us.net>
References: <20200928104326.40386-1-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928104326.40386-1-biwen.li@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
...

> +
> +	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
> +							   client->name, data,
> +							   data->groups);

New drivers must use "[devm_]hwmon_device_register_with_info" to register
with the hwmon subsystem.

Guenter
