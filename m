Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850C327B306
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 19:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgI1RXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 13:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgI1RXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 13:23:16 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB7B2080A;
        Mon, 28 Sep 2020 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601313796;
        bh=3KMAWSEKq7H09MfVihSBQMAUZXAAwDdewBeHU1AqHjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZt0JYPX83WpCKydjEkOeffBj9RV0jwQ9/+0Hg8GfP2lE+Vy46hIXTWXBH9oGgw/I
         PzkKKEW73gtNWg8isLLeI1VcpoZV42+Q9YjkF0r/taQTow2p+1MlIxETbEcXpFffg9
         R+HMp5982g1J5NOy4qi4DU3WZ9eAriFd6ai6H5aE=
Date:   Mon, 28 Sep 2020 10:23:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity check on
 segment/section count
Message-ID: <20200928172314.GB169646@gmail.com>
References: <20200928094239.66221-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928094239.66221-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 05:42:39PM +0800, Chao Yu wrote:
> As syzbot reported:

Please include the Reported-by line that the syzbot report said to include.

- Eric
