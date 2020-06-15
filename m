Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DAB1F9D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 18:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbgFOQUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 12:20:05 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35164 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgFOQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:20:03 -0400
Received: by mail-il1-f195.google.com with SMTP id l6so15896349ilo.2;
        Mon, 15 Jun 2020 09:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uvbped+Dn13FUPq8GHew9vUB2jQNtfi2nsvSR22TQ8s=;
        b=O8WwzAdrGJSmRW4kO6ymUFm+5981B07F21evWCILK+R0Zc8iicKlKf5lSshUOtfKu2
         a0SQW3edpRj3hfWnxb2ujFk/P77byVq9AR6NOiO8furkCUXA57kFVAyAuFsaXIr9sGNN
         Hltfj4xW+5rs9z+bw0irA9KC79soHQs8bzz1tlsQ3yEzMnI304bj3XKDiZZ0EaktOIFj
         eKM6yW05BL7H8zyYOGmna9/H5aQ4UZqbaCMdoTCd6OuGKM3DKlEEzluZzkkuiHU3XC2Q
         +4UIHDBW4Ft8pmCgoj9Ehd34xfuZVKootVwU9vs5xz0LaC2UXZTnv4z5wnch2z9oQVf1
         MKhQ==
X-Gm-Message-State: AOAM532f58MD3dEmqFEkpMudDhMA7DTEIcL6GkwDKeIqfW5YejhPdG34
        UTuD7miZToOrMZwjdPQCzQ==
X-Google-Smtp-Source: ABdhPJyWS/sstoBhKxILy/hcjEoOyepMM2wljkSKlbRqyuvaRgoPm9BvD7ypFBgSLyiSfGmJvM3WIg==
X-Received: by 2002:a92:dc89:: with SMTP id c9mr27936223iln.238.1592238002603;
        Mon, 15 Jun 2020 09:20:02 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i10sm8149137ilp.28.2020.06.15.09.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 09:20:02 -0700 (PDT)
Received: (nullmailer pid 1884267 invoked by uid 1000);
        Mon, 15 Jun 2020 16:20:00 -0000
Date:   Mon, 15 Jun 2020 10:20:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Linux-imx@nxp.com, festevam@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        aisheng.dong@nxp.com, linux-clk@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, robh+dt@kernel.org
Subject: Re: [PATCH V2] dt-bindings: clock: Convert imx7ulp clock to
 json-schema
Message-ID: <20200615162000.GA1884157@bogus>
References: <1591234387-15059-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591234387-15059-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jun 2020 09:33:07 +0800, Anson Huang wrote:
> Convert the i.MX7ULP clock binding to DT schema format using json-schema,
> the original binding doc is actually for two clock modules(SCG and PCC),
> so split it to two binding docs, and the MPLL(mipi PLL) is NOT supposed
> to be in clock module, so remove it from binding doc as well.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- add "additionalProperties: false".
> ---
>  .../devicetree/bindings/clock/imx7ulp-clock.txt    | 103 ------------------
>  .../bindings/clock/imx7ulp-pcc-clock.yaml          | 121 +++++++++++++++++++++
>  .../bindings/clock/imx7ulp-scg-clock.yaml          |  99 +++++++++++++++++
>  3 files changed, 220 insertions(+), 103 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-pcc-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-scg-clock.yaml
> 

Applied, thanks!
