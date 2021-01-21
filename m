Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4262FF0AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbhAUQk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:40:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:50632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388093AbhAUQiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:38:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97F7AAB7A;
        Thu, 21 Jan 2021 16:37:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D4446DA6E3; Thu, 21 Jan 2021 17:35:31 +0100 (CET)
Date:   Thu, 21 Jan 2021 17:35:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Yang Li <abaci-bugfix@linux.alibaba.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove redundant NULL check
Message-ID: <20210121163531.GC6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Yang Li <abaci-bugfix@linux.alibaba.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1611217187-50142-1-git-send-email-abaci-bugfix@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611217187-50142-1-git-send-email-abaci-bugfix@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 04:19:47PM +0800, Yang Li wrote:
> Fix below warnings reported by coccicheck:
> ./fs/btrfs/raid56.c:237:2-8: WARNING: NULL check before some freeing
> functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>

Added to misc-next, thanks.
