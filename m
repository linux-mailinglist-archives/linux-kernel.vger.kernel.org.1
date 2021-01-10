Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6912F08A4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 18:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbhAJRTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 12:19:36 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:35390 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbhAJRTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 12:19:35 -0500
Received: by mail-ot1-f44.google.com with SMTP id i6so14745115otr.2;
        Sun, 10 Jan 2021 09:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=cQNxC3w+3NhrDjCMfYMNSQMQtQhc3EKrflhhoBKNSig=;
        b=FGuuuxd5OpVIPezLHbJCMNwWWjWS0VtHJd/vX/Z4Dcp1QTGqCzT+aEA8JjP482V8k8
         3y8pUGIXlpUW/OlBgl2RBjofKxW98Rw8KYLx9sNZ2CFBBPzOli9ccs2AfEJp22VHlE8D
         qZiRdTac/Nkq/89FL26HS1uGY0mlBjZ73ukTzoITx+iimB5abmu3axc3RghuBf2q9QDW
         iEYwG1ArfUZmkXD1FpUYdyJXMyo0KDy4tPHolI5k09iyBJTQs9FsIyisB/kdXbZCqT91
         7YT/od6Mopksdx3BBz0EbzXhTv3p0YOlpAAcxMpqCnhftoD6iQpMAtdIWkquH7euUczw
         St6A==
X-Gm-Message-State: AOAM530nI9g3adE/WkTUNOqyN1vlDBDb7Q+ElnyBTeYgqnl2dse7t0JQ
        QJz91RsyDwwcj/i67W4a6g==
X-Google-Smtp-Source: ABdhPJz2ZjTBbFaRCwgUWSJmfd4zFHjO0nJAxK8JqdKkEtFgHLzulWRhcxCHfcCD9yBsma3QI+OIcw==
X-Received: by 2002:a9d:7cc9:: with SMTP id r9mr9154962otn.283.1610299134014;
        Sun, 10 Jan 2021 09:18:54 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s66sm2832116ooa.37.2021.01.10.09.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 09:18:53 -0800 (PST)
Received: (nullmailer pid 785273 invoked by uid 1000);
        Sun, 10 Jan 2021 17:18:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     Seamus Kelly <seamus.kelly@intel.com>, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, markgross@kernel.org,
        damien.lemoal@wdc.com, palmerdabbelt@google.com, corbet@lwn.net,
        paul.walmsley@sifive.com, shawnguo@kernel.org, peng.fan@nxp.com,
        jassisinghbrar@gmail.com, dragan.cvetic@xilinx.com,
        Ryan Carnaghi <ryan.r.carnaghi@intel.com>, bp@suse.de,
        leonard.crestez@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210108212600.36850-18-mgross@linux.intel.com>
References: <20210108212600.36850-1-mgross@linux.intel.com> <20210108212600.36850-18-mgross@linux.intel.com>
Subject: Re: [PATCH v2 17/34] xlink-ipc: Add xlink ipc device tree bindings
Date:   Sun, 10 Jan 2021 11:18:45 -0600
Message-Id: <1610299126.003891.785272.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jan 2021 13:25:43 -0800, mgross@linux.intel.com wrote:
> From: Seamus Kelly <seamus.kelly@intel.com>
> 
> Add device tree bindings for the xLink IPC driver which enables xLink to
> control and communicate with the VPU IP present on the Intel Keem Bay
> SoC.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
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

See https://patchwork.ozlabs.org/patch/1423958

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

