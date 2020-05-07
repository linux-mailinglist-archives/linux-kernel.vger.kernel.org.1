Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F3E1C8B85
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 14:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgEGM5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 08:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgEGM5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:57:43 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DEC82082E;
        Thu,  7 May 2020 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588856263;
        bh=5a9ywGLK3FkhOempzXyjRfBlZ1PBXIKXRN7msAWN0Jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fq1vz9r4dUhc9DyFEI7cB7DE/kaGBIvbTrH3iIiIBwzO3YcjeqimJziFRMfXOmIYb
         ZdCgwbNSV12pxYhlf21nsUjfQB6FIznv+DbtuteZnkJMkXaqZl+ad6uqsUvEE9IMR6
         uK3yqSxBOhYmOPRnYsCoSY3t5TzWzwXF7GhjCn48=
Received: by pali.im (Postfix)
        id E4157692; Thu,  7 May 2020 14:57:40 +0200 (CEST)
Date:   Thu, 7 May 2020 14:57:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
Message-ID: <20200507125740.f3ttcsk4pqgb5xwj@pali>
References: <20200507094242.7523-1-koba.ko@canonical.com>
 <20200507111331.dzge7htw5toejh72@pali>
 <CAJB-X+WKqrWuKK0=BWtj7f8AovsMzbCO-QaLi2ZaP0_Q6321WQ@mail.gmail.com>
 <20200507114517.tslux7m7aysuwaok@pali>
 <CAHp75Vcz+HgR1Vxjio+HvLOi_gpZiZLe4P-iPtsLRY8nVWE2+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vcz+HgR1Vxjio+HvLOi_gpZiZLe4P-iPtsLRY8nVWE2+w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 May 2020 15:54:06 Andy Shevchenko wrote:
> On Thu, May 7, 2020 at 2:45 PM Pali Rohár <pali@kernel.org> wrote:
> > On Thursday 07 May 2020 19:27:47 Koba Ko wrote:
> 
> > > don't understand "registration and deregistration would be optional',
> > > could you explain more!?
> >
> > After your patch led_classdev_register() function is not always called.
> > And led_classdev_unregister() should not be called when there is no
> > device registered.
> 
> I think it's not a strong requirement after the commit
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=1dbb9fb4082ce2a2f1cf9596881ddece062d15d0

Thank you for update. I did know about this change.
