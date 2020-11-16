Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C4C2B4820
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgKPPBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:01:33 -0500
Received: from mail-oo1-f66.google.com ([209.85.161.66]:39503 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731022AbgKPPBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:01:31 -0500
Received: by mail-oo1-f66.google.com with SMTP id l10so3959457oom.6;
        Mon, 16 Nov 2020 07:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R9UEviXeV1rCp92wR+Tm/LJi3BfQJ2Jz6UOv857MPrI=;
        b=DAnjOz1spXYZnSXDsl7qkirWx6lbOs1FPSxcyVc+z+MziHb5B1fG/iYpz81DlsAKgh
         ZbZuBJRkrxKdKHBeE6EQX5IwI8+lHV+r4QSidiRzC9pxTpVYcpy21N6/qoB/jIcei2fj
         /Ya3mF1XeQjLaQsv6oEbHOUnuRo95BtfJ5opmuKYS3yTwFr2hcKj2rYggKKQfyDzQJEy
         L9JuSDCk2wP9zAHJTeKP9bRLJIer6+oRAYbFO81k6ci9hiij4ZnYZkGCdrFpnVjPmuYN
         WtlihZUO+GNgxijKAZzPWjkJYkAJGkA/uJux31gMfz5QQQ6enCyzDDRibqPVBmvia4TO
         Q1xg==
X-Gm-Message-State: AOAM532F0yDeOKRNH5IfIOnn5xcS93I8y00g/5QCaQQoywsUFILSZOjc
        5fU1r4xa1dSh+Dqi54nrkJeLuOCIfw==
X-Google-Smtp-Source: ABdhPJz3Q8ZtWwqwoKoqJ8DJgQkQSMvokTPqq7g2GQ7VgqFzk5fu9ft/rdmq7jCSS4a+8S89uwA4wA==
X-Received: by 2002:a4a:d5d3:: with SMTP id a19mr3821973oot.61.1605538890565;
        Mon, 16 Nov 2020 07:01:30 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i8sm4703311otl.60.2020.11.16.07.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:01:29 -0800 (PST)
Received: (nullmailer pid 1644751 invoked by uid 1000);
        Mon, 16 Nov 2020 15:01:29 -0000
Date:   Mon, 16 Nov 2020 09:01:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Cyril.Jean@microchip.com, Ivan.Griffin@microchip.com,
        Rob Herring <robh+dt@kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor.Dooley@microchip.com, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] dt-bindings: riscv: microchip: Add YAML
 documentation for the PolarFire SoC
Message-ID: <20201116150129.GA1643948@bogus>
References: <20201113202550.3693323-1-atish.patra@wdc.com>
 <20201113202550.3693323-3-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113202550.3693323-3-atish.patra@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 12:25:48 -0800, Atish Patra wrote:
> Add YAML DT binding documentation for the Microchip PolarFire SoC.
> It is documented at:
> 
> https://www.microsemi.com/products/fpga-soc/polarfire-soc-icicle-quick-start-guide
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  .../devicetree/bindings/riscv/microchip.yaml  | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/microchip.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/riscv/microchip.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/riscv/microchip.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive.yaml: duplicate '$id' value 'http://devicetree.org/schemas/riscv/sifive.yaml#'


See https://patchwork.ozlabs.org/patch/1400088

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

