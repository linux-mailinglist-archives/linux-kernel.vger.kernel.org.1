Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE3229A48A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 07:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506387AbgJ0GRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 02:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506369AbgJ0GQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 02:16:37 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91EC720874;
        Tue, 27 Oct 2020 06:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603779397;
        bh=NRidSICLnHs7tejvNJMYga1yT7UjRJOjUsl/hMHZeN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DMWnzY3KfudYicTM8jwRQWcszKikkCDT3M25oWTO2qQ+2VCRvwUf9f3akxJ5oejz2
         6+fZ1ExQrPDx5e7KydpILjvlOCOySdQbcDHcJBFrWzrhN+qjU/gbefrt/hL/jr5+u7
         0tQVreYSk//svWWH/AFAwqwoUeO+9JfkrT2oBw3c=
Date:   Tue, 27 Oct 2020 07:16:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peiyong Lin <lpy@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        android-kernel@google.com, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pavel Machek <pavel@ucw.cz>,
        Prahlad Kilambi <prahladk@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        zzyiwei@android.com, Sidath Senanayake <sidaths@google.com>
Subject: Re: [PATCH v4] Add power/gpu_frequency tracepoint.
Message-ID: <20201027061633.GB206502@kroah.com>
References: <20200820162738.33053904@oasis.local.home>
 <20201022173434.910879-1-lpy@google.com>
 <CA+0soA=rrZcHsHt2oGqk0sn7QuJu=TQBdbOHPc1+UupRbWbgZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0soA=rrZcHsHt2oGqk0sn7QuJu=TQBdbOHPc1+UupRbWbgZg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 03:25:22PM -0700, Peiyong Lin wrote:
> Hi there,
> 
> May I ask for a review please?

Please do not top-post, and you just sent this a few days ago, in the
middle of the merge window when we could not do anything.

Give maintainers time to catch up, and they will get to it...

greg k-h
