Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66ECC2A66FB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgKDPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 10:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbgKDPBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:01:13 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DC6C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 07:01:13 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id i6so27563145lfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 07:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxPLb2fGP7jXlgt/bMtm2kfDbxO1T5oNePjTDY71s5g=;
        b=K437N4gFwUwo4LAEMYTnhxYdmjCc6OID6hg1RJCC+5pC3qvf6IdvzxX9n76AcdYIBL
         QDxsEq96dNc/bkqDOyqXrVFRXge73xFsyHP/TrAPnCeLyQvHcf0d2iCF0vJ1i7DIGenh
         SNrvcG7SuZ8VFVidY9dU43Tn4i14u9V/IA/C5sPBlMmKuFm++WhkkVBXaPpYdffxbtcX
         jzY8XjsbwNzNZguyTMW2DiJnnTYV+0f4tDyTXHWgysflHSbgeWMXybTyWvlG4q1UM8Iv
         wQXaZAhkyTjHTqg5keTHbA7VYsKzk0FFAx609/EfK7Qh5+5VZhEVhHrxLwZLngbHPlI8
         LqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxPLb2fGP7jXlgt/bMtm2kfDbxO1T5oNePjTDY71s5g=;
        b=QHJhey29cV5xv822Rbp4Pt0wJ82cpbyiCf28d160tbSoqWGMs0co/GrA8gmfT9XELF
         GrZF1Tcf4Ge0RwayEUcaiuv0xZHdFdy0MnGtGmZ/FzFJ7hI2kaRixYCbwfmDEz6mpQXq
         3eB+cS4IPcqD43FNm4f2nDMKXnZGxS/gbKw9Gz6Te7CmTz9UXpLEX7TgmqrhXYpVjxPN
         VLfpuhvWzq+pQp5b5wN/1aoTsLBPLfNvpq3DOT5652stwRNzwzxXLEzViyeLhzr+HLdu
         hP4j1T18H9T9dg9z7rnKz+sbIg/GhfxQHu4f9+DHSFTgTWFSoPbFAI9L2QcWyXK9e+0a
         Vwyw==
X-Gm-Message-State: AOAM531AUn0dQpWJPKh1DwoklrYwdR7CcXunRJ4dAnm0cLYtOMCC4uQK
        ZSmmG2SkJIMRBwrbVC94Oc6M439pcYmjs+ny36B1oWNIl14=
X-Google-Smtp-Source: ABdhPJyl/WH9CARQ5BarfDdU8YDQkRY652Gbx4tdP7uQk/vv+CjqbrSHh1l3cUEJqKNXs1dItYmt/9FEOyhBaICuudE=
X-Received: by 2002:a19:2355:: with SMTP id j82mr9164396lfj.385.1604502071293;
 Wed, 04 Nov 2020 07:01:11 -0800 (PST)
MIME-Version: 1.0
References: <20201103212725.3716088-1-guro@fb.com> <20201103212725.3716088-4-guro@fb.com>
In-Reply-To: <20201103212725.3716088-4-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 4 Nov 2020 07:01:00 -0800
Message-ID: <CALvZod69Gx5xATQAhjrzS4nWGecWW6PkGB=WEomtR819rJsDfg@mail.gmail.com>
Subject: Re: [PATCH rfc 3/3] cgroup: remove obsoleted broken_hierarchy and warned_broken_hierarchy
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 1:27 PM Roman Gushchin <guro@fb.com> wrote:
>
> With the deprecation of the non-hierarchical mode of the memory
> controller there are no more examples of broken hierarchies left.
>
> Let's remove the cgroup core code which was supposed to print
> warnings about creating of broken hierarchies.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
