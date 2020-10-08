Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247C02879A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgJHQEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 12:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgJHQEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 12:04:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67142C061755;
        Thu,  8 Oct 2020 09:04:30 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 728E52E6;
        Thu,  8 Oct 2020 16:04:29 +0000 (UTC)
Date:   Thu, 8 Oct 2020 10:04:27 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: filesystems: better locations for
 sysfs-pci, sysfs-tagging
Message-ID: <20201008100427.39ca3c1f@lwn.net>
In-Reply-To: <20201007233151.490953-1-jhubbard@nvidia.com>
References: <20201007233151.490953-1-jhubbard@nvidia.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Oct 2020 16:31:51 -0700
John Hubbard <jhubbard@nvidia.com> wrote:

> sysfs-pci and sysfs-tagging were mis-filed: their locations with
> Documentation/ implied that they were related to file systems. Actually,
> each topic is about a very specific *use* of sysfs, and sysfs *happens*
> to be a (virtual) filesystem, so this is not really the right place.
> 
> It's jarring to be reading about filesystems in general and then come
> across these specific details about PCI, and tagging...and then back to
> general filesystems again.
> 
> Move sysfs-pci and sysfs-tagging to a location under the sysfs topic.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

I see why you want to do this, but I have to wonder if moving them out of
Documentation/filesystems entirely might not be a better approach.
sysfs-pci.rst might better belong in the admin guide or under PCI/, while
sysfs-tagging.rst could go under networking/.

Make sense?

Thanks,

jon
