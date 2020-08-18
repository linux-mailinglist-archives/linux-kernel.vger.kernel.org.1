Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C46248A96
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 17:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHRPwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 11:52:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34943 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgHRPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:51:54 -0400
Received: by mail-io1-f68.google.com with SMTP id s189so21679557iod.2;
        Tue, 18 Aug 2020 08:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mf422wvmtHGB+fLAHqkYV5iliyU3plq01dFBfESJYS0=;
        b=fQ033Hg+n30+M9X4XPrqW9mpP2fnBgDl2jbVloW3idniQlMSvwb/B8rkOb56NghyMH
         RsfWG0S4TH1deKefT4lQgqAA3vY09GBUmTG2s412e95C/tDjg3g5Uo1ydUYZM6ActtYy
         BKKIz9SdkbCBgfXtSMdna+5a1ZfVgcJtF8n1gtiVoKPKW8usoRRrIZKeewdU9c0SeQRh
         L6KpLCRNDu48EovocK+ecjSN/Q4urIp1n0yropFRDjrC7WzHbmCvycPCTw13yqlmFmrH
         vn4rccUxOk/8BDeNz1RocdZg7WCiPqH+XT6q30ds7a6TNRaQe3tkGo7WKOkgkLTWwxr8
         Ba+Q==
X-Gm-Message-State: AOAM531JqTfp99peAUucdQdI6JZ3lgcsg+/LkiVl1cCF1ruN5VK9y/BI
        X740ZWDwU63NJ7ctAnfIDGNjMZRY5Q==
X-Google-Smtp-Source: ABdhPJxucHnQnFfDvMaxcgX49sVszAnJBk6CGxr0tcEZLJF8jUkmB4GUT5sDMmAuZn81f35K4UToiQ==
X-Received: by 2002:a02:cf26:: with SMTP id s6mr19858789jar.44.1597765912536;
        Tue, 18 Aug 2020 08:51:52 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id v14sm11524845iln.76.2020.08.18.08.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 08:51:51 -0700 (PDT)
Received: (nullmailer pid 3526978 invoked by uid 1000);
        Tue, 18 Aug 2020 15:51:49 -0000
Date:   Tue, 18 Aug 2020 09:51:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-serial@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        linux-clk@vger.kernel.org, fugang.duan@nxp.com, Linux-imx@nxp.com,
        s.hauer@pengutronix.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        shawnguo@kernel.org, festevam@gmail.com
Subject: Re: [PATCH V3 1/5] dt-bindings: clock: Update i.MX28 example
Message-ID: <20200818155149.GA3526911@bogus>
References: <1597721685-9280-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597721685-9280-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 11:34:41 +0800, Anson Huang wrote:
> Update the i.MX28 clock example to align with MXS AUART binding doc to
> avoid below build error:
> 
> Documentation/devicetree/bindings/clock/imx28-clock.example.dt.yaml:
>   serial@8006a000: clocks: [[4294967295, 45]] is too short
> Documentation/devicetree/bindings/clock/imx28-clock.example.dt.yaml:
>   serial@8006a000: compatible: Additional items are not allowed
>   ('fsl,imx23-auart' was unexpected)
> Documentation/devicetree/bindings/clock/imx28-clock.example.dt.yaml:
>   serial@8006a000: compatible: ['fsl,imx28-auart', 'fsl,imx23-auart']
>   is too long
> Documentation/devicetree/bindings/clock/imx28-clock.example.dt.yaml:
>   serial@8006a000: 'dmas' is a required property
> Documentation/devicetree/bindings/clock/imx28-clock.example.dt.yaml:
>   serial@8006a000: 'dma-names' is a required property
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> no change.
> ---
>  Documentation/devicetree/bindings/clock/imx28-clock.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Applied, thanks!
