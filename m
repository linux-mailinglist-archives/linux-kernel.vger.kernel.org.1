Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102802B85FC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgKRUtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:49:08 -0500
Received: from ms.lwn.net ([45.79.88.28]:46606 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgKRUtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:49:07 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6F34B2EF;
        Wed, 18 Nov 2020 20:49:07 +0000 (UTC)
Date:   Wed, 18 Nov 2020 13:49:06 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Wang Wenhu <wenhu.wang@vivo.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Chucheng Luo <luochucheng@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH doc] doc: zh_CN: add tmpfs to index tree
Message-ID: <20201118134906.6bb1b226@lwn.net>
In-Reply-To: <1605509272-13770-1-git-send-email-wangqing@vivo.com>
References: <1605509272-13770-1-git-send-email-wangqing@vivo.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 14:47:50 +0800
Wang Qing <wangqing@vivo.com> wrote:

> Add temfs to the index tree while adding tempfs translation.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  Documentation/translations/zh_CN/filesystems/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
> index 186501d..9f2a8b0
> --- a/Documentation/translations/zh_CN/filesystems/index.rst
> +++ b/Documentation/translations/zh_CN/filesystems/index.rst
> @@ -25,4 +25,5 @@ Linux Kernel中的文件系统
>  
>     virtiofs
>     debugfs
> +   tmpfs

Applied, thanks, with typos in the changelog fixed.

jon
