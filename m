Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89E32B27D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgKMWIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:08:10 -0500
Received: from ms.lwn.net ([45.79.88.28]:50964 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgKMWII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:08:08 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9E4C14FA;
        Fri, 13 Nov 2020 22:08:07 +0000 (UTC)
Date:   Fri, 13 Nov 2020 15:08:06 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: link ubifs-authentication.rst
 without .rst extension
Message-ID: <20201113150806.364122cc@lwn.net>
In-Reply-To: <20201108132415.1789142-1-j.neuschaefer@gmx.net>
References: <20201108132415.1789142-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  8 Nov 2020 14:24:14 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> Specifying the .rst extension doesn't cause any problems AFAICT, but
> it's uncommon.
> 
> Fixes: 688f118e3139f ("docs: filesystems: convert ubifs-authentication.rst.txt to ReST")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/filesystems/index.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

jon
