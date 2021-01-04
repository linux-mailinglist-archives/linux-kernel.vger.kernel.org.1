Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E862E98F0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbhADPfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:35:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727679AbhADPfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:35:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1F532225E;
        Mon,  4 Jan 2021 15:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609774502;
        bh=tUlL9yn5ELVhqvInaFRCYNJL3pyZoP9Qh20Bgq4Gcxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDqvFLQmBVSzLsCbkDlopNtpXzaRjez82gKxh2/pI3+76tc6yYeB/tOET5qJQMZVt
         vh5cLduPA842au86oac10hDIPiZz3r84SIj3zO012DNYntDPbgNSpI+KB3UGcFZtr/
         JUqsKN9gPBYwF/CeFHe88/cCvqhL18FG2IWJ2zzo=
Date:   Mon, 4 Jan 2021 16:36:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jack Pham <jackp@codeaurora.org>, Felipe Balbi <balbi@kernel.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: gadget: u_audio: remove struct uac_req
Message-ID: <X/M1/Jq7Bx3xFRuL@kroah.com>
References: <20201221173531.215169-1-jbrunet@baylibre.com>
 <20201221173531.215169-4-jbrunet@baylibre.com>
 <X+nzWs3nOrcqu4F2@kroah.com>
 <20201229222949.GC31406@jackp-linux.qualcomm.com>
 <1jr1n0x0aa.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jr1n0x0aa.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 03:08:13PM +0100, Jerome Brunet wrote:
> 
> On Tue 29 Dec 2020 at 23:30, Jack Pham <jackp@codeaurora.org> wrote:
> 
> > Hi Greg and Jerome,
> >
> > On Mon, Dec 28, 2020 at 04:01:46PM +0100, Greg Kroah-Hartman wrote:
> >> On Mon, Dec 21, 2020 at 06:35:30PM +0100, Jerome Brunet wrote:
> >> > 'struct uac_req' purpose is to link 'struct usb_request' to the
> >> > corresponding 'struct uac_rtd_params'. However member req is never
> >> > used. Using the context of the usb request, we can keep track of the
> >> > corresponding 'struct uac_rtd_params' just as well, without allocating
> >> > extra memory.
> >> > 
> >> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> > ---
> >> >  drivers/usb/gadget/function/u_audio.c | 58 ++++++++++++---------------
> >> >  1 file changed, 26 insertions(+), 32 deletions(-)
> >> 
> >> This patch doesn't apply, so I can't apply patches 3 or 4 of this series
> >> :(
> >> 
> >> Can you rebase against my usb-testing branch and resend?
> >
> > From the cover letter:
> >
> > On Mon, Dec 21, 2020 at 06:35:27PM +0100, Jerome Brunet wrote:
> >> The series depends on this fix [0] by Jack Pham to apply cleanly
> >> 
> >> [0]: https://lore.kernel.org/linux-usb/20201029175949.6052-1-jackp@codeaurora.org/
> >
> > My patch hadn't been picked up by Felipe, so it's not in your tree
> > either, Greg. Should I just resend it to you first?  Or shall I invite
> > Jerome to just include it in v2 of this series?
> 
> Indeed. I rebased on usb-testing and the series applies cleanly with
> Jack's changes, as decribed in the cover-letter.
> 
> If it is easier, I'm happy to include Jack's change in the v2, along
> with the fixed PATCH 2 fixed.
> 
> Greg, would it be OK with you ?

That's fine with me.
