Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866832B1E99
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgKMP1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:27:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgKMP1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:27:37 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 043B620691;
        Fri, 13 Nov 2020 15:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605281256;
        bh=/bzvI3PSf1RkDSZTm2OPFclH/942L9sd3Hb0v1zJtrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nl6pczxOVhFOBct+PzCMV9PU84jPFZUalVo90dNEVSL2F4kL1DIYjb4WjpW1bxgpS
         DoHZhvjRPuwokungp9fmSU7hN3SEwUC61tkg/YE3baSoEgXDA8nr22s46JE0+R5NPD
         W59VIX6d2oJEulqAmmppCaPysQrUJ+4Fk9VQDKlM=
Date:   Fri, 13 Nov 2020 16:28:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xiakaixu1987@gmail.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH v2] tracing: remove the useless value assignment in
 test_create_synth_event
Message-ID: <X66mILjXqug9YGgR@kroah.com>
References: <1605280878-6612-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605280878-6612-1-git-send-email-kaixuxia@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:21:18PM +0800, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The value of variable ret is overwritten on the delete branch in the
> test_create_synth_event() and we care more about the above error than
> this delete portion. Remove it.
> 
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
>  kernel/trace/synth_event_gen_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

$ ./scripts/get_maintainer.pl kernel/trace/synth_event_gen_test.c
Steven Rostedt <rostedt@goodmis.org> (maintainer:TRACING)
Ingo Molnar <mingo@redhat.com> (maintainer:TRACING)
linux-kernel@vger.kernel.org (open list)


You have an odd selection of people you copied on this patch, ensuring
thtat the correct people would not see it :(

