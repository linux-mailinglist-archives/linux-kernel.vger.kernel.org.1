Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7176D2E9307
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbhADKEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:04:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:44176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbhADKEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:04:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609754605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=XvxQL3uo22xOTWuEV8NxyovOsIbCf5mKq1Te0FZo3Bw=;
        b=pCfhgPrgcnkR4WfgJRm8EFDbmJKccSO1JxSZxj4mXh9krJcUjo0z66jQP24eo3ca8PYsU+
        Nk9DdyledQXBPQxA+SdKptXfmYlhg6QkublCdq/S5h+TfqUdpSc0PLAKS6Z1RTvWIHJX1a
        rKe8oVOZRwL1A0ALQsypJdofTjAJcOQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E902AAD18;
        Mon,  4 Jan 2021 10:03:24 +0000 (UTC)
Date:   Mon, 4 Jan 2021 11:03:23 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: uninitialized pmem struct pages
Message-ID: <20210104100323.GC13207@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
back in March [1] you have recommended 53cdc1cb29e8
("drivers/base/memory.c: indicate all memory blocks as removable") to be
backported to stable trees and that has led to a more general discussion
about the current state of pfn walkers wrt. uninitialized pmem struct
pages. We haven't concluded any specific solution for that except for a
general sentiment that pfn_to_online_page should be able to catch those.
I might have missed any follow ups on that but I do not think we have
landed on any actual solution in the end. Have I just missed any followups?

Is anybody working on that?

Also is there any reference explaining what those struct pages are and
why we cannot initialize them? I am sorry if this has been explained to
me but I really cannot find that in my notes anywhere. Most pmem pages
should be initialized via memmap_init_zone_device, right?

I am asking mostly because we are starting to see these issues in
production and while the only visible problem so far is a crash when
reading sysfs (removable file) I am worried we are just lucky no other
pfn walker stumble over this.

[1] http://lkml.kernel.org/r/CAPcyv4jpdaNvJ67SkjyUJLBnBnXXQv686BiVW042g03FUmWLXw@mail.gmail.com
-- 
Michal Hocko
SUSE Labs
