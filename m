Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBDF1E72D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 04:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391639AbgE2CwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 22:52:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39464 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389013AbgE2CwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:52:17 -0400
Received: by mail-io1-f65.google.com with SMTP id c8so785244iob.6;
        Thu, 28 May 2020 19:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dYzhLoTll3frc3jvIhj6ziGjQdgJ1GYKRhqt1bvGoRU=;
        b=oaR8ZJf5Mak89dnwr9h8OD/USfj8O0ROCT6zQFTcvPYXZK2wdAIK9R2O9O1JPO0eu4
         6mIpXX5UyxW4pCHrkSSryEF7zn3FmQWg2hDwK7P+3ApDicDqZJ+OCq3dWYhqIKX685sV
         2fac0fupuQ3XHYDBRVyzz77q7B/0ixHg7HlzSFDEHv4whIk63EzpHVEC5uLwNgcY76oy
         F8oj7Typps+dMtLGrPukKqxa47T0KWbtn92lq0mBURKftJ6HvokTXbIQFvdBSEnyJ9Na
         qlgO/cTC6xXF9WcLAnvwjsvlLDqv2UnzKK7r2iQJKYlwvu8tYtvs2PoZR6mRa1+bu/yl
         0IGQ==
X-Gm-Message-State: AOAM532m6drFVVZdZYsiHiHtv/wrZJntjs/3PO3mMLqICcRXfndmS452
        Kc2KvJnFcSe1n+tMgIgUTg==
X-Google-Smtp-Source: ABdhPJxiE/37cei3ZpDYnIjOZrdQ0I7nL29YYsTPAhqWW70ml289YeYIcvVhAX9hwi5FSI8e4xbAAQ==
X-Received: by 2002:a6b:1543:: with SMTP id 64mr5090541iov.123.1590720736453;
        Thu, 28 May 2020 19:52:16 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id o15sm4088313ilg.46.2020.05.28.19.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:52:16 -0700 (PDT)
Received: (nullmailer pid 1176859 invoked by uid 1000);
        Fri, 29 May 2020 02:52:14 -0000
Date:   Thu, 28 May 2020 20:52:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        festevam@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        shawnguo@kernel.org, Linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, s.trumtrar@pengutronix.de,
        kernel@pengutronix.de, shc_work@mail.ru, mturquette@baylibre.com,
        s.hauer@pengutronix.de
Subject: Re: [PATCH 6/9] dt-bindings: clock: Convert i.MX27 clock to
 json-schema
Message-ID: <20200529025214.GA1176812@bogus>
References: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
 <1590650879-18288-7-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590650879-18288-7-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 15:27:56 +0800, Anson Huang wrote:
> Convert the i.MX27 clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx27-clock.txt      | 27 -----------
>  .../devicetree/bindings/clock/imx27-clock.yaml     | 53 ++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx27-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx27-clock.yaml
> 

Applied, thanks!
