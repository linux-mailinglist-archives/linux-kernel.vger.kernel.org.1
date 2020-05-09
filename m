Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19631CC207
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 16:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgEIOIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 10:08:06 -0400
Received: from verein.lst.de ([213.95.11.211]:57108 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbgEIOIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 10:08:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 607A168C7B; Sat,  9 May 2020 16:08:03 +0200 (CEST)
Date:   Sat, 9 May 2020 16:08:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Christoph Hellwig <hch@lst.de>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next 20200508 - build failure in kernel/resource.c w/
 SPARSEMEM=n
Message-ID: <20200509140802.GA26307@lst.de>
References: <17362.1589022588@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17362.1589022588@turing-police>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the problem is the select of CONFIG_DEVICE_PRIVATE.  Jason is
looking into it already.
