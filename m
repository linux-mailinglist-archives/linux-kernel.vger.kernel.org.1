Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063CC21E581
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 04:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgGNCPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 22:15:17 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:41751 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNCPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 22:15:17 -0400
Received: by mail-il1-f193.google.com with SMTP id q3so12966483ilt.8;
        Mon, 13 Jul 2020 19:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HAKv0UP98J59W+EXwmN2neF5GsNxnxRV02qIPUTyYRk=;
        b=eQfFl2hMSXQU20tNmUoDVO3Bz1oTexaC5mJgaJ7rS9wV1yAzU0LDHb1/3i7ljGH3ZC
         PAA9GlwkXKjhBZ1Imtr+V4+jIk7e/DSWXWn7DvCDVmbpN13ss4slGBnlCaEt5QI4tATV
         PzCgiurAP0vr1DdjMn1P1ygsZquqkUviS1Sl4VnUkQNLFEnLGNqslcfdWB6UjfM3/jls
         wLHlzx01ZTbbJw6/73FvrJJqw3/um2AtufKW4EEurqShmH7af4wANeubO+Eb+DVLrthN
         //7kC8k/9ns4XXDZPjDn1AFZcONpFda39zRKhPJPZEfqo39rtt1FTyQZEB0T89xJQsss
         cT3A==
X-Gm-Message-State: AOAM530Xznc1T79Eyp1gOolrSEVbwsEJplqkLIKDTPLWI3IbSUYQnpuG
        yQcn7J/q8crZfrYEQ8GC3A==
X-Google-Smtp-Source: ABdhPJzzxIoZRAvxxuKKpOCe6ort0jaXZG6vZiU3J1Am4i8Qx+6kt5Izr1KNun7PXBrCIjonkJRkcQ==
X-Received: by 2002:a92:cd4e:: with SMTP id v14mr2452258ilq.247.1594692916024;
        Mon, 13 Jul 2020 19:15:16 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k3sm9106930ils.8.2020.07.13.19.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 19:15:15 -0700 (PDT)
Received: (nullmailer pid 1140861 invoked by uid 1000);
        Tue, 14 Jul 2020 02:15:14 -0000
Date:   Mon, 13 Jul 2020 20:15:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Edgar Lee <cylee12@realtek.com>,
        Stanley Chang =?utf-8?B?W+aYjOiCsuW+t10=?= 
        <stanley_chang@realtek.com>, linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        James Tai =?utf-8?B?W+aItOW/l+WzsF0=?= <james.tai@realtek.com>,
        linux-realtek-soc@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 17/29] dt-bindings: nvmem: Add Realtek RTD1195 eFuse
Message-ID: <20200714021514.GA1140827@bogus>
References: <20200623025106.31273-1-afaerber@suse.de>
 <20200623025106.31273-18-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200623025106.31273-18-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 04:50:54 +0200, Andreas F�rber wrote:
> Add a DT binding for eFuse on Realtek Digital Home Center SoCs.
> 
> Signed-off-by: Andreas F�rber <afaerber@suse.de>
> ---
>  v2: New
> 
>  .../bindings/nvmem/realtek,rtd1195-efuse.yaml | 53 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/realtek,rtd1195-efuse.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
