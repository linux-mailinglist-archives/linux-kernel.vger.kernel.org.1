Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDA61E89A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 23:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgE2VLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 17:11:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32880 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgE2VLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:11:06 -0400
Received: by mail-io1-f65.google.com with SMTP id k18so895985ion.0;
        Fri, 29 May 2020 14:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4+FJjDqvVakGBtWvto28UOMlal+7ScZhsCrXZRCRdMc=;
        b=U0ebBPEXp3tUoBcxYUrbhEFbt0iJUSC/QP4wjRRd1vedG2HaNnv6wVmbGF775R6aSc
         6jJRT75/bHWYnFUhlHnUm8p6AjM6DXfpgm3exvdcXKg52g4I3M2x9SEn3ezAzufZNvC6
         cx1bfJ9hXH3qM9tdbMtg+UHmpE0s7M/Gjqmq5xQ/1YYcrbULCBVKD0g0Yy51/+TuSA+/
         1jSoQ2dePCtNd9FjobusTwqAg1yHPXeuVBD9P8zBD+gvM+SuKU8UEw1JzlIyjI/wwJT1
         aDmLyawQwiiKcHg8agwRcUi9BzJNudzvyeke3dp0PTjKwx2zSBgNSww2UfDzNsntLRek
         R3eA==
X-Gm-Message-State: AOAM5306khgzOJODSlij0LrYTOai7gRCnjj30hcvfAgrEvTZxaMhBqYm
        XeGETRhuwDVklZaqFrRU0g==
X-Google-Smtp-Source: ABdhPJwTMNAfS8IROEQi5gx2Eu3kvTjYIoAAlzt3TX+9dVKYzvKUtKD6suQ2xqiCJCISCHzl9WNZ4g==
X-Received: by 2002:a5d:81d8:: with SMTP id t24mr7617148iol.98.1590786665345;
        Fri, 29 May 2020 14:11:05 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c1sm5255130ilq.56.2020.05.29.14.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 14:11:04 -0700 (PDT)
Received: (nullmailer pid 2964602 invoked by uid 1000);
        Fri, 29 May 2020 21:11:03 -0000
Date:   Fri, 29 May 2020 15:11:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, kernel@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, aisheng.dong@nxp.com, festevam@gmail.com,
        linux-clk@vger.kernel.org, shawnguo@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] dt-bindings: clock: Convert i.MX8QXP LPCG to json-schema
Message-ID: <20200529211103.GA2960913@bogus>
References: <1590733299-12051-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590733299-12051-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 14:21:39 +0800, Anson Huang wrote:
> Convert the i.MX8QXP LPCG binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx8qxp-lpcg.txt     | 51 ---------------
>  .../devicetree/bindings/clock/imx8qxp-lpcg.yaml    | 72 ++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
> 

Applied, thanks!
