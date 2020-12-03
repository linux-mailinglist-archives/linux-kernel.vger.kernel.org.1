Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111BC2CDDED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgLCSnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:43:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgLCSnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:43:02 -0500
Date:   Thu, 3 Dec 2020 19:43:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607020941;
        bh=6zTrNQ15fBHs3TKhJrf/dtLFadkiV4i0+CpSsYHNVbI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=qDi5P1y5WZnSxloksrdUiiMOMX98kxPf713eQYcpUY1ZIAcTU0sqLPRST9MdLBp7I
         PCnfK0Dx//5tsHJwniEkM1NArvpJBi/t7scCcDZXCiosLOPey7MjMH81bSmVLx02lJ
         ftmI+w8Q8Uh/VCE4Y+/oNWfSgIMxo5JDa6dm1Sjk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Remove dead termiox code
Message-ID: <X8kx0E6999AZ5Y9j@kroah.com>
References: <20201203020331.2394754-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203020331.2394754-1-jannh@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 03:03:31AM +0100, Jann Horn wrote:
> set_termiox() and the TCGETX handler bail out with -EINVAL immediately
> if ->termiox is NULL, but there are no code paths that can set
> ->termiox to a non-NULL pointer; and no such code paths seem to have
> existed since the termiox mechanism was introduced back in
> commit 1d65b4a088de ("tty: Add termiox") in v2.6.28.
> Similarly, no driver actually implements .set_termiox; and it looks like
> no driver ever has.
> 
> Delete this dead code; but leave the definition of struct termiox in the
> UAPI headers intact.

Crazy that no one uses it.  Nice cleanup, thanks for doing this.

greg k-h
