Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795A72B12F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgKMABh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:01:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgKMABh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:01:37 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9102720657;
        Fri, 13 Nov 2020 00:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605225697;
        bh=CteIWBriT2wFwQCtj11NXU7/1sMNvDtzymNkqqukN88=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DQoeYJmufyomLasCqKpAiiLLxX5az4f6KvxvRgY/Iuu0LXEdaLaTx8fs7sa/YW9EE
         MHukMdVgwd7Kc+XMTqYCJexRSdKfb3pABXxypniBY1ujaUm4sVzlszxyEEoAUrUDxm
         agUGjIEoO/Y+tAAYWq1FkA2vZm3Hw2KdI7o1ybgk=
Date:   Thu, 12 Nov 2020 16:01:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     qiang.zhang@windriver.com
Cc:     pmladek@suse.com, tj@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread_worker: Add flush delayed work func
Message-Id: <20201112160135.2b5720c66b020472892f2366@linux-foundation.org>
In-Reply-To: <20201111091355.19476-1-qiang.zhang@windriver.com>
References: <20201111091355.19476-1-qiang.zhang@windriver.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 17:13:55 +0800 qiang.zhang@windriver.com wrote:

> Add 'kthread_flush_delayed_work' func, the principle of
> this func is wait for a dwork to finish executing the
> last queueing.

We'd like to see some code which actually uses this new function
please.  Either in this patch or as one or more followup patches.

btw, we call it "function", not "func".  But neither is really needed -
just use () to identify a function.  ie:

: Add kthread_flush_delayed_work().  The principle of this is to wait for
: a dwork to finish executing the last queueing.
