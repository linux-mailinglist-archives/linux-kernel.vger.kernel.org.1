Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B21C303291
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 04:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbhAYJ0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:26:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbhAYJSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:18:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C9CC22CA2;
        Mon, 25 Jan 2021 08:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611563182;
        bh=CuJrYRrYf7WL11377lrtvLj2cjYzO9x2JrC4f55ZRHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AGlpPYaST+CA3Nza5xK0fAiDgr+sK295EfqdamA4Nb297b79TjjtNhOW7ZO5SXIlV
         MwuW8h1fubIY+5DSdV3c2hZx+qCiSbQ1lVByGnunjzGFHI0oXt+jrvkPxwi8zlKvoV
         yQ5Xq65yOErVHpg5lEX3pbBZQkHLmgRGAE56uxf0=
Date:   Mon, 25 Jan 2021 09:26:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: Rename all existing 'memhp' into 'mhp'
Message-ID: <YA6AqupAWINtNckx@kroah.com>
References: <1611554093-27316-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611554093-27316-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:24:53AM +0530, Anshuman Khandual wrote:
> This renames all 'memhp' instances to 'mhp' except for memhp_default_state
> for being a kernel command line option. This is just a clean up and should
> not cause a functional change.

THat says _what_ you are doing, but I have no idea _why_ this is needed
for anything...

thanks,

greg k-h
