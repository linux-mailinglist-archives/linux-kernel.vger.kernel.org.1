Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA312D14B3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgLGP2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:28:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgLGP2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607354809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBuR/RJNJ26452jAgu/4WlN7ISqdiXPS/efDMfyU81w=;
        b=XNoqgOkbvmt255T/AcDUxTB66voUKMjdC/f32v722LTPOfjr/rzlA1Q49vhdB1o7bMfbSg
        mKMkqQfzpd/hz83J9q8/Z9qe9dP6v21/W6piGbVUMTiVXw7xIzrxhePkPoZ69nHI6H5kU4
        2O7gBA8Z4rU5uNxkMYsNhTcnFIlZgDU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-eVJdNnImNVOhCOc5VK_3wg-1; Mon, 07 Dec 2020 10:26:48 -0500
X-MC-Unique: eVJdNnImNVOhCOc5VK_3wg-1
Received: by mail-qv1-f70.google.com with SMTP id b15so11769082qvm.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 07:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OBuR/RJNJ26452jAgu/4WlN7ISqdiXPS/efDMfyU81w=;
        b=pQYMVOZRbapF/lxjI4KVCRSe7xUvMAqjqgkGudX67t2eifJ8OsOMTRmyp26h+lJcjO
         P4eQCMu/+wAUfBZ2bMR3+OkSXJ7ed9Fw+4ML+8kQWZJKlEDaghDM1MUGtD7qBlr3ClYf
         CgPTjj0yWXcsmoWOyv/DaO6FZfa6ZDthgGXLbRsfjV6ucmtBe85OgVnDfH56TYl5c9dT
         JMe4KMFgVzjJ4Ev3biaTyYkaegRjKWqqetLz5GhKiInqmyU9m1jp7I0SBnqmQMYGzPrU
         87Od3JGM3viVJR8ZT8MQRztJWJ4RjPDAKjgDQgnGMsyIfVO36SJCSTjf/4d7vo2usk8n
         fQCw==
X-Gm-Message-State: AOAM532+96YwwexzjtV1gZIyCBign9jlu0nEEOfFT2PhFKGUaUKhpopF
        KQfDo5p3yIRUasWQqSBqk+e46bomBNxlaz8Pgf10Y52Yi5kuYmtspo7xXLVC0x2XU4IuFECU8Mx
        7Lz0Tnan9xFBQyBadVBtcYa8S
X-Received: by 2002:ac8:5750:: with SMTP id 16mr24381044qtx.305.1607354807682;
        Mon, 07 Dec 2020 07:26:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDTcSH/J7HhHxdQMICJ9UKAoj2ZQE6f4ymRRE0nXekdQZ8aBG+uJSFf5nwNToLc8w+Jq/xhg==
X-Received: by 2002:ac8:5750:: with SMTP id 16mr24381033qtx.305.1607354807494;
        Mon, 07 Dec 2020 07:26:47 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m190sm6587894qkd.54.2020.12.07.07.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 07:26:46 -0800 (PST)
Subject: Re: [RESEND PATCH v13 0/6] add DFL bus support to
 MODULE_DEVICE_TABLE()
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, krzk@kernel.org,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, hao.wu@intel.com
References: <1606977360-4421-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4738579b-dfab-a7bd-ec97-cbc682445538@redhat.com>
Date:   Mon, 7 Dec 2020 07:26:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1606977360-4421-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Main changes from v12:
> - For patch #5, fix the wrong use of logical'||', should use '|'

This set has not changed in a while, looks like it is just patch 5/6 that needs ack-ed.

Tom

> Xu Yilun (6):
>   fpga: dfl: fix the definitions of type & feature_id for dfl devices
>   fpga: dfl: move dfl_device_id to mod_devicetable.h
>   fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
>   fpga: dfl: move dfl bus related APIs to include/linux/dfl.h
>   fpga: dfl: add support for N3000 Nios private feature
>   memory: dfl-emif: add the DFL EMIF private feature driver
>
>  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +
>  .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  47 ++
>  MAINTAINERS                                        |   3 +-
>  drivers/fpga/Kconfig                               |  11 +
>  drivers/fpga/Makefile                              |   2 +
>  drivers/fpga/dfl-n3000-nios.c                      | 588 +++++++++++++++++++++
>  drivers/fpga/dfl.c                                 |   4 +-
>  drivers/fpga/dfl.h                                 |  85 +--
>  drivers/memory/Kconfig                             |   9 +
>  drivers/memory/Makefile                            |   2 +
>  drivers/memory/dfl-emif.c                          | 207 ++++++++
>  include/linux/dfl.h                                |  86 +++
>  include/linux/mod_devicetable.h                    |  24 +
>  scripts/mod/devicetable-offsets.c                  |   4 +
>  scripts/mod/file2alias.c                           |  13 +
>  15 files changed, 1023 insertions(+), 87 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
>  create mode 100644 drivers/fpga/dfl-n3000-nios.c
>  create mode 100644 drivers/memory/dfl-emif.c
>  create mode 100644 include/linux/dfl.h
>

