Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5AE281590
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388059AbgJBOo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJBOo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:44:28 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9FCC0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 07:44:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n22so1910307edt.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 07:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=H8SXq+IivXLIchSfhBFhCsQdlWRn5LQ5/8Y7HUIonDM=;
        b=1oEjBHmcmrl7G72HPcgOOjmMfPKnY1mzHxUAG+YMZ0vx5yTz/K/Sr1YBmASnczaJn0
         KsRBqbHaizK1jG+UCS2OF+8ZLJLqMqLv+Qen1kVBIpZJbdfq/dUsiU+Mmu7Y3+uzO5P4
         pCSBt9oMxiH71ROSEvG80TXBpOAtBV3llQKzZKcDdkT9CtxBAqmGBZsn6/TfJ70xwX96
         DPyIt4n5O1IvPYzVOCwTwfdhnX4a1u67Bd8FK7z+19KSRNfLUrTQk5VLPtCXDB3MBw1m
         BQTywGcXHi5+/eMlx+RjQc96/GWlDtU8ZMYdTN4PM4mUvk79Xb1Wm+vsHU+qrt7TxYXX
         CkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:date:message-id:mime-version;
        bh=H8SXq+IivXLIchSfhBFhCsQdlWRn5LQ5/8Y7HUIonDM=;
        b=Bii3D7PlpXQ7h1jHBDLOIJKjcjwfKBdVQpc4XjZZcnYxrEqOI1b11I/ec4IwFQ87lN
         JRFY8+uE49/Ls5npLXj2uGpCoIav/clbkI0zLDhPzxbH8OoQNlkHy372pn/p3Cs4zu3V
         0qxrvJ6va5SHoWwS060XuSRowOpqXBEk7LVhRkeMeQEDvR3hehdOTbOfeC3IKrLswChM
         l2hR28u5CbdcEk/5bpdqqnegpwPmK7orStb2hGQXh1b35MjzCBWn7t83B5y9FOogzvYo
         +8KzkmZCObIq9/6nBDp9zx/Dnky7osPs+8V50rKyYNrXv89cim4SmAEeNr30uX2p221O
         hO4g==
X-Gm-Message-State: AOAM5305piaaAHhFsWDpweg4JLxaJ54iZQnu2ocDU6EWwwI3nLGttSwU
        27DFPvaGhoXx2tkow34nHS1mUA==
X-Google-Smtp-Source: ABdhPJyXQIsKPwo9MrANy8jUk3eZWf5PjDyGiQHyY2oynpsndOEwqFNGuAI3YT5mheABVJKbCxFbMg==
X-Received: by 2002:aa7:c98f:: with SMTP id c15mr1761863edt.200.1601649866534;
        Fri, 02 Oct 2020 07:44:26 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id cz11sm508493edb.62.2020.10.02.07.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:44:25 -0700 (PDT)
References: <20201002141619.14387-1-christianshewitt@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: add SM1 soundcard name to VIM3L
In-reply-to: <20201002141619.14387-1-christianshewitt@gmail.com>
Date:   Fri, 02 Oct 2020 16:44:24 +0200
Message-ID: <1jzh54it6f.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 02 Oct 2020 at 16:16, Christian Hewitt <christianshewitt@gmail.com> wrote:

> VIM3L now inherits the sound node from the VIM3 common dtsi but is
> an SM1 device, so label it as such, and stop users blaming future
> support issues on the distro/app "wrongly detecting" their device.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> index 4b517ca72059..f46f0ecc37ec 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> @@ -32,6 +32,10 @@
>  		regulator-boot-on;
>  		regulator-always-on;
>  	};
> +
> +	sound {
> +		model = "SM1-KHADAS-VIM3L";
> +	};

The sound card is the same so I don't see why the sm1 board should have
a different name. If you are not happy with the name, please update it
in the common file.

>  };
>  
>  &cpu0 {

