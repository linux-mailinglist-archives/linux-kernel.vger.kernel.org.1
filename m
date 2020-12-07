Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5692D1B92
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgLGVAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:00:54 -0500
Received: from ms.lwn.net ([45.79.88.28]:45156 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgLGVAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:00:53 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5CB6D2F3;
        Mon,  7 Dec 2020 21:00:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5CB6D2F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1607374813; bh=Mvfz3wfx4t1iZKoJ0/5aShbqfDEpKtAnqPt6O8wfHsA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P+uTd8ir2wrqcGVkUXEDCyAt7uHrqZ0/oY9Gf+B8IVzwbjaMK1JIFrnsgLqzcEGOW
         qwak4gOi1GEbKAWi3kDnSadcThioE1cXX0ZU9PhVFOVHuhzkUT+fDT/7YhuIt+jI3e
         YngOguh9NjjR3CjW0ga7+vbRK8MEOQhV4gMITu5aMQdUMzuHWHgXBi7bGTMF7I7tjk
         QGlYmLX4TS4zj03hNZNvHcdU/Lj/tRsxfpsfMjLKKHnRT5extpZDml9LBhY2n+n52H
         2UWtRkYEAclLmYneUsn/iyQarWuKDDrJxZd7SNW2ZbBsom66Wk/3IO8bYDFKL8SGmG
         l2WINNlZk4/Ew==
Date:   Mon, 7 Dec 2020 14:00:12 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: nios2: add missing ReST file
Message-ID: <20201207140012.2f4cf4da@lwn.net>
In-Reply-To: <e51c4692c4420d28bca35f553a9a3f3d78404d99.1607331056.git.mchehab+huawei@kernel.org>
References: <20201207185257.1198e407@canb.auug.org.au>
        <e51c4692c4420d28bca35f553a9a3f3d78404d99.1607331056.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Dec 2020 09:56:20 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> changeset ed13a92d0fde ("docs: archis: add a per-architecture features list")
> besides having a typo on its title, it was missing the feature file.
> 
> Add it.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: ed13a92d0fde ("docs: archis: add a per-architecture features list")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> Jon/Stephen,
> 
> I ended forgetting to add this one to the patch I sent. Sorry for that!
> 
> If not too late, feel free to fold this patch with the past one.
> 
>  Documentation/nios2/features.rst | 3 +++
>  1 file changed, 3 insertions(+)
>  create mode 100644 Documentation/nios2/features.rst
> 
> diff --git a/Documentation/nios2/features.rst b/Documentation/nios2/features.rst
> new file mode 100644
> index 000000000000..8449e63f69b2
> --- /dev/null
> +++ b/Documentation/nios2/features.rst
> @@ -0,0 +1,3 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-feat:: $srctree/Documentation/features nios2

I've applied this, thanks.

jon
