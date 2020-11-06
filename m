Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECD62A94A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgKFKrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFKrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:47:32 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5669C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 02:47:32 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id n11so858002ota.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XieLODQoDUtSJdxggAHOW0kb6kiCXrUMxQ1jrfa6znc=;
        b=REm1ewpp8OA9iuvBwxjnZDkmtwlR48TrHX2GCAwjvjLyQZnfOh6qoCTG8nNxUnI6XG
         u8CpsZVaXlOXR4IHRuoXTyIbLX6LWx5ZIcbIgO2RU24cmCY11ELqqr7ZWtELiQvZrSVa
         0tYX3/9PQAEPTCotgqxdWCzloW+6Eo6MiqidUPsAmM0GiTo8pa8q6VOLXI6WitZr2gRN
         MiIgVAClxffbCEMPKcDRPSz8TPjVWlKkLquZEwQbqAh/eqBAICnqgTBHkGS+txqEojC2
         7eipX8Y/okYoFZUZUOsdq9IYCV8cezLC7EbDGODeWlQePHMtTPEcvU0b7XsiV+q6cXPj
         J/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XieLODQoDUtSJdxggAHOW0kb6kiCXrUMxQ1jrfa6znc=;
        b=MfYFoZaBbwEt0ukElCmtzEAgx4mxvTk/tRk7lTajakSsnRFvWj9CgOKwYe7TOpxDri
         8e6bqnpy+DPJBfJgfSyXnr9Zy2tpytgV7wtf2obxeB5Hgcsp5CL1KOrZ5f7aEmAy8mLs
         4s5pQaYz+qw3brRjQPiMF9X7Khx3UIAWkdqIL7cEjKWnljSEudQDv/Y2HRbsjZvkoLaO
         ihbXCdxisfbTIpQLRA/W/jypZeJ+gIAo2mg01wJe5wgF9uL5DhaQYtQCe6XoRW1QOF2o
         hwLlDyuB2D5Lo8VsvfM9xSJruxQ3lNjcmBZaSoKLLiJYdld4rLkCBQCjQC4sbnrYe+ib
         PKKA==
X-Gm-Message-State: AOAM530ZJb0lCQ6z2+/2z6cQkbY+Ax8rUDAIJIEYyeWXVtErreZWpvxw
        I3sqNIU5NLa6KcWiIhmmdj1daNGAaNMs+FXcCpJZIfwU1FY=
X-Google-Smtp-Source: ABdhPJwIloGLRSWFWQ9wodHWzKc5TwO6ifr9P9LmptTZEKT7KACLcCJv54mlSX6A2h7b7mezayEiZHMlqhWOC0Cx5Is=
X-Received: by 2002:a9d:f44:: with SMTP id 62mr755169ott.17.1604659651887;
 Fri, 06 Nov 2020 02:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20201105220302.GA15733@paulmck-ThinkPad-P72> <20201105220324.15808-3-paulmck@kernel.org>
 <20201106012335.GA3025@boqun-archlinux> <CANpmjNNj1cc2LUrLdbYy1QkVv80HUPztPXmLfscYB=pU_nffaA@mail.gmail.com>
 <20201106101856.GC3025@boqun-archlinux>
In-Reply-To: <20201106101856.GC3025@boqun-archlinux>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 Nov 2020 11:47:20 +0100
Message-ID: <CANpmjNN8J=bQiEzW5Ohrf2z3eec9oZk9YYRR0Zsv0-WDioPuPg@mail.gmail.com>
Subject: Re: [PATCH kcsan 3/3] kcsan: Fix encoding masks and regain address bit
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 at 11:19, Boqun Feng <boqun.feng@gmail.com> wrote:

> > send a v2 for this one.
>
> Let me add an ack for that one, thanks!

Thank you!

-- Marco
