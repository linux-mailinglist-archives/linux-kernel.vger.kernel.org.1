Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C32C2E31FA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 17:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgL0Q5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 11:57:12 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:35109 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgL0Q5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 11:57:12 -0500
Received: by mail-ot1-f47.google.com with SMTP id i6so7402728otr.2;
        Sun, 27 Dec 2020 08:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=zOHx7r8bUBdtp0nmUurNuEgdm3BgirvRBP8EZaKtUo8=;
        b=qUSmAVR2brO5w8O5XkgiQTG5usAPiv9X4SL6T1d4gvOScwM0wYu2lcjuLmcYQJetLp
         +jMOt29Hi0/DzSo9WKPlC8Y9b/bw9tB8tcxUVN8MS0qJhNtKNQPzBxBUzTxPK2Pbu3Sg
         IIBNwTOLKxq4/+bC20vM1LqYni6zMA+fOq80LZGK6fGF4xDinXVqe+0YtbpW9d8dKj6S
         qdL07qA+twhLS00of6YNad5EajyxRYX+JrVsrTVl3V/jamFH/SAFBnjf5qupTzkJlNAI
         AC+quriOQVET+5MmekHugYfL4FU93U4NO8rJARuVGI8l3F1ZD89DU9qKXcelsybpb+nw
         6LOQ==
X-Gm-Message-State: AOAM532HXA1kSSLDbycmw8NGVxleLQpIc3WGi6TLNVY3c/ule+BLadP0
        aWF1bY/rUjzFvI0xJjYYx2423kMbTQ==
X-Google-Smtp-Source: ABdhPJzjfapIxx697lofhNlLTsEkycfgDUBiDloMLI4cPPgY1p1lUj/Z+HubGl8e9Xsc57xtzgW1hQ==
X-Received: by 2002:a9d:27e9:: with SMTP id c96mr29709334otb.15.1609088191057;
        Sun, 27 Dec 2020 08:56:31 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g92sm8621100otb.66.2020.12.27.08.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 08:56:30 -0800 (PST)
Received: (nullmailer pid 1338172 invoked by uid 1000);
        Sun, 27 Dec 2020 16:56:21 -0000
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
In-Reply-To: <20201224123119.26504-1-Nick.Fan@mediatek.com>
References: <20201224123119.26504-1-Nick.Fan@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: Convert Arm Mali Valhall GPU to DT schema
Date:   Sun, 27 Dec 2020 09:56:21 -0700
Message-Id: <1609088181.485721.1338171.nullmailer@robh.at.kernel.org>
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

