Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616932216C1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 23:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGOVDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 17:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgGOVDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:03:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7721C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:03:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a23so1038724pfk.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hRzNY1JDvrNXSdO8U7l97e0qNXhN4R2q/raGpfh2xSg=;
        b=M0a6hIftqMPigj4qmdMeWnqpRS3Mhy/U/7tUxAJxo7OSSYbXSs1F2eHV2Got5uVniB
         fnnxdnC9ZZJqASAvHEjKtn37vsFNBdsR0Y+c7kAeDJx9/bg+oiwPjtcgbgWSxF45qxW/
         +YUIUkpaCLuGaqFeYoJ7IQUIUHnjtTDVdO2eOUlLAEZc+mqjD5ce/+F+m7DsX6qxzgsf
         zt3i0YoDpSePFWCBoqV0JgX2k1GtNZd9x0PsQ6mObkRRhuqa8i13bcNSo0ft2Yhdpy+8
         FlYet5jyBRKAe9z/e6RkiL/kXCrQdGGuqn8MWdizP19m3CiL1UddjV1tqOIDudAmNzml
         3zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hRzNY1JDvrNXSdO8U7l97e0qNXhN4R2q/raGpfh2xSg=;
        b=szYciO7S96I35LaePNsF6Ceo1iAAgsApLwPGnoXx1DVX6DwNLDuPLtELD2ep+rcmNN
         j3puD9PwxsJtvHC1Gg2rvQgUtQ1EkHBYgQJYSHhS/J3yqfg3OFtP5DMIvKuellQzq5e4
         Ib6lMwxu+xU/yBPbpazOjd6ZAf/OHYApAxapPEen3ytfOAOM9uOIxsc/7SnYoOL28vZ4
         qTSdXALp3S2FBQsghHmYcQtL/URhQgU4iUIZnmIWDz/qFY++OT7K2aChisp4RjFYgVo9
         CN+CCA3PcbZSI86Vzy9rN0KUzCIDmM/6prt08HrQeCUwEHSkF9h9b6Eco2DwvqbyxdyA
         VZwQ==
X-Gm-Message-State: AOAM531Ij6HOzWltZ0Z3a0CN24alKPsJ5qHUCRu87LDKw3g5qnEIc3Xl
        XquQllhQeSElf+cLALQfHRQKwra4Zug=
X-Google-Smtp-Source: ABdhPJzJmgyhP7wX+GxWvJnVu0WYkg3Mrtb2coBAaKPhmJ2puWco+JxG7AG7U8wtv2nQBQYdGGywbw==
X-Received: by 2002:a62:e919:: with SMTP id j25mr957900pfh.123.1594847013262;
        Wed, 15 Jul 2020 14:03:33 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id y7sm2949173pjy.54.2020.07.15.14.03.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 14:03:33 -0700 (PDT)
Date:   Wed, 15 Jul 2020 14:03:08 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 0/4] ASoC: fsl_asrc: allow selecting arbitrary clocks
Message-ID: <20200715210308.GA14589@Asurada-Nvidia>
References: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
 <20200702184226.GA23935@Asurada-Nvidia>
 <3f39a0bb-a766-f646-28b3-a51cf9983c6b@collabora.com>
 <3fea8912-63df-ff27-0c29-6284a85107ab@collabora.com>
 <20200714201544.GA10501@Asurada-Nvidia>
 <20200714202753.GM4900@sirena.org.uk>
 <20200714205050.GB10501@Asurada-Nvidia>
 <20200715140519.GH5431@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715140519.GH5431@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 03:05:19PM +0100, Mark Brown wrote:
> On Tue, Jul 14, 2020 at 01:50:50PM -0700, Nicolin Chen wrote:
> > On Tue, Jul 14, 2020 at 09:27:53PM +0100, Mark Brown wrote:
> 
> > > The nominal rate might be the same but if they're in different clock
> > > domains then the actual rates might be different (hence the desire for
> > > an ASRC I guess).  I can see the system wanting to choose one clock or
> > > the other on the basis of some system specific property (quality of the
> > > clock sources, tolerances of the devices involved or something) though
> > > it's a rather fun edge case configuration :/ .
> 
> > Thanks for the input. Fox i.MX6, I don't feel it would be that
> > drastically different though. And both SSI1 and SSI2 can simply
> > select the same root clock source to avoid that happen.
> 
> If you've got two radios that both need to sync to some radio derived
> frequency it gets a bit more entertaining.

I'm simply curious what could be a problem. Do you mind educating
me a bit? And ASRC here isn't a radio but a sample rate converter
working as a BE in DPCM setup, using radio-capture for example...
