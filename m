Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A4520E440
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 00:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390978AbgF2VWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 17:22:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:44780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbgF2Sv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:51:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3BCBFAE2B;
        Mon, 29 Jun 2020 18:20:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 190461E12E7; Mon, 29 Jun 2020 20:20:14 +0200 (CEST)
Date:   Mon, 29 Jun 2020 20:20:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     =?iso-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: segmentation faults with kernels >v5.8-rc2
Message-ID: <20200629182014.GJ26507@quack2.suse.cz>
References: <CADDKRnAwnLKn5phH_Zxnje_rg10a-uro=H_sNq697G78BTQrkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADDKRnAwnLKn5phH_Zxnje_rg10a-uro=H_sNq697G78BTQrkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon 29-06-20 15:58:50, J�rg Otte wrote:
> I frequently get segmentation faults in newer kernel >v5.8-rc2 e.g.
> Chrome_ChildIOT[1298]: segfault at 40d048 ip 000056111a41970d sp
> 00007fdced6931b0 error 6 in chrome[561115f64000+785b000]
> 
> Bisection gave me the following
> first bad commit:
> 
> e9c15badbb7b20ccdbadf5da14e0a68fbad51015 is the first bad commit
> commit e9c15badbb7b20ccdbadf5da14e0a68fbad51015
> Author: Mel Gorman <mgorman@techsingularity.net>
> Date:   Mon Jun 15 13:13:58 2020 +0100
> 
>     fs: Do not check if there is a fsnotify watcher on pseudo inodes
> ...
> 
> I double checked by reverting this commit on top of v5.8-rc3 and the
> segmentation faults are gone.

We've already reverted that commit today... Thanks for report!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
