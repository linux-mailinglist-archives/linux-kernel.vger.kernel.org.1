Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C425E2F4640
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbhAMIPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:15:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbhAMIPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610525646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1vAmJrhkq2OfagK3P6iEhed/uMIynZjuQhF3qxhH8o=;
        b=Yo+IX3PAvj134ldCL90Fgk0mR0gEqF6wzHuXbjX161G0ZHWFipEIhPZhpTSFGOiYa/0cWb
        dpSDoV7WUfiq2mrvimOuuWfLF8lFW+G3eALDdCEzPk/bdW56R/vQdamesFxtW2rTy43fi0
        Js/6SB54xR2C9wfnxzn8H+vyMrsHBnQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-Pn6P3IMjMfCtvmeJC_NhZA-1; Wed, 13 Jan 2021 03:14:04 -0500
X-MC-Unique: Pn6P3IMjMfCtvmeJC_NhZA-1
Received: by mail-ed1-f70.google.com with SMTP id m16so498221edd.21
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/1vAmJrhkq2OfagK3P6iEhed/uMIynZjuQhF3qxhH8o=;
        b=iVPMyHmX3Q8rykrjGVh01uL+yggfgSq2KTw9W0UOk3q2Yi0bfTlKU93HGY3SJgPwYE
         O2TpjN9KljDGUD5PHCynPEK1SGglrpiLisOfJ6PZauKDC/HpA9Tv1c0uvNGl5UZelR6F
         JDs9M7P4AdIfVIyfCL0tH65NZEJ5sd2EO+yTwumCRoFuMWob2/SyKYWMHaF26150Mb/G
         6/k/+6u+yFiX7Xq9boTBlN3X6tGNXdqEzLD6qEFtumQ62zldO8Rm6qHGOdwXkDDtES3+
         fFjwovoWlJ0bC17j9GCiwO6+7iIDg9mRdNTEWkisbkUCZ9QAw6Zid/QTyZDDwKU5o7W9
         r1DQ==
X-Gm-Message-State: AOAM531MLxH3xwDxEnxiL6kQiIeuWIuEUi44qgAlaVviIOI6BtjHDdsg
        0zvDbzjWkw2P/iNmZkRhZWFQQmuJeu2aOk6pFbLHMGnd9+y/zd5v/aE4+hHrMSmdeHqpDa2gUGb
        3v1McB9aqj9J7wrRkg0xI4WVW
X-Received: by 2002:a17:906:59a:: with SMTP id 26mr685053ejn.309.1610525643081;
        Wed, 13 Jan 2021 00:14:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzpBbPK2it/e3/DMPj561v1NJDrZUmv4OrQR0EDu4qwYEu5NzUyBMJt5+9U1Ocwv7e2f0fGdA==
X-Received: by 2002:a17:906:59a:: with SMTP id 26mr685045ejn.309.1610525642945;
        Wed, 13 Jan 2021 00:14:02 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id x17sm482923edq.77.2021.01.13.00.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 00:14:02 -0800 (PST)
Subject: Re: [PATCH v2 0/3] PinePhone volume key (LRADC) wakeup support
To:     Samuel Holland <samuel@sholland.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20210113040542.34247-1-samuel@sholland.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <45344b30-b784-c3d3-e8dc-d2a562c5cb83@redhat.com>
Date:   Wed, 13 Jan 2021 09:14:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210113040542.34247-1-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/13/21 5:05 AM, Samuel Holland wrote:
> This series allows the volume keys on the PinePhone to wake up the
> device. As pointed out for v1, wakeup should only be enabled when a
> "wakeup-source" property is present, so v2 requires DT and binding
> changes in addition to the driver change.
> 
> Changes since v1:
>   - Add requisite DT binding change
>   - Only add wakeup capability if "wakeup-source" is present
>   - Warn but do not error out if setting the wake IRQ fails
>   - Add "wakeup-source" property to PinePhone device tree
> 
> Ondrej Jirman (1):
>   input: sun4i-lradc-keys -  Add wakup support
> 
> Samuel Holland (2):
>   dt-bindings: sun4i-a10-lradc-keys: Accept wakeup-source property
>   arm64: dts: allwinner: pinephone: Support volume key wakeup

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

