Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063E41B0678
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 12:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDTKXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 06:23:02 -0400
Received: from verein.lst.de ([213.95.11.211]:39855 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTKXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:23:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A185868C4E; Mon, 20 Apr 2020 12:22:59 +0200 (CEST)
Date:   Mon, 20 Apr 2020 12:22:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     James Morse <james.morse@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: stop messing with set_fs in arm_sdei
Message-ID: <20200420102259.GA7862@lst.de>
References: <20200414142302.448447-1-hch@lst.de> <cc0b5d01-bd19-3437-a76e-2d1daa86f9a4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc0b5d01-bd19-3437-a76e-2d1daa86f9a4@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 04:59:16PM +0100, James Morse wrote:
> Hi Christoph,
> 
> On 14/04/2020 15:23, Christoph Hellwig wrote:
> > can you take a look at this series?  I've been trying to figure out
> > what the set_fs in arm_sdei is good for, and could not find any
> > good reason.  But I don't have any hardware implementing this interface,
> > so the changes are entirely untested.
> 
> Its a firmware thing, think of it as a firmware assisted software NMI.
> 
> The arch code save/restores set_fs() because the entry code does that when taking an
> exception from EL1. SDEI does the same because it doesn't come via the same entry code. It
> does it in C because that C is always run before the handler, something that isn't true
> for the regular assembly version.
> 
> The regular entry code does this because any exception may have interrupted code that had
> addr_limit set to something else:
> https://bugs.chromium.org/p/project-zero/issues/detail?id=822
> 
> and the patch that fixed it: commit e19a6ee2460b "arm64: kernel: Save and restore UAO and
> addr_limit on exception entry"

Can you throw in a comment documenting this better?  And pick up the
first patch while we're at it - no need to expose such low-level
mechanisms to modules.
