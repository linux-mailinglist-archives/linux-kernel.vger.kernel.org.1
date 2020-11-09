Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF45A2AC021
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 16:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgKIPnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 10:43:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34963 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgKIPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 10:43:33 -0500
Received: by mail-oi1-f194.google.com with SMTP id c80so10653796oib.2;
        Mon, 09 Nov 2020 07:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vmPHdNO2V3xVagdFRruugzUwa4mox3r4vQd+uFULzzw=;
        b=RrHCMzzdlSBmDLde6diR1H36dLY6H2YLvxkQXF/cQC2UR9nNTf/U2OddO6udp16iiA
         UW8AGTaBY7ARuIJj6nBl02p20byr4uhaoM27ed0fF1Qxc4qP72cqDs0mljbuqEfr0ds6
         N260Qx504FiWvWKxST11DX1k3cEopJCS31JaiFGL3YFlnHV79bRRg81CLk2KnfE6fMP+
         aQvVfWyswvDA5nD7ZqtWTRVkav/grIb3TZUEWpY1Ar5hX3S7vSxkkN4GPPJNlGSiZfYx
         1apeV+RdL1IaNpgEhMSFVOfW2NdTK01JigidxYdLKT5NGuAZ0WLIOe40Jbkvo3ReSz2I
         i0fQ==
X-Gm-Message-State: AOAM533pHAMCoAYx7eH0L6pRuNKU8PKgOTB1ScNWivpb3+JKn/xxL725
        ADu8/+soh6qKD3tp/j0hIA==
X-Google-Smtp-Source: ABdhPJxsJMnZlM8cAmgzrjW2o+B/SEhk2NbAJOapmL1tBceQyHQk9y349zXQ+hMtx1DpCM0G7yaJVA==
X-Received: by 2002:aca:3882:: with SMTP id f124mr8819448oia.111.1604936612223;
        Mon, 09 Nov 2020 07:43:32 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m17sm2570898otq.57.2020.11.09.07.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 07:43:31 -0800 (PST)
Received: (nullmailer pid 1343597 invoked by uid 1000);
        Mon, 09 Nov 2020 15:43:30 -0000
Date:   Mon, 9 Nov 2020 09:43:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shane Chien <shane.chien@mediatek.com>
Cc:     wsd_upstream@mediatek.com, chipeng.chang@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, jiaxin.yu@mediatek.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/2] dt-bindings: mediatek: mt6359: Add new property
 for mt6359
Message-ID: <20201109154330.GA1343292@bogus>
References: <1604914209-9174-1-git-send-email-shane.chien@mediatek.com>
 <1604914209-9174-3-git-send-email-shane.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604914209-9174-3-git-send-email-shane.chien@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Nov 2020 17:30:09 +0800, Shane Chien wrote:
> From: "Shane.Chien" <shane.chien@mediatek.com>
> 
> This patch add "LDO_VAUD18-supply" property to
> control vaud18 regulator. It is labeled as required
> due to mt6359 audio path always need to enable vaud18.
> 
> Signed-off-by: Shane.Chien <shane.chien@mediatek.com>
> ---
>  .../devicetree/bindings/sound/mt6359.yaml          |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/mt6359.yaml: properties:LDO_VAUD18-supply: Additional properties are not allowed ('ref' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/mt6359.yaml: properties:LDO_VAUD18-supply: 'ref' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/mt6359.yaml: ignoring, error in schema: properties: LDO_VAUD18-supply
warning: no schema found in file: ./Documentation/devicetree/bindings/sound/mt6359.yaml


See https://patchwork.ozlabs.org/patch/1396618

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

