Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4737D294BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 13:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442009AbgJUL3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 07:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442001AbgJUL3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:29:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A7E121D43;
        Wed, 21 Oct 2020 11:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603279742;
        bh=mb6gxbYo4kXZH1EqgEcFGVGcbOdWMouSl83SoB7CbN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ouxnjBqFjS90eFacvshDol1iQ1mKPcm8mdUGtt6o6xjXnrAcxak7KD06xczu2vION
         vKExABZsGdPkIqmLOJLOvkUuSAfhmn0JpL28txIpFix3TUO5QtoAkQu1eFUciRO90t
         +VY19LKbI2pBbJFrC2a7dt8cbbeHg8oiQotKSaLo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6F434403C2; Wed, 21 Oct 2020 08:29:00 -0300 (-03)
Date:   Wed, 21 Oct 2020 08:29:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     =?iso-8859-1?Q?=C9rico?= Rolim <erico.erc@gmail.com>,
        dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Hao Luo <haoluo@google.com>, Andrii Nakryiko <andriin@fb.com>
Subject: Re: Segfault in pahole 1.18 when building kernel 5.9.1 for arm64
Message-ID: <20201021112900.GN2342001@kernel.org>
References: <CAFDeuWM7D-Upi84-JovKa3g8Y_4fjv65jND3--e9u-tER3WmVA@mail.gmail.com>
 <82b757bb-1f49-ab02-2f4b-89577d56fec9@kernel.org>
 <20201020122015.GH2294271@kernel.org>
 <f7246cb6-901e-0bc3-eb18-194d1754da53@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7246cb6-901e-0bc3-eb18-194d1754da53@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 21, 2020 at 08:22:40AM +0200, Jiri Slaby escreveu:
> On 20. 10. 20, 14:20, Arnaldo Carvalho de Melo wrote:
> > > Yeah, I observe the very same. I reported it at:
> > > https://bugzilla.suse.com/show_bug.cgi?id=1177921

> > Would it be possible to try with
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.libbtf_encoder
> > ?
 
> Yes, that branch fixes the crashes and the kernel build finishes. The
> zero-sized symbol error remains.
 
> So what should distributions do now -- should we switch to a pahole snapshot
> for a while?

That would do the trick, I just completed my testing and pushed to the
master branch on kernel.org and github, tests detailed at:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=040fd7f585c9b9fcf4475d294b3f5ddf78405297

There are some minor bug reports I want to address but my ETA right now
is the end of this week to release v1.19.

- Arnaldo
