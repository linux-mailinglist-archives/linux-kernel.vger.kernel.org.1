Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA45220D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 14:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbgGOMi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 08:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgGOMi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:38:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A379C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 05:38:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so2481409wrl.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 05:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LYB3XSDUMnHdlWFprV2rE30wciQRc69IYNFNbj/F1bY=;
        b=xeIFXTr4AmTN6OdwluWqgUnoTJOP8T1RhkvjuBEoyfhtiv3eAUhofIMMiIs07Hhes/
         fndKc3BfJyuE5uXK8HJvyoyZ3KF0sEi8xtBPHE80bn8f6iEaWS6ZT+USGVrdpQucr+QJ
         dhodW2lKwzSdxSI4UkMKMIKkx+9i/ArBm8shhBhbVmyBcWo7ODZqN3PEXi6SIfUJtg55
         9Ub9yylNVw2nA1o1Nr0iBv1QGk6PuXnNHNuqtHbCGogHIfN9qOlqvv2Gmpjdhhbg9ztY
         uCZNEW7Je5Be31So1JYhWJQJ/aIXxD4MAUUdsLDAJn5inM9Oolvsh9hiEo8iDWWGuPG0
         BiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LYB3XSDUMnHdlWFprV2rE30wciQRc69IYNFNbj/F1bY=;
        b=nNpPB4gR/MsMJqg+jZggyqEraHXA2cXjeyZSRiWyJX5qxzdCnVwlOmn3puuUoz5t93
         zmtqJO8Q30fdveTIm4Z5bcLbhkkJjvA0+OJG1h+FcWmpgZzMXRiJeQ88zjhKNYdSxPAq
         UOzt14xurn/+NOcZ9KfwXJ7HMAtjwK/EzN1C0Ir1CsAYcSGwzhddlMpFcmoRXRKA3oEE
         wstSpPUb6422gDh6BWgoPE9w8uJkILS/9LdhcUoGfNIX3FkAQbLC8a3Ze9KbfMzHCTDc
         wbfCxnMFTvqscOoyOBTf2fkXMqUwerjUtiOn0qEnf/Y15OJiimqNdNCr8xt8RijWlnWJ
         LtYQ==
X-Gm-Message-State: AOAM531TgiE1I3RPDAa5JB4I2fJpU2mINUPQWUO1+Rk2gkmPh3KeLVMx
        3X/PJAlZ0/Fgxt5mzCf7YEug2w==
X-Google-Smtp-Source: ABdhPJwsP5IWmvcwXKeY1GgtjlESQSfxCcqN/aD8H6qcXMJc3nEsEPIx2wyrADP48feZON5coUBEEg==
X-Received: by 2002:a5d:4707:: with SMTP id y7mr10911923wrq.261.1594816736903;
        Wed, 15 Jul 2020 05:38:56 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id g13sm3535582wro.84.2020.07.15.05.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 05:38:56 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:38:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Sadykov <denis.m.sadykov@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dominik Brodowski <linux@brodo.de>
Subject: Re: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
Message-ID: <20200715123854.GF3165313@dell>
References: <20200714210340.GJ1398296@dell>
 <20200715032442.gh2cliiddhv35fdj@vireshk-i7>
 <20200715032718.2zlo2eurhkpoayya@vireshk-i7>
 <CAJZ5v0jHJDLt6QFWG9FOpqmWMXAUuSEPHdHbVgFWcwR6FQD57Q@mail.gmail.com>
 <20200715113433.GB3165313@dell>
 <CAJZ5v0gFwYj7KKKj806s5SdWO1Wu5exiwObKKAdQWQEKg+2CJA@mail.gmail.com>
 <20200715115029.GC3165313@dell>
 <CAJZ5v0hJf2BwDvmtD6UEyyxm-CGcA=SLmAt+F8Sr0ceDZji0jw@mail.gmail.com>
 <20200715121657.GE3165313@dell>
 <4ba45e6b-7c49-7a7b-ae76-12d912629e4d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ba45e6b-7c49-7a7b-ae76-12d912629e4d@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020, Robin Murphy wrote:

> On 2020-07-15 13:16, Lee Jones wrote:
> > On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
> > 
> > > On Wed, Jul 15, 2020 at 1:50 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > 
> > > > On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
> > > > 
> > > > > On Wed, Jul 15, 2020 at 1:34 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > 
> > > > > > On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
> > > > > > 
> > > > > > > On Wed, Jul 15, 2020 at 5:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > > > > > 
> > > > > > > > On 15-07-20, 08:54, Viresh Kumar wrote:
> > > > > > > > > On 14-07-20, 22:03, Lee Jones wrote:
> > > > > > > > > > On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:
> > > > > > > > > > 
> > > > > > > > > > > On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > > > > > > > 
> > > > > > > > > > > > Can't see them being used anywhere and the compiler doesn't complain
> > > > > > > > > > > > that they're missing, so ...
> > > > > > > > > > > 
> > > > > > > > > > > Aren't they needed for automatic module loading in certain configurations?
> > > > > > > > > > 
> > > > > > > > > > Any idea how that works, or where the code is for that?
> > > > > > > > > 
> > > > > > > > > The MODULE_DEVICE_TABLE() thingy creates a map of vendor-id,
> > > > > > > > > product-id that the kernel keeps after boot (and so there is no static
> > > > > > > > > reference of it for the compiler), later when a device is hotplugged
> > > > > > > > > into the kernel it refers to the map to find the related driver for it
> > > > > > > > > and loads it if it isn't already loaded.
> > > > > > > > > 
> > > > > > > > > This has some of it, search for MODULE_DEVICE_TABLE() in it.
> > > > > > > > > Documentation/driver-api/usb/hotplug.rst
> > > > > > > > 
> > > > > > > > And you just need to add __maybe_unused to them to suppress the
> > > > > > > > warning.
> > > > > > > 
> > > > > > > Wouldn't that cause the compiler to optimize them away if it doesn't
> > > > > > > see any users?
> > > > > > 
> > > > > > It looks like they're only unused when !MODULE,
> > > > > 
> > > > > OK
> > > > > 
> > > > > > in which case optimising them away would be the correct thing to do, no?
> > > > 
> > > > It would be good if someone with a little more knowledge could provide
> > > > a second opinion though.  I would think (hope) that the compiler would
> > > > be smart enough to see when its actually in use.  After all, it is the
> > > > compiler that places the information into the device table.
> > > > 
> > > If that is not the case, then the MODULE_DEVICE_TABLE() magic is
> > > > broken and will need fixing.
> > > 
> > > I'm not sure why that would be the case?
> > 
> > Nor me.  In fact, take a look at my latest email.  I think I just
> > proved out that it's not broken.  The warning is valid and
> > MODULE_DEVICE_TABLE() appears to work just as it should.
> 
> I won't claim to be an expert at all, but...
> 
> For !MODULE, MODULE_DEVICE_TABLE() expands to nothing, so after
> preprocessing the static variable is literally unreferenced.
> 
> Otherwise, MODULE_DEVICE_TABLE() emits an extern declaration of another
> variable which is defined via the "alias" attribute to refer to the symbol
> of the static variable. Thus the compiler presumably has to treat it as
> potentially accessible from other compilation units such that it can't be
> optimised away.

Right.  That's essentially how I'm reading it.

> > > > Removing boiler-plate is good, but not at the expense of obfuscation.
> > > 
> > > I'm not following you here to be honest.
> > 
> > Never mind.  It's no longer important.
> > 
> > > BTW, I'm wondering if removing the "static" modifier from the
> > > definitions of the structures in question makes the warnings you want
> > > to get rid of go away.
> > 
> > I'm sure that it would.  But that just alludes to the fact that the
> > tables may be in use elsewhere, which in the case of !MODULE is
> > untrue.  That's probably more of a hack than using __maybe_unused.
> 
> Right, that just ends up with someone sending another patch changing it back
> to shut up "variable foo was not declared, should it be static?" warnings
> from Sparse ;)

Exactly.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
