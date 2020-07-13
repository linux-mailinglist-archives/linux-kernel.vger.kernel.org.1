Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5421D087
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 09:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgGMHjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 03:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMHjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:39:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D31C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=CbukIvze+ixkFFZXYcRf9D8Qw7Vh9xCWbm2oNoPWjQA=; b=pmaQ6O8cNOxUREJ2p1yuaNhJZb
        LNqbRz1o0HHdW6bW5iXL2nZz2I00KJEWtR0MrhW6wHaphw01CdnnTndMSfaUMO7yttHSEI9JmY8Jm
        LTv7pRgag1x01U8+QcGtr7BDv1SG5iIRyBdDZCV4xKhVU4qoF0TKJULwcG9rxcArKCQS9gqM8Foee
        s8WRjmxM3dbowaximf6AW1/yJBTX+GiWXzRVaANFEASqMix3y0NYB41oDbmDM0GwUZHBFFnnAdjuU
        3qP8aQO9mrLelYHz0r1ZHtBo9kLX8b/CqNbCdz3SDEIykBPzDrEIH4CmT1CAgjiOm6sv/9jKCH0xz
        65+1mhrA==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jut3u-0000hg-HI; Mon, 13 Jul 2020 07:39:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: allow ->read_iter on debugfs
Date:   Mon, 13 Jul 2020 09:37:28 +0200
Message-Id: <20200713073729.875584-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

in my filesystem set_fs removel series I convert the seq_file interface
to be iov_iter based.  It turns out debugfs needs this little patch
to proxy read_iter as well.  Let me know if you are ok with me queueing
this up with the rest of the series.


