Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD5F2F72C3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 07:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbhAOGNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 01:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbhAOGNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:13:30 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1CBC061575;
        Thu, 14 Jan 2021 22:12:50 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id z5so16101100iob.11;
        Thu, 14 Jan 2021 22:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bEbH/65XCoYmcN7zPPW+zWKIvWqjXJ0Wqd+YiV9oO8w=;
        b=N4Q6lUDOFp6zfZ7jnqjNhFW+3eXSO+3aR0B/LekUaXqefrwjzHJkvhZgbMAtC+lDXM
         KZoKCKNWYjwOOyatz/fzS0J20znK5yrq+RJS60PB/iMoY7lv2pzR1JflJOgVAFc6MsFN
         cQO4GPgWoMy6Nw0oC4/SjVtT+TFkfsmX8rIaxaLCOxmDreFZ57RWFK7DkKJ2j33XhQgb
         B/eqKp1E4+qj3OM6LF7sPB2cXJ0bKgQSh7eGVgczTRH+Fq9Nx2INHhtzngqQeYxPvfTI
         0An/IbWbc+o4eQd6yz+w6NssMXZPHwcFtKRMTijt3xNbI8GI4lK4xg9wJg0tv+lugJTh
         92OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bEbH/65XCoYmcN7zPPW+zWKIvWqjXJ0Wqd+YiV9oO8w=;
        b=O66Z/X24q2MtLVdCxLDlizvj7briEnAJLGoi0+TiDCQAOsaEr6/hBo1agfLo+vJVGF
         hAKnRiin/THdL+q4Thm19gUXsjNAWuPufkDhR/W0Dj50S1mCmIKUt7Pl7lwybMOP/yoy
         MMCtK0xeWfViPbLddD3TiVkVR82p4XOzv10gcL+2QYUDSolvrCNhAzd/ZcWbWH5bnSPa
         e6iXsZGIEXdx9kDBxmCF7SHFwUhfCw41hWhon/GnfzqOP6kGYIH2r8/+UyusvR9A4pCL
         eWj29znB23mqhf7YSmGuPv4q66ZwiKvH4sBCrxKR3eo4qGdlWk2qZN+MBXGnjO4v2ffY
         h+xQ==
X-Gm-Message-State: AOAM532/Rvj1gTmjecuYiHueTrSm9nEZ2KQ9HlIf/MkUhoc/3Xhci1J/
        ahviZUmPhxUcaN9Erv2CxAyy0EPmvZiJBBIX0NWyCzDBpgc=
X-Google-Smtp-Source: ABdhPJz1XPbOwLwOJ+0g3tWR/DSkb4kKst/ykr2TfkVL78lQuukpl9HuFsZbMfS8PY3iLiTDP/MqGrEy6tKjEEFFOJs=
X-Received: by 2002:a92:bb0b:: with SMTP id w11mr9645652ili.125.1610691169565;
 Thu, 14 Jan 2021 22:12:49 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 15 Jan 2021 07:12:38 +0100
Message-ID: <CAKXUXMziQ2H7_oiVSxbt1=bDFkjLQYOiOgd00YGyDnCTVDhbqA@mail.gmail.com>
Subject: Re: [PATCH 00/10] Fix documentation warnings at linux-next
To:     mchehab+huawei@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[reduced the recipient list to the main responsible ones and list]

Hi Mauro, hi Jonathan,

We both, Mauro and I, have been submitting patches to address the
documentation warnings on linux-next. If it is okay with you, Mauro, I
would like to take responsibility for the task to send out the patches
to address all warnings on linux-next in make htmldocs and follow up
with all the discussions. I can also provide a short weekly summary
(probably always on Friday) on what is pending where and what I could
not resolve by myself.

Is that okay for you?

If at some point I do not have the time to take care anymore, I will
let you know.


Best regards,

Lukas
