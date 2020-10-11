Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FE028A66C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 10:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbgJKIxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 04:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgJKIxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 04:53:14 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50BCC0613CE;
        Sun, 11 Oct 2020 01:53:12 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j22so9667285lfe.10;
        Sun, 11 Oct 2020 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FAtN4FsQD2DA1DwQ31xS/hb71H89jw4lOSPGVhG6ZKk=;
        b=CnNFq616C6vUUuLJMFi9VOiTB/8tRBRLIBUUqgfdrmZ5R54PuiUgEuSOr4M87HP+Nl
         j3IUrQioPIfXuSRhXntmi6iiCDOUWPUmNaSykrBPhp3327sVAvk63NmRjdM0E970S9C9
         ciltBulid4LZ+muj7r78q7tA91AWwaYt1AM6SailS4BvdYWYCecyEdIDjjYfddeAkUpj
         5nIyUtroww12dd4XcPTcTsRdkF9Am9FmL07HAQSPJPBXqmQ4LTKjY7bAAVt5VjGKt9fT
         LFCtEyc3ntY3hOfg8VRjxscj8S6wp9xjw9wfldjUgf5CuB+3xvseR1o6F7C7+9oQWV3k
         muxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FAtN4FsQD2DA1DwQ31xS/hb71H89jw4lOSPGVhG6ZKk=;
        b=mPn3Ry4mmsTA6dD5cNVDFc7zWNIw6Bxj9IzYFdM/xFHrRTTaE4UTCigsYtub89JaKC
         T1tmYBV8kQZiFF6adcir6EiNpZEPdi7P3l2OvAX0v+1M9+iIKCyPrCUbrIZYLo5wOWk/
         ++OHVeBwFsIR3dhd4h9uzUea/hnH0mk0ZvR0Xzos0ikLBrrWio9zIuhwvZJdQcxAbBV4
         tAObMnVr5SjtcD1T3KDU+MgwhuOkEOaA+EWFEDl3YpeGZ2KN6RzmNC/QmrDitm0aUROC
         oA7Yuo23V092p91sQIrzhnDIsCV7KDmY+l86Gcx633s5E81v1HxdXkAut9sz1fKQl56g
         8GEA==
X-Gm-Message-State: AOAM532hhmbbfph4sKfVqt32b3DO4amr8JfBWU+eTWHdbFH6ASW92Q1h
        BaCza0Ncw1d1b4tn6PdkREnyH9TSEUtnkw==
X-Google-Smtp-Source: ABdhPJzNgceZ2FFEEC2FwjqBWprWdldvW/fLhToS10xhGVdBEz1qRDZaG2r+sJxNUsdpyqPKYyaI9A==
X-Received: by 2002:a19:c3cf:: with SMTP id t198mr6228526lff.461.1602406391253;
        Sun, 11 Oct 2020 01:53:11 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:4275:c0a:6554:d910:ceb:9024? ([2a00:1fa0:4275:c0a:6554:d910:ceb:9024])
        by smtp.gmail.com with ESMTPSA id p20sm2171292ljg.13.2020.10.11.01.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2020 01:53:10 -0700 (PDT)
Subject: Re: [PATCH 11/18] dt-bindings: usb: dwc3: Add interrupt-names
 property support
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
 <20201010224121.12672-12-Sergey.Semin@baikalelectronics.ru>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <a2850dee-6c6b-2ae9-eed4-a13b3f8e532f@gmail.com>
Date:   Sun, 11 Oct 2020 11:53:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201010224121.12672-12-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2020 1:41, Serge Semin wrote:

> The controller driver supports two types of DWC USB3 devices: with a
> common interrupt lane and with individual interrupts for each mode. Add
> both of these cases support to the DWC USB3 DT schema.

    Add support for both these cases?

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
[...]

MBR, Sergei
