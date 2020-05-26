Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E141CEC69
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 07:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgELFYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 01:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725814AbgELFYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 01:24:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318DEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 22:24:14 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s20so4889467plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 22:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jfC4N65vXGbABmirxUbwuTEeeDvoR72Zy98HX99h9ok=;
        b=AOfsAxk5BJNVbrevyPvI8/HrGs/eeWO+2y1kNk+7R0AKyBO+OOFSxI12CRfKgEI7j+
         naT8Xg2NzTkyKRcJ9M7CqujnbiYZM3VBaZs9v+04O8phv559Pzk5AS3cgNKVY/kGfKJy
         qEX8Byz+9n6strmwgZ64FUAJNNmRjUXAuXKaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jfC4N65vXGbABmirxUbwuTEeeDvoR72Zy98HX99h9ok=;
        b=Mi+BJgeA2lpVflngYy9zro7jq2384tjK2c7oQWMMdfL54na9ApZ35SvvO3ZOE8jmEl
         RuhT+NBW1Xg+hqz2tjQhIKZ0N31p+T8qwHDJt1EeDz2Hp0KnqyopWwI2eA+6aSEFlS7Q
         kG1AafQjLG+MeTZ9oNKBSfvF6cbTE6jAQ5Crzc1oXmpW7mtkvHAI+aJgQloMxtjzLrsT
         ea5LAK1e8tw79BJMbqD8pFT1EtQ248ISSaw3tZjHoY1i9xpP4J25Pist3v4xInuw1YaC
         M0CoMdbFRkS+eGSw2XKIU/XWHjbnOBavdtsZUP/+PFeO1/2PoEIh3sTt90B5b+p7+ZMA
         +RLA==
X-Gm-Message-State: AOAM531ZX6v80kBFTrLLQant+LTK2oc7kaBJ1RMSmyVhlygIhTp28fY5
        k59N+nqaEkzYbVRKY2YU2rkp8A==
X-Google-Smtp-Source: ABdhPJxl1Ugzm578aHj3k9+WEXeAs8KN2PSPhcPvtRj92RMTWYBi22PNpuPubFjaea1ILBbMle6V5A==
X-Received: by 2002:a17:90a:19c9:: with SMTP id 9mr1610623pjj.77.1589261053505;
        Mon, 11 May 2020 22:24:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 1sm10921354pff.180.2020.05.11.22.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 22:24:11 -0700 (PDT)
Date:   Mon, 11 May 2020 22:24:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: eventlog: Replace zero-length array with
 flexible-array member
Message-ID: <202005112224.9EFD07F5@keescook>
References: <20200508163826.GA768@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200508163826.GA768@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 11:38:26AM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> Also, the following issue shows up due to the flexible-array member
> having incomplete type[4]:
> 
> drivers/char/tpm/eventlog/tpm2.c: In function ‘tpm2_bios_measurements_start’:
> drivers/char/tpm/eventlog/tpm2.c:54:46: error: invalid application of ‘sizeof’ to incomplete type ‘u8[]’ {aka ‘unsigned char[]’}
>    54 |  size = sizeof(struct tcg_pcr_event) - sizeof(event_header->event)
>       |                                              ^
> drivers/char/tpm/eventlog/tpm2.c: In function ‘tpm2_bios_measurements_next’:
> drivers/char/tpm/eventlog/tpm2.c:102:10: error: invalid application of ‘sizeof’ to incomplete type ‘u8[]’ {aka ‘unsigned char[]’}
>   102 |    sizeof(event_header->event) + event_header->event_size;
>       |          ^
> drivers/char/tpm/eventlog/tpm2.c: In function ‘tpm2_binary_bios_measurements_show’:
> drivers/char/tpm/eventlog/tpm2.c:140:10: error: invalid application of ‘sizeof’ to incomplete type ‘u8[]’ {aka ‘unsigned char[]’}
>   140 |    sizeof(event_header->event) + event_header->event_size;
>       |          ^
> scripts/Makefile.build:266: recipe for target 'drivers/char/tpm/eventlog/tpm2.o' failed
> make[3]: *** [drivers/char/tpm/eventlog/tpm2.o] Error 1
> 
> As mentioned above: "Flexible array members have incomplete type, and
> so the sizeof operator may not be applied. As a quirk of the original
> implementation of zero-length arrays, sizeof evaluates to zero."[1] As
> in "sizeof(event_header->event) always evaluated to 0, so removing it
> has no effect".
> 
> Lastly, make use of the struct_size() helper to deal with the
> flexible array member and its host structure.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> [4] https://github.com/KSPP/linux/issues/43
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
