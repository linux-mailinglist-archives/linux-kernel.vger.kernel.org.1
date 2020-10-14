Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670C928E410
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbgJNQKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731897AbgJNQKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:10:52 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E514F206F4;
        Wed, 14 Oct 2020 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602691851;
        bh=XKX2oUmGeNqyheyV0mb5u9TSV9LACj1x1Zo2RhAnypk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BwZA9Aww7+yxdB7jErWtlQgwtkmAuYTtm/hceEiaLKDAt/M21+1rT5wQy9j0N3mq0
         niy9aHcOYfx1vC5P3a61igk+Otz1AN1F5RhmD8mDQVtBTEhYkiGFGUKsYa9qIzoaSH
         l9Co+/SFPxSKA3IXiNjvDc9C0hjXrH0gNxTne3Qo=
Date:   Wed, 14 Oct 2020 09:10:48 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet: fix uninitialized work for zero kato
Message-ID: <20201014161048.GA1267726@dhcp-10-100-145-180.wdl.wdc.com>
References: <20201014033650.953656-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014033650.953656-1-pizhenwei@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 11:36:50AM +0800, zhenwei pi wrote:
> Fixes:
> Don't run keep alive work with zero kato.

"Fixes" tags need to have a git commit id followed by the commit
subject. I can't find any commit with that subject, though.
