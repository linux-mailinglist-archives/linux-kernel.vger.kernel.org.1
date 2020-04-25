Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70581B85DB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 12:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDYK43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 06:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDYK43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:56:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6649320714;
        Sat, 25 Apr 2020 10:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587812189;
        bh=5WUhtskZxlE9n338vkgbHZfKEH8M1JzBUBkWJZF/qo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KoTEhf54SHrrXeIMq57jRFSwhq7z8lmvBEhiN2G45IYURC5nB2kO3riLOXxhhVS9i
         86ZuHW9IFyzVOWxsKA2t8qYJTqTPNtB1u4n7T5TkrHfU9F5e7iLfx7i2K1F3q1S714
         f3mV3oAuCkuhdy++lr18EtT4E9i6CFAcsl8vZ0kg=
Date:   Sat, 25 Apr 2020 12:56:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        linux-kernel@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 0/2] staging: vt6656: Check the return value of
 vnt_control_out_* calls
Message-ID: <20200425105626.GA2071483@kroah.com>
References: <20200423153836.5582-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423153836.5582-1-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 05:38:34PM +0200, Oscar Carter wrote:
> This patch series checks the return value of vnt_control_out_* function
> calls.
> 
> The first patch checks the return value and when necessary modify the
> function prototype to be able to return the new checked error code.
> 
> The second patch removes the documentation of functions that their
> prototype has changed as the function names are clear enought. Also,
> the actual documentation is not correct in all cases.
> 
> Changelog v1 -> v2
> - Remove the function's documentation instead of fix them as suggested
>   Malcolm Priestley.
> 
> Changelog v2 -> v3
> - Rebase against the staging-next branch of Greg's staging tree.

Are you sure?  It still doesn't apply :(

Please try again.

thanks,

greg k-h
