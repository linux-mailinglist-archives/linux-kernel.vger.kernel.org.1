Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABBE21F85E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 19:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgGNRm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 13:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgGNRm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:42:29 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7666F22519
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 17:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594748548;
        bh=UYSzTeAGbFgBNNEZdY6cVueTgpx/4wjOzCgBidnhIzo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t8Vn5QubLFjkxoPTzw3UVzMVkbfAhMSe3PvnnO1r/3m1FbnckmRuvZ31AVCnNX2sM
         5hUCz2adAqj6z23qniZB8Fo4xKm/VyMswZqulBD6ipF+PfnSltgYK+4TAi2V0DOYF1
         zSFUQzr5OfbNBdBarJ9A0NvurJi1mQIwmzox0VyI=
Received: by mail-ot1-f52.google.com with SMTP id h13so13676726otr.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:42:28 -0700 (PDT)
X-Gm-Message-State: AOAM532abMA/WBSknDhxcq2UDvhSvhKAFxBbVQLsVTZpUO+sZdpmRBmr
        Sn5J/R4T0ME8/2yDa4CqYMs+8f+c0A+7JoqZWg==
X-Google-Smtp-Source: ABdhPJzYZz+VgDT8uruGleSybj6j3KFM7WUrqtCXZ04004fhkD9xWdUXVWJ6bfi4eU+IQ7BOkrnJJICi5Vy9+M1z5a8=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr4828206otb.107.1594748547877;
 Tue, 14 Jul 2020 10:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200714094141.147418-1-thierry.reding@gmail.com>
 <CAL_Jsq+c5+QFpdiNK4K=ROPAhxp=SMYS6iRFuJKooin=NbCiXw@mail.gmail.com> <8d7ebe02cfbff19f31f6ac1ce098f98d8ba1850a.camel@perches.com>
In-Reply-To: <8d7ebe02cfbff19f31f6ac1ce098f98d8ba1850a.camel@perches.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Jul 2020 11:42:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+HUUXRVoLN1OH3YXNYG=z4jyBJu_Z9qMb6L3K6vwXZiA@mail.gmail.com>
Message-ID: <CAL_Jsq+HUUXRVoLN1OH3YXNYG=z4jyBJu_Z9qMb6L3K6vwXZiA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch.pl: Allow '+' in compatible strings
To:     Joe Perches <joe@perches.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:12 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-07-14 at 10:21 -0600, Rob Herring wrote:
> > On Tue, Jul 14, 2020 at 3:41 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > The current checks will interpret a '+' character as special because
> > > they use regular expression matching. Escape the '+' character if it
> > > appears in a compatible string.
> >
> > Ugg, looks like c6x really liked using '+'. Might need to be added in
> > schema checks, too. Not sure offhand.
>
> These are the non alphanumeric characters used in .dts and .dtsi files
> with 'compatible=' strings
>
> - 44115
> , 32035
> . 1131
> _ 259
> + 46
> / 18
> ) 5
> ( 5
>
> So it looks like
>
>         "("
>         ")"
>
> need to be added and escaped too
>
> ?

No, those are 'regulator-compatible' AFAICT which is something else
and deprecated.

Rob
