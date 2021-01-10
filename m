Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356372F089C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 18:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbhAJRT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 12:19:29 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:37845 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbhAJRT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 12:19:29 -0500
Received: by mail-oi1-f172.google.com with SMTP id l207so17706734oib.4;
        Sun, 10 Jan 2021 09:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=F//JdTlnoCOz7aCw0BOV3Lcolb8sAFjfgFTOj6tIyNo=;
        b=Tb3u2hhpwVU9x2NATdtYvOxF6G5MovABdkawTmBq3/aNg3JcjOYVdT9B8ghYgOCiLe
         VufOKYxW63QxUqGpUgAdaRSECG7IPC4BdcIshVHm0RyGQ3JjuPftocUTzMEfxaRg/b7w
         ophMhs47bzydL5C4s1Velvtm/JMVi3rITc1w9uG5XICMavBu2rMuS6gw0e6qlsjrBqZr
         1BZlFhW1jBXzGDp66EGtud61pgxLhPmUksPXRuCJQl0gJ6mv3m7UlLwCZU2FRLxdW5eM
         ERbTnbzkqGNaF2JAzH5TPQ8dV22cgJO86n6SFtQnHXLB7rMujn2n78ArCSWjdjSlMIZ8
         lkIg==
X-Gm-Message-State: AOAM530vgULDbr7B4QRKLPelKRo1oTWDI2/yBLq/ODr37W7nRpFw19Ov
        yWkzB63xwbrTwO0oBBeP5Q==
X-Google-Smtp-Source: ABdhPJz1YITLmeT/RQJhbDMQMgO2iA+7o7KWdVgS0dt73PQj2h5m3tHklZB+11wAOUhsqnKL3pP2Pg==
X-Received: by 2002:aca:a9c8:: with SMTP id s191mr8410224oie.11.1610299128243;
        Sun, 10 Jan 2021 09:18:48 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m7sm2827924ool.29.2021.01.10.09.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 09:18:47 -0800 (PST)
Received: (nullmailer pid 785270 invoked by uid 1000);
        Sun, 10 Jan 2021 17:18:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     markgross@kernel.org, dragan.cvetic@xilinx.com, bp@suse.de,
        Paul Murphy <paul.j.murphy@intel.com>,
        paul.walmsley@sifive.com, arnd@arndb.de,
        devicetree@vger.kernel.org, damien.lemoal@wdc.com,
        leonard.crestez@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        linux-kernel@vger.kernel.org, palmerdabbelt@google.com,
        corbet@lwn.net, peng.fan@nxp.com, gregkh@linuxfoundation.org,
        jassisinghbrar@gmail.com
In-Reply-To: <20210108212600.36850-7-mgross@linux.intel.com>
References: <20210108212600.36850-1-mgross@linux.intel.com> <20210108212600.36850-7-mgross@linux.intel.com>
Subject: Re: [PATCH v2 06/34] dt-bindings: Add bindings for Keem Bay VPU IPC driver
Date:   Sun, 10 Jan 2021 11:18:45 -0600
Message-Id: <1610299125.992252.785269.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jan 2021 13:25:32 -0800, mgross@linux.intel.com wrote:
> From: Paul Murphy <paul.j.murphy@intel.com>
> 
> Add DT bindings documentation for the Keem Bay VPU IPC driver.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Paul Murphy <paul.j.murphy@intel.com>
> Co-developed-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> ---
>  .../soc/intel/intel,keembay-vpu-ipc.yaml      | 153 ++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml:21:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

See https://patchwork.ozlabs.org/patch/1423960

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

