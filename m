Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B732A6D50
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbgKDS6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:58:50 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41098 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgKDS56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:57:58 -0500
Received: by mail-oi1-f196.google.com with SMTP id m13so14191581oih.8;
        Wed, 04 Nov 2020 10:57:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D5nJCWrjLgvJLOiVLXj8dcQZ+LEC4p94v1WKcqs0NR0=;
        b=Hny0QiT8QBLN5t76pCJKjPKupGM/UB4dEUAiPeCOq1QsUMXq3c0Z7qmvXKM5Z8ogkt
         OKgSWQbjqYkOmd3bKFVrPSpbp7/y5t6abKe9gARblxQ38ivGbaJAEZlZzJJQQiHmZXYL
         72RnNS3dfbeuXOwqpdYI3b+2pAXE6PsRAF7Q6Fsdq/cHxoQUrj+ESF/pHjYJY1bs5djm
         9qWm4E/M7D9ziwvo1bYytz9cZ9BS4hPCO/tS4UKAeNQqPty+ytSwCjiy64k7EQ2RiTb8
         SCN1EjkjFgs76Cq4t8BZW8pqkRdUhQRsa+No8JB463qlhLDLwePksLTw78TT2GEvWJ/8
         pKiQ==
X-Gm-Message-State: AOAM53329037lbMVn8IDhbycwtR21S628WMRWpWzastP8b9u7MnHOTJX
        8aAgfN07FI2yhEejUGSl/g==
X-Google-Smtp-Source: ABdhPJyhqCu+Trf+max1jMJtRFh0rWYsf0hk0dBZaQe1VhWS5v4jYK/wm7wrL8WPai77xPv0eAqHVg==
X-Received: by 2002:aca:c4c3:: with SMTP id u186mr3574115oif.4.1604516277206;
        Wed, 04 Nov 2020 10:57:57 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 64sm660896otq.26.2020.11.04.10.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 10:57:56 -0800 (PST)
Received: (nullmailer pid 3948698 invoked by uid 1000);
        Wed, 04 Nov 2020 18:57:55 -0000
Date:   Wed, 4 Nov 2020 12:57:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, kernel@axis.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: Add DA9121
Message-ID: <20201104185755.GA3948381@bogus>
References: <20201103100021.19603-1-vincent.whitchurch@axis.com>
 <20201103100021.19603-2-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103100021.19603-2-vincent.whitchurch@axis.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Nov 2020 11:00:20 +0100, Vincent Whitchurch wrote:
> Add bindings for the Dialog Semiconductor DA9121 voltage regulator.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  .../bindings/regulator/dlg,da9121.yaml        | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/regulator/dlg,da9121.yaml


See https://patchwork.ozlabs.org/patch/1392753

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

