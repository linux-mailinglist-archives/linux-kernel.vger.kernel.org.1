Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A672830BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgJEHQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEHQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:16:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677BAC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4pRfIBoFn6hHSzgiN2brmNHTigG7lI3F4/ydGWaV9vI=; b=UoMDKdE05ZIMXq/pidYBN6sljx
        /Z/spj4eLaN90pHUkMmU6fp8aqHJ+6CU91mF3sToqKxfMoJP+S6Ckv7ephss6m47yHHuZ/rqd+jxo
        uzlCSMmPxFZIDq0VrcvgSRFykI4l2xLYLnl7nbXM/a9tv3n8wOjlHXicdVof27RDRm5Usg723XP3F
        xNuQoUZqu5ajgfuonejAsz4DOpaQrl4OrgTgOANncDfEKmKXByqkSCAjp3uem/RjtM34ZppbqMcXg
        io2U6PcmfaSlGfWxihxBcNW309xZ3/WlAVJr6SJVxHfFxCu/AdCHH7Nj3H0SLTbq0SptK7HO1Ka5N
        oX50Ml2Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPKjY-0003w6-FV; Mon, 05 Oct 2020 07:16:32 +0000
Date:   Mon, 5 Oct 2020 08:16:32 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V Fixes for 5.9
Message-ID: <20201005071632.GA14204@infradead.org>
References: <mhng-c32d6fbf-32dd-45ed-90f1-ffbb7e455aaa@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-c32d6fbf-32dd-45ed-90f1-ffbb7e455aaa@palmerdabbelt-glaptop1>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 09:07:27AM -0700, Palmer Dabbelt wrote:
> * The addition of a symbol export for clint_time_val, which has been inlined
>   into some timex functions and can be used by drivers.

Err, haven't we just agreed on that this is a bad idea and jitterentropy
should not call get_cycles()?
