Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5573D2FF1BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732578AbhAURX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388671AbhAURTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:19:09 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FF9C061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:18:21 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id g46so313304ooi.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sdkeh0H/7odHlGgSM5KxwBcQCuICyL1gellJmb8g1EE=;
        b=B4UiKakf+CLppJj2BZHh8SGKfCcTi9FCKdxud/q3tUFjM7DUuwQzrzPfgo150VDuja
         4F9o5Scz3+mw164ChBaOY/WqkVz2OuQ4v0gkkjn3vHosERlmDbUTnSusbz5Pg2bYlwsy
         3/k6LHVtfA03YbdGV7vS3geejXvqifjxtEj7fcIuAEtKb6R7/eTocINWT+kG8VDHfb6u
         TLxsD4GLKkKDd4tMJxfmXrX9Fo4JDGCfJckIjPlVFyp+VpJNGYhX3cE9qtlOdZX8bWyk
         gtOOD7KdMCsW1SFJAUIkLIJZ6dZ3flyuhTLYvfQBsQ9z+oYSR6IiRBUTv295OHa+G4iZ
         3u4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sdkeh0H/7odHlGgSM5KxwBcQCuICyL1gellJmb8g1EE=;
        b=MO8PnqxvX2pmRp2h0mpx31p3YxBi1OSBasG1+hLWQ1xrfg8BD9BXnoFmQpAUe3+FYN
         003D/L6jbDUHs1MXK0oELAK3C17LZO2nhfvwhCcF7TA1LTelVMSxBJ45EobfB7pnH9vx
         dTHOubEx3MrDLhY5fezoUr3PdY3HoOi5QJTFrvDM1xeE04TDNEHlrgUG6dhSqki7biR8
         Maxcm8xUaSeOYrlIZ8uLmDL/ZSO9HIWEOJVRIAomzquHdtZFFhjNMiIDQ8UN/k8KkFIg
         +oLcrT6qJ3BgvTo/r29BSu8vzGBaAiLeAU3mYaQ/xb4KngRlvzN5IiqwKwhgfk9ruJ/s
         zpxA==
X-Gm-Message-State: AOAM533UxW2wPa96OmFl2p+DiUtLt2FplvNPweuIV7XXFXigl5PXWqr8
        VB+J79eKL1erIbYrhkmoOuGgFw==
X-Google-Smtp-Source: ABdhPJx1t548ggsJoqDf/rrFArAC4Yn/ifb07D+0HaSlMPmVuth++NYTB9WHObDYGf6ak7IfbjxwTA==
X-Received: by 2002:a4a:98a3:: with SMTP id a32mr478259ooj.51.1611249500836;
        Thu, 21 Jan 2021 09:18:20 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r2sm1155200oie.1.2021.01.21.09.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 09:18:20 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:18:18 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: qcom: Define common TLMM
 binding
Message-ID: <YAm3Wjpfg2yIE9Wt@builder.lan>
References: <20210120222114.1609779-1-bjorn.andersson@linaro.org>
 <20210120222114.1609779-2-bjorn.andersson@linaro.org>
 <CACRpkdY6G_EP8QAp1C-eghdbgcgwQezA1ap=nDtSHPNqjuDF6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdY6G_EP8QAp1C-eghdbgcgwQezA1ap=nDtSHPNqjuDF6Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21 Jan 07:20 CST 2021, Linus Walleij wrote:

> On Wed, Jan 20, 2021 at 11:21 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> 
> > Several properties are shared between all TLMM bindings. By providing a
> > common binding to define these properties each platform's binding can be
> > reduced to just listing which of these properties should be checked for
> > - or further specified.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Overall it looks good, just cutting some slack for reviewers (especially
> DT people) before applying.
> 
> > +description:
> > +  This defines the common properties used to describe all Qualcomm TLMM
> > +  bindings and pinconf/pinmux states for these.
> 
> I vaguely recall asking you in the past what the acronym TLMM actually
> means. This would be a good place to expand the acronym so people
> know what these four letters actually represent.
> 

As Vinod said, it's used in a few places and I agree that we should
spell it out here.

In particular I had to include "phandle" in the list of valid properties
for for the dtbs_check to pass when there are references to state nodes,
so I would like to hear from Rob about that.

Will respin this after getting his input - hopefully with his Ack ;)

> (There, I finally gave you an official reason to go and poke Qualcomm
> hardware engineers about this. ;)
> 

:)

Regards,
Bjorn
