Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85BA28FECC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 09:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404368AbgJPHDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 03:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404283AbgJPHDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 03:03:18 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7270720720;
        Fri, 16 Oct 2020 07:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602831798;
        bh=uJukAECNIcAu+vYI+8UiJJJCKee4t90OZstWj3s7SQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KIMCLAm6kqb4E2wfX7d9hU5qbspfnKRqy58AarCDaQIk/DGkkYQ+JOBDCDvYms6Ot
         165I6XQRSKxhTV6eyeazosp5VFreC7aohAMVwqWwq73tm6EF3VmomX1OSHONN0eQDS
         9XXV6p91JNsbuesd8/eloI/K9A53pI8dGRjdjJns=
Date:   Fri, 16 Oct 2020 09:03:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Minh Yuan <yuanmingbuaa@gmail.com>,
        oss-security@lists.openwall.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [oss-security] CVE-2020-25656: Linux kernel concurrency UAF in
 vt_do_kdgkb_ioctl
Message-ID: <20201016070349.GA574432@kroah.com>
References: <09826e03-525c-d307-5bfe-f51cb9298e1f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09826e03-525c-d307-5bfe-f51cb9298e1f@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 08:58:34AM +0200, Jiri Slaby wrote:
> Cc Greg.
> 
> On 16. 10. 20, 5:39, Minh Yuan wrote:
> > Hi,
> > 
> > We recently discovered a uaf read in vt_do_kdgkb_ioctl from linux kernel
> > version 3.4 to the latest version (v5.9 for now).
> > 
> > The root cause of this vulnerability is that there exits a race in
> > KDGKBSENT and KDSKBSENT.
> > 
> > Here are details:
> > 1. use  KDSKBSENT to allocate a lager heap buffer to funcbufptr;
> > 2. use KDGKBSENT to obtain the allocated heap pointer in step1 by
> > func_table, at the same time, due to KDGKBSENT has no lock, we can use
> > KDSKBSENT again to allocate a larger buffer than step1, and the old
> > funcbufptr will be freed. However, we've obtained the heap pointer in
> > KDGKBSENT, so a uaf read will happen while executing put_user.
> 
> Hi,
> 
> this is likely the issue I am fixing at:
> https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?h=devel&id=57c85191e788e172a446e34ef77d34473cfb1e8d
> 
> I think, it won't apply cleanly as it's a part of a larger set. I will
> reorder the patch and send something during the day.

Great, thanks for looking into this!

greg k-h
