Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C98288CEE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389315AbgJIPiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388473AbgJIPiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:38:07 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481BAC0613D2;
        Fri,  9 Oct 2020 08:38:07 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 968D860B;
        Fri,  9 Oct 2020 15:38:06 +0000 (UTC)
Date:   Fri, 9 Oct 2020 09:38:04 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: submitting-patches: describe preserving
 review/test tags
Message-ID: <20201009093804.7a130063@lwn.net>
In-Reply-To: <20201007084306.12591-1-krzk@kernel.org>
References: <20201007084306.12591-1-krzk@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Oct 2020 10:43:06 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> From time to time, the novice kernel contributors do not add Reviewed-by
> or Tested-by tags to the next versions of the patches.  Mostly because
> they are unaware that responsibility of adding these tags in next
> version is on submitter, not maintainer.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/process/submitting-patches.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 58586ffe2808..9752b6311674 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -527,6 +527,13 @@ done on the patch.  Reviewed-by: tags, when supplied by reviewers known to
>  understand the subject area and to perform thorough reviews, will normally
>  increase the likelihood of your patch getting into the kernel.
>  
> +Both Tested-by and Reviewed-by tags, once received on mailing list from tester
> +or reviewer, should be added by author to the applicable patches when sending
> +next versions.  However if the patch is changed in following version, these
> +tags might not be applicable anymore and thus should be removed.  Usually
> +removal of someone's Tested-by or Reviewed-by tags should be mentioned
> +in the patch changelog (after '---' separator).

after *the* "---" separator

This is a bit ambiguous, though, since the point of sending a new version
of a patch is usually that it has changed.  I'm not quite sure how to best
articulate when a patch has changed enough that reviews and such are no
longer applicable...  If nothing else, "if the patch *has changed
substantially*" or something like that?

Thanks,

jon
