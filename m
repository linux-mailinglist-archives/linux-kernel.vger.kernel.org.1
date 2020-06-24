Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B714D206EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 10:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390393AbgFXIX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 04:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390374AbgFXIX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:23:58 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D45C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:23:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so1472467wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7CfWJggOLytFRr/ikNip00lDY5ba4BeQpprJvlEpZKo=;
        b=yGYLrSlhQcadIM9Q2dJ4CvQCzkx8AcJghjxpA1+GyjKYQ/iRmlu8ztULHouYkoaxgT
         cl9d781if+2/7AkR/18N9K1p9NnUuXpybssQHjeD5/+9Qv8DCAoBr5gyP2gNPQuve+Ko
         l7bwJrXijWLfBzSQT6yT5gnH2n6B1sKQnKY4EXyU17fp60IudB1fuk0Rx7R0bmM+wKpb
         j/yQ7U32UOGCTLvhLXWGXcLIgx0rpVSCgZXST10ngQPIoCEo2pJW0fzhzaSbhyPJUSF5
         9LTagsQcH4OMfQn6sb8V2TvrnzPsH4xtZZGinxWkahLz4RFMKgQ4oNKRqjaSAZuTNqQU
         mNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7CfWJggOLytFRr/ikNip00lDY5ba4BeQpprJvlEpZKo=;
        b=gECG5zwN3kAppvPIGtMkv26jJwdVBkqjMMRRkJstRhycpn4NgMTrx5dWIRPD6f/F3e
         Ii2cnsJW9m+mqad4hWzfnCFagK7Oz4Ms2zTMbg2eQ1+TdHu4XoYY1MITaaTdZFJSh3P6
         mSxSX6dkSN4HELM3JU08H0eEybzv82b/9Mo+RBIeZc4uOFrPvHp2CZ3hXAWAQD98is7I
         dAtVG2UhfO9XIjfqhaU/QY7Ee/OEq3pFnM8SNfy4J63X1pmHKBnEvhy5jql0h2w1BXqV
         4QIBnhW8O9+Cf8sBVH91qYWfEX2E+8OC6hCBBM2MiUiyliaWVk+NGovqeaY0JQARvCx6
         /uEA==
X-Gm-Message-State: AOAM5327rmLlv6d0GIanXyQ7yPnPzFHU1BCFHbjrZwSV47lN3V8Otu4x
        o8wHKBhEcZjPgMRDUPqpjHkszQ==
X-Google-Smtp-Source: ABdhPJxelqW9I6Z+7u1Gs3c+QcyYSi1L6TpEnF6VtqYJIB1FBDOrZkKNvBXdMtrikHVFkI74T4j3FA==
X-Received: by 2002:a1c:a385:: with SMTP id m127mr26949887wme.112.1592987035664;
        Wed, 24 Jun 2020 01:23:55 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id m65sm7120441wmf.17.2020.06.24.01.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:23:54 -0700 (PDT)
Date:   Wed, 24 Jun 2020 09:23:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Frank Rowand <frowand.list@gmail.com>, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
Message-ID: <20200624082352.GF954398@dell>
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <30f03734-61fd-1b6b-bf11-21b6423a7c50@gmail.com>
 <20200624064145.GC954398@dell>
 <7a31b34940984b3f0921ed2d4fb29a58@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a31b34940984b3f0921ed2d4fb29a58@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020, Michael Walle wrote:

> Hi,
> 
> Am 2020-06-24 08:41, schrieb Lee Jones:
> > On Tue, 23 Jun 2020, Frank Rowand wrote:
> > 
> > > On 2020-06-11 14:10, Lee Jones wrote:
> > > > Currently, when a child platform device (sometimes referred to as a
> > > > sub-device) is registered via the Multi-Functional Device (MFD) API,
> > > > the framework attempts to match the newly registered platform device
> > > > with its associated Device Tree (OF) node.  Until now, the device has
> > > > been allocated the first node found with an identical OF compatible
> > > > string.  Unfortunately, if there are, say for example '3' devices
> > > > which are to be handled by the same driver and therefore have the same
> > > > compatible string, each of them will be allocated a pointer to the
> > > > *first* node.
> > > 
> > > As you mentioned elsewhere in this thread, this series "fixes" the
> > > problem related to the "stericsson,ab8500-pwm" compatible.
> > > 
> > > I know, I said I would drop discussion of that compatible, but bear
> > > with me for a second.  :-)
> > > 
> > > The "problem" is that the devices for multiple mfd child nodes with
> > > the same compatible value of "stericsson,ab8500-pwm" will all have
> > > a pointer to the first child node.  At the moment the same child
> > > of_node being used by more than one device does not cause any
> > > incorrect behavior.
> > > 
> > > Just in case the driver for "stericsson,ab8500-pwm" is modified
> > > in a way that the child of_node needs to be distinct for each
> > > device, and that changes gets back ported, it would be useful
> > > to have Fixes: tags for this patch series.
> > > 
> > > So, at your discretion (and I'll let you worry about the correct
> > > Fixes: tag format), this series fixes:
> > > 
> > > bad76991d7847b7877ae797cc79745d82ffd9120 mfd: Register ab8500
> > > devices using the newly DT:ed MFD API
> > 
> > This patch isn't actually broken.
> > 
> > The issue is the DTB, which [0] addresses.
> > 
> > [0]
> > https://lkml.kernel.org/lkml/20200622083432.1491715-1-lee.jones@linaro.org/
> 
> Now, I'm confused; because this patch doesn't use the reg property
> but a different node name.

The fix mentioned above is orthogonal to this set.

The *only* reason for the differing node names there is to circumvent
the following DTC warnings:

arch/arm/boot/dts/ste-ab8500.dtsi:210.16-214.7: ERROR (duplicate_node_names): /soc/prcmu@80157000/ab8500/ab8500-pwm: Duplicate node name
arch/arm/boot/dts/ste-ab8500.dtsi:216.16-220.7: ERROR (duplicate_node_names): /soc/prcmu@80157000/ab8500/ab8500-pwm: Duplicate node name
arch/arm/boot/dts/ste-ab8500.dtsi:216.16-220.7: ERROR (duplicate_node_names): /soc/prcmu@80157000/ab8500/ab8500-pwm: Duplicate node name

> I'd actually prefer this for any MFD
> driver which has multiple nodes of the same compatible string. See
> my reasoning here [1]. But until now, no one has responded. Thus,
> I'd rather see a OF_MFD_CELL_NAME() which matches the node name
> instead of the OF_MFD_CELL_REG() macro.
> 
> This would also circumvent the fact that the unit-address has one
> number space. Eg. it is not possible to have:
> 
> mfd {
>   compatible = "mfd,compatible";
> 
>   gpio@0 {
>     reg = <0>;
>   };
>   gpio@1 {
>     reg = <1>;
>   };
>   pwm@0 {
>     reg = <0>;
>   };
> };
> 
> Although Rob mentioned to maybe relax that, but I sill fail to see
> the advantage to have an arbitrary reg property instead of a unique
> node name.

I don't have a strong opinion either way.

We can *also* add node name matching if Rob deems it fit.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
