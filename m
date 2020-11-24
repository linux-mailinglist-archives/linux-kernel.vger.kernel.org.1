Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE3D2C32DF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 22:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbgKXV17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 16:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732174AbgKXV17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:27:59 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA34CC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:27:58 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id t15so35252ual.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=56wAqxqhBDrN0Ju/3+WYd2eoccE4SJAvoDMPg1hvUI0=;
        b=WXTMho/E5mqYYYjU+W5mmv9+te1tCkCm+1gbl5QGKPcp7anOPE6JVKXTLhwCq5G095
         jJ0HWkVRzSZv3LhvNIRJ7NkkLUtL33yk1optAQZgJZ5xpvnIooMELxMS09N+HEsP+I1L
         75O1lpdJ6CTc1IhcfMLiMJDahChl/QtYBGAfdsBR+4nCKT/46r4qA/Oe69PQsILycgah
         skbWZ6nMYJbiCG54vORcag7Pq080GpqVQfaJEOSYj8OVF+pXO4dhMwa0WhKLB3W0JQo3
         6cnknZAomTj4X4RJyJ121IAIa1DaKe6/6qSJzTWobedPSNJ4NOhnUASpgozqmA/7cSPX
         /Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=56wAqxqhBDrN0Ju/3+WYd2eoccE4SJAvoDMPg1hvUI0=;
        b=GJZ50+570XZ9THCJSGZIMPxT5hoNxht7tNGraJd4VXII+GnqbM6m/DvVzVwVcpR4S8
         mJzcyuUOB6kN6N9+leO1+0ngK3CHgvqvFFWOivyL/pVGrpvPqkgxxS6DPk3cqFT9jC1i
         Wp79eo01PH1M22POcdT974o/bWoRKVuQBxRrHBZpXOK5OjM+uYQQorJTuMaaoDF56Ish
         I4O9wr19L7Ve7slnKuUFpA/8uqDnck3qC9xHwc656ZHCmnW+mGtKYdMz4pdnfYwo53ZX
         3dDxDTO6hhoX+ua6mn85O30rS8+aWa1hEEpPua3R3eJk28gU1U7QprtyK/yzN7voUl9B
         tRmA==
X-Gm-Message-State: AOAM5317EYhlBzJimVEFLcpUwQwp4j/mxVIKXlwx/PgTlqmZyxhQz2R9
        1Ro6SFEaHrn5sBerozCxTlkPshCVPMhggP5s6ss=
X-Google-Smtp-Source: ABdhPJxccWB5f7wJr2OScYSg+KGLZNeVxsjIkxeEtq7KQVRw2cr4sr3+WWqn0/lLRCm5utV5hJTq7oW33MqkBWDzhrA=
X-Received: by 2002:ab0:6355:: with SMTP id f21mr134723uap.142.1606253278105;
 Tue, 24 Nov 2020 13:27:58 -0800 (PST)
MIME-Version: 1.0
References: <20201113230048.1200162-1-jim.cromie@gmail.com> <20201117100256.GC3121406@hirez.programming.kicks-ass.net>
In-Reply-To: <20201117100256.GC3121406@hirez.programming.kicks-ass.net>
From:   jim.cromie@gmail.com
Date:   Tue, 24 Nov 2020 14:27:28 -0700
Message-ID: <CAJfuBxzhgQ+fTA-iyqLrpZ-=9ipXZGOCznRMM8AZE5yFOGh6PA@mail.gmail.com>
Subject: Re: [PATCH] locking-selftest: add option to proceed through
 unexpected failures
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 3:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 13, 2020 at 04:00:48PM -0700, Jim Cromie wrote:
> > Locking selftest is currently (v.5.10-rc3) seeing 14 unexpected failures.
> > Add option to not disable debug_locks, so as to let it reveal any
> > locking flaws in new unrelated work.
>
> I'm assuming this is the arm64 fallout? Mark anything I can do to help
> you there?
>
> The reasoning doesn't make sense though; if it can't pass the selftest,
> then why would you trust any further reports?

because it knows more than I do.
having chosen to proceed anyway,
Im free to discount the advice.
