Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32672F08A9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 18:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbhAJRTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 12:19:40 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:33912 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbhAJRTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 12:19:39 -0500
Received: by mail-ot1-f50.google.com with SMTP id a109so14755781otc.1;
        Sun, 10 Jan 2021 09:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=zQwG5dyF5iJUndptOnklBRT7xrYLrcEjcyX/bf4EqN8=;
        b=MLc4W5KDL+htGIf3XsHr/Bt2Bgocqhuzpf9FTQR0o6kdP/FeMGoyCAzlcRAj+5iG62
         FKBTFS1tckeY9R+LAnJGsfLzqeJja5kUYZUlm6HJKYZNf7HxM7n9B5qjy8gOoozihdiN
         9/H0v8QZJyMsmsjB7nnrZ8TZwmecZJ7ktx107LuTHed8nezPfUvCCwjiUT0xL+YDvQ0e
         cvxIB0Hw+7JcwOBLXz4E2zo06TD5u6rghlMPyD8hrAuwx0PhzImubZ4dyLtMw+4fdUzC
         IBCSrKl48dLr0o1Sf8tknj7ht0kfynXCd37ONYE3Nv4dBl8j5HWN89CwhWuvlJKzfQuS
         MhYg==
X-Gm-Message-State: AOAM530XouzTBaYUX2PnYIIjnjpUarEqKBHu2Vna/L8SxFroOdOx1OcD
        ekuCQU4kDLjba754a04Pwg==
X-Google-Smtp-Source: ABdhPJzmMnGx2c5kW7iva0HJ1B54FHuVRheIWZax3TKcCQpjW30hBMgR4QGURnCyAkXwRbCGtE6u5w==
X-Received: by 2002:a9d:bb2:: with SMTP id 47mr9127425oth.122.1610299138380;
        Sun, 10 Jan 2021 09:18:58 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e10sm3040296otl.38.2021.01.10.09.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 09:18:57 -0800 (PST)
Received: (nullmailer pid 785275 invoked by uid 1000);
        Sun, 10 Jan 2021 17:18:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     paul.walmsley@sifive.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>, markgross@kernel.org,
        damien.lemoal@wdc.com, palmerdabbelt@google.com, corbet@lwn.net,
        peng.fan@nxp.com, arnd@arndb.de, dragan.cvetic@xilinx.com,
        leonard.crestez@nxp.com, bp@suse.de, shawnguo@kernel.org,
        jassisinghbrar@gmail.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, Ryan Carnaghi <ryan.r.carnaghi@intel.com>
In-Reply-To: <20210108212600.36850-20-mgross@linux.intel.com>
References: <20210108212600.36850-1-mgross@linux.intel.com> <20210108212600.36850-20-mgross@linux.intel.com>
Subject: Re: [PATCH v2 19/34] xlink-core: Add xlink core device tree bindings
Date:   Sun, 10 Jan 2021 11:18:46 -0600
Message-Id: <1610299126.012552.785274.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jan 2021 13:25:45 -0800, mgross@linux.intel.com wrote:
> From: Seamus Kelly <seamus.kelly@intel.com>
> 
> Add device tree bindings for keembay-xlink.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
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

See https://patchwork.ozlabs.org/patch/1423961

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

