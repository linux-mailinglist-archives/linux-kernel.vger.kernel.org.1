Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44FF23D0ED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 21:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgHETyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 15:54:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37526 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgHEQsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:48:40 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k3L7L-0001LE-7y; Wed, 05 Aug 2020 15:14:11 +0000
Date:   Wed, 5 Aug 2020 17:14:10 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] fork cleanup for v5.9
Message-ID: <20200805151410.ikwqc6c2miylmj5f@wittgenstein>
References: <20200804112801.72380-1-christian.brauner@ubuntu.com>
 <CAHk-=widMtiEEcLQQOpiVA=jjKv-bYsA2g+u5eEDY4ecDvikWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=widMtiEEcLQQOpiVA=jjKv-bYsA2g+u5eEDY4ecDvikWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 02:56:04PM -0700, Linus Torvalds wrote:
> On Tue, Aug 4, 2020 at 4:28 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > This is a series announced some time back (cf. [2]) when we reworked a chunk of
> > the process creation paths in the kernel and switched to struct
> > {kernel_}clone_args.
> 
> You have those refs to [2] (and later [1]), but not the actual links
> they refer to.
> 
> I just edited them out, but please try to avoid this in the future.

Hm, odd. I'll try not do have that happen again.
Christian
