Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92BB26BA5B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIPCus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgIPCup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:50:45 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C19E9221E3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600224644;
        bh=JUErH3f7oxNO2My4mOzkde5yYqEs0mH4/x+e5LWeYs4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oTetqI1okXGztxqhvEqw9zFXPN7Oh1gCY4D/C+KuKkjRE/mgs2nE9V/ncou4VSzwJ
         R/XV9fQ+Kcn+MXpfOwWmu02xt+DnmafVjiVik8uP8riFtcXKYfy+H/AjQ8yKZxL0WC
         5YM6rq/5Aqh0CNaA+cIRtuMvb6yQP++dg3K/yV+g=
Received: by mail-oi1-f169.google.com with SMTP id x14so6371770oic.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 19:50:44 -0700 (PDT)
X-Gm-Message-State: AOAM531xhslcy8vNQUhSZkaJYZvYMHVFDZ6iGuGSwFNg0jtTKrRDLlgT
        x+MMtDKSkNjdJG27GmYFA2OACqxxM120XO6Djg==
X-Google-Smtp-Source: ABdhPJxsJbQ8lR1KZmSN17L4PD+IPJl/r7JM0v+exnkGc4f2xFggSHmMkOaQLTSAUpLVGT5p834PvUd6mf2r/qwXiDY=
X-Received: by 2002:aca:fc07:: with SMTP id a7mr1712728oii.106.1600224644132;
 Tue, 15 Sep 2020 19:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200911215118.2887710-1-robh@kernel.org> <20200912205317.GG1714160@krava>
 <CAL_JsqKwMh9=ppdbY0sAQ8C--aH_XcJR3G4YCq7afAHnfTF9fw@mail.gmail.com> <CANW9uytmafiNb_8oua9QY7L9O5BQTBFQBOMS3ZgjQ7aWj8CD2Q@mail.gmail.com>
In-Reply-To: <CANW9uytmafiNb_8oua9QY7L9O5BQTBFQBOMS3ZgjQ7aWj8CD2Q@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Sep 2020 20:50:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLze6DUD4ewV9uh1KDRz0daDUk0aT7y-Dj8+MjFF+LQgw@mail.gmail.com>
Message-ID: <CAL_JsqLze6DUD4ewV9uh1KDRz0daDUk0aT7y-Dj8+MjFF+LQgw@mail.gmail.com>
Subject: Re: [PATCH v3 0/10] libperf and arm64 userspace counter access support
To:     Itaru Kitayama <itaru.kitayama@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 5:14 PM Itaru Kitayama <itaru.kitayama@gmail.com> wrote:
>
> Could you point us to your repo too?

Sure, pushed a branch here:

git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git user-perf-event-v3

Rob
