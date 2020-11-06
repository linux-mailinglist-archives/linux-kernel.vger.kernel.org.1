Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F03B2A9C7A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgKFSi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgKFSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:38:57 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69414C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 10:38:56 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 79so2115309otc.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 10:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxHuRb9btK6fIk12CKU8DqhKvsu/vUJtkdyol4DJ8ic=;
        b=XIn0aYLWh5cfYI8YC8hnnl+xITpJDnJfsx1CLbBNUc+eCZZd57DKArsvW7NDUqVSt1
         LheCTXJR5A2xA9YYkLBgHiNAFh0oWTUTNf3j6wEN6ZsXKsOSbE4ZvTs4h+FpXAIFXeyt
         Pmij+rPN/c2LZwrq9SM4W6hND4HiVPfiI1cD2ERzy6Hd5GJ0fd6CkwQh6r5w/2ZwMTTA
         +S5xw1FmFZmLSVBxFCRBcLTSF6cmUwmsKCL10xkwBZNcb2q3Lm+IkI5xlJn62nAxiMJP
         xd/L4tYnn0i3ENSMpCo5fGMt6h5HbECCZK40m4p9ZJuA+34kehcoRo8kdBykFutyedKG
         8YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxHuRb9btK6fIk12CKU8DqhKvsu/vUJtkdyol4DJ8ic=;
        b=QxyjVidapOjm3NZ82n8IW7HNZiqlUJPiqMHY/FanTuR8w+FbZU82UjESQbd8RnwPCk
         LKnPqiEI1zFi0yCLTOLi3pxX5jUey2H5aDSs5PdlAPi9a2V+fvc8ulQ54bZuT1EdWutL
         wELXow33SJXflUlYeHQ2FbJz7ViIAJI2guMvEDH2/izZ/8hVUjN8tCdL3AUwZNQNTQHa
         KiPjwjTOYNWwAUdnakyvAhQEYBHDI83aki/qyIWw7bST+n8WmVSBez58NFIDCWLxNxOw
         xTvbnhCdHgKwkxJEDpRmcXRtOZjqQhR753YUgpyaM5EkTlfzfKkt3AIHkUR9lt/hzP+/
         FLTg==
X-Gm-Message-State: AOAM533/pucZk0SReImX9G68fFCIanDEHo9RYlh0Xv0lsyCMoNkKE45j
        m9/XjgJ2fxE+wB/iNrdfStfertSWayG9NcRE3GEGZg==
X-Google-Smtp-Source: ABdhPJxNcc3J7eTwqEeCUsfredQHDe3wiEWZuB9t+2mZJN3+7jqYuEo+q+e2qHzI5HQK1c1ykKTjqQ8tIuyGLvZ7mOQ=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr1849209oth.251.1604687935680;
 Fri, 06 Nov 2020 10:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20201106182657.30492-1-98.arpi@gmail.com> <20201106182850.30602-1-98.arpi@gmail.com>
In-Reply-To: <20201106182850.30602-1-98.arpi@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 Nov 2020 19:38:44 +0100
Message-ID: <CANpmjNP4+ByVyabqiDy1KW94XBEMG3j4jqugY3kN+C-w1kEVhA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 at 19:29, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> Modify fs/ext4/inode-test.c to use the parameterized testing
> feature of KUnit.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> ---
[...]
>  fs/ext4/inode-test.c | 314 ++++++++++++++++++++++---------------------
>  1 file changed, 158 insertions(+), 156 deletions(-)

Acked-by: Marco Elver <elver@google.com>

Thanks,
-- Marco
