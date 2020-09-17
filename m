Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C24D26DA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgIQLnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:43:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgIQLjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:39:16 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECCB321734
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600342752;
        bh=2kFT8juYwsoWVzI7Gq+GsE3itaIadnAkZ07YinPSRLM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tvlPHrWAbfHzeALQ3FScCd2/cS8WzS7Z+m1J15aLvYrV2REfj3RMU4vd5mUus+WjJ
         I+CLBi3DxCghZTVCPYty6KplFv7CXtwGO5Tm3o4iUme6OyGRORe5Km31cd1/wkomIV
         Goj980jY6gxYDQlcTyBWByd1ZJ04ZaTTFsSWJeLw=
Received: by mail-lj1-f172.google.com with SMTP id b19so1706612lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:39:11 -0700 (PDT)
X-Gm-Message-State: AOAM530g7YEYyceWDj7OubtHT11TzuIfrhC8d+Mpt0od16XzFgsod+/J
        B4xXXoEJ8PVcm6t7d84JtopSx0E7LQH72faop/w=
X-Google-Smtp-Source: ABdhPJwoHeTsp9Hl9XkIyBQug7suvujQKpXb1f1sRZCguXUEwXE3AQHbyb1VPFKzFK7Tn3JsTZrDVGbiWNqlu6j+f+M=
X-Received: by 2002:a2e:a28b:: with SMTP id k11mr10380503lja.405.1600342750320;
 Thu, 17 Sep 2020 04:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200916160552.1062243-1-ribalda@kernel.org> <20200916162824.GC6374@sirena.org.uk>
 <CAPybu_20oay941cqHqa_D13cN0XCrk=Pa113ZuwbbAuVC3yX3A@mail.gmail.com> <20200917112203.GB4755@sirena.org.uk>
In-Reply-To: <20200917112203.GB4755@sirena.org.uk>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Thu, 17 Sep 2020 13:38:53 +0200
X-Gmail-Original-Message-ID: <CAPybu_2L5eK7SckELHxUsW72TZ8kG0TsTHbSn1Z6ohyUaPzQCg@mail.gmail.com>
Message-ID: <CAPybu_2L5eK7SckELHxUsW72TZ8kG0TsTHbSn1Z6ohyUaPzQCg@mail.gmail.com>
Subject: Re: [PATCH] regmap: Add support for 12/20 register formatting
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Mark

On Thu, Sep 17, 2020 at 1:22 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Sep 17, 2020 at 08:31:54AM +0200, Ricardo Ribalda Delgado wrote:
> > On Wed, Sep 16, 2020 at 6:29 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > What exactly is the format you're trying to describe here?  It sounds
> > > like there's two blocks of padding in here (I'm assuing that's what
> > > dummy means) but what's the exact arrangement here and what are the
> > > commands?  It sounds like this might not work ideally with things like
> > > the cache code (if it makes things seems sparser than they are) and
> > > might not be obvious to someone looking at the datsheet.
>
> > The format is
>
> > XXXXCCCCAAAADDDDDDDDDDDDDDDDXXXX
>
> > Where X is dont care, C is command, A is address and D is data bits. I
>
> > Shall I add this to the commit message? I want to send a V2 anyway,
> > because I screwed up the identity (ribalda.com instead of kernel.org)
>
> Yes, please.  I was fairly sure it worked, it was just a question of if
> it was ideal for the format described.  The only issue I can see with
> the above is that the users will need to left shift their data - on the
> face of it it would seem better to add a facility for padding the LSBs
> of the data field to the core so that users can just use the data field
> as documented.

I was thinking also about that, the problem is that there are many
devices on that family that are "software" compatible and it only
changes the width of the data. Eg:

DDDDDDDDDDDDDDDDXXXX
DDDDDDDDDDDDXXXXXXXX
DDDDDDDDXXXXXXXXXXXX

So if we need to make a driver, we could use the same driver for all
the chips on that family, saying to the user that the data size is
always 20 bits....

I will send v2 ASAP with the updated doc.

Thanks
