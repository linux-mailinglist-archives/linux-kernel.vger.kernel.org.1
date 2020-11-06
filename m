Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956B92A9F41
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgKFVjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFVjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:39:23 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940E5C0613CF;
        Fri,  6 Nov 2020 13:39:21 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id o129so2600580pfb.1;
        Fri, 06 Nov 2020 13:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7aTWPGVFVbBWyajMT43VMslcFxXhz4VtDG2Makyw31Y=;
        b=r6p4t2hBK6TaeQb58ushb4iE+SAEpBwSj1UGF6u7fYvIqBs1cEHVzdSxjnk/UvBUhQ
         W8cQNHQveNpdu6qA1gOQgeBjly7CjVn0ieNdMmJ4AE1PhT0tBGdqAE2ATyQXtl53Rdac
         ZSEHU6hmqv482cXm79+gjmSgYiVcLHmHBSB9ASlPgGe12tTIZ7BslHv0PrUoTc6QNCzB
         Y4D1M3FoogsQTPU2TEZ8iGOdBXFfpwexcOJliySVCXgf/GT2xq991kkYGm2s66q1CwTr
         P9yJmfhZKmDkC/LbEoObcnYCPuhL8uq3lxzJN/aUEe2Rfj/NIp1IosQuoV/x4T5dC36U
         Xlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7aTWPGVFVbBWyajMT43VMslcFxXhz4VtDG2Makyw31Y=;
        b=Vxl4/pgZfwVJzZFpWYO18lQP5sBGo0tmoetquqOp4a0A3h9Az+OBviyLHrHlB/qGZX
         8nNvpkdJ0LAl7z5uU8m/ccTtBPia7nnp33HbJwTueUy6G3JGDrUIo/aRBafeOGfE/ZSj
         KUJhrF0PJBIJcHCbKDlqBlIQ+I9xA8RgOliUjyRFt76jvRlu071l0CkkRIKof3dkZ/az
         1NWPSUDsFoyPjRUNsP4aU+baOfReBiJpw+XrMeQGx1QsPZ7/JD28JbjBcozLJNqUQrfd
         0MSiLU6oYclCPoRb964bVF9Yj4Kst7F0l8Canqs5oXnE2Snki5Ggz7EJk5NZqIEafBvq
         y2hA==
X-Gm-Message-State: AOAM531vQMVSt/nbOytd5MZIHf8Pd4dwBABGyVDwHN1Ega5pi1fuMwkU
        baoA0pgDsbZQ5iAafTynoBGXGhgCig2c7A==
X-Google-Smtp-Source: ABdhPJwpIojmp9b1+/us6ZoC1XobJl4twTivXTCrNIPeHZ3z7HJtN7EZ21TixK2ffUkYFiMgVC+9xw==
X-Received: by 2002:a17:90a:1f0b:: with SMTP id u11mr1596531pja.105.1604698761088;
        Fri, 06 Nov 2020 13:39:21 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u22sm2689423pgf.24.2020.11.06.13.39.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Nov 2020 13:39:20 -0800 (PST)
Date:   Fri, 6 Nov 2020 13:27:08 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz,
        Xiubo.Lee@gmail.com, festevam@gmail.com, robh+dt@kernel.org,
        timur@kernel.org, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: fsl_aud2htx: Add binding doc
 for aud2htx module
Message-ID: <20201106212707.GA3927@Asurada-Nvidia>
References: <1604281947-26874-1-git-send-email-shengjiu.wang@nxp.com>
 <160466365499.22812.9217467877032314221.b4-ty@kernel.org>
 <20201106122013.GB49612@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106122013.GB49612@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 12:20:13PM +0000, Mark Brown wrote:
> On Fri, Nov 06, 2020 at 11:54:23AM +0000, Mark Brown wrote:
> > On Mon, 2 Nov 2020 09:52:26 +0800, Shengjiu Wang wrote:
> > > AUD2HTX (Audio Subsystem TO HDMI TX Subsystem) is a new
> > > IP module found on i.MX8MP.
> > 
> > Applied to
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Sorry, looks like me queueing this raced with the review comments coming
> in.  I think the review commments are small enough that it'll be OK to
> fix incrementally?

Yes. I am okay if we move forward with this version.

Thanks
