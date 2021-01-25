Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3233036C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbhAZGnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:43:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729669AbhAYOnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:43:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A55D9206C1;
        Mon, 25 Jan 2021 14:42:27 +0000 (UTC)
Date:   Mon, 25 Jan 2021 09:42:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>
Subject: Re: [PATCH v2] tracing: precise log info for kretprobe addr err
Message-ID: <20210125094225.747670fd@gandalf.local.home>
In-Reply-To: <AM6PR08MB358928403BA18D3C1C75215E98BD0@AM6PR08MB3589.eurprd08.prod.outlook.com>
References: <20210120155644.64721-1-Jianlin.Lv@arm.com>
        <20210120112004.4b9ff1df@gandalf.local.home>
        <20210121112847.63d2a06d72979634f25de9cd@kernel.org>
        <AM6PR08MB3589CB4AB4EC3ADBBB45144C98BF0@AM6PR08MB3589.eurprd08.prod.outlook.com>
        <20210124175231.fed85eccade5dbe0240b5c3b@kernel.org>
        <AM6PR08MB358928403BA18D3C1C75215E98BD0@AM6PR08MB3589.eurprd08.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 03:14:03 +0000
Jianlin Lv <Jianlin.Lv@arm.com> wrote:

> Hi Steven,
> Could you give me more detailed suggestions about the UPROBES section? I lack the knowledge of this part.
> Can't fully understand your previous comments;

Sorry for the confusion. I was talking about the MAINTAINERS file. That
there's no "UPROBES" section in it.

-- Steve
