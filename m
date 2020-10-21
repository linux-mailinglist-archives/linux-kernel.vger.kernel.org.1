Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD0129477A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 06:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440234AbgJUEo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 00:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440223AbgJUEo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 00:44:26 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4792220870;
        Wed, 21 Oct 2020 04:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603255465;
        bh=NSD15rPO3YaMhGoJDEWcp2TNY4YumkkVq4v93a7kYbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pLNhDJKWCSBY93whNOy21YCe8QrEvk+XkjDh7CQW0aWQuGVOkANEbhDX/C1O3QCpI
         hvrYzTl4IgOqcE3pjjhmXII7NhsF6TrETV8pxZ7wSSI3QmUTeoWCIpaf7eA04intdN
         zwCIXQm9N/J1GsvjZ1Plh3SgHIQ0Y6ywNdsMIDcA=
Date:   Tue, 20 Oct 2020 21:44:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Satya Tangirala <satyat@google.com>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v2 1/4] block: keyslot-manager: Introduce passthrough
 keyslot manager
Message-ID: <20201021044423.GB3939@sol.localdomain>
References: <20201015214632.41951-1-satyat@google.com>
 <20201015214632.41951-2-satyat@google.com>
 <20201016072044.GB14885@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016072044.GB14885@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 08:20:44AM +0100, Christoph Hellwig wrote:
> And this just validates my argument that calling the inline crypto work
> directly from the block layer instead of just down below in blk-mq was
> wrong.  We should not require any support from stacking drivers at the
> keyslot manager level.

I'm not sure what you're referring to here; could you clarify?

It's true that device-mapper devices don't need the actual keyslot management.
But they do need the ability to expose crypto capabilities as well as a key
eviction function.  And those are currently handled by
"struct blk_keyslot_manager".  Hence the need for a "passthrough keyslot
manager" that does those other things but not the actual keyslot management.

FWIW, I suggested splitting these up, but you disagreed and said you wanted the
crypto capabilities to remain part of the blk_keyslot_manager
(https://lkml.kernel.org/linux-block/20200327170047.GA24682@infradead.org/).
If you've now changed your mind, please be clear about it.

- Eric
