Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399771E72DF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 04:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406834AbgE2CxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 22:53:11 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38216 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389013AbgE2CxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:53:10 -0400
Received: by mail-io1-f66.google.com with SMTP id d7so795554ioq.5;
        Thu, 28 May 2020 19:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=53aepKY1zAZQmqd41i19Tw6DwDH0Gy4Ao8Fm9eGoQlI=;
        b=kVaMgHX1PMVSoG81KlhcDnY+TVjItjSJCwo/TQ2amWCisqsB+LHYocpgWdClm59vJ1
         JfjH/V1bkIMES8U+/wmdJqBkWLoRuCfws3sQYeBkvj9Ci77K0rtHU3Je0csFPy2PfboL
         UnCPUa4VI7JGl58548ExZjoB2eQT5+fwOFreenOwENwa6IZnds25T41XYV8z+b8xtRpb
         2XlyfRfv8DIhCGnGeO/Yf3PC+ZYKEaLIGz8IIyIZUvp6inKPRBFb+KevMLyZETJHUsxH
         WZSLcRcTonLJQ0W7L1wWO53ck2FSwc/WpZSLRiqxlEZQa/Gp9q+cX4E9IsrioYw0jChu
         V+Fw==
X-Gm-Message-State: AOAM530WY7bLzrjghJwDzMEW4rgLH9IVkVDFM47Duk/tsZKbXdTADlz3
        keagSqtbcRV4xHgA0xGwBQ==
X-Google-Smtp-Source: ABdhPJz+oX8+Iq09jc/u0MUOvfOxgJw04iEARivRxjOL/fXGKu6Gz38lnbyZ9D8N6KB/loOrzOJlaQ==
X-Received: by 2002:a05:6602:2dcd:: with SMTP id l13mr4978701iow.203.1590720789224;
        Thu, 28 May 2020 19:53:09 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k17sm2349772ios.1.2020.05.28.19.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:53:08 -0700 (PDT)
Received: (nullmailer pid 1178255 invoked by uid 1000);
        Fri, 29 May 2020 02:53:07 -0000
Date:   Thu, 28 May 2020 20:53:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     kernel@pengutronix.de, linux-clk@vger.kernel.org,
        s.hauer@pengutronix.de, mturquette@baylibre.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, s.trumtrar@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, festevam@gmail.com,
        robh+dt@kernel.org, Linux-imx@nxp.com, shawnguo@kernel.org,
        shc_work@mail.ru
Subject: Re: [PATCH 7/9] dt-bindings: clock: Convert i.MX25 clock to
 json-schema
Message-ID: <20200529025307.GA1177858@bogus>
References: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
 <1590650879-18288-8-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590650879-18288-8-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 15:27:57 +0800, Anson Huang wrote:
> Convert the i.MX25 clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx25-clock.txt      | 160 ------------------
>  .../devicetree/bindings/clock/imx25-clock.yaml     | 184 +++++++++++++++++++++
>  2 files changed, 184 insertions(+), 160 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx25-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx25-clock.yaml
> 

Applied, thanks!
