Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB15129D86B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbgJ1WcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387981AbgJ1WcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:32:00 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A077C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:32:00 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id x6so985838ljd.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pmlvkQeg7H6smcBHZ5aZgeUaLRlAx0R+iCDWXBgF8Uk=;
        b=hzvcafzsTDtVUUVH1kS94mVKvKXmE4c6gcOeNA5ca8NF7hzCPzx9Az8oU7QVR3E5Cy
         C347ZJks3MzRvNGt8HqF6kIaNBzMySi+oOthiNzV0QTHVM45eKqOzoaE39gklCRwa9Ou
         UvDZs3x4mc9w0tfwkHoxd3L3LiCuWFZxjKskc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pmlvkQeg7H6smcBHZ5aZgeUaLRlAx0R+iCDWXBgF8Uk=;
        b=L/B+/bpl+wCaITy4BiPzTAOjR5M6/nM1NAmhcj30VbgZWTI+i4OR3aHp51W6dRklT7
         RETXZ9iLiXpsRKO7EjV2285ir/3n4g+fRy8ouoffIb5Jm6MUnbpaKEJsCB/WaONPzeka
         Y6y1lKAcXOG+3ATdPklj4IPA+3y61ru5L7EafffIkfg+R0PbsnT/NlTsIWAwwDy+mRuE
         7iXdyxk5ZIlqQewWU7kn5KZaQiUpTZ0CAoVHbWywM54rCfBkELiK1vGvFWga+yAEWMai
         taVtaquKWvVAtqIGTs0FmOM2fZJZz6AcU+wPmlhw8gvlYEkVeUvKN1w8B5QDAPAcktt/
         Kqjw==
X-Gm-Message-State: AOAM532tpnDixJThl4YhAynJijaS353pD4GmPYTCRHbo8MxnJWmMUvPL
        dtQpaCUrsKbVrQeeiTCvh8hFsG/Gefs7Pw7pVtm3mysdyW2xRQ==
X-Google-Smtp-Source: ABdhPJzj9kyuupHG0/DfPab48BJrhIBCY+xoQNy6Ur/hkxg1PpSleXYOCl+TPbZZbePCJaxaotpYYjkpmW9vfAUOCi8=
X-Received: by 2002:aa7:d65a:: with SMTP id v26mr8622930edr.82.1603900571122;
 Wed, 28 Oct 2020 08:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201028142809.09f7f4b4@canb.auug.org.au>
In-Reply-To: <20201028142809.09f7f4b4@canb.auug.org.au>
From:   Micah Morton <mortonm@chromium.org>
Date:   Wed, 28 Oct 2020 08:56:00 -0700
Message-ID: <CAJ-EccOQCADagAb8YqRHL6aUVCrMuGOO=tA-TBorjO_AiXT7Gw@mail.gmail.com>
Subject: Re: linux-next: build warning in Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Cedeno <thomascedeno@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 8:28 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In Linus' tree, today's linux-next build (htmldocs) produced
> this warning:
>
> Documentation/admin-guide/LSM/SafeSetID.rst:110: WARNING: Title underline too short.

Thanks for the heads up. I think someone sent a patch to fix this
yesterday: https://marc.info/?l=linux-doc&m=160379233902729&w=2

Do I need to do anything else or should that cover it?

>
> Introduced by commit
>
>   5294bac97e12 ("LSM: SafeSetID: Add GID security policy handling")
>
> --
> Cheers,
> Stephen Rothwell
