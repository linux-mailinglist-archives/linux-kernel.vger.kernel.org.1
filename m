Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4AEB1A2CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 02:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDIAiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 20:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgDIAiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 20:38:46 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31AAF2078E;
        Thu,  9 Apr 2020 00:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586392726;
        bh=hatC4cc+Ht1ZBfv9O/Gn2lLqLVPEXmN9FI0RQ4Wp6Ck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BrP6BhOeEPSU0kw96y7/xaJ+kllF0svq3cRRe3n2hr3waQsrM8zPi41gauQw71a8o
         F4X2sE0GGByrwhKbSJ1Li0CBPxt38tpbMrzSlHagtsj955Xye1SLWNY/GVl+dVjVij
         uHEzvSdZpyu89zUdlpM/WlmlO/6SViWQEJYzFU0M=
Date:   Wed, 8 Apr 2020 17:38:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Philippe Liard <pliard@google.com>, phillip@squashfs.org.uk,
        linux-kernel@vger.kernel.org, groeck@chromium.org
Subject: Re: [PATCH v3] squashfs: Migrate from ll_rw_block usage to BIO
Message-Id: <20200408173845.97387f9bf0dc7eb325f98896@linux-foundation.org>
In-Reply-To: <20200408062415.GA25951@lst.de>
References: <20191106074238.186023-1-pliard@google.com>
        <20191106083423.GA10679@lst.de>
        <20191106083711.GB10679@lst.de>
        <CAEThQxe2sNuCHoQfa30FVmtYkQ_zJsecdW2wmVmwafvne1RXSg@mail.gmail.com>
        <CAEThQxeC2qyUr+3EO7o+2p5tziXQ621SqaaxmF3jzheCKjpEkA@mail.gmail.com>
        <20200402153506.GA13332@lst.de>
        <CAEThQxfKWGo1TZ7SZ-N6kizbkujWwu3yKXUGDrsVrGjtopVqkA@mail.gmail.com>
        <20200408062415.GA25951@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Apr 2020 08:24:15 +0200 Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Apr 03, 2020 at 10:37:15AM +0900, Philippe Liard wrote:
> > This is lower priority for us now but I agree that it would be good to land it.
> > This is my first patch being approved so I'm not familiar with the next steps.
> > Can you land it yourself or is there something more that I should do?
> 
> Normally Phillip should pick it up as the squashfs maintainer, but he
> has been last active about a year and a half ago.
> 
> Andrew, is this something you could pick up through the linux-mm tree?

Yep, shall take a look next week.
