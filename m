Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F721283C16
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgJEQHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgJEQG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:06:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CD6C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 09:06:58 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m34so6270445pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LGmWu344m4jMEqdBtYLPl0c0TkEOVMbk7UWio27A8Tk=;
        b=TkYSb/e7IOhIm473jbED8Jj8Gt7X//gQS0DCxhl2MpeHIO2cL//HrD1VNMgZDVv4Op
         tdc/OJZF1o+6GbyIiXng/RllmZiQFuDmKjRLk1Vq+b7jCiccz6QQ0uL1oUYIKBegc+5/
         LY8ZOCP+Ja5PacfngtFqf0IpWp+wUJnOauK2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LGmWu344m4jMEqdBtYLPl0c0TkEOVMbk7UWio27A8Tk=;
        b=qJpTKQPlT35zxMjecCkAaqiND7r/qpdPLoPy3D5e/lUo/4+Yp5SXZ8mHWMZxdsAD6N
         96VlzcuyHJOqyWBJok1ze0yOAN0Ci9EvQMtkAmtZ1bCb7PLu7OPBdBGHLw/YNX22HNnG
         vbw2dxCUSDPY1GhRfgTlsTA9KAHy62NLuAQF2m0NfN3AUlQKaql5kqF3u5iHylbT7IHq
         kZsC+MDL7L2ZG5YQSYpM/TuL+zjQKk2nbRtmtiVi0vdWi8psQbiQh1SWChtyrN/FOkBI
         z1w0nuOr6cnDvrL5S2ds4dW5MCwyGVom1OS4OvjDX3QM3iJLuwJs5wLQaHp49Ky5Busc
         Y4nA==
X-Gm-Message-State: AOAM5331USEPZ8PRkVCi2Q9CXsXuRMe+aPcJsdFa4AnnnpdOR9BjmqWO
        ioERW2xRVb/jXRO4WPZrSGjwZg==
X-Google-Smtp-Source: ABdhPJxoD4AkZV57gSQe+UrxBrkB+2XoPl8vTz2YUuZPZkWvT/re6yST0kT0PwW8roq357JyeEWMtA==
X-Received: by 2002:a63:1e0c:: with SMTP id e12mr178561pge.386.1601914017645;
        Mon, 05 Oct 2020 09:06:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id c67sm328060pfa.209.2020.10.05.09.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 09:06:56 -0700 (PDT)
Date:   Mon, 5 Oct 2020 09:06:55 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Rob Herring <robh@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete
 onboard USB hubs
Message-ID: <20201005160655.GA4135817@google.com>
References: <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu>
 <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
 <20201002183633.GA296334@rowland.harvard.edu>
 <CAL_JsqKHFA5RWz1SRLkR2JXydURL2pA+4C0+C+4SrJR_h4M0dw@mail.gmail.com>
 <20201003124142.GA318272@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201003124142.GA318272@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 08:41:42AM -0400, Alan Stern wrote:
> On Fri, Oct 02, 2020 at 05:58:22PM -0500, Rob Herring wrote:
> > On Fri, Oct 2, 2020 at 1:36 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > Regardless of how the situation is represented in DT, there remains the
> > > issue of where (i.e., in which driver module) the appropriate code
> > > belongs.  This goes far beyond USB.  In general, what happens when one
> > > sort of device normally isn't hooked up through a power regulator, so
> > > its driver doesn't have any code to enable a regulator, but then some
> > > system does exactly that?
> > >
> > > Even worse, what if the device is on a discoverable bus, so the driver
> > > doesn't get invoked at all until the device is discovered, but on the
> > > new system it can't be discovered until the regulator is enabled?
> > 
> > Yep, it's the same issue here with USB, MDIO which just came up a few
> > weeks ago, MMC/SD which hacked around it with 'mmc-pwrseq' binding
> > (not something I want to duplicate) and every other discoverable bus.
> > What do they all have in common? The kernel's driver model being
> > unable to cope with this situation. We really need a common solution
> > here and not bus or device specific hack-arounds.
> 
> To me this doesn't seem quite so much to be a weakness of the kernel's 
> driver model.
> 
> It's a platform-specific property, one that is not discoverable and 
> therefore needs to be represented somehow in DT or ACPI or something 
> similar.  Something that says "Device A cannot operate or be discovered 
> until power regulator B is enabled", for example.
> 
> The decision to enable the power regulator at system startup would be 
> kernel policy, not a part of the DT description.  But there ought to be 
> a standard way of recognizing which resource requirements of this sort 
> should be handled at startup.  Then there could be a special module (in 
> the driver model core? -- that doesn't really seem appropriate) which 
> would search through the whole DT database for resources of this kind 
> and enable them.

This might work for some cases that only have a single resource or multiple
resources but no timing/sequencing requirements. For the more complex cases
it would probably end up in something similar to the pwrseq series
(https://lore.kernel.org/patchwork/project/lkml/list/?series=314989&state=%2A&archive=both),
which was nack-ed by Rafael, Rob also expressed he didn't want to go
down that road.

It seems to me that initialization of the resources needs to be done by
the/a driver for the device, which knows about the sequencing requirements.
Potentially this could be done in a pre-probe function that you brought up
earlier.
