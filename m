Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33A228177E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbgJBQJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:09:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37951 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387807AbgJBQJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:09:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id c8so2209507edv.5;
        Fri, 02 Oct 2020 09:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5FyqpnE1NitYRE4MXiFKcXlz9HII2gU2Y9I2GLKfofw=;
        b=FVXtrjHgzlqGWE02yF7MZIZ3LPC4E+lNy7iwQllk1KTqNTB0t6YbQqiXHPdYVp8lre
         x39ju+4cUSA6yzU6GdGehGgy2AHw2CZUF8V1jDuneopO8CUz5Zn+/lMB08KoWnNSJq1q
         kQqGGdIzf16xpv80SC5zHohgm9UwBAbGBl3h+Bjtd3dBw/7VDWb1y4m4lsQtkONg//Ea
         /xbAzBDPAsjPIWsbXBTpgJaJZX4vk786qXVjJBpic+zNfjW4q3CPKQd3LaNn9HsTCjt6
         MEjpQvJZ5Ry5SftgghezK6a4YsAOsvFt8HDgsP4RQl+rJV8RG2bq+2dmaD6ZweiBlaun
         ZHHg==
X-Gm-Message-State: AOAM530kS31tKoxffvxdznSeDjo2DhrnzeJB95aj3UzDv110esoQI1DY
        3Bp9GDkZXvvbowZBRe1eW7o=
X-Google-Smtp-Source: ABdhPJzyQ466nllNLijPl8MyvJDDlJ3t+z6Fn527zLluK2eGj5ZooDjyIw5XNhnfnmOyWeCz6NqWTg==
X-Received: by 2002:aa7:c387:: with SMTP id k7mr3026582edq.242.1601654966696;
        Fri, 02 Oct 2020 09:09:26 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id b6sm1453915eds.46.2020.10.02.09.09.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Oct 2020 09:09:25 -0700 (PDT)
Date:   Fri, 2 Oct 2020 18:09:22 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Khuong Dinh <khuong@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dts: apm: drop unused reg-io-width from DW
 APB GPIO controller
Message-ID: <20201002160922.GA4542@kozik-lap>
References: <20200917165040.22908-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917165040.22908-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 06:50:39PM +0200, Krzysztof Kozlowski wrote:
> The Synopsys DesignWare APB GPIO controller driver does not parse
> reg-io-width and dtschema does not allow it so drop it to fix dtschema
> warnings like:
> 
>   arch/arm64/boot/dts/apm/apm-mustang.dt.yaml: gpio@1c024000:
>     'reg-io-width' does not match any of the regexes: '^gpio-(port|controller)@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---

Dear Arnd and Olof,

There is no response from APM maintainer, so maybe you could apply these
two patches directly? Optionally I could take it and send to you via
pull-request.

Best regards,
Krzysztof


> 
> Changes since v1:
> 1. New patch
> ---
>  arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 1 -
>  arch/arm64/boot/dts/apm/apm-storm.dtsi     | 1 -
>  2 files changed, 2 deletions(-)
> 
