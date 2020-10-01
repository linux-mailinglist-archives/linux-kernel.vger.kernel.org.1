Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD90280729
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgJASq3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Oct 2020 14:46:29 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:40002 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgJASq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:46:28 -0400
Received: by mail-ej1-f66.google.com with SMTP id p15so9571114ejm.7;
        Thu, 01 Oct 2020 11:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HFk3PWF1fIGIhUtct1F8xNYI7rsUDHRDpgCUN1z73eg=;
        b=uhAB1zfEF0jswRt/exCSytN09O4n9sCVl9VY6DIutkWFZJq3gy32hhhkujlyhDrfE1
         sNv7SJDwRW830cvLB1ZAXXNpgkTDNNHDnNYnce5qfITp3PbMA1JoPyEGJHSgYCRrLwg5
         jJhmF2hkB6ny7OfE+frERXPEzYDezvkU0sqGagw+AZRbG4bICpTmI9Zr3MnbYjrMXn4D
         5H9+t6i1bKeoiTfgVr+s8iNZILzK2+jvEFDLVsN3U9fiBnid2WQCsGPMVeclUBs6DGMd
         cA6qDabDec5QCKsz4uso//p7An3XkNUcB42wvsHv/WqOCevK01YJ12WPbx0TOzxRXNJf
         f4PA==
X-Gm-Message-State: AOAM531v0JZwYADqULpc/ark8n8M/9QtAyRzd2sMojPL8mCdsn9MqaXQ
        E+Ztq8tWPopi3GAwOoOWS+jT601p6sA=
X-Google-Smtp-Source: ABdhPJyeKTvyYO11tt31HJrJV0L6AW9Pt8JiYnvg8TeyVbTbBaZOXNK9xbMGTIHiaqj+aaQ6Obe88Q==
X-Received: by 2002:a17:906:4bc4:: with SMTP id x4mr9885165ejv.240.1601577986436;
        Thu, 01 Oct 2020 11:46:26 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id e9sm4649852edu.49.2020.10.01.11.46.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Oct 2020 11:46:25 -0700 (PDT)
Date:   Thu, 1 Oct 2020 20:46:19 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH v2] ARM: dts: exynos: Add a placeholder for a MAC address
Message-ID: <20201001184619.GA14823@kozik-lap>
References: <20200930143151.23961-1-l.stelmach@samsung.com>
 <CGME20201001135310eucas1p273e3799cec0ebb29891c1b7db38685e0@eucas1p2.samsung.com>
 <20201001135254.28178-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201001135254.28178-1-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 03:52:54PM +0200, Łukasz Stelmach wrote:
> Add a placeholder for a MAC address. A bootloader may fill it
> to set the MAC address and override EEPROM settings.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
> Changes in v2:
>  - use local-mac-address and leave mac-address to be added by a bootloader
> 
>  arch/arm/boot/dts/exynos5422-odroidxu3.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

