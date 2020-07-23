Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED85B22B237
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 17:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgGWPNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 11:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbgGWPNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:13:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 948F320771;
        Thu, 23 Jul 2020 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595517187;
        bh=bjP+t3vcFK/TJaMpjuhHN2sSEVOmcE09XJOsMG2/VCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njGxuA8ecQB07uRS7ajKvbbCv3NhuhB/9Uz6ECB99UCeX2eZruo77NPheI0h93WTE
         ZIpd5KOv+iDAJYjH4socC3yh/nET+NfUgKJb4jQdy9Y3+/PjJvDvS0hhdqIu3a+Fpi
         sQcBki7nbzL/qjxANeA9G1VpDAIOZns9XCk9WAsY=
Date:   Thu, 23 Jul 2020 17:13:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [char-misc-next 1/6] mei: hbm: use sizeof of variable instead of
 struct type
Message-ID: <20200723151310.GA2809544@kroah.com>
References: <20200723145927.882743-1-tomas.winkler@intel.com>
 <20200723145927.882743-2-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723145927.882743-2-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 05:59:22PM +0300, Tomas Winkler wrote:
> There is a possibility of bug when variable type has changed but
> corresponding struct passed to the sizeof has not.
> 
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/misc/mei/hbm.c | 74 ++++++++++++++++++------------------------
>  1 file changed, 32 insertions(+), 42 deletions(-)

This doesn't apply to my tree as I've applied Gustavo's patch.  Should I
revert that first?

thanks,

greg k-h
