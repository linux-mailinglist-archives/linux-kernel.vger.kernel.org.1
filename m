Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA5F2C14DD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbgKWTwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 14:52:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728631AbgKWTwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 14:52:37 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4A5620717;
        Mon, 23 Nov 2020 19:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1606161156;
        bh=UAN5Zz2aRH8xlZWd7L9XToNiye4snbt2al5c9XjJUbc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Uq/AsyZTk5jY2L3oMtuPdv5WSIo+UAlgyg7hWNkQ9pwk9fCwGgPI925Drvj4tHrkM
         Yt9gx5KZ6a3DqzAtSGijnbmDw7E0rtQ0uIfZ+1i9KAxjrUlpjFKijdxKqeCKjiimVB
         NfkdJ1JCaXLBiDMWljHea4wBBoWypWexBlVQeYxw=
Date:   Mon, 23 Nov 2020 11:52:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Xu Qiang <xuqiang36@huawei.com>
Cc:     <keescook@chromium.org>, <mingo@kernel.org>,
        <peterz@infradead.org>, <mcgrof@kernel.org>, <huyue2@yulong.com>,
        <yangtiezhu@loongson.cn>, <will@kernel.org>, <aquini@redhat.com>,
        <gpiccoli@canonical.com>, <aik@ozlabs.ru>,
        <linux-kernel@vger.kernel.org>, <rui.xiang@huawei.com>
Subject: Re: [PATCH -next] panic: complete the flush of the hard deadlock
 log messages to the serial port
Message-Id: <20201123115235.74aab2449ac5cf27f10a4cfd@linux-foundation.org>
In-Reply-To: <20201123131359.34600-1-xuqiang36@huawei.com>
References: <20201123131359.34600-1-xuqiang36@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 13:13:59 +0000 Xu Qiang <xuqiang36@huawei.com> wrote:

> when hardlockup_all_cpu_backtrace is on, and there are
> a large number of cores in the system, it takes
> a long time to output the hard deadlock logs of all cores
> to the serial port. When the console_flush_on_panic function
> in panic is executed, console_locked is still held.
> As a result, garbled characters are displayed in the serial port log.
> 
> To solve this problem, wait for a maximum of 10s for the serial port
> to be released before console_flush_on_panic.

Wouldn't it be better to wait until all the printing of all those
backtraces has completed?


