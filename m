Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D919256ECF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 16:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgH3O6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 10:58:31 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:44476 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgH3O6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 10:58:23 -0400
Received: by mail-ej1-f68.google.com with SMTP id bo3so5166330ejb.11;
        Sun, 30 Aug 2020 07:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yLdu6brDWJDDXexjV3/nXBgg6pnnhqUXBpD1PlhzB94=;
        b=i2YYQ5A3XHobp7LzR7rHNAEq2B+qB3RA74PZDd4iRVrUmHVYvYatMClnS6kEcAOcWv
         6Q/G30KDD5X/9jjgnyuLOgGW+3A0zEWoRkAUplT7vSDYNZZUdnkvkcSqJp57lzkNmeew
         JO9o/sRkCGS5CfaKMEYSEDanbH1VETFt/+35gt2NUisOS+I72O6Ltsi0owjgrVh8QW7x
         S/UA5pckBOC5PYwQo4XY9N4gO1eZzE/Z776zbNxGhol4+NYHZJYONjbUZtltzawOIe3U
         +H08HqczMSUF/0MJVo2sB6qB31DBcH57ox0XuAK8JL95sCGNZyaYxGsK7Cx1DAIRnvhL
         PdBw==
X-Gm-Message-State: AOAM531Anu2byySym0aLv9fXFQYeT5HI7ueAGJ5Dv8oK1mLkv0TI8hrv
        94OAY3zqCbgqXx0CJhh+g2w=
X-Google-Smtp-Source: ABdhPJzmu7wboTsmbAgNBd2kGcqxNX+jO6kQBtq3muCwmdaSCJrd9tb2Bd6LWPTEamm9vdB6SfptdA==
X-Received: by 2002:a17:906:b154:: with SMTP id bt20mr8439716ejb.272.1598799502027;
        Sun, 30 Aug 2020 07:58:22 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id a18sm5389900ejy.71.2020.08.30.07.58.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Aug 2020 07:58:21 -0700 (PDT)
Date:   Sun, 30 Aug 2020 16:58:18 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/3] ARM: dts: alpine: Align GIC nodename with
 dtschema
Message-ID: <20200830145818.GB31461@kozik-lap>
References: <20200819175816.21398-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200819175816.21398-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 07:58:14PM +0200, Krzysztof Kozlowski wrote:
> Fix dtschema validator warnings like:
>     gic@fb001000: $nodename:0:
>         'gic@fb001000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/alpine.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi,

Any comments here? Is anyone maintaing these files?

Best regards,
Krzysztof
