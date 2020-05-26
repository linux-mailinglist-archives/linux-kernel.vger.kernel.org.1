Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821A51C71A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 15:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgEFN2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 09:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgEFN2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:28:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EB28206DB;
        Wed,  6 May 2020 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588771702;
        bh=LVUfe9mSykJZFr6+07W64xVGHzU3Mi6tnYebvbmsww8=;
        h=Date:From:To:Cc:Subject:From;
        b=MdehGSe4QwJ2WJS3nPHgN3xY7ScZNMJX2eUU+PzKZLBoXY2hTSY7fE0mgZBCNEcnN
         6OuHULEQyNb4i3Egcc0hdins1d0FSKERgLil/nxz1Yq+FLzp4Lf1A4cGNifVnUmJA2
         0LRXYCo0IglL7Kygq0OptJCv1xCvtqsjYBOEvSgU=
Date:   Wed, 6 May 2020 14:28:17 +0100
From:   Will Deacon <will@kernel.org>
To:     mingo@kernel.org, tglx@linutronix.de, paulmck@kernel.org
Cc:     peterz@infradead.org, elver@google.com,
        linux-kernel@vger.kernel.org
Subject: Please can I have a stable KCSAN branch for 5.8?
Message-ID: <20200506132816.GJ8043@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi TIP folks,

I'm looking to rebase my READ_ONCE() series [1] on top of the KCSAN patches
so that we can get them in for 5.8. However, tip/locking/kcsan seems to be
missing some bits:

  * An update to checkpatch.pl to warn about missing comments for
    data_race():

    https://lore.kernel.org/r/20200401101714.44781-1-elver@google.com

  * I'm unable to apply these two patches from Marco that are needed for
    my READ_ONCE() work:

    https://lore.kernel.org/lkml/20200424154730.190041-1-elver@google.com/

    I think these depend on stuff that has been queued by Paul, and appears
    in linux-next, but to be honest with you I'm quite confused about what
    is queued for 5.8 and what isn't.

What's the best base for me to use?

Cheers,

Will

[1] https://lore.kernel.org/r/20200421151537.19241-1-will@kernel.org
