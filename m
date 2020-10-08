Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76A6286F45
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgJHHWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgJHHWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:22:35 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3099CC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 00:22:35 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id k18so3825780ybh.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 00:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVt6HPCbv7NkAw3ASSdTsU1dVq2uc72ksR0NlB2xCJg=;
        b=kutSNlGCJ4DWn8geC2BcqllTlHrAhFdTBF/cCO7YJMeNrBGCCDWQ37FEUYopj9TwnB
         Kk55GYLf+Yj9o5CkMTmK37F0rRg1tiAPHFZZkNEUfrR8ap6lbtFUAWT9Fqf0mMzJhQ2p
         mcoBY+xr69zGzD2/Ofyr4eYlFPvQx91ROInlE6NkEymnoGnv7M/6VKak7kmfuxImRkWZ
         OaP+Fs2qg57HdvIjh+x1jcF7U6UsMaHNorlCGYG9UIQ8KFvF5GxWdi1vn6VD0BA/rYv3
         2jPGtJWkmUNNul8SU6+fd3SGVUTjlFdNqGZjPl6b62GdxPzCqmfJyEvjnLwffL8NREs6
         bDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVt6HPCbv7NkAw3ASSdTsU1dVq2uc72ksR0NlB2xCJg=;
        b=bhSIQRWX4r81tSR8FOroke5Os60nhul7hRPyFGQy1V+M4UaT1NKVszfF/PYY/1Obw3
         u7CQ9KZ+YUG7aZj4qRTBIvRzr6RIORT0kPnp/E6OGU39Kauz84egtgWbd/Jkz4mIrZu7
         GQcHQyMzGHKCC5eaT+EEQX+f5IQiXhkbFIW0lDL5b/H1TeCZFAu18rcoWKsuYdOZzFn9
         QBsKmBoAWRSL6HOhBSRN8UW8x8c41RQxvAOxxdoRQyRo8wv5DDEq5uitM9DZspR+gGkV
         mA5Xkofkw9NK8O5CLSxiqdF2LNcYBLWNvj6FELc3RMhMjCtiIW89ldbJ9zX7X/hRWm2v
         wY2g==
X-Gm-Message-State: AOAM533q+ojW7QCE1Kq7wd3PRASnHo4q/IJBLR+K3Fuu5KTjjfeBVByd
        mONGTRdRV6q1y6s/1NM6JIfKpqlPyvJBEf1ZZPLAEg==
X-Google-Smtp-Source: ABdhPJwpFp41/iqnZPbR9ZaIh0yqzdNQJ50wKIrTOJk31V+lLXBS8CnYFjtdxBlZoVA+/iYDktEcyuwVqP1YU3MRL04=
X-Received: by 2002:a25:d4d7:: with SMTP id m206mr9441434ybf.332.1602141753828;
 Thu, 08 Oct 2020 00:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201007184403.1902111-1-axelrasmussen@google.com> <20201007184403.1902111-2-axelrasmussen@google.com>
In-Reply-To: <20201007184403.1902111-2-axelrasmussen@google.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Thu, 8 Oct 2020 00:22:21 -0700
Message-ID: <CANN689E_uE3MosPqVJwG71Trwo15CGNJB2H5+U_Gg47FtPLbxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: support "bool" type in synthetic trace events
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 11:44 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
> It's common [1] to define tracepoint fields as "bool" when they contain
> a true / false value. Currently, defining a synthetic event with a
> "bool" field yields EINVAL. It's possible to work around this by using
> e.g. u8 (assuming sizeof(bool) is 1, and bool is unsigned; if either of
> these properties don't match, you get EINVAL [2]).
>
> Supporting "bool" explicitly makes hooking this up easier and more
> portable for userspace.

Acked-by: Michel Lespinasse <walken@google.com>

Looks fine to me, but you really want to get Steven's opinion over mine here :)
