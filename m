Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535702CA14C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgLAL1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:27:40 -0500
Received: from verein.lst.de ([213.95.11.211]:49293 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbgLAL1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:27:39 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2070268AFE; Tue,  1 Dec 2020 12:26:57 +0100 (CET)
Date:   Tue, 1 Dec 2020 12:26:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 3/4] configfs: implement committable items
Message-ID: <20201201112656.GA32252@lst.de>
References: <20201130164704.22991-1-brgl@bgdev.pl> <20201130164704.22991-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130164704.22991-4-brgl@bgdev.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 05:47:03PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This implements configfs committable items. We mostly follow the
> documentation except that we extend config_group_ops with uncommit_item()
> callback for reverting the changes made by commit_item().
> 
> Each committable group has two sub-directories: pending and live. New
> items can only be created in pending/. Attributes can only be modified
> while the item is in pending/. Once it's ready to be committed, it must
> be moved over to live/ using the rename() system call. This is when the
> commit_item() function will be called.
> 
> Implementation-wise: we reuse the default group mechanism to elegantly
> plug the new pseude-groups into configfs. The pending group inherits the
> parent group's operations so that config_items can be seamlesly created
> in it using the callbacks supplied by the user as part of the committable
> group itself.

This looks pretty awkward in the hierachy, but I can't really think
of anything else.  One idea would be to require fsync to stage updates,
but that isn't really very well discoverable.
