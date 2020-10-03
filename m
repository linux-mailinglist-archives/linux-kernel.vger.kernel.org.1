Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410EA282647
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 21:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgJCTgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 15:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgJCTgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 15:36:09 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA952C0613E7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 12:36:07 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 77so6126014lfj.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 12:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w3Ngi5vlbzYdW/bDZyAeIiKsITew3BleP03QjUOOp9E=;
        b=NL3W0BU3MYVSlmKaGe0apPVLCOWMrRvHHy6MxlaJ4zkI/5fZW6A2ly8bd/ZSw5zN4l
         UbsojxYClh5sDdVjL4VpsS+1gbchOMXIpbo/Lee4jyQjFVIGH4K4vnRxRPrCK5jDlJso
         L6itAExkxUCBRPMKT0n9qougujJj4UbEIlXkvQ71i2fX+7ioM4OYkc6X5DZh/i/GB0hV
         9mKb+fFKNYcIppRJpwX5/3kxqLUSBZqNCNejgkAI0xLPwMr2fuZ3mQe84JhOs+7X027h
         ykx2K8gU3qUEs8T7OBOX8Xm1JaQfj8jo+p7YHBpqtr9bNMhyYrmZoILcw3dZYVUqyfkg
         fS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w3Ngi5vlbzYdW/bDZyAeIiKsITew3BleP03QjUOOp9E=;
        b=rZ5d8myMDHRR9GNeOG0neuLvPUu6GYb1b4JV6/GfMot3pG0psTohSkTtgSDD+10pwp
         r67xPu1uPp7/dgoFkA38Jm3fgdX77ooFAtwRE4dHICYVZcmf1vi1mLlA0zY3hMi/8e8G
         XEGMYUiOwK1ZMbliuhb/4qZl5Rsf1IjIuBEx6R4hRSuNFzVZGQ18rNxgqgY5N8mlLB6C
         oqjSxpynQma5P0Z0CsxthvPFvuAdeEGOuxrUpdnHGPhUyejIqDJjPbrdZeeJTUoo/pvn
         GD5J1jD1j4TkPZnxypVwmprQ4I/ZJTUxpJe2K/YxvSdm0Qypqj/j/ygXkLyc6jIA8MAL
         K0Xg==
X-Gm-Message-State: AOAM531HTyeuMciNwQHOUA17LuXQfy3nE13m9MzzwIRXfLxK6pM0OCeV
        2Y4TLlVuKJPWaQmpvxjeTmwziw==
X-Google-Smtp-Source: ABdhPJzlCylEeGhrYpzJE62KmnsvFA9SXe6+3IcJwxU1POJcuOBkf2krH+BSRuYP+ZJuVQlcdpntFg==
X-Received: by 2002:a19:4c1:: with SMTP id 184mr924325lfe.547.1601753766144;
        Sat, 03 Oct 2020 12:36:06 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id b28sm1826099lfq.107.2020.10.03.12.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 12:36:04 -0700 (PDT)
Date:   Sat, 3 Oct 2020 12:31:36 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dts: apm: drop unused reg-io-width from DW
 APB GPIO controller
Message-ID: <20201003193136.GC8203@lx2k>
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

Sure, applying.


-Olof
