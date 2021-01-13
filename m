Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A02F4C74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbhAMNsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbhAMNst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:48:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1E4C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:48:09 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c7so1965684edv.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qw6VQNbr/MnGxv6QaGRimh6NhRF2uRUV4EBku2j8OE8=;
        b=DqL6xvtf1VN44MbClbs2zHC+F7AfTtHbWZKCDloGxMTyzpjTZ0i2r/gppVW+lvsMfI
         R57GivDirDyGicvdn46ASdf4y8Zt2PmH6PkycgdposUrCQS86Yn9mbjs6Xmzcz/B/tCu
         XLahc4a9CfnqpS0JPxIP+/gE2qHVTDTd3WAgOs2kUphHR7LMigOuWAM3mqxh1BrVVTgN
         yZpUF/XMDEh5KCfpLjNwHDgnJHqv5FoY9kAGC9juo+8RclfHd8qtReP+qXrwMGSeyh+l
         mwOqI3MYRNDgWyEgisV/78gxV8g2KqKqmyiKOgcJNTrnBSLwwQufSnxlgULQoJ1FhAAf
         z23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qw6VQNbr/MnGxv6QaGRimh6NhRF2uRUV4EBku2j8OE8=;
        b=UFHxn+Tg4AiZyywMlCL6Ul0UzTMQCgKr9YOZRxsyV37b7AF8277OoopcEbifM33ytO
         TLGsSG0mkDt0TfHVULusfxnzIs5yB4N4OcNSS8cSf6lFs5Uvtw9KoBfngwyS9wb1anGb
         BppVp0xMBHBOWg/WnJ1ovarS3MMD0qC3nPzbi2vnAlLCNf+LyyB2BZbQ9VJ+CZzpw5BT
         vziiRsXAAfPXjUQFtioT+DQs1l7QFfBQvHo6gUlxzyEcKM+qVqGen7tki83MV5OAZ5tK
         CA8DckUkAQ3LFmYX4j6X9JWq8l26pOQqvSZZXud1NuvCUKxOdwoSqVLkHSWkNW5aZOhD
         JZLA==
X-Gm-Message-State: AOAM530poLE4fHKg0tZofV1+/gbpXUFnh/PoQ3PiCDG4dwSr0VLeQFIL
        NMOHfkC0s/urlUrYtDrOC249VK/BS3Y5JtrUx4TU
X-Google-Smtp-Source: ABdhPJwB4tmGNdMbAc1D65UZyTgVVNUEtW4KR+KikSXTmEkqME3Uj+9zKG0LG7DEXXVH92c+5/i2cXRJl3qFCKZrFV4=
X-Received: by 2002:a05:6402:1bcd:: with SMTP id ch13mr629052edb.31.1610545687667;
 Wed, 13 Jan 2021 05:48:07 -0800 (PST)
MIME-Version: 1.0
References: <202101132038409309743@zte.com.cn>
In-Reply-To: <202101132038409309743@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Jan 2021 08:47:56 -0500
Message-ID: <CAHC9VhSB0UvbQZbCa4hTHgnx23+9FR-P+ytXw547c7YjSH0rMw@mail.gmail.com>
Subject: Re: [RFC,v1,1/1] audit: speed up syscall rule match while exiting syscall
To:     yang.yang29@zte.com.cn
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 7:39 AM <yang.yang29@zte.com.cn> wrote:
> From 82ebcf43481be21ee3e32ec1749b42f651737880 Mon Sep 17 00:00:00 2001
> From: Yang Yang <yang.yang29@zte.com.cn>
> Date: Wed, 13 Jan 2021 20:18:04 +0800
> Subject: [PATCH] [RFC,v1,1/1] speed up syscall rule match while exiting syscall
>  If user add any syscall rule, in all syscalls, audit_filter_syscall()
>  traverses struct list_head audit_filter_list to find out whether current
>  syscall match one rule. This takes o(n), which is not necessary, specially
>  for user who add a very few syscall rules. On the other hand, user may not
>  much care about rule add/delete speed. So do o(n) calculate at rule changing,
>  and ease the burden of audit_filter_syscall().
>
>  Define audit_syscall[NR_syscalls], every element stands for one syscall.
>  audit_filter_syscall() checks audit_syscall[NR_syscalls].
>  audit_syscall[n] == 0 indicates no rule audit syscall n, do a quick exit.
>  audit_syscall[n] > 0 indicates at least one rule audit syscall n.
>  audit_syscall[n] update when syscall rule changes.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  include/linux/audit.h |  2 ++
>  kernel/audit.c        |  2 ++
>  kernel/auditfilter.c  | 16 ++++++++++++++++
>  kernel/auditsc.c      |  9 ++++++++-
>  4 files changed, 28 insertions(+), 1 deletion(-)

Before we go too far into a review of this patch, please provide some
performance measurements using a variety of rule counts, both common
and extreme, so that we can better judge the benefits of this patch.
The measurements should include both the rule add/delete time deltas
as well as the impact on the syscall invocations.  If non-obvious,
please also include how you performed the measurements and captured
the data.

These are good things to include in the commit description when
submitting patches focused on improving performance.

-- 
paul moore
www.paul-moore.com
