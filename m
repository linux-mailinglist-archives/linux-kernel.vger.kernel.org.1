Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA83E2A3129
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgKBRQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:16:02 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34541 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKBRQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:16:02 -0500
Received: by mail-oi1-f196.google.com with SMTP id c21so390071oic.1;
        Mon, 02 Nov 2020 09:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DJhMNxXZamIrpg0kzWp8B/V6rtHCtD1wqM+Smkrcy+0=;
        b=Nk7RsEqk6s9o8FxjYSY5Iv0a7rbTn2LuAK/Xf0cjxw18y/hNT7kgr/LT2BXdaZWJLS
         RkgIa/RoRTJxQhO93Mm42zH9LveCR/cUjXUbQACFttSOBbEdpaHyeyx+rjcdcnux9d2G
         iC1SPBNIsyTqQclXdDrkWFA+t9nwquy63BnPmUdN8Pamx6Vo05s5NzoIHXrxlYXl8sf0
         qzNrXIae4Yq19Fz9qhTveomRLvoasWQUdQTjrIOQA3R/PIYJB09AwWrzyRDjt16+tBlG
         LeMvL03vzaQ54WjABUemRfbyd/BtO14YBfZG+o9INslTP6AFavi+2Ou5hJcuGUiN0FkP
         fldA==
X-Gm-Message-State: AOAM531io2YZLvPu/Uif8e+Z6JKrGyRbIwsbX6yZP7FYg9xEAzdGvZA8
        6qFpzCdj9OzzeKV5EULt/w==
X-Google-Smtp-Source: ABdhPJzYQ0ZAxLvXxFHfECWqzCjvhZK3LAQinOKxN35gOPwU5N4c4JSMJ6sES7FN2EoLdD6xLN3qig==
X-Received: by 2002:aca:5110:: with SMTP id f16mr1024894oib.94.1604337361192;
        Mon, 02 Nov 2020 09:16:01 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r24sm248303otq.77.2020.11.02.09.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:16:00 -0800 (PST)
Received: (nullmailer pid 4065376 invoked by uid 1000);
        Mon, 02 Nov 2020 17:15:59 -0000
Date:   Mon, 2 Nov 2020 11:15:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-kernel@vger.kernel.org, aford@beaconembedded.com,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: imx: Add binding doc for spba bus
Message-ID: <20201102171559.GA4063854@bogus>
References: <20201101131257.782279-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101131257.782279-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Nov 2020 07:12:56 -0600, Adam Ford wrote:
> Add binding doc for fsl,spba-bus.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/bus/fsl,spba-bus.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml: duplicate '$id' value 'http://devicetree.org/schemas/bus/simple-pm-bus.yaml#'


See https://patchwork.ozlabs.org/patch/1391735

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

