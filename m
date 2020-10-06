Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7585B285328
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgJFUd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJFUd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:33:57 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B5BC061755;
        Tue,  6 Oct 2020 13:33:57 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id s66so89495otb.2;
        Tue, 06 Oct 2020 13:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0TMlbKMV2B99JtkBFVHwA4dI5Ul+dOx1FNcZbIk+0NU=;
        b=Jserfl6q9NDbZEqdLPfWpK5xia1iP7/eBC/dKhWYIR7jUWJuBzcZVjFpBfZzjdukq0
         ZoRKTgrNkhQEJHuXNwcen6HlUe5RTfZK55K5A/w7D8m146msmHSITbsbg0aYplHC98uG
         xc9xSlRQ9VQyNcSG4eOe5OM0KtrM2Y+m1u75/CXtiwDLELd/jC3XhaUH9lvvPSVXA7IQ
         i9ywYoCKULTlIpy1A9xolB/qp16+ws5HY/7pCb4hCwJRE0ZAq3BAOUKBI9n+fVSq6Sq6
         DwDjqMMoAL2++ap8muYoq9nLaLMd0lh++jfpp2zsr0EqMIJPgEC+8bI+JzAPUneXYASH
         lMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0TMlbKMV2B99JtkBFVHwA4dI5Ul+dOx1FNcZbIk+0NU=;
        b=cnZ/2kALlIHFudeGztKbH2YFSosr4yWz/rYRni9+YISFc/LnzBvocxKQfFBRyIrt/6
         4VDJWzvMXTtV/2woJ+lh13KI8YORBnr+tVSFoVlIqkyuYk1QENDyxzfF7PtFpqp2kL9A
         I87hK/9hOTeE6MTDB1GHNPjfbJFXPZTSWi+OTQo9oPf+sDQlUnCap3HTJ8JEMWrmvAej
         34bnUKSOwch+/uerUYx1XJY2AwzC+UTqOG9bf4x5fEwASgXzuPbrKHx0HSsSdFZ6Dn9P
         nEWYJuWPN692muFN5P5CL5VCjtM3kjJAqH063XrTwR9Eg2/xUn0tteWEvfFHZWA5IYLR
         LNOg==
X-Gm-Message-State: AOAM5329U4SJbhCZ3Y8w44XGEoMvOyu5Xxck49zHkzxScgjZiU4q8Svl
        /EObjYUZ1/w+bvTOIEeoSzQ7/9mIglU=
X-Google-Smtp-Source: ABdhPJyJvvqpKCeLedCBp+8xhomScUXD17n8gmeFux4kh5AdZI64glUB3zSpo8nVxNRM0aR0aMvacw==
X-Received: by 2002:a9d:7501:: with SMTP id r1mr3869002otk.115.1602016436562;
        Tue, 06 Oct 2020 13:33:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w3sm1545388otl.13.2020.10.06.13.33.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 13:33:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Oct 2020 13:33:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alban Bedel <alban.bedel@aerq.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: hwmon: Add the +vs supply to the
 lm75 bindings
Message-ID: <20201006203354.GA88755@roeck-us.net>
References: <20201001145738.17326-1-alban.bedel@aerq.com>
 <20201001145738.17326-3-alban.bedel@aerq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001145738.17326-3-alban.bedel@aerq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 04:57:37PM +0200, Alban Bedel wrote:
> Some boards might have a regulator that control the +VS supply, add it
> to the bindings.
> 
> Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> v2: Removed the unneeded `maxItems` attribute
> ---
>  Documentation/devicetree/bindings/hwmon/lm75.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> index c9a001627945..96eed5cc7841 100644
> --- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> @@ -43,6 +43,9 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  vs-supply:
> +    description: phandle to the regulator that provides the +VS supply
> +
>  required:
>    - compatible
>    - reg
> @@ -58,5 +61,6 @@ examples:
>        sensor@48 {
>          compatible = "st,stlm75";
>          reg = <0x48>;
> +        vs-supply = <&vs>;
>        };
>      };
