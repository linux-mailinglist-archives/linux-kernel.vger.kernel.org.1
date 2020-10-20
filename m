Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD37028BE81
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403996AbgJLQxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403984AbgJLQxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:53:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D4AC0613D0;
        Mon, 12 Oct 2020 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=0xPKHcc8MTxN9G6km2QTOKG69v7B4xiLbgAzISFd/e0=; b=kz3byLEjQRbXUjKEwxSctQX5ib
        JSA+qNZHtA9aewEXAvoV2M3/g5ArH8yJiAAE/kke62YDaHPl5o3/+xMrd/i+waTWdk3FhLyFNeYuc
        4Nk7+Bj9BYXz1xAwd03P2XqWJ4u6gF0YTzxkwS+nNCJwrPuiM7tYRinTk9MOFt20vbPG0TllKA7E7
        FUnU7I/afnKhT4pPw79tju4VhbduW2vl13IeqsRBdekOuYvNqMsrEYykSyc7jGqRQHVc5tHH6aPY+
        3213WdwwwrFYELr6mggaHw1E8IyEoal3f+Bv/YjhibFGCElAxvPsPRtwNZbUqKeJg0h3VUzn9VsZs
        n9KroRrg==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kS14o-0005Ww-Nr; Mon, 12 Oct 2020 16:53:35 +0000
Subject: Re: [PATCH v2 21/22] mpool: add documentation
To:     Nabeel M Mohamed <nmeeramohide@micron.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org
Cc:     smoyer@micron.com, gbecker@micron.com, plabat@micron.com,
        jgroves@micron.com
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201012162736.65241-22-nmeeramohide@micron.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <57fef732-f63d-9c9c-e368-660c654a7438@infradead.org>
Date:   Mon, 12 Oct 2020 09:53:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012162736.65241-22-nmeeramohide@micron.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/drivers/mpool/mpool-locking.rst b/drivers/mpool/mpool-locking.rst
> new file mode 100644
> index 000000000000..6a5da727f2fb
> --- /dev/null
> +++ b/drivers/mpool/mpool-locking.rst
> @@ -0,0 +1,90 @@

> +Object Layout Reference Counts
> +------------------------------
> +
> +The reference counts for an object layout (eld_ref) are protected
> +by mmi_co_lock or mmi_uc_lock of the object's MDC dependiing upon

                                                     depending

> +which tree it is in at the time of acquisition.

-- 
~Randy

