Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFCB2A5FDA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgKDIt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgKDIt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:49:26 -0500
Received: from kernel.org (unknown [87.71.17.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8205B206DB;
        Wed,  4 Nov 2020 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604479766;
        bh=YjV8drwtbCKLQgPVP1Fm9MmP9SfbtUGj8UOQKGuV/As=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mdof30MlU5fx/72EQbF4RNf0tmeF2AD2NHfeqJj1/kb3FjG8AGj3Alsl0kyWzErVk
         VUyuY2siPE+szmVdAyUsMhQHM4cmlSIzzUudLJrWB3DR1osf5izmwIFPe82DDRQ/7t
         qnjBxvWsmLD8wTGTx/vkTv5VNxiN6N7PiADDeio4=
Date:   Wed, 4 Nov 2020 10:49:19 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM, xtensa: highmem: avoid clobbering non-page aligned
 memory reservations
Message-ID: <20201104084919.GM4879@kernel.org>
References: <20201031094345.6984-1-rppt@kernel.org>
 <CAMo8BfLCfpZcQC3oqEvExSqZ+dT2sVDjcXoaO_XKALn4rGjoog@mail.gmail.com>
 <20201031171608.GB14628@kernel.org>
 <CAMo8BfJ4ai4UHD36JZb2ETiFe9SeqpVQw5tsNLrSF8sUx11ccQ@mail.gmail.com>
 <CAMj1kXFmi4+1FmLk-0kSL8sSMDgftLTArwf_6hONLkyMJk+srg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFmi4+1FmLk-0kSL8sSMDgftLTArwf_6hONLkyMJk+srg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 09:35:14AM +0100, Ard Biesheuvel wrote:
> On Sat, 31 Oct 2020 at 18:44, Max Filippov <jcmvbkbc@gmail.com> wrote:
> >
> > On Sat, Oct 31, 2020 at 10:16 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > On Sat, Oct 31, 2020 at 09:37:09AM -0700, Max Filippov wrote:
> > > > On Sat, Oct 31, 2020 at 2:43 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > > > Please let me know how do you prefer to take it upstream.
> > > > > If needed this can go via memblock tree.
> > > >
> > > > Going through the memblock tree sounds right to me.
> > >
> > > Can I treat this as Ack?
> >
> > Sure, for the xtensa part:
> > Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> >
> 
> Could we get this queued up please?

It's in memblock/fixes now, I'd like to have it in next for day or two.

-- 
Sincerely yours,
Mike.
