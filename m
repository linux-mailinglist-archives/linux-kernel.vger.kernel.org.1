Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54CB20E847
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 00:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgF2WFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 18:05:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37067 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391865AbgF2WFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:05:06 -0400
Received: by mail-io1-f68.google.com with SMTP id v6so5193838iob.4;
        Mon, 29 Jun 2020 15:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/33WwvXDUgobqj85r5L3nzLt5ser+3dcQ28svWATI7k=;
        b=mifdKd076vt1x5Ou7aR4oKqwHs2Fqnn/+OFDNsQXVfa6hHKR4yRnzFX/WQWnyg5rxn
         mkdXsccScyk8qejLl092dkXpTsFrRFeCQoEhB2jXD2R/JDUBkhhs70kaLANQseD/fVwR
         FHR8i+nUTHOdDunZLy5Esm7JsUm4UTILGPjvxarqKQqcIhso8tN0ZnRgss5b2oR9ybd3
         wzYB1ZgspLoAPcOOsFmScLDu7FEZhJNASfDTroEiH3c8wGzwQcvqo1P4zmPQ8FWxykCL
         6t/nLXPfGR0RyGF17614wKs+/06idorQlldid+QdvVUUp+OXC18oX1x8TT9nqV2WhvC5
         c+tg==
X-Gm-Message-State: AOAM5317VzWIU8D6C42s0zlRJCgfXNLpBWtQKb48FCfPst7flQstOf7k
        I1UDQWo45w1TTAUE5PhVjrxOcTbkjw==
X-Google-Smtp-Source: ABdhPJxVuYyuGtstqDJ8HOPThuovY3rPXcwWLAx5FKDmu1o5PgaYcJiB1dyG+EsqAE8S7/Upre6ZQQ==
X-Received: by 2002:a05:6602:2dca:: with SMTP id l10mr18871444iow.163.1593468305897;
        Mon, 29 Jun 2020 15:05:05 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id o19sm543584iob.5.2020.06.29.15.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 15:05:05 -0700 (PDT)
Received: (nullmailer pid 3021658 invoked by uid 1000);
        Mon, 29 Jun 2020 22:05:02 -0000
Date:   Mon, 29 Jun 2020 16:05:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        ulf.hansson@linaro.org, s.trumtrar@pengutronix.de,
        aisheng.dong@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V4 3/3] dt-bindings: clock: Correct example in i.MX8QXP
 LPCG binding
Message-ID: <20200629220502.GA3019731@bogus>
References: <1592450578-30140-1-git-send-email-Anson.Huang@nxp.com>
 <1592450578-30140-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592450578-30140-3-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 11:22:58AM +0800, Anson Huang wrote:
> In i.MX8QXP LPCG binding's example, "fsl,imx7d-usdhc" as fallback
> compatible is incorrect, remove it to avoid below build error:
> 
> Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml:
> mmc@5b010000: compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was unexpected)
> Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml:
> mmc@5b010000: compatible: ['fsl,imx8qxp-usdhc', 'fsl,imx7d-usdhc'] is too long
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch, to fix build error when patch #1 is added.

So, patch 1 should come last. I'll re-order when applying.

Rob
