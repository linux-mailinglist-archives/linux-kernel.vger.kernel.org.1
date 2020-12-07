Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267C92D1BC1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgLGVKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:10:50 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33248 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgLGVKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:10:49 -0500
Received: by mail-oi1-f195.google.com with SMTP id d27so9496018oic.0;
        Mon, 07 Dec 2020 13:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bt+ps/dKb5r74Mb0v6+4x1IC5AfqN6K2pKEQDGflIY8=;
        b=iEiJs0a5Aw7yDc24exwzjBZjME9i5yzoodyp6tww0nV976lqKv0OkJWcbazZnSHWvv
         ReIT50aMhgxujHE1lDqi7TLPvp+7Wb21j54gNhQABksTvTW7IpI2t+jLOrFNlpclCj/e
         fwdyKXUw6YRID4xeEZbV+Jqm8CC5rUwnwhe/3lQs3tNiIE+In5N4RcaDzHhS+IPhNgsA
         mRAierm8b3jTuJ58PbpzrnafyUjAYvV2QXz3NM/+NYNFFbj3FHSAixD5MR50xDCmgT1w
         pLyyEbJPFG9pri3jt/dFt+L2hVQESPS1n0JN7ZrUJ5t9lEIaxw9gxGHAI/Tjvlpl5wSy
         m4nA==
X-Gm-Message-State: AOAM530EDleTqUAok6AXVvM7zV7M8ousEuJgsqJzitXWBxLq08M5BW8i
        zkAO7OEQHGu1jRAqdqiVPcO0K78EkQ==
X-Google-Smtp-Source: ABdhPJxjIkIa33xlJd/GYVGpZiQkkj7vZ8wbMjJf06l2XX6zmOKfA873RWTEmz+2F6xCnOC4Rvu7zw==
X-Received: by 2002:aca:aa90:: with SMTP id t138mr485229oie.171.1607375402561;
        Mon, 07 Dec 2020 13:10:02 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s9sm2908336otb.6.2020.12.07.13.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 13:10:01 -0800 (PST)
Received: (nullmailer pid 828974 invoked by uid 1000);
        Mon, 07 Dec 2020 21:10:00 -0000
Date:   Mon, 7 Dec 2020 15:10:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, Kun Yi <kunyi@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/4] dt-bindings: hwmon: convert TI INA2xx bindings to
 dt-schema
Message-ID: <20201207211000.GA828921@robh.at.kernel.org>
References: <20201117220807.208747-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117220807.208747-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 23:08:04 +0100, Krzysztof Kozlowski wrote:
> Convert the TI INA2xx bindings to dt-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/hwmon/ina2xx.txt      | 24 --------
>  .../devicetree/bindings/hwmon/ti,ina2xx.yaml  | 55 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 56 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/ina2xx.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
