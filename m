Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72702E3EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 15:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505244AbgL1Oe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505225AbgL1Oe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:34:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69798207B2;
        Mon, 28 Dec 2020 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609166057;
        bh=PS/mKB4+Limn2Hoji3D2MdSRJN4+Qi2gS09ur5/6o4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X60GvXTt1KL400mVIdK+kzP4tBLi3II4riIqnm81zE+ZCuZ3Tfg2TsQt4r7F+1vW9
         U1+tay7ajuAB9H1BBR+PCO+qt2sz1lgyoV1jo0w1pE1J/069Um9FWaEYJPx5m4YEAs
         1NqVxInqEaT6bTxFHQsTXLhe7XZ3YHBxlbtbn8w0=
Date:   Mon, 28 Dec 2020 15:24:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] usb: host: use DEFINE_MUTEX() for mutex lock
Message-ID: <X+nqt/fncN9wZ8PQ@kroah.com>
References: <20201224132545.31677-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224132545.31677-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 09:25:45PM +0800, Zheng Yongjun wrote:
> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/usb/host/u132-hcd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

What changed from v1?  Again, please put that below the --- line and
resend a v3.

thanks,

greg k-h
