Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68DE2CA044
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgLAKrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:47:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:52146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgLAKrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:47:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606819610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4XjxTKeWtP85u4526YK/SSmoEntBxdWY4/p5zoANOP4=;
        b=TAzVYi8vnq0zQMjJEIsvdiOYFoPxx5uscNRrykhIOJGq3ghBk6yMk/adgzffNIgHxoQKUV
        hNSzuvfGEE2nVdUZMsdtDsr4sEa23wQWXKwzfSNCUUkJch4OMhtdP9qxBfbDzu7ayhF9zc
        HCFtSaXYDNsWg/MhksNi3ZJNpELWeOY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 76A20AC90;
        Tue,  1 Dec 2020 10:46:50 +0000 (UTC)
Date:   Tue, 1 Dec 2020 11:46:50 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] reboot: allow to override reboot type if quirks are
 found
Message-ID: <X8YfGllCdPcyH1my@alley>
References: <20201130173717.198952-1-mcroce@linux.microsoft.com>
 <20201130173717.198952-2-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130173717.198952-2-mcroce@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-11-30 18:37:16, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> On some machines a quirk can force a specific reboot type.
> Quirks are found during a DMI scan, the list of machines which need
> special reboot handling is defined in reboot_dmi_table.
> 
> The kernel command line reboot= option overrides this via a global
> variable `reboot_default`, so that the reboot type requested in
> the command line is really performed.
> 
> This was not true when setting the reboot type via the new sysfs
> interface. Fix this by setting reboot_default upon the first change,
> like reboot_setup() does for the command line.

Strictly speaking this is not necessary. The quirks are proceed
in core_initcall() while the sysfs interface is created in
late_initcall(). By other words, the quirks are uses before
the default can be modified by the sysfs interface.

On the other hand, it does not harm. Better be on the safe
side for eventual future changes.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
