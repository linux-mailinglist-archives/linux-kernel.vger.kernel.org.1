Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8690A20D74E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 22:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbgF2T2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732588AbgF2T1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:27:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA41DC0307A5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:48:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so17022538wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxhWWYOwQOu56hWy0vq9flZ1hYmRSlFK3eJ+O2k5iZo=;
        b=Dhk4UWh0LpVxPuFBzs8wUMsTYVEXED3JLrpgoLREr+/tq9LVsfgREsZXmLB6uZwDls
         BLCUywdk1m69vGe8mlNlMNCI0uXXE3TdjdXOz2HzVgf+PuogjpTZcYvhDF0Yw0gb/TZJ
         p0/ORuzE/2IwI/kycCgjv7AivNfZ0N623DEDkwu59vJNtFhoDCa2UYWcMYVF/jQH5RH0
         8nYJrosMHzxIh9Cb2ptmrOfnroIf6V/zLCt3GX/+fussXf0UECH4vZRSrblNKg5bRfs5
         UMvEFGM+PRQOAZvRtiySmSiNLk29ga8eV8ZG3flJj8MQ7wclRNEByBBQVyNPm8fPvjPn
         tTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxhWWYOwQOu56hWy0vq9flZ1hYmRSlFK3eJ+O2k5iZo=;
        b=osJSORUS5we/R598HqR2UmEd0t/YqNumLdvJueiF1EpGjwkhgVmcMX4sPX0NBXdgJg
         ZOKWU8DOrsxNAPVwBhDzAU8quD9FtpXqtjMp66YYjGZkbC0vOpwld/CasuTl9FPRSUG9
         CoVD5wRQa5vpRpofBKFokRHVaG9tZ4dFUWwdwW+Qh6a7Zxln980Tp9T//R1y1YrdwWcG
         3EwYWL3Fx1S/5Ae3KBgI0Zwp8/oItT9VCEITIbB+orBPr/tic+8GBMG5lGWBJnuWGUuG
         NlxbbEtriwjN/Dddf4UOLdaZOK9FKdam+zFEpfelfBRvBLjZyn9LTO8hbCKXYPgLIcHj
         uTqQ==
X-Gm-Message-State: AOAM530Yr7FJOwfLBbZXUyQcwpKm4zxueFgviV0R1AaIM2ng9jJkhrAm
        N7dl/7sFxQA0CiXfk7PMvzuE+isDMxR9wmwidgiN5g==
X-Google-Smtp-Source: ABdhPJzKd0CZpRqechU+gE0OcaB8psaLKc7m8JbUyMMtZG2D0NBIOnIXP/XqMMIPZeaDqBqPIdhMVIF+O89aj5wSSac=
X-Received: by 2002:adf:e40e:: with SMTP id g14mr18955335wrm.271.1593445716443;
 Mon, 29 Jun 2020 08:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626194720.2915044-2-jolsa@kernel.org>
 <CAP-5=fV-i+fNj1v_6v4gnaZNoT9XSR1AOJr3cau2R0+MjJemkQ@mail.gmail.com> <20200628214959.GK2988321@krava>
In-Reply-To: <20200628214959.GK2988321@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 Jun 2020 08:48:25 -0700
Message-ID: <CAP-5=fWxLBCGkA_p2R4zR9cUBrM75KqKWk3OJi8Y1aDO5jX8rg@mail.gmail.com>
Subject: Re: [PATCH 01/10] perf tools: Rename expr__add_id to expr__add_val
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 2:50 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Jun 26, 2020 at 01:01:51PM -0700, Ian Rogers wrote:
> > Firstly, thanks for this work!
> >
> > On Fri, Jun 26, 2020 at 12:47 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Renaming expr__add_id to expr__add_val so we can use
> > > expr__add_id to actually add just id in following changes.
> >
> > Perhaps clear up in the commit message that add id won't add an id and
> > a value, just the id. I don't mind long intention revealing function
> > names, so expr__add_id_with_val may most fully convey this change.
>
> ok, how about expr__add_id_val ?

Sounds good to me, thanks!
Ian

> jirka
>
