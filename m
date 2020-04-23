Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3C81B624C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 19:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgDWRqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 13:46:53 -0400
Received: from foss.arm.com ([217.140.110.172]:44938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730093AbgDWRqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:46:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC8C230E;
        Thu, 23 Apr 2020 10:46:51 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1C843F68F;
        Thu, 23 Apr 2020 10:46:50 -0700 (PDT)
References: <CALAqxLURuJ-tMxMY6Z2BvLmyd6X+w7SiSB5otoH6vx+NxJm-NA@mail.gmail.com> <jhj8simxgqo.mognet@arm.com> <CALAqxLXGQa-sPjNQV-uXzJLOVMyJtHqdfk0J48dhs+WVbWu+Sw@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: BUG: Invalid wait context with 5.7-rc2?
In-reply-to: <CALAqxLXGQa-sPjNQV-uXzJLOVMyJtHqdfk0J48dhs+WVbWu+Sw@mail.gmail.com>
Date:   Thu, 23 Apr 2020 18:46:48 +0100
Message-ID: <jhj7dy6xfg7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/04/20 18:29, John Stultz wrote:
> Oof. Way to twist the knife :) I'm probably to blame for that
> deferred_probe_work_func issue. I'll take a look at it.
>

Sorry :(

> thanks
> -john
