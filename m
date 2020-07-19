Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6B822517B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 13:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgGSLF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 07:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgGSLF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 07:05:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 653C92065E;
        Sun, 19 Jul 2020 11:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595156726;
        bh=YlJtL/LZmuxlJGPHCVKpVrk2xtAJ6lZY7jAqb30NAzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+cilKhSdWwLjuFYmalbTYfbx//v4KVr2UefRwyU1wgXYKOMioTu5hnvUOSZQDopu
         Cg9jXRE5iaIid2hJRofw33kZUY3aJqzUrixUSx4oEmvqsKWly7mc09RMSAF+1Y2GSi
         000oSkRcVAxTlEvauVd6Y8pm3Umfxo18+htDSAJM=
Date:   Sun, 19 Jul 2020 13:05:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Darshan D V <darshandv10@gmail.com>
Cc:     yuehaibing@huawei.com, ardb@kernel.org, contact@christina-quast.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8192e: Fixed a coding style error
Message-ID: <20200719110538.GB266150@kroah.com>
References: <20200719092236.GB171181@kroah.com>
 <20200719105557.12605-1-darshandv10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719105557.12605-1-darshandv10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 04:25:56PM +0530, Darshan D V wrote:
>     rtllib_crypt_ccmp.c: Fixed the error - space required before the
>     open parenthesis '(' on line #281.

What does this mean for a changelog text?

And why is it indented?

Did you read the section in the submitting patches document about how to
write a changelog text?  Perhaps you might want to re-read that :)

> Signed-off-by: Darshan D V <darshandv10@gmail.com>

Is this how you sign legal documents?  If so, great, but I have to ask.

thanks,

greg k-h
