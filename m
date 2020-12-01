Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0E32CAD59
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbgLAUcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgLAUcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:32:06 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D795C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:31:20 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f27so2189239qtv.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZzwh1qZeO2b0+phIivb7f/h0/WTvwlyT6OwTCuU8Go=;
        b=JT8a4im5mRuwETNO39npw148r3340SB50NEKuWNK0T0EuLy6OY9QxvW2zT/YDF2yFp
         UDut3hb/IwScMF6t2XadwaGd+yHJh+yFtyRwrtZpeoHwNKSKSdAMjf3ot8WcDsnZjxqf
         bMAuJ4tVWjR7xLj3IP145iuAhRDUlXYWfYAEA6byKRLe3aotgpbVCFQZZ4gA8DHne6/k
         Rb5mEgw3XQWX9US8bpL1sM9eU5aL+7nYIo7rmz1/s3gQWSI6h3f+hcarRBw7d+JUJAtw
         thynGtAl3j149w2TA2Keiu7Q77qscbMbf9q8yi6/+z56GAa+epwJnUIXluzV9/0K2Q8o
         1Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZzwh1qZeO2b0+phIivb7f/h0/WTvwlyT6OwTCuU8Go=;
        b=fyh/nJwlNy09km5aNGq5FQXVdOYnem6dTYKlx4u95iLGA77Vzy1w/8FCXwgkZIKpJ7
         xme+tGeM/kdm76w68dz2/mdj+q0sCKYLxZGYcV6w0pmHxxN1b9CJwtgJrvXs24xJ898w
         BRu0y29uvDLMxMlDHNTI89Nron7gGdcxb+Amx7YJop7vETtz1cC9lpEYKmKrG3SUfOe3
         GQuHrLUnjeXYXyHuGjS25++t+7h/wBktjmwZZjlAjXqEJuCxGa7EW2oRpo87jhGxA5BB
         /HDAnl7XepISNfg4zWJAUvyuLI8Dyj+XU+PUokIVq4U9cz5W+c1QoApBeCn8VwybkjYc
         uGSQ==
X-Gm-Message-State: AOAM533NNjaCOHaZ7o4v9EJTzYJI2QIdPDiWY8UKPjiruxaVk593TnJZ
        pjZ41UtZUnHr3+xkP6zjVz2x36qjjswKRvfNHC64
X-Google-Smtp-Source: ABdhPJwORLiqHf9AEcfRZc8YF8T9RnXczT+vC9iTlw0cFtvOwxSpw6bde3sJmjRTqSW8oC8iYZN969xbu1Qx+8dDGiA=
X-Received: by 2002:ac8:679a:: with SMTP id b26mr4823395qtp.79.1606854679256;
 Tue, 01 Dec 2020 12:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20201116054035.211498-1-98.arpi@gmail.com> <20201116054150.211562-1-98.arpi@gmail.com>
In-Reply-To: <20201116054150.211562-1-98.arpi@gmail.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Tue, 1 Dec 2020 12:30:42 -0800
Message-ID: <CAAXuY3rE9D+QbY-0rfkeFSMUULPkzvqZGsyYhM2Fza2nNt3e3w@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Modify fs/ext4/inode-test.c to use the parameterized testing
> feature of KUnit.

Reviewed-by: Iurii Zaikin <yzaikin@google.com>
