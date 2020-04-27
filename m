Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7EB1BA61B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 16:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgD0OSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 10:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbgD0OSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:18:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B519C206B6;
        Mon, 27 Apr 2020 14:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587997092;
        bh=zXQ51mgKn2086N6wizSp+QElbF+XlMV+kXnI1pYIupo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHBDofvS1ltNw6wWUrFj55BdrcHAE70kn5woRvDyehi5xL+/TT4oRzt1Ml7SBMnef
         vFNOYaZfQeW/NwSztgHp9kwV6aO2xMmBMnVMPWLI9VCvYCX2XDVhhs1Sf53m2A+LCK
         ppdFpHrESeOTXvt38mBbE1npB34ytmj0WdOt4mXo=
Date:   Mon, 27 Apr 2020 16:18:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     devel@driverdev.osuosl.org, hslester96@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: staging: rts5208: rtsx.c fix Unbalanced
 braces around else statement issue
Message-ID: <20200427141810.GB3158628@kroah.com>
References: <20200427135212.26285-1-john.oldman@polehill.co.uk>
 <20200427135212.26285-2-john.oldman@polehill.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427135212.26285-2-john.oldman@polehill.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 02:52:12PM +0100, John Oldman wrote:
> Make a better job of fixing coding style issues, this time fixing 
> all blocks as per Joe Perches' comment.

Trailing whitespace :(

> 
> Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
> ---
>  drivers/staging/rts5208/rtsx.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 

You sent 2 patches with identical subject lines, yet they do different
things, which is not ok.  Please fix up.

greg k-h
