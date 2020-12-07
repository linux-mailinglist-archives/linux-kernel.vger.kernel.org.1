Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4272D157F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgLGQDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:03:20 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35125 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgLGQDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:03:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id i6so6810159otr.2;
        Mon, 07 Dec 2020 08:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oC8jqcaQ1w2TKQ4DQo9on8EqAASDCUF2kr+D7Fn2XEo=;
        b=IXOHmP1T6rMIyGnTj5bCamZK+qGzEXQIkPbamQY2XCJYC4PAt1Ylg90QyjbrdJIR8u
         9FiWfraYaILLiBsrA+PGvcrcnqG7t6GFeBmPxFk6fvp0RLiUNqYCh2ly76QofFGNw3sa
         ZvdsZ3la2Xuaz4txNwDTuSwD6b5XhDTzMPLiYiHU2tkGfQvuOEsj4GKKfbcTr6oAULj3
         t9LlawTpvYXCUbjuMr2UneObieE8vSF2Wv6f/WaaFTs0xmJPDYPZY3tWcJ/N+hnCLyEA
         cif3TKkAg3hsoMHFhGg/jYFk3akgOF7N52Tlq/vIucSFGBaFIUv8CCiPozA7TE+C7jI2
         y1EA==
X-Gm-Message-State: AOAM533m192hU0GxJUemzWalZcj3Ey6AxnHQqaPDaSwr7ZrG7do0KQ4G
        foStClQHTwgp172nBreVJg==
X-Google-Smtp-Source: ABdhPJzKQSas80qFIijWLD9SpHfai1kZqOIGBjPkVoB4T9MeQHb/atvGMcIMypXRIu3vlnLCsraTLQ==
X-Received: by 2002:a05:6830:18f8:: with SMTP id d24mr12997558otf.44.1607356959303;
        Mon, 07 Dec 2020 08:02:39 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c6sm2980591oif.48.2020.12.07.08.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:02:38 -0800 (PST)
Received: (nullmailer pid 357950 invoked by uid 1000);
        Mon, 07 Dec 2020 16:02:36 -0000
Date:   Mon, 7 Dec 2020 10:02:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     Ryan Carnaghi <ryan.r.carnaghi@intel.com>, peng.fan@nxp.com,
        damien.lemoal@wdc.com, shawnguo@kernel.org,
        paul.walmsley@sifive.com, markgross@kernel.org,
        devicetree@vger.kernel.org, bp@suse.de, arnd@arndb.de,
        dragan.cvetic@xilinx.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        palmerdabbelt@google.com, gregkh@linuxfoundation.org,
        leonard.crestez@nxp.com, corbet@lwn.net
Subject: Re: [PATCH 17/22] xlink-core: Add xlink core device tree bindings
Message-ID: <20201207160236.GA357778@robh.at.kernel.org>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-18-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201223511.65542-18-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Dec 2020 14:35:06 -0800, mgross@linux.intel.com wrote:
> From: Seamus Kelly <seamus.kelly@intel.com>
> 
> Add device tree bindings for keembay-xlink.
> 
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
> Signed-off-by: Ryan Carnaghi <ryan.r.carnaghi@intel.com>
> ---
>  .../bindings/misc/intel,keembay-xlink.yaml    | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml:21:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml


See https://patchwork.ozlabs.org/patch/1409184

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

