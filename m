Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76DB21A8C0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 22:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgGIUNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 16:13:51 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33372 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgGIUNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:13:50 -0400
Received: by mail-il1-f193.google.com with SMTP id a11so3163202ilk.0;
        Thu, 09 Jul 2020 13:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k0op+C2S3aQoquxdFo+HuSbYEJeD5ZxAC+v6vN831a4=;
        b=K9TSYtt2c5afM0uU7JVLKIeP9eqwdCBJYYuf2kngPxYtFZIJGLMXdkpIKqI9BH05wk
         l3xtUi+2WOMtN5LxYcPUbFRBiVbvuwD9ZtVvE4xVWzo7Qp1aA1TS9TP7v7dfr8UyAMq+
         /49v3bNjuGFRJ41XKRLBTnD/8PT3YDIg25GlVU/LiH264SBuc/z//OjSOYjYp3KO+1JO
         F9cqLAkVVfyAWqBJDy+8kztnj2YQucQrhRhvaRyK7q6Gu4bZ5soix7yrXJUvU690XSDO
         MVmygTTNwPw5Hg3Ue+W16XqI5EUoqys4MhdH4hM2UD2ovulU9R+4AtFTideACmbdYUl4
         M8hw==
X-Gm-Message-State: AOAM530x0WQoaUrgOIA2fKLuDBXspRUgniNheTYdXa9OZM4HR4NNquws
        M+1dps+Aq4tfKMKCTqrHkQ==
X-Google-Smtp-Source: ABdhPJwN9Tnm2g10urJefbESGH3i3X/kkcFt7HTqUBM8iKFH7AQHI2Y9MXUrD93PD3LlrhQdXnC3sQ==
X-Received: by 2002:a92:cc50:: with SMTP id t16mr48154798ilq.180.1594325629998;
        Thu, 09 Jul 2020 13:13:49 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id c3sm2314843ilj.31.2020.07.09.13.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:13:49 -0700 (PDT)
Received: (nullmailer pid 813726 invoked by uid 1000);
        Thu, 09 Jul 2020 20:13:48 -0000
Date:   Thu, 9 Jul 2020 14:13:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        treding@nvidia.com, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, yhsu@nvidia.com, snikam@nvidia.com,
        praithatha@nvidia.com, talho@nvidia.com, bbiswas@nvidia.com,
        mperttunen@nvidia.com, nicolinc@nvidia.com, bhuntsman@nvidia.com,
        nicoleotsuka@gmail.com
Subject: Re: [PATCH v10 4/5] dt-bindings: arm-smmu: add binding for Tegra194
 SMMU
Message-ID: <20200709201348.GA808454@bogus>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-5-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708050017.31563-5-vdumpa@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 10:00:16PM -0700, Krishna Reddy wrote:
> Add binding for NVIDIA's Tegra194 SoC SMMU.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index d7ceb4c34423..ac1f526c3424 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -38,6 +38,11 @@ properties:
>                - qcom,sc7180-smmu-500
>                - qcom,sdm845-smmu-500
>            - const: arm,mmu-500
> +      - description: NVIDIA SoCs that program two ARM MMU-500s identically
> +        items:
> +          - enum:
> +              - nvidia,tegra194-smmu
> +          - const: nvidia,smmu-500
>        - items:
>            - const: arm,mmu-500
>            - const: arm,smmu-v2
> @@ -138,6 +143,19 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra194-smmu
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +          maxItems: 2

This doesn't work. The main part of the schema already said there's only 
1 reg region. This part is ANDed with that, not an override. You need to 
add an else clause with 'maxItems: 1' and change the base schema to 
{minItems: 1, maxItems: 2}.

Rob
