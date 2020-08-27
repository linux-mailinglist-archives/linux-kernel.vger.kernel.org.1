Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6485A2545FF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 15:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgH0Ndp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 09:33:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50990 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgH0N20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:28:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id t2so5193122wma.0;
        Thu, 27 Aug 2020 06:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnE5XnOAU04RtRGwnc1i8f81QJg38PEA9j5A7dNJ4Dc=;
        b=GkHeP2iRhPxkCVA7Fyc+uq5HUmrhCKI8wAqNcZ2gj0nw6Qw1qL53mbC1N3p8aeJBOz
         gSBpiXSIAKyODf6QZ4K69Q5Kd37E3ocS2vKyxBJUC0Dt99qSvdUMnwz+/pXGXJYzbokm
         M61dm6xltNhH0MsphBhqka82k0hxSh6kfcqch/4SXDDov5LY850QtslfnJDB4/SvsBl0
         Yd0zO5TJ/8Msh3I25qtg40Pm1/JQKAF5MVBFKg/PxDXTwJ0cIJjeq+mRNYVYRzO/LzIU
         UO8DaTwZFeLe90G3gfQvFQN8ySX4ft5SVlq2JEB1I1Dcu3zcpJRu4TDYNcgdrEDnkF3w
         zIEw==
X-Gm-Message-State: AOAM531qm/A0xEvBU1N19v+RSJGtt4M7Wrt90UXDmQLS9Z2h2BafycRp
        L37kmTQMYBk7YMcEH2+AFwWnGW5bZg//cQi2EfQ=
X-Google-Smtp-Source: ABdhPJx4dIiFkTVYZkCo8Usm4/wlasCA/mql8y1esdJoewkf9uGAcahvQ3llViFThqjXE8FVFWbuiSYQ9kYrB+/QG5k=
X-Received: by 2002:a1c:105:: with SMTP id 5mr11756863wmb.175.1598534904287;
 Thu, 27 Aug 2020 06:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200827105319.9734-1-krzk@kernel.org>
In-Reply-To: <20200827105319.9734-1-krzk@kernel.org>
From:   Felipe Balbi <balbi@kernel.org>
Date:   Thu, 27 Aug 2020 16:28:13 +0300
Message-ID: <CAH8TKc_Wk6F1nRAJL95asjyyOW78QCjgVhC8bUAMd7WK_wzeHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: process: Add cross-link to security-bugs
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brooke Basile <brookebasile@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 27, 2020 at 1:54 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The submitting patches mentions criteria for a fix to be called
> "security fix".  Add a link to document explaining the entire process
> of handling security bugs.
>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/process/submitting-patches.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 5219bf3cddfc..d5b3c5a74d5d 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -299,7 +299,8 @@ sending him e-mail.
>  If you have a patch that fixes an exploitable security bug, send that patch
>  to security@kernel.org.  For severe bugs, a short embargo may be considered
>  to allow distributors to get the patch out to users; in such cases,
> -obviously, the patch should not be sent to any public lists.
> +obviously, the patch should not be sent to any public lists. See also
> +:ref:`Documentation/admin-guide/security-bugs.rst <security-bugs>`.
>
>  Patches that fix a severe bug in a released kernel should be directed
>  toward the stable maintainers by putting a line like this::
> --
> 2.17.1

Reviewed-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
