Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D578E2FA57F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405880AbhARQCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:02:23 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:37546 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405872AbhARPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:47:46 -0500
Received: by mail-oi1-f175.google.com with SMTP id r189so8448633oih.4;
        Mon, 18 Jan 2021 07:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=i2fXl5nr8dRcreMh5NWEXvw6/KX/mVOXwAbBHxbOFbU=;
        b=PWN+FZnl5ZIrwWVwDc2R8PU43tkiTrUai7Rk4XoMB7DMkLYr7kV7Zdti40/yKYYBC4
         kJHpmNzaevYuk3g8SHw57/kw9esZSs0HJZOtz99Fwno3pZloic4FXVVvH+xNRyuSYWrD
         SX/pRRt014X/W6PYFonA4CGF6vhSErBH9wYnYXXpEbneaNgL0OfdfVG7LKwpCEyt491t
         kfg3dlEYBhnmp4uvVqJGJt+UrNCHB+ChJ7BPkLHlngGhNv0HlNF/6+z88k3zCNn/eURB
         6rNYbWqPthCmsBMrRrNzl4SnsnamxViB2IHYXKDWhESH1K5dut3A6fYnDpI3PSoii2A+
         k5nA==
X-Gm-Message-State: AOAM530EJzNij5D8mR59qUSECFLmO01oKV70NfPuGb8AHU255McENxzM
        DjNdopg+pno7LwjEzwSNyg==
X-Google-Smtp-Source: ABdhPJxazd83doE5xsvnsVKmOvEkkXqEk74obX4VH4gMN2jv/AJP7Nx800PQsBoqL5EsLGWP+lcPKA==
X-Received: by 2002:a54:4401:: with SMTP id k1mr8648825oiw.145.1610984825265;
        Mon, 18 Jan 2021 07:47:05 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t19sm4005018otp.36.2021.01.18.07.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 07:47:04 -0800 (PST)
Received: (nullmailer pid 3984434 invoked by uid 1000);
        Mon, 18 Jan 2021 15:47:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     devicetree@vger.kernel.org, kernel@pengutronix.de,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, alistair23@gmail.com, lgirdwood@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org
In-Reply-To: <20210117042539.1609-1-alistair@alistair23.me>
References: <20210117042539.1609-1-alistair@alistair23.me>
Subject: Re: [PATCH 1/6] devicetree/bindings: Initial commit of silergy,sy7636a.yaml
Date:   Mon, 18 Jan 2021 09:47:02 -0600
Message-Id: <1610984822.698513.3984433.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jan 2021 20:25:34 -0800, Alistair Francis wrote:
> Initial support for the Silergy SY7636A Power Management chip
> driver.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  .../bindings/mfd/silergy,sy7636a.yaml         | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/mfd/silergy,sy7636a.yaml#

See https://patchwork.ozlabs.org/patch/1427906

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

