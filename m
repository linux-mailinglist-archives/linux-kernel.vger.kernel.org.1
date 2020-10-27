Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9F129A606
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508610AbgJ0IBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:01:01 -0400
Received: from verein.lst.de ([213.95.11.211]:37700 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390715AbgJ0IBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:01:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7664767373; Tue, 27 Oct 2020 09:00:58 +0100 (CET)
Date:   Tue, 27 Oct 2020 09:00:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Kyle Huey <me@kylehuey.com>
Subject: Re: [PATCH] Fix compat regression in process_vm_rw()
Message-ID: <20201027080058.GA22650@lst.de>
References: <f69575e0-5170-2d51-8d74-8b3453723aa3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f69575e0-5170-2d51-8d74-8b3453723aa3@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
