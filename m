Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2CB1BBE6F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 15:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgD1NA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 09:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgD1NA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:00:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B0CC206A1;
        Tue, 28 Apr 2020 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588078858;
        bh=5Ir3UpjZ3kYs3+3drjIzMAkoscWBNVFvMX3aVN4pc+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qa/2omsCXT/ZlQ0YBCv5wPm+ofuanYYMhcSrp+mEykw1fVmxANjAoArcEjNk/ilKl
         lGkYvnHaULq1RdiKacK7Ebkf+CZBVtEdW+aSvZiw+QM+ivkYX7IwNc7c5jjkm1Rnix
         kgRKb16/me63EjWFnTqd1+tOQfO/DS0J3t5PGYHs=
Date:   Tue, 28 Apr 2020 15:00:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Youngjun Park <her0gyugyu@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, her0gyu@naver.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fixup redundant indentation.
Message-ID: <20200428130056.GB1302692@kroah.com>
References: <20200424155334.17053-1-her0gyugyu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424155334.17053-1-her0gyugyu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 08:53:34AM -0700, Youngjun Park wrote:
> From: Youngjun Park <her0gyu@naver.com>
> 
> Signed-off-by: Youngjun Park <her0gyu@naver.com>
> 
> fixup redundant indentation on the label.
> ---
>  fs/kernfs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

signed-off-by needs to go last.

And this fix is not needed, the existing code is fine.

thanks,

greg k-h
