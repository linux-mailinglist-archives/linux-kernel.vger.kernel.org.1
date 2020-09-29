Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AB027D69A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgI2TPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:15:53 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45472 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgI2TPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:15:53 -0400
Received: by mail-oi1-f193.google.com with SMTP id z26so6688593oih.12;
        Tue, 29 Sep 2020 12:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oTo5P4j8bq5i4SuXQz18PWxEgX+pndXzZYhEdHAlB/M=;
        b=Mc+88Srd7kQ6kZExJ43hQKFtwDkWAV+hSxCjwFT6NHfSixo5UQ3GQ06EEf3Gukbfvw
         jgFMBNKYT1NE4c1YPtoKJgN1EBFXLMwisfEblOzBRYTWqrn0BMniL2a6YmRn3/DSrbwS
         VrYX2QLxUZgTDgWmM4WVqBIDDzq+FA+91ajevD7tPyREyn9XoT1zjs9f7rcfaUE691Uh
         VYQ3MMecjfFVzGUwIbnthNwE8mecyyVFgfO3sdjHRlLypgfkyoWxtZ4iPK6l+xnfxIyM
         uLJ84tS3KAkt5+XoDz048RwAmd8zt69PgICZ0UIEaOTGuDbI2sr/set/AkqfkuhfiY3k
         RElg==
X-Gm-Message-State: AOAM533weXwdBg/2QvBmeRFlXz/+EXmJEwDr/VJzCyZeycNoZmMJZyqu
        RixW2bP9zQiKNQl8ZSrlgw==
X-Google-Smtp-Source: ABdhPJxna/uKwC3Qv+BHr/YmlMDWRDnnd/qNhRRAlmY01w1YBmh+VqW1rfoxeInQcc0oWSaFs/RtOg==
X-Received: by 2002:aca:c744:: with SMTP id x65mr3621717oif.4.1601406952400;
        Tue, 29 Sep 2020 12:15:52 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u15sm1201002otg.78.2020.09.29.12.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:15:51 -0700 (PDT)
Received: (nullmailer pid 992978 invoked by uid 1000);
        Tue, 29 Sep 2020 19:15:50 -0000
Date:   Tue, 29 Sep 2020 14:15:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 03/14] dt-bindings: vendor-prefixes: add Embest RIoT
Message-ID: <20200929191550.GA992942@bogus>
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926162811.5335-3-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 18:28:00 +0200, Krzysztof Kozlowski wrote:
> Document vendor prefix for Embest RIoT.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
