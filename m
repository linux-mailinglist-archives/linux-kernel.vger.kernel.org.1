Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0392280641
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbgJASJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbgJASJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:09:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633F4C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 11:09:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 5so4637844pgf.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PtuekNoU7BQ4fWy1XFBKnyR+pN5uqF4DdrBhyKg+UhM=;
        b=Xabcep2JhqLck7//1CRquAZmQYOXu3EpJ669MtMcS89PDB7ToYcTSsFmV42ajY+V7Z
         9ZX6B+Vzqv9lyFNTmHhPWviy17UBWN6BR3agnBurKZ5lfykjBp+iqmHpvPCbZgN1CBf8
         yHdjifmzyluVwk24JlHZd4nyiPRN8CbjTjo/rPZkECLadK8z6mX0LQQifbBu+S+qFoeo
         FjiMKXSC+LFzy476AWpAahvpoqyWvDV11iMF2PaKmibl26QHVCTy86AeREGd8jn7YcW4
         9OmsREnu7mhjy4sGMbHZmZxa33gmoWUDb7zPd6GcfkCH07wzoyqjPi0+15r1pExIRclb
         F9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PtuekNoU7BQ4fWy1XFBKnyR+pN5uqF4DdrBhyKg+UhM=;
        b=TbFv4m/Bsa1wqhJ6cEq+5fp1Se+upxYGYpJgZ8kl2FRdL1POycDqrmkwIe/9KYYpUh
         nkoZ9Uk+f6qYG5AEuctfY0VwAt7MCxiwf6dfRQ5KIayOor3zUAD7niT/rKlwOVVhXqRP
         GOHFG0haXbOvfjg2NhU5V9zOcUmUiOikhpF9Ceql93dwyQtILpWwfxfVOeZTPNJwsj6d
         Boa5e3P7chtcgE1coXION8QvOfcZ1DG4gmHebiNuU5itlJ2y0HHAzVNdov5JxXXuiO+K
         WgTQkewCI5/q725Zg2c0C/a/G7f8lwAWAGj9szZUDe0r9q2fbmfFcJPxg6Dm/HpMVjSo
         ILMg==
X-Gm-Message-State: AOAM530zHMzcQBKPb6+5aTVspetDnWZh5ITTHL0A0rqM695g0gP/ndP+
        pC7scaSvVtc2TIq1gV3phYw=
X-Google-Smtp-Source: ABdhPJzHJmF1lu+SRWpH0rtjLB2oVFYm3H6n4cv/c3dkIIDnjTeHT5RLa+NY7PYfMTE3TLudRL7udQ==
X-Received: by 2002:a17:902:848a:b029:d2:4276:1b00 with SMTP id c10-20020a170902848ab02900d242761b00mr3880436plo.36.1601575750784;
        Thu, 01 Oct 2020 11:09:10 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id e2sm6072137pgc.29.2020.10.01.11.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 11:09:10 -0700 (PDT)
Date:   Thu, 1 Oct 2020 11:09:08 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Maxime Ripard <maxime@cerno.tech>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 80/80] ARM: dts: bcm2711: Enable the display pipeline
Message-ID: <20201001180908.GA3159642@ubuntu-m3-large-x86>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
 <cfce2276d172d3d9c4d34d966b58fd47f77c4e46.1599120059.git-series.maxime@cerno.tech>
 <20200929221526.GA1370981@ubuntu-m3-large-x86>
 <20200930140758.gummt3umouva3wyu@gilmour.lan>
 <20200930163823.GA237050@ubuntu-m3-large-x86>
 <eb0c0edaf22404fd69440a85bb78397a14d49ddc.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb0c0edaf22404fd69440a85bb78397a14d49ddc.camel@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 11:22:03AM +0200, Nicolas Saenz Julienne wrote:
> On Wed, 2020-09-30 at 09:38 -0700, Nathan Chancellor wrote:
> > On Wed, Sep 30, 2020 at 04:07:58PM +0200, Maxime Ripard wrote:
> > > Hi Nathan,
> > > 
> > > On Tue, Sep 29, 2020 at 03:15:26PM -0700, Nathan Chancellor wrote:
> > > > On Thu, Sep 03, 2020 at 10:01:52AM +0200, Maxime Ripard wrote:
> > > > > Now that all the drivers have been adjusted for it, let's bring in the
> > > > > necessary device tree changes.
> > > > > 
> > > > > The VEC and PV3 are left out for now, since it will require a more specific
> > > > > clock setup.
> > > > > 
> > > > > Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > > > Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> > > > > Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> > > > > Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> > > > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > > > 
> > > > Apologies if this has already been reported or have a solution but this
> > > > patch (and presumably series) breaks output to the serial console after
> > > > a certain point during init. On Raspbian, I see systemd startup messages
> > > > then the output just turns into complete garbage. It looks like this
> > > > patch is merged first in linux-next, which is why my bisect fell on the
> > > > DRM merge. I am happy to provide whatever information could be helpful
> > > > for debugging this. I am on the latest version of the firmware
> > > > (currently 26620cc9a63c6cb9965374d509479b4ee2c30241).
> > > 
> > > Unfortunately, the miniUART is in the same clock tree than the core
> > > clock and will thus have those kind of issues when the core clock is
> > > changed (which is also something that one should expect when using the
> > > DRM or other drivers).
> > > 
> > > The only real workaround there would be to switch to one of the PL011
> > > UARTs. I guess we can also somehow make the UART react to the core clock
> > > frequency changes, but that's going to require some effort
> > > 
> > > Maxime
> > 
> > Ack, thank you for the reply! There does not really seem to be a whole
> > ton of documentation around using one of the other PL011 UARTs so for
> > now, I will just revert this commit locally.
> 
> Nathan, a less intrusive solution would be to add 'core_freq_min=500' into your
> config.txt.
> 
> Funnily enough core_freq=500 doesn't seem to work in that regard. It might be
> related with what Maxime is commenting.
> 
> Regards,
> Nicolas
> 

Excellent, thank you for the tip, that worked well!

Cheers,
Nathan
