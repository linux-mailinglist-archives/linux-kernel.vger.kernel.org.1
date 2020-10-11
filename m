Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E34B28A668
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 10:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgJKItS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 04:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbgJKItR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 04:49:17 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D2BC0613CE;
        Sun, 11 Oct 2020 01:49:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c21so13809605ljn.13;
        Sun, 11 Oct 2020 01:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0UhbpU3sjBsuckT5hKzAbLs6yLSondr3TPSSErdB7fY=;
        b=sSCZW6UKKQ5oAWufDvmibcB/vob0SlURA7Bb0ZSUT6pTfB2RqbtjHUoPKR1+b9PtO3
         82nwedlFanf3bWtSELs4Lwh1ksTsVT9/sdb9N6uqUp5UKDjpaidUwehl3/4yg+yQP0Iv
         7ZFXt3Q2cVCkZv030niPszlPT6XnU63Ngd20+U9/B2lqIMyZDlNc4SvyLHPRgyjHgfA2
         nK7xFJqTMO+wUXm10qsQUKgOofEgqnhP6Wr0rDZn8ZZJksin6gflRGM2mNsulwAilGK3
         Dt0egzBwDugThriHJht/ZIeU+P7DxGoKYjYsZgF0ZQeHgpQ3F8qso8ig/eyXmygS3wqH
         4W/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0UhbpU3sjBsuckT5hKzAbLs6yLSondr3TPSSErdB7fY=;
        b=AAjkaBWZA2xNkf4HB7VaIohaL3zEfZRdDITgh8CcECE90qZ/vITCZJHU6xaVnPi7ol
         jFvybsuSXQ1LD0kf9yRkVakXxKqW90P7Lr5z6zMgdgWDFcTwW1+/Yo1rVtA7W4JWXxLv
         TZEz8y7ZQ3O23Hm1LEC+Qz5ogNFF0KK4+xOrdEViIqarRALFTC+WUyGRzBVRBGGMswpE
         Nu6WYqLcpyJAuZ/+TKFm180xrMjG82vspcYUqHfze08DRMivFAj0PpRjXMCVZUN+q8pS
         nOEcTe3GIsSbQp+gga+jUiHEMVMg59S2tQVNiHMZT71lYGkGAcx3YHTap3NyR4hDxife
         r4/g==
X-Gm-Message-State: AOAM531yS2xn5eeQM1ebZr3p9Vj3XewvhglpUUcLyIjjlm19wo8RFCDI
        ABsF6pIFeIQKyVMW169UjUeLqAYD9aN7bQ==
X-Google-Smtp-Source: ABdhPJwvVspDglVAT7vFoRQm+6eRWZVTeCm+iS6q4/cfIjoifsXDWI6NsEx9bgBgdsgotAFa71r7Hw==
X-Received: by 2002:a2e:9905:: with SMTP id v5mr8881359lji.134.1602406155212;
        Sun, 11 Oct 2020 01:49:15 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:4275:c0a:6554:d910:ceb:9024? ([2a00:1fa0:4275:c0a:6554:d910:ceb:9024])
        by smtp.gmail.com with ESMTPSA id x7sm2431417lfg.281.2020.10.11.01.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2020 01:49:14 -0700 (PDT)
Subject: Re: [PATCH 04/18] dt-bindings: usb: usb-hcd: Add "ulpi/serial/hsic"
 PHY types
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
 <20201010224121.12672-5-Sergey.Semin@baikalelectronics.ru>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <a1fcac64-934a-c68a-cd71-032efce3d0bc@gmail.com>
Date:   Sun, 11 Oct 2020 11:49:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201010224121.12672-5-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2020 1:41, Serge Semin wrote:

> Aside from the UTMI+ there are also ULPI, Serial and HSIC PHY types

    "That" missing after "types"?

> can be specified in the phy_type HCD property. Add them to the
> enumeration of the acceptable values.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
[...]

MBR, Sergei
