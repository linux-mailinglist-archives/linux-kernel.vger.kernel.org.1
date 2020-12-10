Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2866B2D5749
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbgLJJeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbgLJJeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:34:11 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8143BC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 01:33:31 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id bj5so2484340plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 01:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NMxKlRYBb5lr66i9S2BnZ0csslGiBrLWirm/cD72+fA=;
        b=nXcY+NK9w3n9SLZKVpMBonSIOdWvBXpO80IxAhoIrhwwgX2QvqyjgoTmELA4QqeMpd
         IiVlB16sFqbzRqqnO8LoXWGezuBgePlIPyEKliZMnnVEVkxyLeABAnZuvFcTg3zyRh18
         rPQyq4hMxDpulHtCBwYwvKmsOigSjmk+/jSZd+IX6gcEHMvbB4eEhvOPOX2H3mZaVsyZ
         pb2Jgts27ka6JBtsfrDFnjd3iWzMhELX54NHZKWoHDL9oH3ScNj/icjqRjw8Qs+o4Y9+
         i2pMxf06HtCNdeew+iZ9v3VIWLssJErMYa1jF0F2b6gPwXwSP+mk7CChcsRG1RMhjef0
         g2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NMxKlRYBb5lr66i9S2BnZ0csslGiBrLWirm/cD72+fA=;
        b=mZQeXyvY8MLw/E+UgJSJPfBuBBhCL94uQc/0vbA9A41ksFeBsdg0CXI1NatT/GBiJ5
         ybKs0rmKpqhTjP/fGTzOWxGjafsCy8ShtctpsCWAAabF5BObq3iRAViWyJBxidCmziBQ
         WlvEZ5ytxv2oK0tr1sshRCYPUv6rv6pQlj9wOnw29N5G4jbfj4MD3SFoAlwhcDjC2Jhf
         TBYXaZbOim7FjoGZBXj9tbQOBpD3Us7Zt+diCgLwqfOOdH9PU4In7a86jZpc2x3iExMl
         hyrYzITCeJk3eF68tPi6Lk62A+37vQKOpN2xpsnQyMjlgciCoVDprgoDkYF6HyOmb+bV
         xm2w==
X-Gm-Message-State: AOAM531sxk8X2TJCI2IJDEnuyi25jjHNe9sR9Crsnk+xVmK3QTSgwKsW
        Qnd9qyq8TiZWu11fr6+1jSfq
X-Google-Smtp-Source: ABdhPJynZIeZg2ND6ZfyQeXfcn2q2ncsTKKFruijwxpb9sDXIulSuWSqVh+YHaX8uYsKZaETZI6I2w==
X-Received: by 2002:a17:902:be11:b029:da:ba30:5791 with SMTP id r17-20020a170902be11b02900daba305791mr5609367pls.13.1607592810943;
        Thu, 10 Dec 2020 01:33:30 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id p1sm5935208pfb.208.2020.12.10.01.33.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Dec 2020 01:33:30 -0800 (PST)
Date:   Thu, 10 Dec 2020 15:03:23 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH 0/8] arm/arm64: dts: Use generic "ngpios" rather than
 "snps,nr-gpios"
Message-ID: <20201210093323.GC24867@work>
References: <20201109170258.4a70c768@xhacker.debian>
 <CACRpkdbywjEaKORgS4GkWXkX9DOX0318hKoc0YY=o0NtBjyYcA@mail.gmail.com>
 <20201210171224.74943144@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210171224.74943144@xhacker.debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 05:12:24PM +0800, Jisheng Zhang wrote:
> On Tue, 10 Nov 2020 15:43:36 +0100 Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> 
> > 
> > 
> > On Mon, Nov 9, 2020 at 10:07 AM Jisheng Zhang
> > <Jisheng.Zhang@synaptics.com> wrote:
> > 
> > > To remove similar errors as below for all snps dw gpio users:
> > >
> > > OF: /...gpio-port@0: could not find phandle
> > >
> > > Commit 7569486d79ae ("gpio: dwapb: Add ngpios DT-property support")
> > > explained the reason of above errors well and added the generic
> > > "ngpios" property, let's use it.  
> > 
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > For all 8 patches.
> 
> > Thanks for cleaning this up!
> > 
> > Yours,
> > Linus Walleij
> 
> Hi all,
> 
> I merged patch6 and patch7 to berlin, will send out a berlin SoC dts
> Pull-Request today.
> 
> For other patches, I see Wei has taken patch4, will other patches be
> taken by each SoC maintainers?

For bitmain platform, I don't have any other patches this cylce. So I'll
just send this patch directly to soc@kernel.org.

Thanks,
Mani

> 
> thanks
