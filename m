Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25756234D74
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 00:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgGaWWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 18:22:06 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39745 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaWWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:22:06 -0400
Received: by mail-io1-f65.google.com with SMTP id z6so33206946iow.6;
        Fri, 31 Jul 2020 15:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ADzBuOiLZyEIMSgEuT6sp61hm3Ua1v/+hcd4W8y8a/I=;
        b=I+8jftqh/yuTal0QSmCkKY8kCrUXwEvbzxIr/5YqheLopfWcmQOVwQE1iQMNVGbvJ4
         TKRf5VBoSXBP85Y89IUyxKYNJmL7ShdfiKVLrQrWmvNO2z6AMEbX0nl++xaIsqoi5hrJ
         qhmztjb55ojrMC3Xzja6FtzDjVAVJMm+JjMKioKU2S/aLSl2diT62gAcKiMOJJqanGZH
         J0bos9bfF/e9GVSm0VegV1EKyswbUMNzbE1x6F8Fwk4zYrEs/q4bQI9mj7EO2ROFOeI9
         fWOtvriTx/zUr+KEvmKQp5vmWaCn496omhYMZqIZs+UZlGy1355ih03mPMlpzjog6WAH
         Av5Q==
X-Gm-Message-State: AOAM5338RVzRYJt5wc9MQonOUpdqXXYZ2RFNYsKDA/fylbH/0lHIaOdo
        3IhHgPznQLoQMfYqwYBQzQ==
X-Google-Smtp-Source: ABdhPJxwKhKvxWj5rySzDy66QWUUqepkReUUmQ0Jekt1Dp956WSN37NUUetb2fGKNF9K0/bu7hSq9w==
X-Received: by 2002:a02:a584:: with SMTP id b4mr7074517jam.68.1596234125215;
        Fri, 31 Jul 2020 15:22:05 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p26sm5763684ill.76.2020.07.31.15.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:22:04 -0700 (PDT)
Received: (nullmailer pid 908895 invoked by uid 1000);
        Fri, 31 Jul 2020 22:22:03 -0000
Date:   Fri, 31 Jul 2020 16:22:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     linux-clk@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fugang Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 03/17] dt-bindings: clock: imx8mp: Add ids for the audio
 shared gate
Message-ID: <20200731222203.GA908813@bogus>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
 <1596024483-21482-4-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596024483-21482-4-git-send-email-abel.vesa@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 15:07:49 +0300, Abel Vesa wrote:
> All these IDs are for one single HW gate (CCGR101) that is shared
> between these root clocks.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  include/dt-bindings/clock/imx8mp-clock.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
