Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BA12E1989
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 08:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgLWHxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 02:53:51 -0500
Received: from verein.lst.de ([213.95.11.211]:33666 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgLWHxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 02:53:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A473667373; Wed, 23 Dec 2020 08:53:07 +0100 (CET)
Date:   Wed, 23 Dec 2020 08:53:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Does uaccess_kernel() work for detecting kernel thread?
Message-ID: <20201223075307.GA4185@lst.de>
References: <0bcc0c63-31a3-26fd-bccb-b28af0375c34@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bcc0c63-31a3-26fd-bccb-b28af0375c34@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 11:39:08PM +0900, Tetsuo Handa wrote:
> For example, if uaccess_kernel() is "false" due to CONFIG_SET_FS=n,
> isn't sg_check_file_access() failing to detect kernel context?

sg_check_file_access does exactly the right thing - fail for all kernel
threads as those can't support the magic it does.

> For another example, if uaccess_kernel() is "false" due to CONFIG_SET_FS=n,
> isn't TOMOYO unexpectedly checking permissions for socket operations?

Can someone explain WTF TOMOYO is even doing there?  A security module
has absolutely no business checking what context it is called from, but
must check the process credentials instead.
