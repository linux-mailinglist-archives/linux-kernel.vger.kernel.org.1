Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420EE2B2CB5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 11:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgKNK3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 05:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgKNK3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 05:29:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EAAC0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 02:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RQ0BzoWz9BYLNavzrfqo48yO4I5cp41/13j1nTRCVR4=; b=XuxKeboAw5/NxoxHqkFJ4yyORJ
        0rLruR0ECyYolv7tP9YNNPU8vPPwRSodxg8G6NKmcisPUO+GS4GpIw2MX/3cBwi+IY/GH+I64BN2L
        +2q67bTke814X4PbLqQOMBDYkGDyd80dQGH/3flVDIZfObJ3y4TnuSnzQdfYMOGqKUejPO7tToOXO
        doxl4/tbNNgbsgsqeozI8tTn3gdo7ahGQuCRtxcAoYuPH1m4T1bAxk8zngx3VqpOmMvB2zvBvH6kJ
        OvCD1utKZ5L4GB4Os3Xzn5Foip4xph1mA+bWR0S87CawvM78pObvFRG+qjODtdujSqwYKYUg1Qjb3
        JuMxeoaQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdsnd-0002Pi-Dz; Sat, 14 Nov 2020 10:28:53 +0000
Date:   Sat, 14 Nov 2020 10:28:53 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: [RFC] depopulate_range_driver_managed() for removing page-table
 mappings for hot-added memory blocks
Message-ID: <20201114102853.GA8618@infradead.org>
References: <bb30aa44d367ad217e9c877eba7b0a12@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb30aa44d367ad217e9c877eba7b0a12@codeaurora.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 06:41:22PM -0800, Sudarshan Rajagopalan wrote:
> 
> Hello,
> 
> When memory blocks are removed, along with removing the memmap entries,
> memory resource and memory block devices, the arch specific
> arch_remove_memory() is called which takes care of tearing down the
> page-tables.
> 
> Suppose there???s a usecase where the removed memory blocks will be added
> back into the system at later point,

Stop this crap.  If you have a use case post the actual use here,
including code and specs.  If you don't have that don't waste peoples
time on your pipe dream.
