Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA302B5367
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbgKPVFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:05:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgKPVFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:05:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42AF7207BC;
        Mon, 16 Nov 2020 21:05:10 +0000 (UTC)
Date:   Mon, 16 Nov 2020 16:05:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peiyong Lin <lpy@google.com>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        android-kernel@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pavel Machek <pavel@ucw.cz>,
        Prahlad Kilambi <prahladk@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        zzyiwei@android.com, Sidath Senanayake <sidaths@google.com>
Subject: Re: [PATCH v4] Add power/gpu_frequency tracepoint.
Message-ID: <20201116160508.3e86496f@gandalf.local.home>
In-Reply-To: <CA+0soAkD7BG6CjhMW6PYR4yAgDykU2uUizcHx1QQdXqgesCFFg@mail.gmail.com>
References: <20200820162738.33053904@oasis.local.home>
        <20201022173434.910879-1-lpy@google.com>
        <CA+0soAkD7BG6CjhMW6PYR4yAgDykU2uUizcHx1QQdXqgesCFFg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 12:55:29 -0800
Peiyong Lin <lpy@google.com> wrote:

> Hi there,
> 
> May I ask whether the merge window has passed? If so is it possible to
> ask for a review?

This is up to the maintainers of power management to accept this.

Rafael?

-- Steve
