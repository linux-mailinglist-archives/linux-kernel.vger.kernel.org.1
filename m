Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4B12B85F9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgKRUsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgKRUsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:48:07 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69840C0613D4;
        Wed, 18 Nov 2020 12:48:07 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DF9EE1F5B;
        Wed, 18 Nov 2020 20:48:06 +0000 (UTC)
Date:   Wed, 18 Nov 2020 13:48:05 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH] Documentation: kgdb: Fix a typo
Message-ID: <20201118134805.7304a9bf@lwn.net>
In-Reply-To: <1605519767-25502-1-git-send-email-yangtiezhu@loongson.cn>
References: <1605519767-25502-1-git-send-email-yangtiezhu@loongson.cn>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 17:42:47 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> "to into" -> "into"
> 
> Reported-by: Sergei Shtylyov <sergei.shtylyov@gmail.com>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  Documentation/dev-tools/kgdb.rst | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
> index 77b688e..4345624 100644
> --- a/Documentation/dev-tools/kgdb.rst
> +++ b/Documentation/dev-tools/kgdb.rst
> @@ -63,10 +63,9 @@ will want to turn on ``CONFIG_DEBUG_INFO`` which is called
>  It is advised, but not required, that you turn on the
>  ``CONFIG_FRAME_POINTER`` kernel option which is called :menuselection:`Compile
>  the kernel with frame pointers` in the config menu. This option inserts code
> -to into the compiled executable which saves the frame information in
> -registers or on the stack at different points which allows a debugger
> -such as gdb to more accurately construct stack back traces while
> -debugging the kernel.
> +into the compiled executable which saves the frame information in registers
> +or on the stack at different points which allows a debugger such as gdb to
> +more accurately construct stack back traces while debugging the kernel.

Applied.

In the future, though, please avoid refilling paragraphs when you make a
change like this; it makes it much harder to see what has actually changed.

Thanks,

jon
