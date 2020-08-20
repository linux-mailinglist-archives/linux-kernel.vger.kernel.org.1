Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404A524B6E5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 12:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbgHTKnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 06:43:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:55502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbgHTKnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:43:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65C6EAD71;
        Thu, 20 Aug 2020 10:44:16 +0000 (UTC)
Date:   Thu, 20 Aug 2020 12:43:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org
Subject: Re: [patch 0/2] timekeeping: NMI safe timekeeper enhancements
Message-ID: <20200820104348.GF4353@alley>
References: <20200814101933.574326079@linutronix.de>
 <20200820084738.GD4353@alley>
 <878se9ip7k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878se9ip7k.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-08-20 12:30:55, Thomas Gleixner wrote:
> Petr,
> 
> On Thu, Aug 20 2020 at 10:47, Petr Mladek wrote:
> > The interface is perfectly fine for printk() needs.
> 
> Good. So I suggest that I apply that on top of rc1 somewhere in tip and
> tag the top commit. So you can pull that tag into your printk branch and
> go wild.

Sounds good to me.

Best Regards,
Petr
