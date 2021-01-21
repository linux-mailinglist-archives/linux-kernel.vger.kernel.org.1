Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AF32FEAE1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbhAUM6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:58:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729301AbhAUKco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:32:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEBAC233EA;
        Thu, 21 Jan 2021 10:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611225123;
        bh=9Mx+3eVOwHs7zpRPVOJbEpYl3wDBoqN73S/6c9d/6T0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jBVjsx0g1d5PMZvsC1UgS+pe9y0VRej1qi4+I4mIIwGzjGZJYwSDCDzeSW0ovSi4O
         QKza0NJTv75T6ELTxHREEWZ6yB30Y2jlGanmLUmJn/WCZ3YtZhEEQXSifaUtRzJj5w
         UrwJgBfhALvVSWYPHngMyhpx0m8zrUOyE5EmOMrHr0lkQS/eydbHLxH9I0LeVYh+1z
         ex3z3WH5LjfJ1xrFO+gRWFFT7l5MIRtGAkXWtnIgntpUuTxA54heY992/xyq9z/rI5
         eTExhosc/g+7XUsfjjlhwaTUD8nhpYoJcG65fjiVI+zOxTMMcCw8G2Kr6K/RC2mobS
         Jo+Ky1Lo7t7ww==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l2XG6-0004ZT-1Z; Thu, 21 Jan 2021 11:32:10 +0100
Date:   Thu, 21 Jan 2021 11:32:10 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Pho Tran <pho.tran@silabs.com>
Subject: Re: [PATCH] USB: serial: cp210x: suppress modem-control error on
 open and close
Message-ID: <YAlYKjRYOzmTht7D@hovoldconsulting.com>
References: <20210121102922.17439-1-johan@kernel.org>
 <20210121102922.17439-2-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121102922.17439-2-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 11:29:12AM +0100, Johan Hovold wrote:
> The CP210X_SET_MHS request cannot be used to control DTR/RTS when
> hardware flow control is enabled and instead returns an error which is
> currently logged as:
> 
> 	cp210x ttyUSB0: failed set request 0x7 status: -32
> 
> Add a crtscts flag to keep track of the hardware flow-control setting
> and use it to suppress the request in dtr_rts().
> 
> Note that both lines are still deasserted when disabling the UART as
> part of close().
> 
> Also note that TIOCMSET is left unchanged and will continue to return an
> error to user-space when flow control is enabled (i.e. instead of
> disabling and re-enabling auto-RTS when RTS is deasserted and
> re-asserted).
> 
> Reported-by: Pho Tran <pho.tran@silabs.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Oops, this one wasn't supposed to be submitted again. Please ignore.

Johan
