Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700581F84C7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 20:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgFMSyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 14:54:51 -0400
Received: from 8bytes.org ([81.169.241.247]:47594 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgFMSyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 14:54:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3264A2D8; Sat, 13 Jun 2020 20:54:49 +0200 (CEST)
Date:   Sat, 13 Jun 2020 20:54:47 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Subject: Re: [git pull] iommu: Move Intel and AMD drivers to a subdirectory
Message-ID: <20200613185447.GC3701@8bytes.org>
References: <20200612152205.GA18833@8bytes.org>
 <CAHk-=whtWYyUWP2Us3ZnOQB8i=C6JkVRZ7EG74rVY3K2v-gKaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whtWYyUWP2Us3ZnOQB8i=C6JkVRZ7EG74rVY3K2v-gKaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:23:49PM -0700, Linus Torvalds wrote:
> Looks good to me. Any time a directory starts to have a lot of
> filenames with a particular prefix, moving them deeper like this seems
> to make sense. And doing it just before the -rc1 release and avoiding
> unnecessary conflicts seems like the right time too.
> 
> So pulled.

Thanks!

> Looking at it, it might even be worth moving the Kconfig and Makefile
> details down to the intel/amd subdirectories, and have them be
> included from the main iommu ones? But that's up to you.

Yeah, right. Its cleaner to move the Kconfig and Makefile stuff a level
deeper too, I'll take care of that for v5.9.


	Joerg

