Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E2128A665
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 10:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgJKIrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 04:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbgJKIro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 04:47:44 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92ADC0613CE;
        Sun, 11 Oct 2020 01:47:43 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i2so13848012ljg.4;
        Sun, 11 Oct 2020 01:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WEkmoWmE+gfjv5nQomkH8CsqwBmk68jyUS3urfyycVc=;
        b=Ruc2iQFm/qaEgiNba39zG6wMu9GysWNq+KjcUmDta3BB+jPIxuITMJH8kbq846WP+D
         zKwR79dL5vdHwgA5SYQ3dGqCqIcjHaSEnM6iV5hMTCxEIu0P0VxCbaB5CSmXDG77OQsE
         l24zWkM2QYXZtxVPppGc825JyEcDErTXFLotoRYg9fnSPimaV+jkfJr+Uf4saExnLf/8
         Y1J0U8EVaXyHQWWgJbtpBliDcb787Jyp+KZWtTdXFGnDTy79YZ9sBLU/Us1l0IdVwado
         vZ3Qkfb9KUOTUYsa0zG/WNmOmhrfBfLiDtUEvr1GarMznT9pR4ItoQOJUreiONzDGtN5
         obHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WEkmoWmE+gfjv5nQomkH8CsqwBmk68jyUS3urfyycVc=;
        b=XN8JdmHGdzq6G+EBLnsMh+CA8m2kTpJUDI1pYZo3BkGCM/drNhUzAe6AyQjBAOvKqB
         s96jUJdT7TEKPWOB0Z6RErWN4EdS51/OS4likrm4vepAf82+wOPoweKhxF5+IQX1OB1J
         chwnO4LodRKOeRh2sEX1xqKd4GuQQ4N+JvR8F3VM1QFvX7ufQVrtJwQdWk2NasJH99sM
         D6akqEylgHRyLSfNhbNydlMG10UxtE1aL+TOSeCJxELzrqSs3yq2Afl3eHN7mrzjXh7N
         /pMZha0KnpWvBgLpmPVY7UiujWQkhDr2aYFK4pOAqD3xk8nkcL2mimT/YItlEXTC2ryL
         bhIg==
X-Gm-Message-State: AOAM532AnMN6HwwJA2OM/rPdauPuRQL5q3EEUMmIWo/duzrdYjOYw9DG
        tbEei0CR0Aj1QxwdOM9DX0eF3S4of2jdJg==
X-Google-Smtp-Source: ABdhPJwSgU7ysJDeHsLirDGNOmlQUApyMQ/5mDZGew1EJYrQpXM3jMOlk9GY11NrqVqkatJTnRuxPA==
X-Received: by 2002:a2e:8e8f:: with SMTP id z15mr8821138ljk.238.1602406061600;
        Sun, 11 Oct 2020 01:47:41 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:4275:c0a:6554:d910:ceb:9024? ([2a00:1fa0:4275:c0a:6554:d910:ceb:9024])
        by smtp.gmail.com with ESMTPSA id e28sm15242ljp.28.2020.10.11.01.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2020 01:47:41 -0700 (PDT)
Subject: Re: [PATCH 05/18] dt-bindings: usb: usb-hcd: Add "tpl-support"
 property
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Roger Quadros <rogerq@ti.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
 <20201010224121.12672-6-Sergey.Semin@baikalelectronics.ru>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <ada3becf-ab69-6bac-9459-c9fb076b3bf4@gmail.com>
Date:   Sun, 11 Oct 2020 11:47:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201010224121.12672-6-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11.10.2020 1:41, Serge Semin wrote:

> The host controller device might be designed to work for the particular
> products or applications. In that case it' DT node is supposed to be
                                          ^^^
    Its?

> equipped with the tpl-support property.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
[...]

MBR, Sergei
