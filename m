Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3101E72BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 04:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405511AbgE2CsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 22:48:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40175 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391547AbgE2CsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:48:13 -0400
Received: by mail-io1-f66.google.com with SMTP id q8so770805iow.7;
        Thu, 28 May 2020 19:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q1m9tKVJmiPkpjVJ9X5DnP4DoNu0eVPvuiZD1HFsVYE=;
        b=YUPUoR73MC2fQydKC4ujfzhRjBEzbIqaEqEJwVI//8laWZBJl8OafvQLZ4gO0cWpDU
         z4tuvpT0uch26cF55+mdTAVFtYknuc27KxXwvF1Otp5VZN8fb+NvI9lBekY4YMKe55xw
         un7ZwggXBj+vBMlV96GAO2ddqO9w1SnNb3p9D/wWsAZwNYsaC4sewHh3bKpb9lS53v9V
         xq1465jW+yRfcHjjUjIfDCqNi8UlRBWm085rohkPJiG6B1IMAlQCC9+F35vmDd6kgiAz
         6AcjJJiPyuRskQWUGyi1+X+1Y5lFBPxa+IEpfNJCtz3xr7++tsq212rhwhOJrq6DDz+U
         NSFw==
X-Gm-Message-State: AOAM531uwVlOtkzjlGdqEfUNI+fEQqMO+lbx7Lfo5wupMYa83cf2CeAB
        1yhzEceW6Pn7zIPP/HPLNOWLPd1snw==
X-Google-Smtp-Source: ABdhPJxWVCmMrK5zSnnEPmpXBj2Pl3iFgBmdHggvP7hCMu0TTF1lMF5Dkq3PsGMR/NV4Qy36bH3Aug==
X-Received: by 2002:a5e:d506:: with SMTP id e6mr5000253iom.184.1590720492161;
        Thu, 28 May 2020 19:48:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r17sm4248768ilc.33.2020.05.28.19.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:48:11 -0700 (PDT)
Received: (nullmailer pid 1170326 invoked by uid 1000);
        Fri, 29 May 2020 02:48:10 -0000
Date:   Thu, 28 May 2020 20:48:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shc_work@mail.ru, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, s.hauer@pengutronix.de, Linux-imx@nxp.com,
        robh+dt@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        s.trumtrar@pengutronix.de, kernel@pengutronix.de,
        shawnguo@kernel.org, festevam@gmail.com, mturquette@baylibre.com
Subject: Re: [PATCH 2/9] dt-bindings: clock: Convert i.MX35 clock to
 json-schema
Message-ID: <20200529024810.GA1169680@bogus>
References: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
 <1590650879-18288-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590650879-18288-3-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 15:27:52 +0800, Anson Huang wrote:
> Convert the i.MX35 clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx35-clock.txt      | 114 -----------------
>  .../devicetree/bindings/clock/imx35-clock.yaml     | 137 +++++++++++++++++++++
>  2 files changed, 137 insertions(+), 114 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx35-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx35-clock.yaml
> 

Applied, thanks!
