Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63BB28C143
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388834AbgJLTMs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Oct 2020 15:12:48 -0400
Received: from wildebeest.demon.nl ([212.238.236.112]:60658 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbgJLTMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:12:47 -0400
Received: from tarox.wildebeest.org (tarox.wildebeest.org [172.31.17.39])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id DD386300160F;
        Mon, 12 Oct 2020 21:12:44 +0200 (CEST)
Received: by tarox.wildebeest.org (Postfix, from userid 1000)
        id C1C114000CA2; Mon, 12 Oct 2020 21:12:44 +0200 (CEST)
Message-ID: <f3a1cd68a3f8f83e9e78a6ac1e5b74ceccbdc8be.camel@klomp.org>
Subject: Re: [PATCH] Only add -fno-var-tracking-assignments workaround for
 old GCC versions.
From:   Mark Wielaard <mark@klomp.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <andi@firstfloor.org>, linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Date:   Mon, 12 Oct 2020 21:12:44 +0200
In-Reply-To: <CAKwvOdnLrgVRmkXLK-OoQsDTcAMZx4RfrTQXEASnJVroAZBdkQ@mail.gmail.com>
References: <20201010215135.GB2666@wildebeest.org>
         <20201010220712.5352-1-mark@klomp.org>
         <CAP-5=fUT-1-CR-KMMsrpzgw9b3nBooeY05=YU9XKa5enO9SK+A@mail.gmail.com>
         <CAKwvOdnLrgVRmkXLK-OoQsDTcAMZx4RfrTQXEASnJVroAZBdkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2020-10-12 at 11:59 -0700, Nick Desaulniers wrote:
> On Sat, Oct 10, 2020 at 3:57 PM Ian Rogers <irogers@google.com>
> wrote:
> > On Sat, Oct 10, 2020 at 3:08 PM Mark Wielaard <mark@klomp.org>
> > wrote:
> > > -DEBUG_CFLAGS   := $(call cc-option, -fno-var-tracking-
> > > assignments)
> > > +# Workaround https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61801
> > > +# for old versions of GCC.
> > > +DEBUG_CFLAGS   := $(call cc-ifversion, -lt, 0500, $(call cc-
> > > option, -fno-var-tracking-assignments))
> 
> Should this be wrapped in: `ifdef CONFIG_CC_IS_GCC`/`endif`?

I don't think so. It wasn't before. And call cc-option makes sure to
only add the flag if the compiler supports it (clang doesn't and it
also has a much higher version).

Cheers,

Mark
