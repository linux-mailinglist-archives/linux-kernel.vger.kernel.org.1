Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172ED27B445
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgI1STA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgI1STA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:19:00 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A0A9206C3;
        Mon, 28 Sep 2020 18:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601317139;
        bh=E7RNuUSPfvtE7jpiObwtzpwal66tOS7GFaUg8Gd3Wz4=;
        h=Date:From:To:Cc:Subject:From;
        b=CKw/MGF9lt9qb8i6Q7X9U3pUvYwLyqJeAjzgIhZoAOzE1bv+ayHHjFhKCVTyJTtC5
         IxPBqtVxzTI07nnrCKMqpFiOkXxqoJnUc7XtP3fn/nJnPVju7+ZN2YIg4hwjmsjXz2
         kMjXwPeXd/qwp4YlFg439RpDVi2GhMjnaLpWh+gE=
Date:   Mon, 28 Sep 2020 13:24:38 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Reporting bug in mpi_ec_mul_point()
Message-ID: <20200928182438.GA11739@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm reporting the following bug detected by Coverity:

The _scalar_copied_ variable is set to 0 at

lib/mpi/ec.c:1255:
1255                 int scalar_copied = 0;

and it is never updated before reaching the code below:

lib/mpi/ec.c:1317
1317                 if (scalar_copied)                                                         
1318                         mpi_free(scalar);

This code was introduced by commit d58bb7e55a8a ("lib/mpi: Introduce ec
implementation to MPI library")

Any ideas on what's the right solution for this?

Thanks
--
Gustavo
