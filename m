Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7792D182F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgLGSHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGSHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:07:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D09C061793;
        Mon,  7 Dec 2020 10:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=cU2izUF0U8oU/+JZ+FI/5fLEHzSRensvQxJYfR5QiZQ=; b=hlu0NKeSRiaunpXlOfiiZEyuI5
        RAb/zNImj0jipcbI154rSJqDnJus5Qxscf2/NDuwF3KWJSvwc2Zs+7f6DmcwMv/mHx7zOiwvdHK0F
        8J3LwKyGYt7fdVS7iMCe6GhquEh7Cn0EIXFn6a8JgPIWrgRzGopY7l81ij6ZFbiZJgnjbVqIv3g7Y
        +0vUaASyaNNLEyuWLMweRzYVlI3nUMX9xpQftseJcmBx0aImRtyAUQtUChmBxu+4zsxmxs7A+q/07
        ac/jY0/dRs5mvC137MQTc7ZtVtdjcTcxr4Kr078a5PRmTh0+oJMwTINzTaUbx44cu8yHRpw2Gt+aO
        Do9FwEew==;
Received: from [2601:1c0:6280:3f0::1494]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmKu7-00080m-Ea; Mon, 07 Dec 2020 18:06:31 +0000
Subject: Re: [PATCH] arch: fix spelling mistakes in Kconfig
To:     Colin King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
References: <20201207155004.171962-1-colin.king@canonical.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <da56a602-7d36-e141-04dc-799f7a0fa04a@infradead.org>
Date:   Mon, 7 Dec 2020 10:06:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201207155004.171962-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/20 7:50 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are a few spelling mistakes in the Kconfig comments and help
> text. Fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy
