Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FF42F24C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405183AbhALAZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404232AbhALAHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:07:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E6D222D2B;
        Tue, 12 Jan 2021 00:06:32 +0000 (UTC)
Date:   Mon, 11 Jan 2021 19:06:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Remove cpu_buffer argument from the
 rb_inc_page()
Message-ID: <20210111190631.433c3d07@gandalf.local.home>
In-Reply-To: <20201225140356.23008-1-hqjagain@gmail.com>
References: <20201225140356.23008-1-hqjagain@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Dec 2020 22:03:56 +0800
Qiujun Huang <hqjagain@gmail.com> wrote:

> The cpu_buffer argument is not used inside the rb_inc_page() after
> commit 3adc54fa82a6 ("ring-buffer: make the buffer a true circular link
> list").
> And cpu_buffer argument is not used inside the two functions too,
> rb_is_head_page/rb_set_list_to_head.
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---


Thanks, I added this to my queue.

-- Steve
