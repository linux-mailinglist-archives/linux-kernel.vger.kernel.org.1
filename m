Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DAE2FE134
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbhAUE4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:56:24 -0500
Received: from mail-qv1-f52.google.com ([209.85.219.52]:44277 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbhAUEzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:55:23 -0500
Received: by mail-qv1-f52.google.com with SMTP id d11so359536qvo.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 20:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ovkYtOPUuG5VhHSVRVaRC9GgRg3OX+tBxgdnBr0JDxw=;
        b=P0pNl0BSDxG7UDmc8N3ikNp0vBkVBxaom4VUndPhybiqQXbz3t5/102FrZL7+v+7RY
         1pt+lTpbl20f2+v7txVbLfyKQT6tyWJOar1YYhRM8HCh+G0UrHD5vGNDr/vNP18bdaaw
         T6+5m28LmLECkVhBS/wQCeaY17Ny2tO1bRhN8tbO1bXuXGPGsv0a+r9q9PNUiUqAkVrJ
         0H6ciZwhC4wcOM0zcEChUTEhhy+mQhsqlUy1eyKP7C9JWuXPDJ2nDuMQ9WQ/17sEaJDX
         nMJVPArlPlK84aUPXI1TKqKXS3VNO9eZ8Wpvqg8cm5eeFN59L4b9i+8UY2tLQypuQ28X
         0pTg==
X-Gm-Message-State: AOAM532Xr950Q7UUqT3q3Z3+F/SgJA5e0/HF+cAKjg13dRgpHmhAJLgu
        l6G2hJNGzwpd5TZMBr6F2eQDGjHCVC7Nn7XXepYXmRN4x4w=
X-Google-Smtp-Source: ABdhPJzrH5s7XhWslkIEmtDtussHb2Et1L/e93VpnGmi0f7h2cN4GS6WBjgHsJ0nD7Ik6x0nOJVwCm05xa4buUKOrtk=
X-Received: by 2002:a0c:dc13:: with SMTP id s19mr13074921qvk.26.1611204878192;
 Wed, 20 Jan 2021 20:54:38 -0800 (PST)
MIME-Version: 1.0
References: <20210102220441.794923-1-jolsa@kernel.org> <20210102220441.794923-9-jolsa@kernel.org>
 <CAM9d7cgSx7WFo5fwxSoU9h2vD19LJxaM7p5i5+W+HLM6kpkwpw@mail.gmail.com> <20210119174901.GD1717058@krava>
In-Reply-To: <20210119174901.GD1717058@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 21 Jan 2021 13:54:27 +0900
Message-ID: <CAM9d7ciuvab0MbcZh=Uj4V0AbvSr=TABJ_=NMBDSP9edJHgkOw@mail.gmail.com>
Subject: Re: [PATCH 08/22] perf daemon: Add config file change check
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 3:51 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 19, 2021 at 02:31:55PM +0900, Namhyung Kim wrote:
> > On Sun, Jan 3, 2021 at 7:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Adding support to detect daemon's config file changes
> > > and re-read the configuration when that happens.
> >
> > Hmm.. maybe some of the code in the previous commit can be moved here.
>
> do you mean the config file support?
>
> I think this patch is quite small and straightforward - adds
> the inotify processing for checking config change
>
> perhaps we can separate some of the code from previous commit,
> and make it simpler, I'll check

I thought the reconfig logic could move to here.

Thanks,
Namhyung
