Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C012478ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 23:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgHQVgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 17:36:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38809 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHQVgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:36:46 -0400
Received: by mail-io1-f65.google.com with SMTP id h4so19151472ioe.5;
        Mon, 17 Aug 2020 14:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OZFGynvYRACIfLrkLQO1tg1ssrvEIvNb+ROWjP+mHJo=;
        b=dzP99uW7890M4O8wOkHBp8iui5floQ2Y8gEPbPP4fTDy+l0CfqaqGQkWlWY+wvIw26
         dgtAIExJzT8YRvHwtXo4lzgOsp/gI4QhV8ch+kzmeuALDICW4XrikFrzBbW/Eb60hg+o
         vH4F2OmBVL7Fv99RFQPNP1B7AjxJKEWroAMnO1h8kKvJ5U27t7mXVgmFkw235PW21Gpo
         OcBp/AOObmwBwiMy8pMU4YsYZvM/JqkrwQzdbxbJE371vEDPMpRkUdNMd7igDNqLW1zE
         TMOLP/gVSr3F7Nbge6kMNf5ZvpVLc1Lmf36RPm+xRdNO0iWKEZGFQlXJymYtOOIMBMqN
         MzFg==
X-Gm-Message-State: AOAM530XFTllOFvk6doP60+YQ81jWKE47j2mthbUR1+nIbUhJj3YV8+E
        pTs5t8pN4aBn75kTbHinHg==
X-Google-Smtp-Source: ABdhPJz8To4nkVTyS7sMS/xd6kJ0R8xV7e9DxlzHo8J4xNxoWUt9tTVlbwJwHU+TATFt9QbQNudFig==
X-Received: by 2002:a5e:d505:: with SMTP id e5mr13889224iom.77.1597700204960;
        Mon, 17 Aug 2020 14:36:44 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id v10sm9731931iom.31.2020.08.17.14.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:36:44 -0700 (PDT)
Received: (nullmailer pid 1610036 invoked by uid 1000);
        Mon, 17 Aug 2020 21:36:41 -0000
Date:   Mon, 17 Aug 2020 15:36:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        shawnguo@kernel.org, Linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        aisheng.dong@nxp.com
Subject: Re: [PATCH 1/2] dt-bindings: fsl: Convert i.MX7ULP PM to json-schema
Message-ID: <20200817213641.GA1609903@bogus>
References: <1596595841-27563-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596595841-27563-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Aug 2020 10:50:40 +0800, Anson Huang wrote:
> Convert the i.MX7ULP PM binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,imx7ulp-pm.txt      | 23 -------------
>  .../bindings/arm/freescale/fsl,imx7ulp-pm.yaml     | 40 ++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml
> 

Applied, thanks!
