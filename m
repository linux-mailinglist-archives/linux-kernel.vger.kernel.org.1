Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751EF286068
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgJGNqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:46:16 -0400
Received: from verein.lst.de ([213.95.11.211]:37411 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgJGNqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:46:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 574736736F; Wed,  7 Oct 2020 15:46:14 +0200 (CEST)
Date:   Wed, 7 Oct 2020 15:46:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 09/12] samples: configfs: prefer sizeof(*var) to
 sizeof(struct var_type)
Message-ID: <20201007134614.GC764@lst.de>
References: <20200924124526.17365-1-brgl@bgdev.pl> <20200924124526.17365-10-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924124526.17365-10-brgl@bgdev.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 02:45:23PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> It's better to use the size of the actual variable than its type when
> allocating memory. This also has the benefit of avoiding a line break
> here.

Either style has up an downside.  The variable based on tracks type
changes automatically, but on the other hand leads to lots of bugs
where people forget the *.  I'd rather not just change from one to
the other pointlessly.
