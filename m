Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074AB2DFE26
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgLUQpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:45:36 -0500
Received: from ms.lwn.net ([45.79.88.28]:45818 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgLUQpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:45:36 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 789DC9B2;
        Mon, 21 Dec 2020 16:44:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 789DC9B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1608569093; bh=0x4bn3amvPabhwdRTkhgk2jOAl4RQkmRqo6ffszm8fo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d4pKIq4gWbaUU/f/5dNJ1HZDv9XXaO+JofyEAYCXGAJZI0htgIhnJgT4XSInSmyzv
         D9HPAAyT8nfsZ2AtZ9OPgHLv34wYN7mELVE+H7BdKEUhAtVozUJ+7mH+tCCYtkebQc
         h5cAWiFhMOhh1Xahch2xKucc8vmX4qnfl76y/ej2WGEuMzFt6i9heuGv9+VUayKYEa
         0UZLlhWP8TSCrbfMuiAjWskI0FcMeyBbbJo28+jGiiYbcERNQu+FJBU6k0AojFl7hm
         Lrl5Aq9l3bZthA30TbRJpWTTl0LtMfmKQ5Zee/uT+mZaUKmQAi1mtk9Mj6sq6qlcFp
         dwZ9uhpeyprxg==
Date:   Mon, 21 Dec 2020 09:44:52 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/1] docs: submitting-patches: Trivial - fix grammatical
 error
Message-ID: <20201221094452.02851661@lwn.net>
In-Reply-To: <20201216134654.271508-1-lee.jones@linaro.org>
References: <20201216134654.271508-1-lee.jones@linaro.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020 13:46:54 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> "it is a used" does not make sense.  Should be "it is used".
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/process/submitting-patches.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index fb8261a4be308..2c48a00a436e7 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -446,7 +446,7 @@ patch.  This tag documents that potentially interested parties
>  have been included in the discussion.
>  
>  Co-developed-by: states that the patch was co-created by multiple developers;
> -it is a used to give attribution to co-authors (in addition to the author
> +it is used to give attribution to co-authors (in addition to the author

Applied, thanks.

jon
