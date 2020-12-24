Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8372E2828
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 18:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgLXRCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 12:02:30 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:39722 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgLXRCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 12:02:30 -0500
Received: by mail-oi1-f173.google.com with SMTP id w124so2857767oia.6;
        Thu, 24 Dec 2020 09:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=legzg8I2MAkLelYcw+H6Zk5lbIAyOngzrLsiKEK6Lrw=;
        b=Go5T175Amc8JvDnlmfTHi14mG2hke+CMr7J1D/UTaCRmpZ6yzPyjAiOtPfeGBSHntu
         CRjS9c+g9uWnqAhKgOrE3woYR31bBMkjUPGkxIe0bkK7RCf14etRsTszlwOeqW3r215K
         cAuTr/6hRcgKBC5uK1hnZCXslxr5QNWVgsVWFEV1tPUYAmUNf9mQgdAcGVRLdPVRsO/a
         ZbTcLp23ylBw+vTN7R2aKdognvbtWrHEeDcxx/MDGBQptC6WVJ9uz7pJkYNT2yDK7Z+y
         xZFyiC625vX9bCG5G0VQ7Oa9bTf0bzlLsgR7357cGnOhZqk5G/VLF5AJ86wEjdWB9FXJ
         ghYg==
X-Gm-Message-State: AOAM533g0HpaLtl56tdEQ5MeXBGykI3yfcA10mXZ47A8iXXwQWRjWGg/
        j82upxTsbIeJYhRIiYVaGg==
X-Google-Smtp-Source: ABdhPJz7ArG+puFJXp7jzObW8XbluImuBQTdVYc5NpAO99mYo01wCZwRnNvPbt+g5MmWu0359C5/Sw==
X-Received: by 2002:aca:b657:: with SMTP id g84mr3496457oif.86.1608829309269;
        Thu, 24 Dec 2020 09:01:49 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id c12sm3939360ots.7.2020.12.24.09.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 09:01:48 -0800 (PST)
Received: (nullmailer pid 2966450 invoked by uid 1000);
        Thu, 24 Dec 2020 17:01:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20201223212947.160565-2-paul.kocialkowski@bootlin.com>
References: <20201223212947.160565-1-paul.kocialkowski@bootlin.com> <20201223212947.160565-2-paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v8 1/4] dt-bindings: display: Document the Xylon LogiCVC display controller
Date:   Thu, 24 Dec 2020 10:01:45 -0700
Message-Id: <1608829305.375557.2966449.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 22:29:44 +0100, Paul Kocialkowski wrote:
> The Xylon LogiCVC is a display controller implemented as programmable
> logic in Xilinx FPGAs.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/xylon,logicvc-display.yaml        | 313 ++++++++++++++++++
>  1 file changed, 313 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/xylon,logicvc-display.example.dt.yaml: logicvc@43c00000: 'display@0' does not match any of the regexes: '^gpio@[0-9a-f]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml

See https://patchwork.ozlabs.org/patch/1420307

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

