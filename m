Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF712746CE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIVQk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgIVQk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:40:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E0142399A;
        Tue, 22 Sep 2020 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600792827;
        bh=T0AaL2yG9qq9Q0JTKDbHYBQ/UoJxQqIKcEEzX23lw6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pCzVd8nV0bfFJzZr3jMy4+1Ukx5v/c8/FgvFZhVsBhoBsB7Bas5thE2cuYwb32qFk
         491wdrJ2tP7JKQl5SKp465DVgBZZmssYtdn8f7Z/3zuM5CViks1aIxssC3r6oTfrly
         0klO30jXue4Yfqha+UOqK4DnH3Naiiy8vSB2afsQ=
Date:   Tue, 22 Sep 2020 18:40:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.10-rc1
Message-ID: <20200922164013.GB2322802@kroah.com>
References: <20200922160837.GA6025@ogabbay-VM.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922160837.GA6025@ogabbay-VM.habana-labs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 07:08:37PM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This is habanalabs pull request for the merge window of kernel 5.10. It
> contains many small improvements to common and GAUDI code. Details are in
> the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit 8fd0e2a6df262539eaa28b0a2364cca10d1dc662:
> 
>   uio: free uio id after uio file node is freed (2020-09-17 18:52:03 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-09-22

Pulled and pushed out, thanks.

greg k-h
