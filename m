Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4001E72D6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 04:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391627AbgE2Cv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 22:51:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33960 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389013AbgE2Cvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:51:54 -0400
Received: by mail-io1-f67.google.com with SMTP id f3so822318ioj.1;
        Thu, 28 May 2020 19:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B2hJTTsHFtyJU4dEBhfj2siSRzajGaCQHW/RqcEB/Yk=;
        b=a1B/7YiGIbCeD6H/tivV5+J/2gwULifzf6PQz/0kX/sP6d4yr+lRCutW/qFDrNiRMv
         pxnEqxJYNnNgUUaJntYvqHko/89uq03VPvYZX4j1Kqm+V4CIVChJLahWbZnjK9AN7bfZ
         dq6U8guG8tu9xQd+HQEKbzTtSULIiEUFOEvDPi6L3LTNB6biW/qAdcRTfNyxR/MiEsB/
         mkRsDzsbckr2b444mG9vjNSeGCqBaAVubaxMqFsfU8migvbHWq94I/5NlpzVvmkvjiYg
         YQLn58IKEZwajN757RShXqGUHel4Y92KKMhdxBEgcbg5XS4nMOXJfyupbErL7JnjOfoF
         vyaA==
X-Gm-Message-State: AOAM533enlXT2WTM+9y2QzMdGdzQICQPe8WWMQzHLRd25MonhJt2js+L
        s5nbI6m5OZGtpoOgSejVkg==
X-Google-Smtp-Source: ABdhPJw6PmqgJ5xdIrW/3UYr6MdedPPQalvckWPH7hp4CFeAubFvrhDdmE6tJtOl8MOwfoEIvGETpA==
X-Received: by 2002:a5d:88d3:: with SMTP id i19mr5054087iol.194.1590720713435;
        Thu, 28 May 2020 19:51:53 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s84sm4309500ill.5.2020.05.28.19.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:51:52 -0700 (PDT)
Received: (nullmailer pid 1176127 invoked by uid 1000);
        Fri, 29 May 2020 02:51:51 -0000
Date:   Thu, 28 May 2020 20:51:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, mturquette@baylibre.com,
        robh+dt@kernel.org, shc_work@mail.ru, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        festevam@gmail.com, linux-clk@vger.kernel.org, Linux-imx@nxp.com,
        sboyd@kernel.org, devicetree@vger.kernel.org,
        s.trumtrar@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH 5/9] dt-bindings: clock: Convert i.MX23 clock to
 json-schema
Message-ID: <20200529025151.GA1175609@bogus>
References: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
 <1590650879-18288-6-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590650879-18288-6-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 15:27:55 +0800, Anson Huang wrote:
> Convert the i.MX23 clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx23-clock.txt      | 70 -----------------
>  .../devicetree/bindings/clock/imx23-clock.yaml     | 90 ++++++++++++++++++++++
>  2 files changed, 90 insertions(+), 70 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx23-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx23-clock.yaml
> 

Applied, thanks!
