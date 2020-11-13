Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D022B27A7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgKMWDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgKMWBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:01:45 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938D1C0613D1;
        Fri, 13 Nov 2020 14:01:45 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 24FB94FA;
        Fri, 13 Nov 2020 22:01:45 +0000 (UTC)
Date:   Fri, 13 Nov 2020 15:01:44 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com, joe@perches.com, sir@cmpwn.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] Documentation: include sign off for reverts
Message-ID: <20201113150144.11316c0c@lwn.net>
In-Reply-To: <20201110174749.32068-1-yashsri421@gmail.com>
References: <20201110174749.32068-1-yashsri421@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 23:17:49 +0530
Aditya Srivastava <yashsri421@gmail.com> wrote:

> Currently, we do not have any documentation on commit reverts regarding
> the requirement of Signed-off-by tag for it. This may be misleading to
> the users.
> 
> Evaluating MISSING_SIGN_OFF checkpatch warnings on v4.13..v5.8 showed
> that 4 out of 11 cases missing a sign-off are revert commits.
> 
> Add documentation regarding the same to document the community
> consensus and let readers know.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
>  Documentation/process/submitting-patches.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 83d9a82055a7..fb8261a4be30 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -404,6 +404,8 @@ then you just add a line saying::
>  
>  using your real name (sorry, no pseudonyms or anonymous contributions.)
>  This will be done for you automatically if you use ``git commit -s``.
> +Reverts should also include "Signed-off-by". ``git revert -s`` does that
> +for you.

Applied, thanks.

jon
