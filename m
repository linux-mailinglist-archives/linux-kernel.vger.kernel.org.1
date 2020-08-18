Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6FF248AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 17:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgHRPyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 11:54:09 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:46083 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgHRPxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:53:12 -0400
Received: by mail-il1-f194.google.com with SMTP id c6so17993329ilo.13;
        Tue, 18 Aug 2020 08:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e8xwT+XbdKbVXnEs3AgJg8sUqMKGkHFT2KlDaoxIjxw=;
        b=TdMcDjst4Ir5x4ReAr2Zv1XPZfVQfdTsidjQM9soi77SehYqE7c+bFf9pi/NMwipDW
         y5WBZjRtOM4m/MWcxpcs6puePubjeN3SW8WGSV0rLbExt3n3MNh8P4EUW1mGKu6WI6hN
         B58enOg99W+lmJhImFv9wP9jOx0KaiN0WHJSik1rK7nMvji2P9xUKrSb9iC/aqUNXXwN
         U5ul1buPUfQ9580OpnwhpdhDyJuXCPwbGq6F8ghVCzPE6EjhK6iywaUWdDsWCXHe1OO5
         DLMtB17y3VB3FRb9fVysQogacitZTMoUm4qwFz6cETZH+rBSHOjZ7e1Vd1WXjavfDwSx
         kHmw==
X-Gm-Message-State: AOAM531jh+c4qO7ePdE4k7NMrAu6k/dPb/PmltkCvyYAlJkNB8aLANT0
        hvVZh5+346a2obRsKpUeglRwpqG3iA==
X-Google-Smtp-Source: ABdhPJz7y7DtUryAad9pPrdvv6ZcWrAUTi6RyapxV/kvz9wzOYmpRw8J/elnLKZGFHgiIsSQ8hPTKA==
X-Received: by 2002:a92:dc90:: with SMTP id c16mr18914056iln.202.1597765991438;
        Tue, 18 Aug 2020 08:53:11 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id m7sm11595867ilq.45.2020.08.18.08.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 08:53:10 -0700 (PDT)
Received: (nullmailer pid 3529434 invoked by uid 1000);
        Tue, 18 Aug 2020 15:53:09 -0000
Date:   Tue, 18 Aug 2020 09:53:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-serial@vger.kernel.org, fugang.duan@nxp.com,
        Linux-imx@nxp.com, mturquette@baylibre.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        festevam@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        sboyd@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH V3 5/5] dt-bindings: serial: Convert NXP lpuart to
 json-schema
Message-ID: <20200818155309.GA3529387@bogus>
References: <1597721685-9280-1-git-send-email-Anson.Huang@nxp.com>
 <1597721685-9280-5-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597721685-9280-5-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 11:34:45 +0800, Anson Huang wrote:
> Convert the NXP lpuart binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V2:
> 	- update maintainer, the original owner's email address is no longer valid,
> 	  use one of the patch contributors as well as NXP's UART owner as maintainer.
> ---
>  .../devicetree/bindings/serial/fsl-lpuart.txt      | 43 ------------
>  .../devicetree/bindings/serial/fsl-lpuart.yaml     | 79 ++++++++++++++++++++++
>  2 files changed, 79 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/fsl-lpuart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> 

Applied, thanks!
