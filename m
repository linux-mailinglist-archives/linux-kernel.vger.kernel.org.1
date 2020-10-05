Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E552842F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 01:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgJEXda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 19:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgJEXd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 19:33:29 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8953CC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 16:33:29 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id n6so4611196ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 16:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lXiPJPLBllyPob1halc69SSReCoTJuEufqY7SNQHS/Y=;
        b=ow75tcI7vKFZs8MD3KEMgfhvCUJuvTHMI7uixbRoqUq5xuTqA1qizEAH6GBqdnx3bD
         8B113ybKzWntlgvS4Fu+Ri7qWDTEfhqIjRfaVogVb8SwV13nh4JI98uoXCrJneYLhPOb
         d3pGVGuiKcr8i0mBMi65bMxJqhD0hGXdUbC66iI265HzqIAA8RfHbgIn3KoK89kruDVx
         yTELX+iDXhuFb+WBf4ZZMNXJ7Pe1LylXnG+R1YvJyQBRv3YSJfSvYOsY4aWgItlUELbg
         bRkWxeIk08UutKDJ+sdDO4+ut1giRmXRKAl7SfpZLOgKgYIST90bDu89lmiwN5WnbRFI
         TZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lXiPJPLBllyPob1halc69SSReCoTJuEufqY7SNQHS/Y=;
        b=LJzTh2pZcezuRzzG7T0BTGEtKjXRFgKyrfgx3d7xzDmm3vQ858GhZwspC53KkjSZP8
         d8wOQWXucKNuHaOW+Rz0ixZa7NUCq+Zjz+8gh/hQHeIDR9pBnp9383ILIUuV/03WqepS
         PtRW7+cCOl001k06TKz4FbJc7ObK8CE+0ymXDRkIBgkd+LPnfVUrT5SA4QYXou/5OhqI
         2R5IgqpjI9yYqdYxS7Y8ltZAxrE3AhShCvRpsXkOcFiSI/F155bwmh4DFAeQPfcnBf8k
         Lnp9UoHJdeoxuA375imCs3mI6iWA9ySQTYOjF25yxEasbudMcihX4CTAV9shtXIbuP9z
         ZUgA==
X-Gm-Message-State: AOAM531nBAxsDbPqm6FLNP3HcJmVie/+CPdesdTU9iZWbkQNyvmNNA4C
        065CVaOdfavN1Vh+i/bJng0wQgIMWms2qk3fRouqzA==
X-Google-Smtp-Source: ABdhPJwBLlubx4vdoL+pwkH4nDaNYihiO8vD2QEqabU9I3UsaGxI1l23hunR2FvxQhKXi/6Uig9V4Ysxe57Lz/eGLwI=
X-Received: by 2002:a6b:5c06:: with SMTP id z6mr1813090ioh.49.1601940808820;
 Mon, 05 Oct 2020 16:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 5 Oct 2020 16:33:17 -0700
Message-ID: <CAGyf7-Hbs8nTUWzF+bo96x-HNR-pR16MzVjK2Pn-+=bs3Ki7Ww@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.29.0-rc0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 3:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> An early preview release Git v2.29.0-rc0 is now available for
> testing at the usual places.

I've run Bitbucket Server's test matrix over the release candidate. No
failures to report.

Thanks again for these early milestones! I really appreciate the
testing opportunity.

Bryan
