Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2752829477E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 06:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440261AbgJUEva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 00:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440253AbgJUEva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 00:51:30 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF23C0613CE;
        Tue, 20 Oct 2020 21:51:30 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 188so1114764qkk.12;
        Tue, 20 Oct 2020 21:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7S+Ge/DxkH9CUYM5ngdE9w4BnrCUgNRtxj8SJF7Zxcs=;
        b=S1A9iVzO/2CwZAsuuw7v7Aqajmblbv1ifw6clkwdsI1ijOdOXrZFuNSbOtNdwJ/Jr4
         mM6fvJs1Hig3zUMTj+a8yxATwbVR5KgdPHEo3vre+qW6OUYbKwwGs4IDwei77DacrDM5
         29K2oTYfrsFgGi0p6JCTnfqW2uwtlmKWz2kHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7S+Ge/DxkH9CUYM5ngdE9w4BnrCUgNRtxj8SJF7Zxcs=;
        b=EuoDIkSySp8e5kjUCRJ1n6TNQIRtf5bUoaJum0bzi0FkoW4mn9l8fc/o15LWpDdWDI
         /wppV6iMwrCoY3Iw+5qAew1XQWgxo68cTPcZ3Bmi6EV5lEWJoOLWpLoEM6iJtFuGHi/Z
         1Zg19wIqAnMaEM1xq1hu8w201Ub5sbg4unRkBYIWWKe++6UyFX+vaG4fz4oCCcGFBmGN
         5kAi29/8AncygxFGswKbx/ki1wwJDytD8IfSNaFqVymV3xmXwIkb6HijET0xmhoiEvFl
         Y7azKHQRONIhLsmfPn6hgxQAWC1CXxUpJWWRORU2opeKyU9JZA89553PaiALeaShGNoY
         4yug==
X-Gm-Message-State: AOAM532vc0yff+gQc7XkQJEll2ygev8/Uuvs+IlgyoSy9JxlRspoPRll
        zDFp8SJ6th8P035ZLyrDDWnvfaG8dUvMcBa7SvE=
X-Google-Smtp-Source: ABdhPJyOqiPlkiXcnTLhnLMYTXkl6P2IifPhUM7Ht1EKmmNBup3yA5+KgVfY5MS0R33Hwo6up58TM91d0R+UyZiMm7E=
X-Received: by 2002:a05:620a:1e7:: with SMTP id x7mr1512189qkn.465.1603255889394;
 Tue, 20 Oct 2020 21:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201016043513.119841-1-andrew@aj.id.au>
In-Reply-To: <20201016043513.119841-1-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 21 Oct 2020 04:51:17 +0000
Message-ID: <CACPK8Xf1=YEApovVOCbE5dkM3uK0Lsx2iXnVK6nK3mx=+q4jpw@mail.gmail.com>
Subject: Re: [PATCH 0/2] ARM: dts: Enable ramoops for Rainier and Tacoma
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 at 04:36, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hi,
>
> We're looking to improve our crash data capture for the BMC on some IBM
> platforms. This small series enables ramoops for Rainier and Tacoma.
>
> Please review.

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> Andrew
>
> Andrew Jeffery (2):
>   ARM: dts: rainier: Add reserved memory for ramoops
>   ARM: dts: tacoma: Add reserved memory for ramoops
>
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 9 +++++++++
>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts  | 9 +++++++++
>  2 files changed, 18 insertions(+)
>
> --
> 2.25.1
>
