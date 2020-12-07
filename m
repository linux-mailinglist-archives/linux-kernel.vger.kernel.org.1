Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD132D1551
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgLGP6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:58:09 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43322 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgLGP6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:58:09 -0500
Received: by mail-oi1-f193.google.com with SMTP id q25so7786734oij.10;
        Mon, 07 Dec 2020 07:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=onaHdKCsWOlOQVTdXMBF53sCUCt5ldvhTQu+6oWqXis=;
        b=oBsNx7CpHs8HRg/ndzaz5hFXL0QW4ofnMpKX8KIG0/YsFcLFzrMHZoLRAFDJL2raHh
         h78IdfmMHEFd3iQ/9DDS8WVCfFverh/bRI4BAdliT0seTZv+m1ENiL5+yLrfdvCU3n8y
         LeBylyl6zjFIVRXVAjeu/8HZtNMDSEAKOnojegB/DFIClDp/+brBhhRBWvECb4Tpfec1
         kN9sC7FFa2psq+Hzs6ri1B9XVeElN6sB2rO4Ev7oiYnVQ7OPgAr4xOXfZ+hpCGA6bTd1
         ifGPiS5J9W3rop4fvu87exswMdWmiochMp8AsxfpaEhAwbTVmAzS1BwJn57ymalUpRGE
         WRsA==
X-Gm-Message-State: AOAM532q3he5XuI56X3l0yaHZ7fZDlkKIvlD6f8a3fjlEP9jCU158hxu
        Zd9efIeyjLyafHqfGGRVhw==
X-Google-Smtp-Source: ABdhPJzHrPlpTNna15h5lC5ZlV/dy/hBQ4EaoEEKLS3bq6lqRgplSDkr7Cmkzg5p0kMn53yibQu6Tg==
X-Received: by 2002:aca:cc17:: with SMTP id c23mr2969517oig.80.1607356648343;
        Mon, 07 Dec 2020 07:57:28 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m47sm2637696ooi.12.2020.12.07.07.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 07:57:27 -0800 (PST)
Received: (nullmailer pid 350816 invoked by uid 1000);
        Mon, 07 Dec 2020 15:57:26 -0000
Date:   Mon, 7 Dec 2020 09:57:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     damien.lemoal@wdc.com, leonard.crestez@nxp.com,
        Paul Murphy <paul.j.murphy@intel.com>,
        dragan.cvetic@xilinx.com, markgross@kernel.org, robh+dt@kernel.org,
        corbet@lwn.net, devicetree@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        arnd@arndb.de, palmerdabbelt@google.com, bp@suse.de,
        shawnguo@kernel.org, peng.fan@nxp.com, gregkh@linuxfoundation.org,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/22] dt-bindings: Add bindings for Keem Bay VPU IPC
 driver
Message-ID: <20201207155726.GA350430@robh.at.kernel.org>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-5-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201223511.65542-5-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Dec 2020 14:34:53 -0800, mgross@linux.intel.com wrote:
> From: Paul Murphy <paul.j.murphy@intel.com>
> 
> Add DT bindings documentation for the Keem Bay VPU IPC driver.
> 
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Paul Murphy <paul.j.murphy@intel.com>
> Co-developed-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> ---
>  .../soc/intel/intel,keembay-vpu-ipc.yaml      | 151 ++++++++++++++++++
>  1 file changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml:21:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml


See https://patchwork.ozlabs.org/patch/1409183

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

