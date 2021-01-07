Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A038B2EE7CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbhAGVp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:45:59 -0500
Received: from ms.lwn.net ([45.79.88.28]:39016 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727713AbhAGVp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:45:58 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A52CA614F;
        Thu,  7 Jan 2021 21:45:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A52CA614F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610055917; bh=ShpXoPqiXbKHbFfWt1nojHL1kB6dg5xgyD91MNlmtyc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aibkbxKb5GQgAth+rS/fl0pMAjwA3DZUrQUM7JsI19qc4dDUyPkVsNpfuBbWdnFrr
         KYLwJrnrX3Q499+NDKr+DZwEx2C48hSDpKo9D4az8ObEo/cMBxTDe89aXYYWcfqe13
         fTbwe0fLw3MGaEX/sT34IlI50xGmShysP0V+a+wrZwA0K802pKzfp2m7xS4y7A2vAe
         vlwomRp3DduUEJw+z5Xr3/Sx22mfHmpnOb2PvqUtb8X3cCzgxOoLGGCeJjzlEF5cdg
         M0bosP6chX+OV5RoPsPB9VRtOS34agGWv/fspqnsByoOwjpOPyJHUITrLTq+2SfW0D
         EgSJDdQFYwUQw==
Date:   Thu, 7 Jan 2021 14:45:16 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     mhiramat@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] docs: admin-guide: bootconfig: Fix feils to fails
Message-ID: <20210107144516.2dc246d0@lwn.net>
In-Reply-To: <20210107125610.1576368-1-unixbhaskar@gmail.com>
References: <20210107125610.1576368-1-unixbhaskar@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Jan 2021 18:26:10 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> s/feils/fails/p
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/admin-guide/bootconfig.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index 9b90efcc3a35..452b7dcd7f6b 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -154,7 +154,7 @@ get the boot configuration data.
>  Because of this "piggyback" method, there is no need to change or
>  update the boot loader and the kernel image itself as long as the boot
>  loader passes the correct initrd file size. If by any chance, the boot
> -loader passes a longer size, the kernel feils to find the bootconfig data.
> +loader passes a longer size, the kernel fails to find the bootconfig data.

Applied, thanks.

jon
