Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172DD2E2CB7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 01:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgLZARf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 19:17:35 -0500
Received: from mail-oo1-f52.google.com ([209.85.161.52]:41828 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgLZARe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 19:17:34 -0500
Received: by mail-oo1-f52.google.com with SMTP id q6so1127974ooo.8;
        Fri, 25 Dec 2020 16:17:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zOHx7r8bUBdtp0nmUurNuEgdm3BgirvRBP8EZaKtUo8=;
        b=RqMb0Dx8RWd8oBZtRcZZu5kq7ESNsV/cHdeSOLe8WF8NBgzqgbGwsft1MJNbhLW46z
         arH6MqeGEFznB3rmDxfmyltKhRrg1JNcpGD1zvF90+WmmocV1ZBRAwI6OVutGawUGd4E
         UNsg2mM/2Lt/KnAFMalr6dVTLOIULHgjQXruOVUUeYdP23Rx7uFuiGHA3z9Jy8qi8U2Y
         Pn00wccL0meKJOqcYwH9adFEbs27ng6O6Dpe2PhEVWxERNGdbIFGQp0eO8g9OWKXw8O2
         B8vTHlD+gMh43Woco/Q0cikMpH/Q1afM/ylTUHIn6zAwj9crg02l3m0b+uM9lNFTsPti
         6LSA==
X-Gm-Message-State: AOAM531BzXr2Ui3RUgD9+PnxjfbL3SNIqo1niPuwp/yod3ffX8esTD0v
        cFqB2l06CkWhVRQF6pvreQ==
X-Google-Smtp-Source: ABdhPJzmiUegrby/ih3TTnHOVg6dB9Qgxi/9GJxGsOTIVe68coS6CJWRwWQF/j1vMvrKvrGuzp09Cw==
X-Received: by 2002:a4a:a88a:: with SMTP id q10mr25045349oom.27.1608941813745;
        Fri, 25 Dec 2020 16:16:53 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r204sm8272186oif.0.2020.12.25.16.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 16:16:53 -0800 (PST)
Received: (nullmailer pid 1641376 invoked by uid 1000);
        Sat, 26 Dec 2020 00:16:49 -0000
Date:   Fri, 25 Dec 2020 17:16:49 -0700
From:   Rob Herring <robh@kernel.org>
To:     Nick Fan <Nick.Fan@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        dri-devel@lists.freedesktop.org, srv_heupstream@mediatek.com,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: Convert Arm Mali Valhall GPU to DT
 schema
Message-ID: <20201226001649.GA1641257@robh.at.kernel.org>
References: <20201224123119.26504-1-Nick.Fan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224123119.26504-1-Nick.Fan@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Dec 2020 20:31:18 +0800, Nick Fan wrote:
> Convert the Arm Valhall GPU binding to DT schema format.
> 
> Define a compatible string for the Mali Valhall GPU
> for Mediatek's SoC platform.
> 
> Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>
> ---
>  .../bindings/gpu/arm,mali-valhall.yaml        | 252 ++++++++++++++++++
>  1 file changed, 252 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/gpu/arm,mali-valhall.yaml#

See https://patchwork.ozlabs.org/patch/1420519

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
