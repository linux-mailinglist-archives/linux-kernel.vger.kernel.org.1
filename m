Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121A02D6E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405032AbgLKDDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:03:34 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42072 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404992AbgLKDDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:03:15 -0500
Received: by mail-oi1-f195.google.com with SMTP id l200so8266999oig.9;
        Thu, 10 Dec 2020 19:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rVA3v//5uFeyzZYgKjyJny/vDnQO/EJzRhd8D8iaejQ=;
        b=tGHxxURFceUNIWu+1IexjktNuzHGJ8/ZKcPo48mNyobobUiXZ9ua6f3K4u5kXDiHoF
         B7vL14EggvIKbkiK7117i6QYWFoskVRsrQGFN+0r42a9nUNGf7+Nhxca/Bb9lAiCAf2p
         qh5ckmeeOrIx15jHEaGTC43iM415nrhwoRfO3dDPHTYAhDdxZLgMYdKdaxZdoWZXE6At
         JTkCnnxTq7R/EQJEZNiC8qPQxBa6LbK2kayml8mJQpdo0FzkUTPyaJMzlnS3UinScMza
         P1RaDkpBDyzVX2DViij+vwBFmWIIFa1T4Pa96mS7mRg+16d6kqycnh4zmfer1UAbRh24
         z1Cw==
X-Gm-Message-State: AOAM5334Nm+NNt3mWatV1HLR7jxn5oovi9iN49C489VGt0qX2qYUz/iw
        B874CiLIO1Gq3xhX1dYbHg==
X-Google-Smtp-Source: ABdhPJwCIQonnSCIfxwOgO8gPt+2/0oE5Zl3IUpntY7Xd98njTzBqZsLFZWiIrcsrQosIMcr8S04Rw==
X-Received: by 2002:aca:dd09:: with SMTP id u9mr7177668oig.73.1607655755070;
        Thu, 10 Dec 2020 19:02:35 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h20sm1546911otj.57.2020.12.10.19.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:02:34 -0800 (PST)
Received: (nullmailer pid 3538020 invoked by uid 1000);
        Fri, 11 Dec 2020 03:02:33 -0000
Date:   Thu, 10 Dec 2020 21:02:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
Cc:     devicetree@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, 'Rob Herring' <robh+dt@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 2/2] Staging: silabs si4455 serial driver: docs device
 tree binding
Message-ID: <20201211030233.GA3536340@robh.at.kernel.org>
References: <20201210122154.GA31799@dincontrollerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201210122154.GA31799@dincontrollerdev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 12:21:56 +0000, József Horváth wrote:
> add: device tree binding schema
> 
> Signed-off-by: József Horváth <info@ministro.hu>
> ---
>  .../bindings/serial/silabs,si4455.yaml        | 53 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  2 files changed, 54 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/silabs,si4455.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/serial/silabs,si4455.example.dts:19.9-14 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/serial/silabs,si4455.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1414082

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

