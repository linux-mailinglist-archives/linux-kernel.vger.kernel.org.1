Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D43283F74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgJETSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbgJETSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:18:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF957C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 12:18:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so6613382pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 12:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3GA56NAT+rDqMXV6hlkrQNn+gOyv5hJPGyi8gBGz2Yw=;
        b=Q9MEsXX0361UUwV7RuVD/f0AKxW7z6wkFZdTRrgWCTYOfgH577knEikRgtzBHQjMjT
         npieQ9L0cO6YMbO9IpY6eJPPMihiD9dMciZQBeFIUd080itgkBLZ5bijX9xOlUr9LPPC
         w3wuJAbkk1nAMWytYU9SF4dfcGLrMkvFlZcAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3GA56NAT+rDqMXV6hlkrQNn+gOyv5hJPGyi8gBGz2Yw=;
        b=XWQy8ba48BD9V9NfbGGDFOg2wOV6UrahpctOTh/EtBYGkclOUhHVJscvHAWsXg4D5/
         7lBC3HW9wcHAZg5CcA4gmjdX905GwlJ0eg4hWlhxW18iwn6IGX2qke0UaM7Few1x3Zli
         /hEd0KYFT9PhDqE89176NVaxqv1cZk9htLmw1GPGhKtzN2q45B93sOyUCcTgeiQoNJFc
         OBmKG+RUCXx27y/Q6xDvPDoqArR1yy97buONuWnXpu0f8eA+usawivFBgDwyfjIM3htp
         BlXtIZzW6Sb6qudZaxbEEqBsn4Frnt3RdjSu+8mthVRJ4kqdB5d9blL3L+vaKqViDYHB
         cW1A==
X-Gm-Message-State: AOAM53068FZnVq7pCvRxrUvdCkrtnMDhisStxmwuG2dZ36fsyg3rd/7O
        ZYRvidfv6m9ahEPhcbABo/2aZw==
X-Google-Smtp-Source: ABdhPJybYrDyDmNEj+u3/qlEH3IdseL3kHfXOlCVbiW/p1EWpvW/cAS0DSyWz22/1QvVdrp4IgDZrQ==
X-Received: by 2002:a63:d50a:: with SMTP id c10mr1007307pgg.26.1601925494272;
        Mon, 05 Oct 2020 12:18:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id fv13sm334222pjb.50.2020.10.05.12.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 12:18:13 -0700 (PDT)
Date:   Mon, 5 Oct 2020 12:18:12 -0700
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
Message-ID: <20201005191812.GB4135817@google.com>
References: <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
 <20201002183633.GA296334@rowland.harvard.edu>
 <CAL_JsqKHFA5RWz1SRLkR2JXydURL2pA+4C0+C+4SrJR_h4M0dw@mail.gmail.com>
 <20201003124142.GA318272@rowland.harvard.edu>
 <20201005160655.GA4135817@google.com>
 <20201005161527.GI376584@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005161527.GI376584@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 12:15:27PM -0400, Alan Stern wrote:
> On Mon, Oct 05, 2020 at 09:06:55AM -0700, Matthias Kaehlcke wrote:
> > On Sat, Oct 03, 2020 at 08:41:42AM -0400, Alan Stern wrote:
> > > The decision to enable the power regulator at system startup would be 
> > > kernel policy, not a part of the DT description.  But there ought to be 
> > > a standard way of recognizing which resource requirements of this sort 
> > > should be handled at startup.  Then there could be a special module (in 
> > > the driver model core? -- that doesn't really seem appropriate) which 
> > > would search through the whole DT database for resources of this kind 
> > > and enable them.
> > 
> > This might work for some cases that only have a single resource or multiple
> > resources but no timing/sequencing requirements. For the more complex cases
> > it would probably end up in something similar to the pwrseq series
> > (https://lore.kernel.org/patchwork/project/lkml/list/?series=314989&state=%2A&archive=both),
> > which was nack-ed by Rafael, Rob also expressed he didn't want to go
> > down that road.
> > 
> > It seems to me that initialization of the resources needs to be done by
> > the/a driver for the device, which knows about the sequencing requirements.
> > Potentially this could be done in a pre-probe function that you brought up
> > earlier.
> 
> One of the important points of my suggestion was that the resource init 
> should be done _outside_ of the device's driver, precisely because the 
> driver module might not even be loaded until the resources are set up 
> and the device is discovered.
> 
> The conclusion is that we need to have code that is aware of some 
> detailed needs of a specific device but is not part of the device's 
> driver.  I'm not sure what the best way to implement this would be.

Wouldn't it be possible to load the module when the DT specifies that
the device exists? For USB the kernel would need the VID/PID to identify
the module, these could be extracted from the compatible string.

Having the initialization code outside of the driver could lead to code
duplication, since the driver might want to power the device down in
certain situations (e.g. system suspend).
