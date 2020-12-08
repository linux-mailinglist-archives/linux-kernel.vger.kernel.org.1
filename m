Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DDE2D2038
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 02:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgLHBiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 20:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgLHBiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:38:06 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697BDC061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 17:37:26 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmRwQ-00HIxf-GL; Tue, 08 Dec 2020 01:37:22 +0000
Date:   Tue, 8 Dec 2020 01:37:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC] exit: do exit_task_work() before shooting off mm
Message-ID: <20201208013722.GG3579531@ZenIV.linux.org.uk>
References: <abab9af4e0d26358538a45a2826650e9cefd2924.1606961931.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abab9af4e0d26358538a45a2826650e9cefd2924.1606961931.git.asml.silence@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 02:30:46AM +0000, Pavel Begunkov wrote:
> Handle task works and lock it earlier before it starts killing off
> task's resources like mm. io_uring makes use of it a lot and it'd
> nicer to have all added task_work finding tasks in a consistent state.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> Would it be correct? I clearly don't know all the exit invariants, but
> can't find any users relying on task_works in-between.

You've just gotten rid of exit_task_work() anywhere after exit_files().
And exit_mm() can trigger the final fput() just as easily as exit_files().

IOW, you have just made the effect of final close on exit() completely
asynchronous.

NAK.
