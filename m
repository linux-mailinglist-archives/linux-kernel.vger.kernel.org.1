Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EDF2F68A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbhANR72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbhANR71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:59:27 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19EFC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:58:46 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id p5so6797020oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v5EYWSiR16iLtT1JtiGCCP6c/dvJqxEAs0A1EAfTfgo=;
        b=ogXNQtxgMuLTQUR+LuqGSnVuZySnkrl7p5Ik60NNBhEV1lT8h/4tjxens4bet8b2Hr
         FKGeembZTe+JMaBSBN1PM1GTSLf7ayJTau8kqkuo7iNM3PRx/93URjiic8tLKPvWOFZY
         XKVg2b9oQBEpUjzjaz2mudkjTB/Oc/PAJkaZoK7gzzF+TL3dITcH7CvT57HMqAndAWR+
         Z/0UTKYFuSnr6+cb8LE68yAWF9GM35GURPlWTWqjN9h96T2ew7KHsnIMDYNostxk6x+U
         pCF6w92t/+Ln2uplZForHURTCyndVKKzRTpKCnLSZWkYbF+H7bo6cYp8nPGJJPQnxiNR
         YeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v5EYWSiR16iLtT1JtiGCCP6c/dvJqxEAs0A1EAfTfgo=;
        b=PcKEEuhuBkwUVx7mvPugeqiJKBBeGsXfqTwQHvnYVXnQhTTazKVnv0WFp+5s9LZ8+n
         kB+zSMl+TpgkB+K0UgbEivwLX1oF/nAg+J3kUrvgYOzHAefhgXDHapLyJHduG+d5cqz3
         xBYbBfrVlic2wg8LQ5InZ+xSGmWWk2JhNkhs+RRPyqE4E0CI0TTGudqK+FQQQ/APBPTp
         +DzeQx+k3HQqV7lrNVcguLqUOBHeehMIQjslyoM2NF79YmljhAuTW+oegwspsGSqW6ob
         dbONSdW/KvlVoOvgLuXKBcO/RZGXJAy4HkGB5MaOLAmm/rXXbZe3p825O7IWtwUmdoqp
         DKYw==
X-Gm-Message-State: AOAM533C+PV0l9m4nGAavNwYUyem++P/WlQES3mhXIy/Lgk3T1SNUVD1
        tumQpPiFh5YOE+ZMvOAFbDJlLg==
X-Google-Smtp-Source: ABdhPJwE3VnQoQr7mIxVwCyiQjO7/Ofk/bZAbr8LdoTVYRrLFBGnhTJdcphLLMQ0aAh5QbPamy623Q==
X-Received: by 2002:aca:fc96:: with SMTP id a144mr3255775oii.146.1610647126304;
        Thu, 14 Jan 2021 09:58:46 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i126sm1163247oif.22.2021.01.14.09.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:58:45 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:58:43 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: i2c: qcom,i2c-qup: Document noise
 rejection properties
Message-ID: <YACGU7Di1RnD9nYL@builder.lan>
References: <20210114174909.399284-1-angelogioacchino.delregno@somainline.org>
 <20210114174909.399284-4-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114174909.399284-4-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14 Jan 11:49 CST 2021, AngeloGioacchino Del Regno wrote:

> Document the new noise rejection properties "qcom,noise-reject-sda"
> and "qcom,noise-reject-scl".
> 

I presume these are unit-less levels?


Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../devicetree/bindings/i2c/qcom,i2c-qup.yaml      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml
> index c5c7db3ac2a6..3f14dd65c6b9 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml
> @@ -58,6 +58,20 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +  qcom,noise-reject-sda:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Noise rejection level for the SDA line.
> +    minimum: 0
> +    maximum: 3
> +    default: 0
> +
> +  qcom,noise-reject-scl:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Noise rejection level for the SCL line.
> +    minimum: 0
> +    maximum: 3
> +    default: 0
> +
>  required:
>    - compatible
>    - clocks
> -- 
> 2.29.2
> 
