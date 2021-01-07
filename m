Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1B92ED38E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 16:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbhAGPb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 10:31:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbhAGPb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:31:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DFB8224B0;
        Thu,  7 Jan 2021 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610033478;
        bh=Xb/OryXbIvuQ9xk17LvU0wVCWg5Lqq9GXtoBiaBCfyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LjMaCWt4QUuFOCUH1RtDPvjXYndcG87JWo7VKYi6huHvY/vx3EsRgoNgNGe4HNol7
         b3TZA8LL0U0gzdPoCR+Sok/Pm0aGARgCLdLFGX1tejvwddPwdfIpTWm5RNAAdpEufY
         2BB4lEEMCUnS9mv7E6o6b682DCSoffunmws2SEng=
Date:   Thu, 7 Jan 2021 16:32:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     minyard@acm.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        brian.bloniarz@gmail.com
Subject: Re: [PATCH 0/2] drivers:tty:pty: Fix a race causing data loss on
 close
Message-ID: <X/cplo+nw5IaG3CJ@kroah.com>
References: <20201124004902.1398477-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124004902.1398477-1-minyard@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 06:49:00PM -0600, minyard@acm.org wrote:
> I finally got some time to spend with this issue, and I think I have a
> good fix.  Not really a v2, this is a completely different fix.
> Basically, calling tty_vhangup() on the slave when closing a pty master
> is just a bad idea.
> 
> >From what I can tell, the tty_vhangup() is there in case there was a
> console redirect to the pty slave.  When you close the master, you need
> to release the redirect.  I didn't see another reason for tty_vhangup().
> So this has two parts, export the release of the tty redirect release
> for the pty code to use, and call it from the pty code.
> 
> With this change, everything seems to work ok and no data is lost on the
> slave side if the master closes with outstanding data.  I have updated
> my test program to check that all written data is read, it's available
> at https://sourceforge.net/projects/ser2net/files/tmp/testpty.c/download
> 
> But, this code is quite intricate and I certainly may have missed
> something.

Tricky stuff, but I think this makes sense, so let's see how the
test-builders and linux-next work with this...

thanks,

greg k-h
