Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B634A1CE35D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 20:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgEKS5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 14:57:08 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:44985 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgEKS5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:57:07 -0400
Received: by mail-oo1-f67.google.com with SMTP id p67so2166326ooa.11;
        Mon, 11 May 2020 11:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O81zLtu1BdFWeCMUJf9Mg4FTRQ1nE4nJG/nnDMBNYg0=;
        b=Jh5rdd0gDL2DUK4KTebtmiuImkYddQwunAjZ3QKjo0/adJFOvJcsibCU2o70LL7qed
         OvGd/FCbpNpnVXasfGTPD2MczktZAnmrwIiwfNG+NemCTsBPUDTHfl6q51hBb01Ozm1s
         l1RHUfwEaykyFXomknptvzB5B7WkZ+9FuBUvl2f7WkwakpY076S8Uzzg+rk4ugVurt8X
         BZI3ECUl1DpLyvIE4ZDzuU/QovjQs1EwI1R57LQDWuhz7bJsb46vK3P7yv5gO9Tjm/g9
         VI/WD5WknF34HzX/v2S3/fAwWf0Xp38ZUjCRiaNG5HsKSexgJY9Nq+jNWm1cl0iKVSQm
         VVuA==
X-Gm-Message-State: AGi0PuZRg+B9CpVsgT46Mz9ozaG1y3yzXdryIvrrdHcc+WywcrnJtCuJ
        ffb5A6rHO9uvZdRW6eAP2SPaIgY=
X-Google-Smtp-Source: APiQypJK8Cdqg6qDrQ5p85pVfGjbAkyd7vaTSUq60Z1+Bd5hHgZ1aBojkROk+BcugoEzhl4nSMvXBA==
X-Received: by 2002:a4a:c30e:: with SMTP id c14mr14939182ooq.74.1589223426715;
        Mon, 11 May 2020 11:57:06 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y25sm1812430oto.29.2020.05.11.11.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:57:06 -0700 (PDT)
Received: (nullmailer pid 2875 invoked by uid 1000);
        Mon, 11 May 2020 18:57:05 -0000
Date:   Mon, 11 May 2020 13:57:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        festevam@gmail.com, robh+dt@kernel.org, kernel@pengutronix.de,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        shawnguo@kernel.org, Linux-imx@nxp.com, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 2/3] dt-bindings: nvmem: Convert i.MX IIM to
 json-schema
Message-ID: <20200511185705.GA2797@bogus>
References: <1587478181-21226-1-git-send-email-Anson.Huang@nxp.com>
 <1587478181-21226-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587478181-21226-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 22:09:40 +0800, Anson Huang wrote:
> Convert the i.MX IIM binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- drop clocks description.
> ---
>  .../devicetree/bindings/nvmem/imx-iim.txt          | 22 ---------
>  .../devicetree/bindings/nvmem/imx-iim.yaml         | 57 ++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/imx-iim.txt
>  create mode 100644 Documentation/devicetree/bindings/nvmem/imx-iim.yaml
> 

Applied, thanks!
