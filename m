Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0308E29F560
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgJ2TeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgJ2TeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:17 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B575C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p17so1764852pli.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=no+LFVggH1X+W4BzHVXAaNv+yc1wDOUghNOGzIROf18=;
        b=qyAdMLTeSzMhaaJK2dlID6/WegSaP74cbynv9ImzQ7d9/yD0hRd28az42zcogXLTBe
         VoibyEkl4eBzDPG6Qri1M90Ztr30Z6kpQ/mHOigSAnQ8k417FY4JBi9H4Vsud8gdAb9o
         r3YOcpUdgbbjBQfPfCAwKTfcFOFgYgshfqD72mwHRBNwGv9BGt8Bg5iKJLx2vdkDPQLm
         jpgnzaQWvOvP9x6pFSKitmFpaPpP/v0eFHphKxlwDfU7Sap3VrnMzHoVZkNg9+Fu6CPU
         M19p7c+nfwT4f9G21BOCNAgcZhDKLhWFwC3WVUenZhs0P3W2puUfgkk3eP050WLRT6bY
         lxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=no+LFVggH1X+W4BzHVXAaNv+yc1wDOUghNOGzIROf18=;
        b=VUmYsfVlCbqn4BIaDpbnfQbAgAU6FeB1LEm1V7/l7ufbN+o43BpLwZXN+ALp9HIUxY
         +kE/i+i3TbLpH+twjAUInjMTTfcHosikQRG5warjORPKIt/9AGoHfolQSoARq3MsJK8G
         q0M4VBDeFejQIY4N2a+u0pF7/IWboziBMe7E0f4TH3l7ZSGeM+l0TgZWM1lsP3yfAZoK
         nVkKOKN+S4eY7IIq0iNeYfpumcgl8iwOU7BMUZIzug+QowOLT1kYQZnIjHDaavvqqMhT
         BFk//4BfNjdSSQO0zJ7EDuILLyzp5Zzx0Oxb8LR5UAZRSkZomJs27sx0aLeOI8eWv15R
         BtOg==
X-Gm-Message-State: AOAM532CvgEoDZlOqPB0gduewQvyi85GdYUnzMYFf0nctFS4AZXskmPr
        TI269SzX3WrBp62ZHBIZoOkhwTt8RVKGu5wHT/1WOw==
X-Google-Smtp-Source: ABdhPJyLa39Lok2TGDOrhjed0bxZPeqYmMk2y5AOr/vIOxrVDWaZbltVNWvL9dGnOEjpsdSas6FDn2Ip07nV138ZTWE=
X-Received: by 2002:a17:902:8ecc:b029:d6:991d:1193 with SMTP id
 x12-20020a1709028eccb02900d6991d1193mr1428555plo.56.1604000056830; Thu, 29
 Oct 2020 12:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201026213040.3889546-1-arnd@kernel.org> <20201026213040.3889546-3-arnd@kernel.org>
In-Reply-To: <20201026213040.3889546-3-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Oct 2020 12:34:05 -0700
Message-ID: <CAKwvOdka+UFvwntx-Dcx3oX2nJEkcdo+krm8gu016vPVBF8MBQ@mail.gmail.com>
Subject: Re: [PATCH net-next 03/11] rsxx: remove extraneous 'const' qualifier
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 2:31 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The returned string from rsxx_card_state_to_str is 'const',
> but the other qualifier doesn't change anything here except
> causing a warning with 'clang -Wextra':
>
> drivers/block/rsxx/core.c:393:21: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
> static const char * const rsxx_card_state_to_str(unsigned int state)
>
> Fixes: f37912039eb0 ("block: IBM RamSan 70/80 trivial changes.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/block/rsxx/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
> index 63f549889f87..d0af46d7b681 100644
> --- a/drivers/block/rsxx/core.c
> +++ b/drivers/block/rsxx/core.c
> @@ -390,7 +390,7 @@ static irqreturn_t rsxx_isr(int irq, void *pdata)
>  }
>
>  /*----------------- Card Event Handler -------------------*/
> -static const char * const rsxx_card_state_to_str(unsigned int state)
> +static const char *rsxx_card_state_to_str(unsigned int state)
>  {
>         static const char * const state_strings[] = {
>                 "Unknown", "Shutdown", "Starting", "Formatting",
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
