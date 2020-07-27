Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7BF22FA48
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 22:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgG0UoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 16:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgG0UoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:44:13 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B3AC20759;
        Mon, 27 Jul 2020 20:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595882652;
        bh=t9ljCa86mAmXcEfUhWxtO7BrRHTALZYL65NXwXBbzps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lva86vM0yR+ykzetM6P2yNWHIEIBUmbLKR+cYnkTCBElg/iIhC9AZDEfvpB5QRPEY
         Bs1WSopwxfn+NQvSt2u6dFkQwfLAHXx5wnXde4hNxXGa+oX6AniyLoSNM+kN9mGzo9
         TOyc/yiOesNznDiHJk2rD8Y8dVWI+x3e5zGpl9vE=
Date:   Mon, 27 Jul 2020 13:44:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        SeongJae Park <sj38.park@gmail.com>,
        Joe Perches <joe@perches.com>, <linux-kernel@vger.kernel.org>,
        <apw@canonical.com>, <colin.king@canonical.com>, <jslaby@suse.cz>,
        <pavel@ucw.cz>, SeongJae Park <sjpark@amazon.de>
Subject: Re: checkpatch: support deprecated terms checking
Message-Id: <20200727134411.73461df2fe73f8f96d93f75e@linux-foundation.org>
In-Reply-To: <20200727065441.27164-1-sjpark@amazon.com>
References: <20200726203328.GA8321@qmqm.qmqm.pl>
        <20200727065441.27164-1-sjpark@amazon.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 08:54:41 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> > > > Unfortunately, the inexperienced _do_ in fact run
> > > > checkpatch on files and submit inappropriate patches.

I don't think I really agree with the "new code only" guideline (where
did this come from, anyway?).  10 years from now any remaining pre-2020
terms will look exceedingly archaic and will get converted at some
point.

Wouldn't be longterm realistic to just bite the bullet now and add these
conversions to the various todo lists?
