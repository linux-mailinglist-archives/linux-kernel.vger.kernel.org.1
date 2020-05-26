Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF3C1C1BB2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 19:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgEARaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 13:30:35 -0400
Received: from verein.lst.de ([213.95.11.211]:47993 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbgEARaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:30:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C9B8968C65; Fri,  1 May 2020 19:30:32 +0200 (CEST)
Date:   Fri, 1 May 2020 19:30:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/10] loop: Refactor loop_set_status() size
 calculation
Message-ID: <20200501173032.GD22792@lst.de>
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-5-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429140341.13294-5-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason this fails to apply for me against both
Jens' for-5.8/block and Linus' current tree.

What is the baseline for this series?
