Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D08A2EA634
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbhAEH6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:58:15 -0500
Received: from verein.lst.de ([213.95.11.211]:60425 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbhAEH6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:58:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 441A467373; Tue,  5 Jan 2021 08:57:32 +0100 (CET)
Date:   Tue, 5 Jan 2021 08:57:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Does uaccess_kernel() work for detecting kernel thread?
Message-ID: <20210105075731.GB30414@lst.de>
References: <0bcc0c63-31a3-26fd-bccb-b28af0375c34@i-love.sakura.ne.jp> <87a6u5iw3d.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6u5iw3d.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 11:33:58AM -0600, Eric W. Biederman wrote:
> I do wonder though if perhaps we should create a is_user_cred helper to
> detect the difference between the creds of kernel threads and the thread
> of ordinary userspace.   Which would handle io_uring that copy creds
> around and check them at a later time more cleanly.

I don't think we should as no one has a business to check this difference.
If there is a case where the creds are not correct for all access decisions
we need to fix that rather than adding hacks.
