Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42053026B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbhAYPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:09:57 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:34998 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbhAYOwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:52:19 -0500
Received: by mail-ot1-f47.google.com with SMTP id 36so12961376otp.2;
        Mon, 25 Jan 2021 06:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=nrCQLfao526o0fGjMW4wVw1VcyPVAh2tkxCsHK4TitQ=;
        b=TDOVeLMIc1AowIfmvkOwg1lK/nLG/mecITBlkRneVPycJTANEwBeHvtDSHM3t4txEj
         x1iWofaO1YGzusurmeUhUwAwH8Uvn+DoXX+pg4z3Uf+wqXOBta5ay0XvLQL4vtFP0vEG
         HFHfytSYrMMyQxoE+nRfRsiK8hPr9cNr00T4CSHjPo3chFn+N17XEh7qMrthtw2A0mzb
         iAhajpok6FYd7D/DzGOeeNm7OVw2vwopiTZUof2AgXqx+gvqsQxn36xmGFzj2j1XBWMO
         +Zq/aDylxGKVqSQk9JMr1JFF8o9dRaPpIWPTQfUPc3a4wyI59eRi8ZNTvU6KhuFr1By0
         l48Q==
X-Gm-Message-State: AOAM530umCyDc16uM4rBZrp2v8HXl08zmUwCqlyALY5piDA9U5y0tLRI
        s380kIWh06wRomqQc0ktpA==
X-Google-Smtp-Source: ABdhPJxcnPbW3xvzEVWoAbGKzh7WdwAOiFUBOnW7V2tkNHJnZk7uCfm+pVVmgMRg18vRSSB0yxYqRA==
X-Received: by 2002:a9d:170a:: with SMTP id i10mr690874ota.179.1611586297781;
        Mon, 25 Jan 2021 06:51:37 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d5sm2003318otc.61.2021.01.25.06.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 06:51:36 -0800 (PST)
Received: (nullmailer pid 327903 invoked by uid 1000);
        Mon, 25 Jan 2021 14:51:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     petre.minciunescu@analog.com, linux-clk@vger.kernel.org,
        sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org
In-Reply-To: <20210124221304.51007-3-alexandru.tachici@analog.com>
References: <20210124221304.51007-1-alexandru.tachici@analog.com> <20210124221304.51007-3-alexandru.tachici@analog.com>
Subject: Re: [PATCH 2/2] dt-bindings: clock: ad9545: Add documentation
Date:   Mon, 25 Jan 2021 08:51:35 -0600
Message-Id: <1611586295.654604.327902.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 00:13:04 +0200, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add dt bindings for ad9545.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../devicetree/bindings/clock/clk-ad9545.yaml | 352 ++++++++++++++++++
>  1 file changed, 352 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/clk-ad9545.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/clock/clk-ad9545.yaml:78:6: [warning] wrong indentation: expected 4 but found 5 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/clk-ad9545.yaml: properties:clocks:maxItems: False schema does not allow 4
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/clk-ad9545.yaml: ignoring, error in schema: properties: clocks: maxItems
warning: no schema found in file: ./Documentation/devicetree/bindings/clock/clk-ad9545.yaml

See https://patchwork.ozlabs.org/patch/1431040

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

