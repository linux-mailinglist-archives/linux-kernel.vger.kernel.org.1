Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC862DF5D7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 16:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgLTP0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 10:26:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56598 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgLTP0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 10:26:21 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kr0aX-0004u0-IK; Sun, 20 Dec 2020 15:25:37 +0000
Date:   Sun, 20 Dec 2020 16:25:35 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Leesoo Ahn <dev@ooseel.net>
Cc:     linux-kernel@vger.kernel.org, Leesoo Ahn <lsahn@ooseel.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Collingbourne <pcc@google.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: Re: [PATCH] signal: Don't init struct kernel_siginfo fields to zero
 again
Message-ID: <20201220152535.k74foxjgejedslgx@wittgenstein>
References: <20201220074555.12655-1-lsahn@ooseel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201220074555.12655-1-lsahn@ooseel.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 04:45:54PM +0900, Leesoo Ahn wrote:
> clear_siginfo() is responsible for clearing struct kernel_siginfo object.
> It's obvious that manually initializing those fields is needless as
> a commit[1] explains why the function introduced and its guarantee that
> all bits in the struct are cleared after it.
> 
> [1]: commit 8c5dbf2ae00b ("signal: Introduce clear_siginfo")
> 
> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

I have a __user annotation fix in my tree from Jann that I plan to send
soon so I'll just stick this on top of it if noone minds.

Christian
