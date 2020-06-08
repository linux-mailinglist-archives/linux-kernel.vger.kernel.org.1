Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52D81F1270
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 07:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgFHFPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 01:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgFHFPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 01:15:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7BA20774;
        Mon,  8 Jun 2020 05:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591593320;
        bh=RwwqNtSWXtwOCL6Vp+u2+tFCW/QKBn0b1Ql4owdjkbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIv4hI/tV7QY1un109kqXOVtOmtQHh9mfgNtVgsNo4PQl2Tc0hqrnZJ2w/qHNSdTY
         RoCkHyhloGNu9sF9Azs4cMjP9xdNn3ItBqoO6hT2SWS52mQux7heGGSvzacUeJxm/t
         HWPD7PfBoIYc0VBCwZByasSwe39fUBq5v9fCytdg=
Date:   Mon, 8 Jun 2020 07:15:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rodolfo C. Villordo" <rodolfovillordo@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Forest Bond <forest@alittletooquiet.net>,Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,devel@driverdev.osuosl.org,linux-kernel@vger.kernel.org
Message-ID: <20200608051516.GA237669@kroah.com>
References: <20200607224156.GA24090@ip-172-31-24-31.ec2.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607224156.GA24090@ip-172-31-24-31.ec2.internal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 10:41:56PM +0000, Rodolfo C. Villordo wrote:
> Multiple line over 80 characters fixes by splitting in multiple lines.
> Warning found by checkpatch.pl
> 
> Signed-off-by: Rodolfo C. Villordo <rodolfovillordo@gmail.com>
> ---
>  drivers/staging/vt6655/rxtx.c | 225 ++++++++++++++++++++++++----------
>  1 file changed, 162 insertions(+), 63 deletions(-)
> 

Your subject is a bit odd :(
