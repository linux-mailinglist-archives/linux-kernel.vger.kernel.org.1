Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72691D1686
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbgEMNzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 09:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387503AbgEMNzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:55:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F13362054F;
        Wed, 13 May 2020 13:55:03 +0000 (UTC)
Date:   Wed, 13 May 2020 09:55:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200513095503.7488b0d6@gandalf.local.home>
In-Reply-To: <20564555-7b84-f716-5dcd-978f76ad459a@i-love.sakura.ne.jp>
References: <20200427062117.GC486@jagdpanzerIV.localdomain>
        <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
        <20200428121828.GP28637@dhcp22.suse.cz>
        <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
        <20200428154532.GU28637@dhcp22.suse.cz>
        <b1d507b1-dae7-f526-c74a-d465ddecea6a@i-love.sakura.ne.jp>
        <20200429142106.GG28637@dhcp22.suse.cz>
        <a59271f1-b3fc-26d1-f0a2-5ec351d0095e@i-love.sakura.ne.jp>
        <20200513062652.GM413@jagdpanzerIV.localdomain>
        <a75d6560-ad99-5b02-3648-247c27c3a398@i-love.sakura.ne.jp>
        <20200513100413.GH17734@linux-b0ei>
        <20564555-7b84-f716-5dcd-978f76ad459a@i-love.sakura.ne.jp>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 20:03:53 +0900
Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> I think that basically only oops (e.g. WARN()/BUG()/panic()) messages worth
> printing to consoles and the rest messages do not worth printing to consoles.
> Existing KERN_$LOGLEVEL is too rough-grained.

Why don't you look into having a "noconsole" command line option that will
not print anything to the consoles but oops messages.

Sounds more like what you would like, and something that perhaps would be
acceptable by the larger community.

-- Steve
