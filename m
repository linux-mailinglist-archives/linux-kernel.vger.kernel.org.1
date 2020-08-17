Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDF32478F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 23:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgHQViB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 17:38:01 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43460 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHQViA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:38:00 -0400
Received: by mail-il1-f196.google.com with SMTP id e11so7869515ils.10;
        Mon, 17 Aug 2020 14:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bR82rNL4yqjtWxgtLaqjAthZz9IraEgjUWKkJ1P0xIk=;
        b=buZcVYG8PnyYuICs+rdo4lUdoj+aSVgJgL2CM/fGuiMqJnOpgHM08T7owQQ14gTLpd
         UoeAua8yo/1ZQcZVVXr912v0N5g4mRonZ9GvoZG3mm0eoZbjKPYZrIYDcDDojOgiomcz
         Tca21cmxJUqnBK1xmKt/LAnMjHeSH92OXF0DUdO2I+eeJhnLwMY2fZrrCqDaZGRpy0mH
         eSae9E9ByAhw6yPxmgzxT+kbO7Nr4a3S90hKiPgpUtKDTeqd01mU7iiV1UjY3/HmrXsT
         EUj5GH/wUUT9x1JbSM2AiwPwznTbi2fCjBVSLtLhD2ybLXnhv6mwkXnI5ck7b6s6PuUt
         Gq0A==
X-Gm-Message-State: AOAM533Fmk1L+42sffwe2aBtEXRlfEoaLnxcqQFE/n6E86k6qf4zOWOn
        54LDjB5RubvriTXl8wbruw==
X-Google-Smtp-Source: ABdhPJx1AtYHLtHhsASwdPVfW8dhw5e/RniENH9qBgdvo4sf+aZCjqM66Tln6WWQui3HEb4LQN82pQ==
X-Received: by 2002:a92:6c09:: with SMTP id h9mr9660936ilc.46.1597700279449;
        Mon, 17 Aug 2020 14:37:59 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id w22sm9670417ioc.24.2020.08.17.14.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:37:59 -0700 (PDT)
Received: (nullmailer pid 1612265 invoked by uid 1000);
        Mon, 17 Aug 2020 21:37:57 -0000
Date:   Mon, 17 Aug 2020 15:37:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     festevam@gmail.com, aisheng.dong@nxp.com, robh+dt@kernel.org,
        Linux-imx@nxp.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de
Subject: Re: [PATCH 2/2] dt-bindings: fsl: Convert i.MX7ULP SIM to json-schema
Message-ID: <20200817213757.GA1612179@bogus>
References: <1596595841-27563-1-git-send-email-Anson.Huang@nxp.com>
 <1596595841-27563-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596595841-27563-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Aug 2020 10:50:41 +0800, Anson Huang wrote:
> Convert the i.MX7ULP SIM binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,imx7ulp-sim.txt     | 16 ----------
>  .../bindings/arm/freescale/fsl,imx7ulp-sim.yaml    | 36 ++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.yaml
> 

Applied, thanks!
