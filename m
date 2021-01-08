Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639452EF873
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbhAHT6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbhAHT6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:58:24 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAADEC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 11:57:43 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u25so4986542lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 11:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3W7x7ScL3wGkQjE5SI95SfSty4cvjot0cOD9t89S6rY=;
        b=fARfI0CqTUFPbYt68DPCIOj5rZiF3wO2g9YE5Y/tBYsz7TSsvjphEWxH4YEF9Xas9p
         nmt5oJkBMdqklVTS3xKbVNzbAsRcSPvOdEWxEK+mXRLjJq/UsAtB58yF6vNpaiCFm7Qk
         36N46uLWQiLyRQbtiMNCEenU/xzuC0HEJomK8GS0n4j2gRUGrnOgYdq63HxYL6NtJEmL
         0fc5y9cjApbT/z9qMH7ftRfldtYns+xvG/odA1X9ciZhNX2ag21QXapD7xx/P+QkR+PB
         zFWzC0n6vAn4dpElr2eo/+HLknFRl2/tjE9K7XTz226+qALCM/oLrUwZO17NaC1GGVFZ
         lTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3W7x7ScL3wGkQjE5SI95SfSty4cvjot0cOD9t89S6rY=;
        b=jP3gm/oAgX+9yKNnyJriPCRUb8N5mcjZZ6GQA1Hajfxx6/TKokVP3Je/Tja97iIvue
         KxbKxOJQCQxPdEEtA1wFobXlaVJskWBMVjaaYfPeg1uKUgV851p4kesbwA87zKj7RvP2
         Qi8BU/HItLJc2t8swOTxWywCnfKFXAvOrM6+JkJ2IqdOXSJyeFzENT2A1pxIkj92YxLi
         SX8k2XZdPv85I/udJ+7oQCRtvn/2Q0bYxBvmVvICkodNiRBUmpUtUuFX8PfunpUqT0UL
         PNNEvHDgIit4aC0XlgTdVwc+p3lu1XJhvjGPbJcURZvPLahsgjdVaX3IEFadRgkj+1l2
         dvkw==
X-Gm-Message-State: AOAM533DazzgryzJ5+GDsFfpoXgzBoZaxBurNW+Awe5zvGjNXAd8GqNv
        XVInzgYLEmmxtWKKYR9R+VFSEQ0qO/00wStvjwd/9g==
X-Google-Smtp-Source: ABdhPJziKZKezR5FFJtgceAonF2x6ApDI28G/BcG69DKiTmfX2Y4lj8WrmMbiUPJkHpMNw/gjbgnFIC/MQMYCo1tMW4=
X-Received: by 2002:a2e:9a84:: with SMTP id p4mr2031455lji.160.1610135862104;
 Fri, 08 Jan 2021 11:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20210108020332.4096911-1-guro@fb.com>
In-Reply-To: <20210108020332.4096911-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 8 Jan 2021 11:57:31 -0800
Message-ID: <CALvZod7bXva9BU6+YWf=qPO+YDj+LF_hHWJzra5GpXZi=ortkQ@mail.gmail.com>
Subject: Re: [PATCH] mm: kmem: make __memcg_kmem_(un)charge static
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 6:03 PM Roman Gushchin <guro@fb.com> wrote:
>
> I've noticed that __memcg_kmem_charge() and __memcg_kmem_uncharge()
> are not used anywhere except memcontrol.c. Yet they are not declared
> as non-static and are declared in memcontrol.h.
>
> This patch makes them static.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
