Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283BB24936C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 05:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgHSD0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 23:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:32862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgHSD0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:26:21 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BBFA20639;
        Wed, 19 Aug 2020 03:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597807581;
        bh=q7+Q/+y2Z3KkXfI9Jfs3WmjNQUR4eLgv8vMcc1n2J1Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y/GJHTDJ0a8fdqqPNcZ36pLJ65TO6e5ck0D8eOohdb1dqL/x3PzHY7L/vAG1QGsZb
         5vv/m0nHF39SCc/E4B2r3E6jfqLKEC+ik+gy4VH03JgEbipL6j7Q7erl1g4o6Ol2po
         iKzrJGRfHg+zy//zwoDtTD1GU/KI6lhKaCf0R508=
Date:   Tue, 18 Aug 2020 20:26:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     <wuyun.wu@huawei.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <hewenliang4@huawei.com>,
        <hushiyuan@huawei.com>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/slub: sysfs cleanup on cpu partial when
 !SLUB_CPU_PARTIAL
Message-Id: <20200818202619.6f04826a98d845e489890bba@linux-foundation.org>
In-Reply-To: <20200813084858.1494-1-wuyun.wu@huawei.com>
References: <20200813084858.1494-1-wuyun.wu@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 16:48:54 +0800 <wuyun.wu@huawei.com> wrote:

> Hide cpu partial related sysfs entries when !CONFIG_SLUB_CPU_PARTIAL to
> avoid confusion.
> 

But it changes the userspace interface in ways which might cause
existing code to misbehave?

We just had to revert a different commit for this reason :(

http://lkml.kernel.org/r/20200811075412.12872-1-bhe@redhat.com
