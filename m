Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD91B2F5624
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbhANBm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbhANBm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 20:42:28 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8727C0617A4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 17:30:31 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b5so2306004pjk.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 17:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=wCQA51R3XjajxLm+ktkTMM4Jv8olQ2Y7A7ylvVfTXdM=;
        b=R0b+Sur4Q7QJ0KvjH+hU9OqVL3HDbi0PF1ivhQv+l13Q9YppVaU9eRhqURO0kOWuTh
         CeEJaJkYhM6ZovtluJGvI05hqOh6EVDOnMWQqUhaT3+SOw4Tvdp2dg7NkokCm+VKZGd/
         O9qX3zFXxcN9rJpgw9TpAC0SYjn0XR/aqFc2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=wCQA51R3XjajxLm+ktkTMM4Jv8olQ2Y7A7ylvVfTXdM=;
        b=gI1KlDJ+6gWQDQ43iEI1YAb24AL1qlKgJmx9/dPHHZk73L2Gdr2Mnp7X3+RTG7osdg
         w+/d82Dasnzn3UQiL0J2WH6Keq1FdmxSI9mb5WxRtqQsf2lJmwJIAzy9KkhCUj8OVAfg
         SlrLEoCN4HpaTSMUz7fv+oYrcQeLZeE+vIeciNUObf6sKvwervNY1Y+dQJd6eusv7l59
         p469ubWJxvFLwquZ5pNGrR8A2yTnOeqE+JZQADZt9UcusTs7vvJmitOr89soAKj4sytP
         pEuAOCqlNctHX9xJOMmGKgrjpaivbTJrtmU6uuoXCCgrvfzKlKtzrDEA8FFr6EKvSUZY
         BI7g==
X-Gm-Message-State: AOAM531o99eeRj+Vkj1aZNfWUVLSJQ1dqfH4XXH4AiTeIcaj1dsWf0HB
        FiKv1U3NKeL7fNjG0RjIKq07ig==
X-Google-Smtp-Source: ABdhPJzGi2jR1JsKhdPtp0pxlVaK8vg4k/dVLLn9sYrEc7m3vm0ofkJBncXjINhwzNNa6avh38R4PA==
X-Received: by 2002:a17:90a:5303:: with SMTP id x3mr2336824pjh.54.1610587829782;
        Wed, 13 Jan 2021 17:30:29 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id b11sm3750264pjl.41.2021.01.13.17.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 17:30:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210113172450.v5.1.I025fb861cd5fa0ef5286b7dce514728e9df7ae74@changeid>
References: <20210113172450.v5.1.I025fb861cd5fa0ef5286b7dce514728e9df7ae74@changeid>
Subject: Re: [PATCH v5 1/2] dt-bindings: input: cros-ec-keyb: Add a new property
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     dianders@chromium.org, Philip Chen <philipchen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>,
        dmitry.torokhov@gmail.com
Date:   Wed, 13 Jan 2021 17:30:27 -0800
Message-ID: <161058782774.3661239.6435895454078235399@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-01-13 17:25:12)
> This patch adds a new property `function-row-physmap` to the

:)

> device tree for the custom keyboard top row design.
>=20
> The property describes the rows/columns of the top row keys
> from left to right.
>=20
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
>=20
> Changes in v5:
> - add minItems and maxItems for `function-row-physmap`
>=20
> Changes in v2:
> - add `function-row-physmap` instead of `google,custom-keyb-top-row`
>=20
>  .../bindings/input/google,cros-ec-keyb.yaml          | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.=
yaml b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> index 8e50c14a9d778..e573ef3e58b65 100644
> --- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> +++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> @@ -31,6 +31,18 @@ properties:
>        if the EC does not have its own logic or hardware for this.
>      type: boolean
> =20
> +  function-row-physmap:
> +    $ref: '/schemas/types.yaml#/definitions/uint32-array'

I'm not sure this is needed if min/max items is there.

> +    minItems: 1
> +    maxItems: 15
> +    description: |
> +      An ordered u32 array describing the rows/columns (in the scan matr=
ix)
> +      of top row keys from physical left (KEY_F1) to right. Each entry
> +      encodes the row/column as:
> +      (((row) & 0xFF) << 24) | (((column) & 0xFF) << 16)
> +      where the lower 16 bits are reserved. This property is specified o=
nly
> +      when the keyboard has a custom design for the top row keys.

Can you add it to the example so it can be tested? Then you can prove
out if the ref is needed or not.

> +
>  required:
>    - compatible
>
