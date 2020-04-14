Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0EE1A75AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 10:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407108AbgDNIQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 04:16:57 -0400
Received: from verein.lst.de ([213.95.11.211]:38066 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407099AbgDNIQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:16:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1527168BEB; Tue, 14 Apr 2020 10:16:47 +0200 (CEST)
Date:   Tue, 14 Apr 2020 10:16:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] loop: Call loop_config_discard() only after new config
 is applied.
Message-ID: <20200414081646.GA26486@lst.de>
References: <20200331114116.21642-1-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331114116.21642-1-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 01:41:16PM +0200, Martijn Coenen wrote:
> loop_set_status() calls loop_config_discard() to configure discard for
> the loop device; however, the discard configuration depends on whether
> the loop device uses encryption, and when we call it the encryption
> configuration has not been updated yet. Move the call down so we apply
> the correct discard configuration based on the new configuration.
> 
> Signed-off-by: Martijn Coenen <maco@android.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
