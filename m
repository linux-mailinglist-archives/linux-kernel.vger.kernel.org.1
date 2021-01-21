Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861402FE561
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbhAUIwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbhAUIvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:51:15 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078B5C061757
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:50:27 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 11so1110044pfu.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxeABTwKrp5jAkyYCl41DNW06QqjOBvc5g/VHYkvxFg=;
        b=v/hwrp4dy4L4iMVa4yYX+2VsKRPl0Y33S5OKbzNy1leDJBCcj0k2hMDcu1aYVgFnoW
         JSDF/FUaXePzzLqV5RKMQigb7pXPloNzB/a5CKo6Z4YI5dv/9mLcvlNI+2Jg07nuvBVq
         FHDpzcHiirZI272P7r8hXOJWsRL+GRsCemSb2oWk9nfx4ZKO+78edOD4cTSEFQRyqM3b
         McGgDFYHNdF4TsNbIoJt/X4IbLYDc8SdI1CKIiFSGYoVd0g5VBq4QK0OfKBfPd5lMaF8
         c5HipIkJdW95uuyoMvHoD6JuBABaV5dA53F4aYZ6E6r7zTM9Xg6PYLvHBxr/q4iKGElT
         hHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxeABTwKrp5jAkyYCl41DNW06QqjOBvc5g/VHYkvxFg=;
        b=Y2Gp4Q7Ae/M+58h3jvLLVTWuGhcCkElFC/aLTUOy9p7FvoYVq/qgOLue8/mAQKZzsb
         aPZpZjKWFa6W15zbAnu/sSV0Mutx8IEkSPAkQPdll7FbttyxJ3c5D7JfuL3I5w5gJDsR
         cM86/gnh8q2rwnclY9lijvkbNJl0+ZnSLcS0D69FEjcNHrqrgkFaRc8FDzxXSZh9Oe7h
         /OU7XkgEnoJ4gLvF3EoALT6tXR5YFIvmGG9UADfhWY+EH1J9GVT1t2GgIWOkk4ESjoAV
         T+8L/cgUT5oujwZgTmnTlo0NAdIsHOG1BymDdGKtKrAjdmZkQ8/rQlw2BGcAuEo1RcBY
         WiAw==
X-Gm-Message-State: AOAM533xhXHxlcePuSYSxVc8LFa1qVrCVuXQOykvRSa4qyM0P6C5hQAL
        IavZa0pvcdLFHmOgG8L5tlLbmk4W/eUQ1JRM8d/PyA==
X-Google-Smtp-Source: ABdhPJxTk/OtbD6zGhUq09a8X9z6O9WR0eoO0GnaaPSY1RSrBUsWrxeZ4ANACpTuP7BsBGU0WjRwPZn8Zq+t6iury4I=
X-Received: by 2002:a63:e049:: with SMTP id n9mr13504415pgj.339.1611219026528;
 Thu, 21 Jan 2021 00:50:26 -0800 (PST)
MIME-Version: 1.0
References: <20210121184136.43c30669@canb.auug.org.au>
In-Reply-To: <20210121184136.43c30669@canb.auug.org.au>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 21 Jan 2021 09:50:15 +0100
Message-ID: <CAG3jFyttW6eGw3FHfr2U657bTT2=kmWTr3MjV04S6_0diECrig@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the qcom tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Stephen,

On Thu, 21 Jan 2021 at 08:41, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   d4863ef399a2 ("arm64: dts: qcom: sdm845-db845c: Fix reset-pin of ov8856 node")
>
> Fixes tag
>
>   Fixes: d4919a44564b ("arm64: dts: qcom: sdm845-db845c: Add ov8856 & ov7251
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> Pleas do not split Fixes tags over more than one line.  Also, keep all
> the commit message tags together at the end of the message.
>

That's on me. Would you like a resubmission with the above fixes?

> --
> Cheers,
> Stephen Rothwell
