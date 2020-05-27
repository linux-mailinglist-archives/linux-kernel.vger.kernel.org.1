Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343FA1E3860
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 07:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgE0FkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 01:40:22 -0400
Received: from foss.arm.com ([217.140.110.172]:60560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE0FkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:40:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD69355D;
        Tue, 26 May 2020 22:40:21 -0700 (PDT)
Received: from A010555 (unknown [10.169.38.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2EA03F305;
        Tue, 26 May 2020 22:40:19 -0700 (PDT)
References: <20200522065330.34872-1-nick.gasson@arm.com> <CAP-5=fU8CJzOttgVDSxqHQoRg_eZ1+sToywOiek+8vw4j2GykA@mail.gmail.com>
User-agent: mu4e 1.4.5; emacs 26.3
From:   Nick Gasson <nick.gasson@arm.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf jvmti: remove redundant jitdump line table entries
In-reply-to: <CAP-5=fU8CJzOttgVDSxqHQoRg_eZ1+sToywOiek+8vw4j2GykA@mail.gmail.com>
Date:   Wed, 27 May 2020 13:40:14 +0800
Message-ID: <xgl9wo4ylyv5.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/27/20 13:03 PM, Ian Rogers wrote:
>
> Great result, thanks! I note there is a lack of symbolization when
> benchmarking a few Java applications. I'll try to see if there's a
> sensible resolution for those.
>

I noticed it loses information when the Hotspot code cache is
resized. I've been working around that by setting
-XX:InitialCodeCacheSize and -XX:ReservedCodeCacheSize to large
values. Does this help in your case?

>
> It'd be better to make this into two patches. Also on acme's perf/core
> branch if possible:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core

OK sure, I'll do that.

--
Nick
