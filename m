Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B41A28A67B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 11:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbgJKJEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 05:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJKJEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 05:04:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D27FC0613CE;
        Sun, 11 Oct 2020 02:04:14 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id l2so15255634lfk.0;
        Sun, 11 Oct 2020 02:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=op4C1dyWec2MNa3n2GiL3r5ejlKfwUOPFae3SX3BS8g=;
        b=O0Zh2Agmj9c2F6bcDOpxYHA0I1hTC5fcHKvfoW9Z1KjYaqRh0LetmEjRf0Lv590+pb
         tEGg2Av318WMZ/P9KhjD3GAuyApXIqh8RwErMIuLWDUEHI8nERnEQMntA7zUj8Oguyui
         +57mxemkp5I/ztJm/KgXSliTowi/ayeHsb07L8SOwJ7ft40qMNZPRtLxCd2CoPTcMvV7
         +QaABO0hI2dDYWtagDwlTlBz0aQ9/JtL9uWT14l3KRQGH01926DEr/txlbN3U5K/Jy8h
         LV+vtyupb6FhTq7/CI9q3E63fLsAuDn0XimEm7IBIkC7hmwBTb9wU/bRXnanSWfimdjO
         GgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=op4C1dyWec2MNa3n2GiL3r5ejlKfwUOPFae3SX3BS8g=;
        b=DS1ouHgFeSVMK6tVfUFWorhvLu7+U2rY9zDc2N7xMqhs+VpFXIKw7GPzDz/T51K0/e
         5H6Z/bI4RM3f+JnoYsiDKdKfnmKZmV0orIzbz10TLKBZHAjRgys89UfNbfmgCqku63nN
         eRg+E2ykRYIm03NmK1lSjWvMlHwlKx+KA2Aic1++dXqQZHZDEWmiWJ8QeNYIl8uDsbEG
         cpfmx9c7JxGFifWM0vexjomvWpCAs7NgohoGCpkPt4JkSycYyTyEIRjkhWnzrpmCHoLx
         ls1gWQoixz7lPCfbZkXZyxeG2u/6jHp+9FhtVdtatEj7eUcEXfmsdGfM+lbiy1JVkWqu
         byMQ==
X-Gm-Message-State: AOAM5306jyN5IYmqc2ffSQCJG10hArT6R0Aw8lV7zdLbGA+VPIZvZjFs
        5bl/KVUHoqM+r2wXHJ+I7Prnh8EbXiznYg==
X-Google-Smtp-Source: ABdhPJz9EE8xjySHoMmnUEBpfYu6Ux45Y8E7ZtSK9JIWShZAxJR5+2GBYjtFb14je8t8HABotww5MQ==
X-Received: by 2002:ac2:5294:: with SMTP id q20mr6756421lfm.538.1602407051227;
        Sun, 11 Oct 2020 02:04:11 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:4275:c0a:6554:d910:ceb:9024? ([2a00:1fa0:4275:c0a:6554:d910:ceb:9024])
        by smtp.gmail.com with ESMTPSA id r17sm2441887lff.239.2020.10.11.02.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2020 02:04:10 -0700 (PDT)
Subject: Re: [PATCH 17/18] dt-bindings: usb: keystone-dwc3: Validate DWC3
 sub-node
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
 <20201010224121.12672-18-Sergey.Semin@baikalelectronics.ru>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <874c8ba6-bd0c-4f4e-f4ee-29c7f6ae563a@gmail.com>
Date:   Sun, 11 Oct 2020 12:04:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201010224121.12672-18-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2020 1:41, Serge Semin wrote:

> TI Keystone DWC3 compatible DT node is supposed to have a DWC USB3
> compatible sub-node to describe a fully functioning USB interface.
> Since DWC USB3 has now got a DT schema describing it' DT node, let's make
                                                     ^^^ its?

> sure the TI Keystone DWC3 sub-node passes validation against it.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
[...]

MBR, Sergei
