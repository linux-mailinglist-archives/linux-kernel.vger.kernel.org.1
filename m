Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A2128BD8F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390564AbgJLQXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390448AbgJLQXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:23:46 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1FCC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:23:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w21so13934820pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kyN3yO0Fyapr+1W7eTNMsddvU7aXp7OnsWuid+jGUhs=;
        b=QAzgswrZgXbxOqumqhLsgrTKU1F7ZQj3xPXqJ8mdrX8JqUs2o8OJEz4q34XwPERe78
         3S8Lwx6nrgftBzKXPDnyqbSta+Zo7u9850r9z/vYubXEY12qn2tVF8eezktvELKywUec
         1U4Gr3zKm8DMWMkQLHonCNrInD3+a/Eg5YhLBdvr6quk6PSoMjLglNR35ZjZdw/GKflD
         u12Zpmc9dcyVu8CLskwltdOWm4Q9TElDGtzG+W5mYZTEJjlIRralqWO/sUMqTpL27bLt
         gqGy2oLjIQ7YQ5S/VQbNBNZVvVVZwYGUWySPGFpAlkpTh4ABLdubIJthmFAkposxlAht
         2FYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyN3yO0Fyapr+1W7eTNMsddvU7aXp7OnsWuid+jGUhs=;
        b=MHsjlLjWm1bbhjo73X7mowowoBk8HhG1FTL94ESRp/k+T4ddGh/1Tf26zM6A2t78jc
         /jcLumJOx9+wQeOFgaWXNqu6yFSto8fmBjoVSh+lTprmEIOPnALmyDdE7p9/I6YT+FsT
         kJIk523CiiQtbEbBi5keEVoLBHEz5le+RcX/pQQAu9cm616Kxp4OdVMn4J1CQjKsrpRm
         Z2O2xZ22zKxzDaMaV7kxXF/QRgqWefYELeMBbWwrSdnXCXlvdVPr0aNvq9005zb/gKFs
         9Bb6/8ORcTOHBAezwAlMDrAUUPULzIb8DZxtHnxxyjYpWb1yKCVQCzQvBcw/7rHrUx8J
         JIIA==
X-Gm-Message-State: AOAM533noBsjCxo03E5imY5rQXKrkR3V8Qbn8liMTgBjmUNn0T4bGWu1
        WL6HhjyTIlL+FQmCYyg5oA6SrFoUmdmwHgDS+lBwRw==
X-Google-Smtp-Source: ABdhPJwUt4jbCZmOvqIet6+v4HE794y1OT8/kXD+F/1cFzlmRu+02BbEs63JEutFaFuRGE8VrVkVK4XcnC6GBCrJoUI=
X-Received: by 2002:a17:90a:9403:: with SMTP id r3mr21460526pjo.52.1602519826120;
 Mon, 12 Oct 2020 09:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201009220524.485102-1-axelrasmussen@google.com>
 <20201009220524.485102-2-axelrasmussen@google.com> <20201012101527.6df53dda@gandalf.local.home>
 <43b10ad23a80ee5ae9f10b6d47d7944b6b14a25d.camel@kernel.org> <20201012104614.25ea97bc@gandalf.local.home>
In-Reply-To: <20201012104614.25ea97bc@gandalf.local.home>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 12 Oct 2020 09:23:09 -0700
Message-ID: <CAJHvVchSCTmqz56Vnkn77v6qxmS3bUVy23X=ur4kr-pJU43rqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tracing: support "bool" type in synthetic trace events
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 7:46 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 12 Oct 2020 09:26:13 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
>
> > Hi Steve,
> >
> > Looks ok to me.
> >
> > Acked-by: Tom Zanussi <zanussi@kernel.org>
>
> Great!
>
> I'll pull this patch into my tree. It doesn't look like patch 2/2 is
> dependent on this and these two can go through different trees.
>
> Is everyone OK if I take this patch through my tree?

Sounds good to me. You're right that there is no compile-time
dependency between the two patches.

Thanks!

>
> -- Steve
