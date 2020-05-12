Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB11CFFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 23:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbgELU76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 16:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731083AbgELU76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:59:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69603C061A0C;
        Tue, 12 May 2020 13:59:58 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q24so10005096pjd.1;
        Tue, 12 May 2020 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJPL9Tl1cgActLuK4g/HRhyhZpVeiRdgyWh88fXkA+w=;
        b=OHrva3OtIfkvxENY7wpj/fPhbyf8DcMvdrS2KP0ysWrSpz4mxaNsIDn2wnh3QYK54q
         fo9J9nU2TZq3Sw8TA+Z0R/lCFxtBrBy7dtvhMnhFXXX2vkl+uDBpTR450URMLJsmJK0y
         wb7M9g+RbxshL3G5Ry5qd9EbQD5Ftcy56E116a0c5wdK4N/pt/pId4Da4k0aSIE+jEWE
         FUML6G7C5PN2NMxyBnr8oxwTk59YaPMEJxYLDgf6ehJ+d0efVkRw5tImFoFnXkGMYGrE
         EyNcL1Dxw9q9dYMxx4eusEpsh7QVLo7VkqF7y1BLv5/NoWS+q8FwlrD5nATzcjfOWoOr
         1H0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJPL9Tl1cgActLuK4g/HRhyhZpVeiRdgyWh88fXkA+w=;
        b=ZxRvgqci0C5qiAxOkk24Y5cyL277UjLgA2RR9TWl+8CXLB+oAHdkipdgLJja/BqgtY
         VeC+pfqVrzHad3f5moF76nh7fjCQ/gTsouZV92uiL3cf5+nu/TOFJ7PHmFSLJ1vF4BeS
         hL58sjwgRBQ/WS5OQv8EYzOmHgn+kMBKLagKNHSMm6GiBi82KJDIAheLfTYDWMmWos8f
         42kGaiKD/l/klOfQoAmZ6uqHLVRSwVp/gkr+KyV+ue9xjdzN3VWuBjeulmjy3wpzMFAr
         HjnVfROyAoMfiadKQe5pVbsZ6ACTywDAUH7CEtWPjWrBHKo6lbBRayySUWaZcgHYj04v
         7xsg==
X-Gm-Message-State: AGi0PubMvoKgd/y/q2LuDHl/jnEygm3wGQ+HGpjrOfNWGb6HucdM6Rlr
        YW8pOwHmXh7HsQA0bCk3qZU8ml28oBJ3+WGNFng=
X-Google-Smtp-Source: APiQypLqRUkFh5Gq4ZARlaTpFxPfK5sVf01Itv5Lo33wIETMAdD0Tv6bI9JM3S3OgvhG7Hi8srQ//CYX2STx/6trW6A=
X-Received: by 2002:a17:90b:3717:: with SMTP id mg23mr31789295pjb.129.1589317197919;
 Tue, 12 May 2020 13:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br>
In-Reply-To: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 May 2020 23:59:46 +0300
Message-ID: <CAHp75VfLMUCpDWr4_Wo3Gqd4rZdC3dEFhQfmwjF6eTxaLMxYvw@mail.gmail.com>
Subject: Re: [PATCH 1/3] video: fbdev: ssd1307fb: Added support to Column offset
To:     Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
Cc:     linux-fbdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "maxime.ripard" <maxime.ripard@free-electrons.com>,
        alencar.fmce@imbel.gov.br
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:55 PM Rodrigo Rolim Mendes de Alencar
<455.rodrigo.alencar@gmail.com> wrote:
>
> This patch provides support for displays like VGM128064B0W10,
> which requires a column offset of 2, i.e., its segments starts
> in SEG2 and ends in SEG129.

Thank you!

>         if (of_property_read_u32(node, "solomon,page-offset", &par->page_offset))
>                 par->page_offset = 1;
>
> +       if (of_property_read_u32(node, "solomon,col-offset", &par->col_offset))
> +               par->col_offset = 0;
> +
>         if (of_property_read_u32(node, "solomon,com-offset", &par->com_offset))
>                 par->com_offset = 0;

Needs to be rebased on top of latest changes (can be, in particular,
found in Linux Next tree).

-- 
With Best Regards,
Andy Shevchenko
