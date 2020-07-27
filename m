Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFFF22F24A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 16:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgG0OKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbgG0OKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:10:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795FCC061794;
        Mon, 27 Jul 2020 07:10:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z3so9103552pfn.12;
        Mon, 27 Jul 2020 07:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iqYroehPFcEKA0DuHr0GAM24cX3Wuh7Qs4Cf/Ni43Nw=;
        b=gm7wXr6WaK2LUdiC2YSw3blB63KWwYd66vUkkEfH1aEZqtnS7UgC24R6RW7Sc9eW5h
         BPYrHVjoULj70bQ7hFagqAZnoLHJMhjoW6y0yydWSjsAcwMkRG+U2fTQEGd4Wfw6tZGU
         ZMg2fp2lbk8VU1VpKhB3ye6PDdzD3PmSU1K0ACAWI7slzwatvaUIK7i76gJVtn0hIAih
         AqQJ4QcDa7zqMdJMdM8e03FwB6BJ3/cWZSoR58Xq0rQI8rcdy/VdSpklS9TLgZ7RHLLR
         9T2BTywn4xIS47yfCZAkIRA0JEHzQ3Z+t0FY2GS1tD9xf07IfuCYS9qjLtGtyQtaJ++H
         4E1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iqYroehPFcEKA0DuHr0GAM24cX3Wuh7Qs4Cf/Ni43Nw=;
        b=F5uOzYSH9ABj9CKDa9MeTIXBr0HSV6BvQgfkOmZnudQpMaf9XDOR9N9o+KhU78t1AC
         LJRimfIdTOG8K99EohgZJKfU+16bQh5D7pKTFaKaN73eyizI/2+YK+eu7Uw0u1ZVgTzn
         hb52jbeOzIN0PetKo/2YlJa879vqu2mdN1r7md517Ih5QOE+TvRl9c/Gz9d6yYKB060l
         NjMPJ3PAaqXJ8x8/1peCjP3B9lP6byCKIQv7DyVHCePUMrFKr/VL11vR3ZSfcv2QHPsC
         f+sWsYI4bTKmNzFOErvLiLEZsUUxqMQLPCq+4V+JYPR+Wd//8cNMezujZwaTVymklyJj
         XFYw==
X-Gm-Message-State: AOAM530cdSYm/l5wXtZpsB2q7DBaVHcmKlzVgprqA2ut6DeL9zhK3Luf
        k8rcWBuHtyiBGhYVYEktR/BJCfnR
X-Google-Smtp-Source: ABdhPJwMFfsygmwIYfA01x480CVo3T15VuCDYFIk5AXxLQpO6CEac3O8azB0YZfru+Q11QggUrcuUg==
X-Received: by 2002:a62:8603:: with SMTP id x3mr20534588pfd.268.1595859011932;
        Mon, 27 Jul 2020 07:10:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2sm3407979pjg.35.2020.07.27.07.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 07:10:11 -0700 (PDT)
Subject: Re: [PATCH v6 0/9] hwmon: pmbus: adm1266: add support
To:     alexandru.tachici@analog.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org
References: <20200727053121.23288-1-alexandru.tachici@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <8de28448-12a3-6d2e-14ab-299c57ff4391@roeck-us.net>
Date:   Mon, 27 Jul 2020 07:10:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727053121.23288-1-alexandru.tachici@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/20 10:31 PM, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add PMBus probing driver for the adm1266 Cascadable
> Super Sequencer with Margin Control and Fault Recording.
> Driver is using the pmbus_core, creating sysfs files
> under hwmon for inputs: vh1->vh4 and vp1->vp13.
> 

What happened to change logs ? Do you really expect me
to go through the history of this series to figure out
what changed from and in previous revisions of this
patch set ?

Guenter

> 1. Add PMBus probing driver for inputs vh1->vh4
> and vp1->vp13.
> 
> 2. Add Block Write-Read Process Call command.
> A PMBus specific implementation was required because
> block write with I2C_SMBUS_PROC_CALL flag allows a
> maximum of 32 bytes to be received.
> 
> 3. This makes adm1266 driver expose GPIOs
> to user-space. Currently are read only. Future
> developments on the firmware will allow
> them to be writable.
> 
> 4. Allow the current sate of the seqeuncer to be read
> through debugfs.
> 
> 5. Blackboxes are 64 bytes of chip state related data
> that is generated on faults. Use the nvmem kernel api
> to expose the blackbox chip functionality to userspace.
> 
> 6. Add group command support. This will allow the driver
> to stop/program all cascaded adm1266 devices at once.
> 
> 7. Writing the firmware hex file with offset 0
> to the nvmem of the master adm1266 will trigger
> the firmware programming of all cascaded devices.
> The master adm1266 of each device is specified in
> the devicetree.
> 
> 8. Writing the configuration hex file to 0x30000
> byte address of the nvmem file will trigger the
> programing of that device in particular.
> 
> 9. dt bindings for ADM1266.
> 
> Alexandru Tachici (9):
>   hwmon: pmbus: adm1266: add support
>   hwmon: pmbus: adm1266: Add Block process call
>   hwmon: pmbus: adm1266: Add support for GPIOs
>   hwmon: pmbus: adm1266: add debugfs for states
>   hwmon: pmbus: adm1266: read blackbox
>   hwmon: pmbus: adm1266: Add group command support
>   hwmon: pmbus: adm1266: program firmware
>   hwmon: pmbus: adm1266: program configuration
>   dt-bindings: hwmon: Add bindings for ADM1266
> 
>  .../bindings/hwmon/adi,adm1266.yaml           |   56 +
>  Documentation/hwmon/adm1266.rst               |   37 +
>  Documentation/hwmon/index.rst                 |    1 +
>  drivers/hwmon/pmbus/Kconfig                   |   10 +
>  drivers/hwmon/pmbus/Makefile                  |    1 +
>  drivers/hwmon/pmbus/adm1266.c                 | 1273 +++++++++++++++++
>  6 files changed, 1378 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
>  create mode 100644 Documentation/hwmon/adm1266.rst
>  create mode 100644 drivers/hwmon/pmbus/adm1266.c
> 

