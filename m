Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AC62AA271
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 06:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgKGFAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 00:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgKGFAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 00:00:31 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C681C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 21:00:30 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y16so3758324ljk.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 21:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=voEsZPkyjZD18rzLtdDPpUVqOWAqR2u8yHFoISL5tWA=;
        b=ozEJnOM2IixHrnCPEtGb8FlqnzWcNz+owQfR7J4Eue5meJU/pZItrdTH+v0KHF0cFo
         3lLpgXRPOSHF6gUusRw2FxmWULcNJa0AV7m/aCcn8kIQWrxpaenHvu4ZfGHc3ZiZiZBW
         WVFQB3tG8c63Lifd0NAKzG5T8ez3LWkaxc26yiUmwNA314ZHSabqU+PFVT0gGvfiPp6W
         TZYs2MYDYb1AFpUxW2W+wjZVFeZkYueQs6SaJyl5/oe0ESlReMhwk+xbeJ3Y9Y4s1GXs
         07Fe+pa4L7AXyhtkqeXfpjSsJGpKXdPXYPYdYX2eifPUuJxWYcbqFN0iESHwomlTY+gt
         bJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=voEsZPkyjZD18rzLtdDPpUVqOWAqR2u8yHFoISL5tWA=;
        b=VXK/NE8qRDjFt5VVO9voyEmq0O/obnn64uUJjOnR/cI8NgDKuIjO9WyoDIzDaRqbQi
         3on9U7CfpTcrmtCEYHpxykogOYh3K6cHH4ILUl2nk08ZzOZ3nT9RUhrU5rChgeLPOOC7
         TUNKmUqYF2UdXoNFQTXeq48IbK32vASyti6X+MOL9jGJPGoXx2D3jjto7KVnvUnOXvGJ
         feVVqaPpuTf6NxC1ow+wD/IJeGaMw4O93VEkWHLfghcHtPZzIcdiE4PPK/GNGoWV3xSB
         a11kWP9AvO7cMaxG6wIHriP+dth96x0CHJQ6rJs90zRlX883m3oX91IEVOtWS8YCHb/6
         udzQ==
X-Gm-Message-State: AOAM533CQ341Vwlp3KE+sm1MQ32MBh1U43PPNq2jOpn4ZOcMVEueGRVi
        swufeV2LAZpLpaIzuc+ZE6rXVURs2kSQCkTZmfxkhQ==
X-Google-Smtp-Source: ABdhPJxRL+E/FG0jMGqNmEVkiK0JKDx1AmCZa7th6GCMdfj5xVmIDB1v0qf0mRD8QdCKNL5aBnnNUOaJn4UczaqLpNs=
X-Received: by 2002:a2e:9a89:: with SMTP id p9mr2070693lji.363.1604725228766;
 Fri, 06 Nov 2020 21:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20201106192154.51514-1-98.arpi@gmail.com> <20201106192249.51574-1-98.arpi@gmail.com>
In-Reply-To: <20201106192249.51574-1-98.arpi@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 7 Nov 2020 13:00:17 +0800
Message-ID: <CABVgOSkdwPHLSVQRZX_HoRNokgLFq8ue2gm6zVHWvkD=1-dFyQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 7, 2020 at 3:23 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Modify fs/ext4/inode-test.c to use the parameterized testing
> feature of KUnit.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> ---

This looks good to me. Thanks!

Reviewed-by: David Gow <davidgow@google.com>

-- David
