Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3A22D155E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgLGP65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:58:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43295 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLGP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:58:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id q25so1082550otn.10;
        Mon, 07 Dec 2020 07:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=voI/5OCID9h7T7s4ztgsU/7R03t2LV7/eDN1pq5mjMQ=;
        b=XSBFJMjbsSmliZVSkGK4Ywujqn17HurPnbOLr7Xn3O2gVEZ/oC9d6CFqr/LEVNAoSj
         BZMo/GZsOSzpXFjzpORVxK0HIUlBs0/lcJFoA3f75TIAcq+vk81BTHE8M1+SDNUtJKVz
         ujcR4OTJzJCAhFq+F/wL051R9dGuc8Bz4Az3FvP+wS/bBaTuQ5NEPjiQmUCpjnnTaVr0
         DH+nfEgr6+vTBMvxRZwJvzP7knJwvnskw40xY/rgGZLM7556Sq1xetvzWOnqbI/NcndL
         RdlpcOD+FZRHsldP4jPntH/A+QO7OPweDqTxVVVM2evDXUi99RkAQRAE/Y/oYAi3QBFF
         wPkA==
X-Gm-Message-State: AOAM533iFYobSJP41yzLifzNrnTORTJtIsyjmwAtEdSVgooyYFWq6FU/
        g9dJRs95UxRS/4BNaFJfHg==
X-Google-Smtp-Source: ABdhPJwsTYZ1hdmjDHYLEIVeZZNqxdDUzmiscVda2Gg1Hc1oYsqolaJGXGJG8/9tOVN80FxnOK9w+g==
X-Received: by 2002:a9d:5381:: with SMTP id w1mr13279853otg.7.1607356696000;
        Mon, 07 Dec 2020 07:58:16 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v5sm2672942oob.40.2020.12.07.07.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 07:58:15 -0800 (PST)
Received: (nullmailer pid 351998 invoked by uid 1000);
        Mon, 07 Dec 2020 15:58:14 -0000
Date:   Mon, 7 Dec 2020 09:58:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     robh+dt@kernel.org, leonard.crestez@nxp.com,
        gregkh@linuxfoundation.org, palmerdabbelt@google.com,
        devicetree@vger.kernel.org,
        Ryan Carnaghi <ryan.r.carnaghi@intel.com>,
        Seamus Kelly <seamus.kelly@intel.com>, arnd@arndb.de,
        damien.lemoal@wdc.com, markgross@kernel.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, dragan.cvetic@xilinx.com,
        shawnguo@kernel.org, paul.walmsley@sifive.com, bp@suse.de,
        peng.fan@nxp.com
Subject: Re: [PATCH 15/22] xlink-ipc: Add xlink ipc device tree bindings
Message-ID: <20201207155814.GA351233@robh.at.kernel.org>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-16-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201223511.65542-16-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Dec 2020 14:35:04 -0800, mgross@linux.intel.com wrote:
> From: Seamus Kelly <seamus.kelly@intel.com>
> 
> Add device tree bindings for the xLink IPC driver which enables xLink to
> control and communicate with the VPU IP present on the Intel Keem Bay
> SoC.
> 
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
> Signed-off-by: Ryan Carnaghi <ryan.r.carnaghi@intel.com>
> ---
>  .../misc/intel,keembay-xlink-ipc.yaml         | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml:21:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml


See https://patchwork.ozlabs.org/patch/1409186

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

