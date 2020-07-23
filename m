Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E7322B4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 19:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgGWR26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 13:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgGWR26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:28:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2835A20714;
        Thu, 23 Jul 2020 17:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595525337;
        bh=VkdDKS0wN9LZ9uHZh7M2Y+USkmugM8r/87cp7BNkqhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UwCI8+k1hDpdbuZUG5lr/L4L8Udn9SrtdS6b+mPP3r0OqMl7mhQcdycrgMaBSrquz
         CB9HnfsRx0WsnmEnLFc9pBYcKxB2s0VNqQPCBnPUtMxRpnFODnVMZPja7zh0X2KwLw
         C9SjMRMyrB5WSdAVfnlLt4T7ry22VP1bYEyAPUCw=
Date:   Thu, 23 Jul 2020 19:29:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [char-misc-next 1/6] mei: hbm: use sizeof of variable instead of
 struct type
Message-ID: <20200723172901.GA2840395@kroah.com>
References: <20200723145927.882743-1-tomas.winkler@intel.com>
 <20200723145927.882743-2-tomas.winkler@intel.com>
 <20200723151310.GA2809544@kroah.com>
 <a59b37f7-db9b-02f1-98c3-3207db213e3b@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59b37f7-db9b-02f1-98c3-3207db213e3b@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 12:04:06PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 7/23/20 10:13, Greg Kroah-Hartman wrote:
> > On Thu, Jul 23, 2020 at 05:59:22PM +0300, Tomas Winkler wrote:
> >> There is a possibility of bug when variable type has changed but
> >> corresponding struct passed to the sizeof has not.
> >>
> >> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> >> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> >> ---
> >>  drivers/misc/mei/hbm.c | 74 ++++++++++++++++++------------------------
> >>  1 file changed, 32 insertions(+), 42 deletions(-)
> > 
> > This doesn't apply to my tree as I've applied Gustavo's patch.  Should I
> > revert that first?
> > 
> 
> Yep; this series doesn't take into account my patch. I'm OK with
> reverting it, so we can apply this series.

Ok, will do, thanks!

greg k-h
