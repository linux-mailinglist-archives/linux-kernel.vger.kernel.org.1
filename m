Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C11527EF5C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbgI3Qi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Qi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:38:26 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DE2C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:38:26 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f18so1526539pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eqA5Yjqpw1Bsw3FC6hiZcg7yvgPy9JdfdWyc2OK4tIE=;
        b=PpVNX5Y9JJh6419bg49cy6+3MOgsRfDFL1g8g2u6OJHxp++JDRl5u3F0iIFoeKOl75
         1cv54J0ZNDa362UQXdE13/cZOh3dR/qle0WjvvDgtTJqlJlk5b8OcUQAiB8Q1+tDkaWT
         8wbRHcc3Z2fNhqeXBIy6Bt0ndFewH953iC2Kk5BOkAuzNA/K1YCOYt1V8FXt0gMA3ErK
         mfkEIHRy4pXznLKOHyVG4yJYpuMLbR6Q/X5kyCq/VlJC4wbgCUG76kpHc/PJ36Dyc0XS
         ELRLfYkq0nM/1vrTZMjhUx8L7IoydK3jF+961/tC1IXS0PQYooi389Fa26gl5xnEp0YN
         GlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eqA5Yjqpw1Bsw3FC6hiZcg7yvgPy9JdfdWyc2OK4tIE=;
        b=GIpZMrb/tWzgoXnVGw8CzX4TYIzS+45A8Pd1027IUSsN5eNXmGO91RG1knn1bWcqYm
         i8Vc8f5Qv4AajrTX+DM13xEHvPMxeZ2362thsuyCvmIYP1GhZZHz56zORlX3eAaWLgv8
         +0ZvoJNKQ8lsVMnY3TSlxHTiX3epxGNhDbqZofyusH3jt5KJHSRpvdruy8z9bJQe3FnW
         TB5iYAGXFL+/N7feo9KZeBi2BGSIdmte/4QNMNglxgVjRkxRH8OS2LhvOxvQPB1tXBN3
         ufpcrKl3csNAquwFmi8e1Y7UwtWFy7Cm2s3CW7lBI/GYtvnngYjBhXYXSCtSe/ak/uS6
         y5Qw==
X-Gm-Message-State: AOAM530f3aGtQuDlFxCJJJn5cnbWrvrLIj7jjbtERq0D9aMU8JEFBhzB
        XSO6ngTYVRlsA32fCX/YB1M=
X-Google-Smtp-Source: ABdhPJz7dAO5ZXZWDbVclIyTNurrP6GFWR/1LUjuON2l0fXkKsA4f6ZjytNU54niyfKdzuFUl9Yv8w==
X-Received: by 2002:a62:d456:0:b029:13c:1611:66c2 with SMTP id u22-20020a62d4560000b029013c161166c2mr3403578pfl.13.1601483906178;
        Wed, 30 Sep 2020 09:38:26 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id e19sm3354451pfl.135.2020.09.30.09.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 09:38:25 -0700 (PDT)
Date:   Wed, 30 Sep 2020 09:38:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
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
Message-ID: <20200930163823.GA237050@ubuntu-m3-large-x86>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
 <cfce2276d172d3d9c4d34d966b58fd47f77c4e46.1599120059.git-series.maxime@cerno.tech>
 <20200929221526.GA1370981@ubuntu-m3-large-x86>
 <20200930140758.gummt3umouva3wyu@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930140758.gummt3umouva3wyu@gilmour.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 04:07:58PM +0200, Maxime Ripard wrote:
> Hi Nathan,
> 
> On Tue, Sep 29, 2020 at 03:15:26PM -0700, Nathan Chancellor wrote:
> > On Thu, Sep 03, 2020 at 10:01:52AM +0200, Maxime Ripard wrote:
> > > Now that all the drivers have been adjusted for it, let's bring in the
> > > necessary device tree changes.
> > > 
> > > The VEC and PV3 are left out for now, since it will require a more specific
> > > clock setup.
> > > 
> > > Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> > > Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> > > Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > 
> > Apologies if this has already been reported or have a solution but this
> > patch (and presumably series) breaks output to the serial console after
> > a certain point during init. On Raspbian, I see systemd startup messages
> > then the output just turns into complete garbage. It looks like this
> > patch is merged first in linux-next, which is why my bisect fell on the
> > DRM merge. I am happy to provide whatever information could be helpful
> > for debugging this. I am on the latest version of the firmware
> > (currently 26620cc9a63c6cb9965374d509479b4ee2c30241).
> 
> Unfortunately, the miniUART is in the same clock tree than the core
> clock and will thus have those kind of issues when the core clock is
> changed (which is also something that one should expect when using the
> DRM or other drivers).
> 
> The only real workaround there would be to switch to one of the PL011
> UARTs. I guess we can also somehow make the UART react to the core clock
> frequency changes, but that's going to require some effort
> 
> Maxime

Ack, thank you for the reply! There does not really seem to be a whole
ton of documentation around using one of the other PL011 UARTs so for
now, I will just revert this commit locally.

Cheers,
Nathan
