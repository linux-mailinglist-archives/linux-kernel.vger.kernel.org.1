Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE141282648
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 21:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgJCTgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 15:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgJCTgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 15:36:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D355CC0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 12:36:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m16so1626858ljo.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A5i2OjTLBkoVH5tm7bzHi/USJTrW+lyYNLFkq/+L0FE=;
        b=h3cyyzFG4wrIzM4oY5CE0DCL/Xlwnalfgek7F6Jl6pEXbpfFB93mpo+Ea2whCFCE5A
         eefa/5pd2+DMdH7Z23HajkB6EKfH9TQdBlvDWC/a/yWf/yWAaK3kpZ5rfSM1c0B6zbr1
         GobhSXja3U2BbV98T6fHAf4LoaR5R2hb7t7GfiJNBPkFNklMUMYSNmE71ValjBQ684sd
         n48zNbKObaLBDIFo679zmuOCOamJ4Jlspgzx3Mvd5FNsnM8HdU6I7vFYZczmmabom/4R
         VjN6RK9fG5tbRAYG/qpvwlVcCEGkkHeR9DCTS0LUgUXPAl0h8bDDFiX0DngZWCyfoz2n
         VM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A5i2OjTLBkoVH5tm7bzHi/USJTrW+lyYNLFkq/+L0FE=;
        b=Z5OZ5QjDGp+R+p9Rsfhcqnn2sIeEEAWjubzDjaC4hFZjCMfa+yQPvCUdYPuVjiHz1A
         6wJ9AaFREJiexPZ+iLyfp09ubSlQCzblphmjOwjmqT2DL2FhzENXVdelLxqVMls/O0g5
         tmmffPoGb6c8tJ8sXEGZD3uXVLsrEGX2RMSTgVfHUsGY0wPS9FUhGUrA+7Pw0F+4XnjI
         nevadwpRttweW8Lkwn+os53V26bsNPrhe3VqYv/LIUjAd43PZrabLBtcQdMbG80Fcfbo
         5djX+xrXM+vd0eAcEM+1qLSguybgAweqyBcZl/oXc5btidAgWfuednHdm4HrAvTQiTwy
         g2oQ==
X-Gm-Message-State: AOAM531MVJyt5rvYX3KZhA5Y9VBLCGdD3qZa35ky+bKzEeiMsOkAhpOm
        wMzeEsWusFwRCJHPcKJnyShWINclsAGwX45s
X-Google-Smtp-Source: ABdhPJzHJtCvvQB+I/1En4cpoIp25Yjr+eteA0t1Q7YniLLB8jaOGU2zQtPRVLJFu9G/iNWeJuwReg==
X-Received: by 2002:a2e:8e30:: with SMTP id r16mr2385633ljk.304.1601753768288;
        Sat, 03 Oct 2020 12:36:08 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id o17sm1911597lfi.261.2020.10.03.12.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 12:36:07 -0700 (PDT)
Date:   Sat, 3 Oct 2020 12:33:10 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dts: apm: drop unused reg-io-width from DW
 APB GPIO controller
Message-ID: <20201003193310.GD8203@lx2k>
References: <20200917165040.22908-1-krzk@kernel.org>
 <20201002160922.GA4542@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002160922.GA4542@kozik-lap>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 06:09:22PM +0200, Krzysztof Kozlowski wrote:
> On Thu, Sep 17, 2020 at 06:50:39PM +0200, Krzysztof Kozlowski wrote:
> > The Synopsys DesignWare APB GPIO controller driver does not parse
> > reg-io-width and dtschema does not allow it so drop it to fix dtschema
> > warnings like:
> > 
> >   arch/arm64/boot/dts/apm/apm-mustang.dt.yaml: gpio@1c024000:
> >     'reg-io-width' does not match any of the regexes: '^gpio-(port|controller)@[0-9a-f]+$', 'pinctrl-[0-9]+'
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> 
> Dear Arnd and Olof,
> 
> There is no response from APM maintainer, so maybe you could apply these
> two patches directly? Optionally I could take it and send to you via
> pull-request.

I've already applied them, so no need. Thanks for following up though, seems
like the patchwork email service hasn't been working on all patches.


-Olof

