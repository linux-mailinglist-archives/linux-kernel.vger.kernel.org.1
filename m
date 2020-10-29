Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188AE29E13F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgJ2B4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbgJ2Byg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:54:36 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89362C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:54:35 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v6so1242717lfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdFzVv58H65jJdmf3Ufqe4CniXPY8PDzCg5XmX8U0Sk=;
        b=tiC/AVoVMmn8tilMgdX+in8K0Yjj4INH3BlSiJE1i/FYsg5/tdHYBPHV8a6SM+mjLf
         p2LtCkHoBgwc/uCSaWm0K/UgbEqo/zbgJBhcsG6FKaeb9oPjL8/1k8O2KdNBlI3kqxPA
         0ptuwCxuUeJopPXLCfmFKPToBf+aJ9489F2hcG6WUdFwQEyHQdpKhGBkyjwBnm47mK8o
         7/HpY2jimntzVbQDlxOO5FE0zN3R5/7+JsgqFa24E/KzZjHu/0JRQbLqb8EguIWoCQBY
         xZFoiNwFyIpu/8JjUkjEKYbqhcXN0fvI0gqflwj9S4pQDKkceoD+HBU6S7ErkW0xMrrO
         cdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdFzVv58H65jJdmf3Ufqe4CniXPY8PDzCg5XmX8U0Sk=;
        b=TKRvbcOO0Qc6nU3YJfmgjqoz6JDX7T4X0kn1XD+9ePC4ac0LoOXm3MNRTmm7dGg7Su
         fxyH04WbuCYdV5cQ6gkjdr7d9iM/xT8L9/hkdFuxpdqMvEjkQN3I8r9tOo1xiOOgdxuA
         sdebBTTC8ogQTyIDa6M0Di9ELk+3ORR8wgxLq6GIKye1cMIQIMssHlMn27qebXyZB4mt
         mVfPBctwGEoXmRXK9F0iMNzGQim1RSW1qyTiQECng8970+sxXuooziW9TZLk/ln3H5S5
         G99NrE+5HOjULjNl+GPrOKP2Su924rysoNuuycxtNmi9QveG+YXoMlrSWRz+9kdOB7//
         Ylow==
X-Gm-Message-State: AOAM531an99Yusie1TizYxUD4ZMa+Jwhu7gdMvG1vm1o4DeIaB4evvkM
        ZwyleNTuV1o36qNS2B3qYGCsPpLgzmGLE04maaf1Xw==
X-Google-Smtp-Source: ABdhPJwauBImhfKJM6NoGIwTjek7s8o4dkYW2qotO1xbRGWxPztTmolQB6je1z2UiNNM0Z4FnaKpNsbAdrRpO7nIh0c=
X-Received: by 2002:a19:c357:: with SMTP id t84mr620041lff.34.1603936473887;
 Wed, 28 Oct 2020 18:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201028174218.11750-1-rdunlap@infradead.org>
In-Reply-To: <20201028174218.11750-1-rdunlap@infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 29 Oct 2020 09:54:22 +0800
Message-ID: <CABVgOSnNU1dOGEGhtRW=odkwjDDk7B_=FvdDmxAB_t-mNVY-9g@mail.gmail.com>
Subject: Re: [PATCH v2] KUnit: Docs: style: fix some Kconfig example issues
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 1:42 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix the Kconfig example to be closer to Kconfig coding style.
>
> Also add punctuation and a trailing slash ('/') to a sub-directory
> name -- this is how the text mostly appears in other Kconfig files.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Gow <davidgow@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
> v2: covert spaces indentation to tabs in Kconfig example
>

Thanks! Sphinx is still converting the tabs to spaces for its HTML
output, but this is nevertheless an improvement.

Cheers,
-- David
