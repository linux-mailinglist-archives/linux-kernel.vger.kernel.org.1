Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DAF1A6697
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 14:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgDMM6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 08:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbgDMM6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:58:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9BBF2073E;
        Mon, 13 Apr 2020 12:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586782690;
        bh=IuesiDdKuTFLdMkQnFkzjJmikYEfulB5uV/jLl08rjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xZtaYU17UeaAIkLF9UXgHgSF2mMm8QOYQDtu2x4MeTJew13bk69BH3xeXewew6SM8
         fufkJS3Q4Xq7SAH0D3nmNN+aa6hGmKq/72syMNVpUA5MpryegVI4nxe22dB67PZ8Fh
         ll20MIUHL+YLHf7zMNYgtxyQcyS7aV+IZ/JcMMgM=
Date:   Mon, 13 Apr 2020 14:58:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] staging: vt6656: Use BIT() macro instead of bit shift
 operator
Message-ID: <20200413125808.GA3140872@kroah.com>
References: <20200412093311.5279-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200412093311.5279-1-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 11:33:11AM +0200, Oscar Carter wrote:
> Use the BIT() macro instead of the bit left shift operator. So the code
> is more clear.
> 
> It's safe to remove the casting to u16 type because the value obtained
> never exceeds 16 bits. So the casting is unnecessary.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  drivers/staging/vt6656/card.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

This too did not apply :(
