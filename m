Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA4721FFAA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 23:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgGNVJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 17:09:48 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43510 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgGNVJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:09:47 -0400
Received: by mail-il1-f194.google.com with SMTP id i18so43204ilk.10;
        Tue, 14 Jul 2020 14:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7n1eCfcIXRzp8Zf/h32IGI3ysZU8V6mXbcHVjQ48LpM=;
        b=pyKmC1iUGPTpESp5UMsKKB8qMGHSZYTG3QAWfP9O6DfL/dhCSRBo7hYqVDFUPQLbXB
         AwtEVltT2cRklulEZ5N08nsVNMdUmf1Y608Q0vHnEXmwsYfnUWa3a+xXiC1TJj4XNZYV
         E53s+iO0ATpir+MMmN3vryeS8+96VWAtl/plIKUtZvHGP6ksq4E5SfaJTMQ8LxdUaHj1
         bpFHsfLQ2v+8f4t21pg0RFTz8xIBCJ/w6xmhN69Lrc4JVbUHqg3SJDtSH0kZ6D4pUIbg
         2sEfEl2BuFI+cqSoTEMlVSBm/HfCSBjuONy29rRbZRQzQS6seBFRKUyUb9z3EBU/0sUv
         CkOg==
X-Gm-Message-State: AOAM531wDsS6JMD2Ob2ASYR5HEziOU31/RMklbkWn4yEEB+LvkuVuvGl
        4pERuDrNz5WLvxS+/7H8dh7//cK03ZTK
X-Google-Smtp-Source: ABdhPJy2M+RM7ODxSIifUBuOn2xzZSlv5UJSECY0kHYVvd6TGRWoVCEMCkEvE+CKWf8plGmQrP4TkA==
X-Received: by 2002:a92:6a02:: with SMTP id f2mr5984073ilc.68.1594760986430;
        Tue, 14 Jul 2020 14:09:46 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x71sm57098ilk.43.2020.07.14.14.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:09:45 -0700 (PDT)
Received: (nullmailer pid 2921463 invoked by uid 1000);
        Tue, 14 Jul 2020 21:09:44 -0000
Date:   Tue, 14 Jul 2020 15:09:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Franck Lenormand <franck.lenormand@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Matt Mackall <mpm@selenic.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-crypto@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 1/5] dt-bindings: rng: add RNGB compatibles for i.MX6
 SoCs
Message-ID: <20200714210944.GA2921406@bogus>
References: <20200714123920.23711-1-horia.geanta@nxp.com>
 <20200714123920.23711-2-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714123920.23711-2-horia.geanta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 15:39:16 +0300, Horia Geantă wrote:
> RNGB block is found in some i.MX6 SoCs - 6SL, 6SLL, 6ULL, 6ULZ.
> Add corresponding compatible strings.
> 
> Note:
> 
> Several NXP SoC from QorIQ family (P1010, P1023, P4080, P3041, P5020)
> also have a RNGB, however it's part of the CAAM
> (Cryptograhic Accelerator and Assurance Module) crypto accelerator.
> In this case, RNGB is managed in the caam driver
> (drivers/crypto/caam/), since it's tightly related to
> the caam "job ring" interface, not to mention CAAM internally relying on
> RNGB as source of randomness.
> 
> On the other hand, the i.MX6 SoCs with RNGB have a DCP
> (Data Co-Processor) crypto accelerator and this block and RNGB
> are independent.
> 
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> ---
>  Documentation/devicetree/bindings/rng/imx-rng.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
