Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB842E8D10
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 17:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbhACQRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 11:17:18 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:36612 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbhACQRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 11:17:17 -0500
Received: by mail-io1-f44.google.com with SMTP id u26so20150783iof.3;
        Sun, 03 Jan 2021 08:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MLD+EZewrLbaWCLExHGTczXjOb1vPGkfTuYMAwGL1ik=;
        b=ZOahjPbmJ0byghcRAsrXNFU7adn5H/Hf0dgOhGOBKlwPVCUUj8Pa7pkyX4hu1hs3Yh
         Ckso3uXxHKUJ6nV43CVnI2ZspTX9Tjg6yok6dle1+7t9/98jiasA05Tb0uGg58+JLjn0
         +17wba2grRjlgUfkcm8B1Tag6qva2bUPrrT2jMQfHtzq0hLirt1UZOiHNqZdMuUiN+Fx
         bPY7KZlvOck9USWyXkV6gEGM840MOff1p5a3DYynYtcvs9d3H0IHQCGYCjg8kUBtnUaL
         lreXYKSsw/9T3ajNQhKEna5u3gLy9ahRRKCZb/cDA8cZXOq4rK8TRqmYg7xAVOqTYDx2
         MK9w==
X-Gm-Message-State: AOAM531jRO0wXLe4OdcnTEUhHNM8/T4+hciep2SesqQvefhPP1hgSn/D
        3I633NJhfKZvUewcdd7iUg==
X-Google-Smtp-Source: ABdhPJyc0JoUpUvR/zYc0zoCYmpZ4Vkk8wTWqUmP5uUOt5Kab8Ra0bY81Vs354t6bo5sZe5p64pKJg==
X-Received: by 2002:a02:ce2c:: with SMTP id v12mr58941999jar.60.1609690596661;
        Sun, 03 Jan 2021 08:16:36 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id e1sm41109004iod.17.2021.01.03.08.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 08:16:35 -0800 (PST)
Received: (nullmailer pid 3960611 invoked by uid 1000);
        Sun, 03 Jan 2021 16:16:32 -0000
Date:   Sun, 3 Jan 2021 09:16:32 -0700
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, catalin.marinas@arm.com,
        srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>, linux@armlinux.org.uk,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, will@kernel.org
Subject: Re: [PATCH v2 2/5] nvmem: Add driver to expose reserved memory as
 nvmem
Message-ID: <20210103161632.GA3960550@robh.at.kernel.org>
References: <20201218154320.28368-1-nsaenzjulienne@suse.de>
 <20201218154320.28368-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218154320.28368-3-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Dec 2020 16:43:17 +0100, Nicolas Saenz Julienne wrote:
> Firmware/co-processors might use reserved memory areas in order to pass
> data stemming from an nvmem device otherwise non accessible to Linux.
> For example an EEPROM memory only physically accessible to firmware, or
> data only accessible early at boot time.
> 
> In order to expose this data to other drivers and user-space, the driver
> models the reserved memory area as an nvmem device.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> 
> Changes since v1:
>  - Remove reserved memory phandle indirection by directly creating a
>    platform device from the reserved memory DT node
>  - Only map memory upon reading it to avoid corruption
>  - Small cosmetic cleanups
> 
>  drivers/nvmem/Kconfig  |  8 ++++
>  drivers/nvmem/Makefile |  2 +
>  drivers/nvmem/rmem.c   | 97 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/of/platform.c  |  1 +
>  4 files changed, 108 insertions(+)
>  create mode 100644 drivers/nvmem/rmem.c
> 

Reviewed-by: Rob Herring <robh@kernel.org>
