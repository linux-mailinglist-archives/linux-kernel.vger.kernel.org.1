Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52B11A669B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 14:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgDMM7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 08:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgDMM7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:59:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45F6C206DA;
        Mon, 13 Apr 2020 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586782774;
        bh=idXQW+yIFFWo5382aZ8Okt15T8N6elOKHZ6SROy0oy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lUND/la/4JHwJIFtbVLUTRYdQTposg/JMgwISwidYD7maBiNemQJr3gdA69GY3i2q
         ku+nASaD9cnWajqfJO0q+H0gUOHN9IF6qvN1CZ9KMwjtSIi2CnCM4V/4s5YshBh/dF
         GyjB6neqbZOMAiJLA323fQWQSvOQYNivgZPlwxKo=
Date:   Mon, 13 Apr 2020 14:59:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Return error code in
 vnt_rf_write_embedded function
Message-ID: <20200413125932.GA3150182@kroah.com>
References: <20200413101931.6334-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413101931.6334-1-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 12:19:31PM +0200, Oscar Carter wrote:
> Use the error code returned by the vnt_control_out function as the
> returned value of the vnt_rf_write_embedded function instead of a
> boolean value.
> 
> Then, fix all vnt_rf_write_embedded calls removing the "and" operations
> and replace with a direct assignment to the ret variable and add a check
> condition after every call.
> 
> Also replace the boolean values true or false in the vnt_rf_set_txpower
> function to 0 or error code EINVAL to follow the coding style guide.
> 
> The vnt_rf_set_txpower function is called only in the vnt_rf_setpower
> function that already returns error codes. The calls to this function
> (vnt_rf_set_txpower) not use the returned values, so they not need to be
> fixed.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  drivers/staging/vt6656/rf.c | 99 ++++++++++++++++++++++++-------------
>  1 file changed, 64 insertions(+), 35 deletions(-)

This too did not apply :(
