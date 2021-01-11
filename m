Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FC82F24A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404871AbhALAZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:04 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:37221 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404133AbhAKXdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:33:04 -0500
Received: by mail-ot1-f51.google.com with SMTP id o11so583493ote.4;
        Mon, 11 Jan 2021 15:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FO+1RWOepEgnEnQDhYtS1zJXbSeLIjgq43icfIf2ou8=;
        b=SIf33LJ/Cj9yqcd8rIZQyoZsCzdZMVDiSYIb+WlRCnpRODvZfXTVwjC4c2pgCze2nf
         Wpebg9dsUUhAJPF34E/gjzSkJMUp9dOZkXGi+GKsjI0iuXOA1xjdfEnAG3ZMLRE49ub+
         c5RYzmmcifmQjBbfzSJGPJPf43dGW2yZGMGRhGnaVD/s7XXXj49lmKuEeY0OMliWglWJ
         295Guv7HWoaIIh/MbVt0eXFHGoIdoDyn6MRdWYfD3Frq0UfFM0yYbNGjduPXHsdiCLlH
         QlBpyFceu6g4vRals3/fkb1YjEnY57OGUUdbtYxO2lY95/o6/bYyO7Alt+tdOtQjFsId
         wqbQ==
X-Gm-Message-State: AOAM533/5is+EVBsUhIeQr1nbBvk0drF4IKY9bAHmGwtiqN6dhJ1pL0p
        uLWR2gm8w1T+d/WvWrWYAhLRlIhEFA==
X-Google-Smtp-Source: ABdhPJw7nfxAAHoj8MVA3IL1gcQbO0RTxwbr6D9qumK+Zpkh49OrEff3WNhW+1FwlTgN2vu155/4Jw==
X-Received: by 2002:a05:6830:204b:: with SMTP id f11mr958232otp.372.1610407942996;
        Mon, 11 Jan 2021 15:32:22 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 39sm276397otu.6.2021.01.11.15.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 15:32:22 -0800 (PST)
Received: (nullmailer pid 3259406 invoked by uid 1000);
        Mon, 11 Jan 2021 23:32:20 -0000
Date:   Mon, 11 Jan 2021 17:32:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Documentation: devicetree: Add new compatible
 string for eeprom microchip 93LC46B
Message-ID: <20210111233220.GA3259372@robh.at.kernel.org>
References: <20210105105817.17644-1-a-govindraju@ti.com>
 <20210105105817.17644-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105105817.17644-2-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jan 2021 16:28:11 +0530, Aswath Govindraju wrote:
> Add a new compatible string for eeprom microchip 93LC46B in eeprom-93xx46
> dt-binding file as it belongs to the 93xx46 family of devices.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  Documentation/devicetree/bindings/misc/eeprom-93xx46.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
