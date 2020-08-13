Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8802440E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 23:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHMVul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 17:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgHMVul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:50:41 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C81920716;
        Thu, 13 Aug 2020 21:50:39 +0000 (UTC)
Date:   Thu, 13 Aug 2020 17:50:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peiyong Lin <lpy@google.com>
Cc:     amit.kucheria@linaro.org, android-kernel@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, paul.walmsley@sifive.com, pavel@ucw.cz,
        prahladk@google.com, rafael.j.wysocki@intel.com,
        ulf.hansson@linaro.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH v2] Add power/gpu_frequency tracepoint.
Message-ID: <20200813175037.48a16064@oasis.local.home>
In-Reply-To: <20200813213703.153080-1-lpy@google.com>
References: <20200813172239.18ccc4f4@oasis.local.home>
        <20200813213703.153080-1-lpy@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 14:37:03 -0700
Peiyong Lin <lpy@google.com> wrote:

> Historically there is no common trace event for GPU frequency, in
> downstream Android each different hardware vendor implements their own
> way to expose GPU frequency, for example as a debugfs node.  This patch
> standardize it as a common trace event in upstream linux kernel to help
> the ecosystem have a common implementation across hardware vendors.
> Toolings in the Linux ecosystem will benefit from this especially in the
> downstream Android, where this information is critical to graphics
> developers.
> 
> Signed-off-by: Peiyong Lin <lpy@google.com>
> ---
> 
> Changelog since v1:
>  - Use %u in TP_printk
> 

For just the tracing side of this, but the use case is up for others to do:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
