Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5935826F7BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIRIMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgIRIMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:12:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF01C061355
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:12:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so4658475wrx.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jamieiles-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w+duO7ag7Wo1FDAv0KdE+0dJbmttarxgE5AV6WREnJY=;
        b=JBzyTof205n9CrskwSX6h5Bsd/ce4bOhMLfdprN2vtBrAd1z5+/9ZhvRoaligoxanv
         smL52mWM1PO6qYEC8JWk7UVts5wnz6ckzZGbS47gg58IbWhgq/qapkjmvoMHMRg+AIgX
         lFspaU+cUnPO3ejGryBI8TfdIkBtRTpq+QgmN8mn75Il+6yfzrRFSTtzPVh4HXg0UMwv
         gc3Ycnm6bZ8qnt9xj91o1ODzqIQ05UVvmPTaCg925XoGV+e5F1n3yuxfIrG6mMvuqFys
         I3bNd72JRQeeS5cTnD/cAuM5NeNLNDvIwiZZZQA2OmsXC3rq/mSmkvKlwiCvjsd9fC4x
         pWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w+duO7ag7Wo1FDAv0KdE+0dJbmttarxgE5AV6WREnJY=;
        b=Ms4fMmc1Iag3i33p9hiLt/mMaAApmdfv62iFNIVVoEfpGvCAXP50kie7N4OG6HOGYu
         +Iv+L061dUzncEUaAvBE5SaENIoSZ/wYwv/Y1mSHL5LSf2ovAJwLT8q+mSa3tfnzZ3BF
         2E/pUha4OonStR/hVENgaCDjaxBDSKwP36UH/7EcS1wFBaEMCVXPzjs+pGd4rp/Xe7J+
         EGyBA4gseIsvKrviq4UOSLZxxt9gR2GhYzZKrOLw0yFbb8uBiDZxMN5IJa+7sFNzbKf1
         j96Uqq8LqdP1OObWQzTdfTCFFZWxmVVFdzz9F+UHPCN9H3fwT8lYQSSxL/WzM8F49k9q
         idqg==
X-Gm-Message-State: AOAM532vPql8jPG78eSucL+Qs8+uWCeBBMdtmp/Zjnq9q2pXAw7KWky8
        MPpJkHn0OzJh4cpkJugLBrHyHg==
X-Google-Smtp-Source: ABdhPJyJr//yLNQwyzSFw6/KlL1AcjWCyiFqfcdL5xyJ6/pG3MRMA7PeXdNmhNmuPs4oRzTR2ORU+w==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr34340382wrm.291.1600416727526;
        Fri, 18 Sep 2020 01:12:07 -0700 (PDT)
Received: from localhost ([82.44.17.50])
        by smtp.gmail.com with ESMTPSA id t15sm3408203wmj.15.2020.09.18.01.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 01:12:06 -0700 (PDT)
Date:   Fri, 18 Sep 2020 09:12:05 +0100
From:   Jamie Iles <jamie@jamieiles.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jamie Iles <jamie@jamieiles.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arm@kernel.org, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ARM: dts: picoxcell: drop unused reg-io-width from DW
 APB GPIO controller
Message-ID: <20200918081205.GA27553@willow>
References: <20200917164909.22490-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917164909.22490-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 06:49:09PM +0200, Krzysztof Kozlowski wrote:
> The Synopsys DesignWare APB GPIO controller driver does not parse
> reg-io-width and dtschema does not allow it so drop it to fix dtschema
> warnings like:
> 
>   arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dt.yaml: gpio@20000:
>     'reg-io-width' does not match any of the regexes: '^gpio-(port|controller)@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Jamie Iles <jamie@jamieiles.com>

Thanks!
