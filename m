Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB65F29F018
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgJ2PhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:37:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44192 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgJ2PgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:36:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id m26so2587076otk.11;
        Thu, 29 Oct 2020 08:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pYhNMIk7qOW8fzlPIb6mwbR/RjaOX4ALpVWt9vbGPp4=;
        b=BrVxa5UiOx5kR/0jO5IesBft/NM+eHzZtoV0ibgiqVYlzaaQlX3hOcyXctVyPN7yJ/
         HUfUfNhhazJNdKG62iahtZWbFgr985EfNHQ5Tvytuivock8U644Q9CapQjS3PlS8OggZ
         UX71LUeLKUAo1Lt7iNaLnQMbqNJigaL8935nHAVb1lgjP4JpieGEenoQSWIm7cDSJQ47
         bmfNYD2AMiVXHeyjMFnwgHUEctYX4L7WH51AJLD4BclHgQ+Vshu+MylnyuodPoeWl7A1
         bseWwF8lpT5hvkUiFDsaha3nEP/Vnqt0RBEnoJYcvChl1FHU2pJCzcLt0sClF9OWGGfF
         zNxA==
X-Gm-Message-State: AOAM530QX6SESV0oOtPK6uJH41LkrJfEJfCYt4tVVE9oEQcqXCjljQ6u
        fs8A4xyH+7xYGbrRKCvZdw==
X-Google-Smtp-Source: ABdhPJy7+Dy/GtcnO7U2Vrvmm/n1381d2/qROf8vZtBudP2OEw4K3ND9BPfhzrMSTTMrbLJ3cylRlw==
X-Received: by 2002:a9d:d01:: with SMTP id 1mr3802468oti.16.1603985765503;
        Thu, 29 Oct 2020 08:36:05 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v185sm680470ooa.31.2020.10.29.08.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:36:04 -0700 (PDT)
Received: (nullmailer pid 1914957 invoked by uid 1000);
        Thu, 29 Oct 2020 15:36:04 -0000
Date:   Thu, 29 Oct 2020 10:36:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net
Subject: Re: [PATCH 3/3] dt-binding: hwmon: Add documentation for ltc2992
Message-ID: <20201029153604.GA1914153@bogus>
References: <20201029094911.79173-1-alexandru.tachici@analog.com>
 <20201029094911.79173-4-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029094911.79173-4-alexandru.tachici@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 11:49:11 +0200, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add documentation for ltc2992.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../bindings/hwmon/adi,ltc2992.yaml           | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml:37:10: [warning] wrong indentation: expected 10 but found 9 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml: patternProperties:required: ['reg'] is not of type 'object', 'boolean'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml: patternProperties: {'enum': ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'deprecated', 'description', 'else', 'enum', 'if', 'items', 'maxItems', 'maximum', 'minItems', 'minimum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'propertyNames', 'required', 'then', 'unevaluatedProperties']} is not allowed for 'required'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml: patternProperties: {'enum': ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'deprecated', 'description', 'else', 'enum', 'if', 'items', 'maxItems', 'maximum', 'minItems', 'minimum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'propertyNames', 'required', 'then', 'unevaluatedProperties']} is not allowed for 'additionalProperties'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml: ignoring, error in schema: patternProperties: required
warning: no schema found in file: ./Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml


See https://patchwork.ozlabs.org/patch/1390001

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

