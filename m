Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5310C26BF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIPIkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbgIPIkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:40:36 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B33420678;
        Wed, 16 Sep 2020 08:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600245636;
        bh=9/jLc6Hh0XM5wA4iwl1MJX6huqDrd9/aFYZ5hSgKcvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zq/Qv/EEXjcAVqj4/a627j3LyXIjt1K30xLqRmoZzBvPWUX2sEbIkVUdxoakO2OHp
         a242RwYQ5UgTgJ3uvxP+GZzpUAh342oiH4FvJnfYeuOuXo/BWgf4dnoWOSjmr5Kc1I
         OVwpisTBU3i02rV0E2H28CxRqAVomQ0IJpzhp3gE=
Date:   Wed, 16 Sep 2020 09:40:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Bailu Lin <bailu.lin@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangqing@vivo.com
Subject: Re: [PATCH] doc: zh_CN: index files in arm64 subdirectory
Message-ID: <20200916084030.GE27496@willie-the-truck>
References: <20200916045720.33636-1-bailu.lin@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916045720.33636-1-bailu.lin@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 09:57:01PM -0700, Bailu Lin wrote:
> Add filesystems subdirectory into the table of Contents for zh_CN,
> all translations residing on it would be indexed conveniently.

Sorry, I don't understand the reference to "filesystems" here. Is this
a copy-paste of a different commit message, or am I just failing to read
it properly?

Will
