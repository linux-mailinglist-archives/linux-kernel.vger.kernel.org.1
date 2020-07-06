Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0169E215EF2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 20:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgGFSnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 14:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbgGFSnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:43:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEEDC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 11:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ORm6apFlr0or9eIN6c2S/XYj8igaAicJE5rQj2wwahI=; b=LlUm6PLA9QnRBupzFu+RUt3epj
        it2UhGCR9Xm0YBc8IurnHhCXq6hz+Qt7i5aLzzdjLgebFPBTtw9OQZJVo5T/3tkBTwYEO43fUh6cO
        YlJbTcga7+RPn/7onL/ahOB3bmm6ZEoiH1qrTe/vx3AGS0OLRtMhaD/ng6SBs/7bvIP9h9aPURC7E
        f1VXBZIkDCEZrX0/rYIwQMqDIT6omuEBOG83AOCw3MTZmhOq5THdOj4Mu6XwqeGJIDLlM4JPKyUhh
        khOoEc6ToKZTwKLnlZF01AkP3MuA7T+IEw0XKb1kWJwUDMVnpNPkkv4kPTIy11CznURRRrvaJsaoU
        P/N26CVQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsW54-00088w-Rc; Mon, 06 Jul 2020 18:43:08 +0000
Subject: Re: [PATCH v3 6/6] Documentation: Describe console mouse reporting
To:     Tammo Block <tammo.block@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
References: <cover.1594032517.git.tammo.block@gmail.com>
 <59a6057afa3b2310384f489b35e15eb624af2774.1594032517.git.tammo.block@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0da88f04-792c-8b8e-7a0e-72a61ffb4b70@infradead.org>
Date:   Mon, 6 Jul 2020 11:43:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <59a6057afa3b2310384f489b35e15eb624af2774.1594032517.git.tammo.block@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/20 4:00 AM, Tammo Block wrote:
> This patch adds a description of the kernel interface(s) used for vt
> console mouse reporting and describes the protocols and bitmasks.
> 
> Signed-off-by: Tammo Block <tammo.block@gmail.com>
> ---
>  .../admin-guide/console-mouse-reporting.rst   | 88 +++++++++++++++++++
>  Documentation/admin-guide/index.rst           |  1 +
>  2 files changed, 89 insertions(+)
>  create mode 100644 Documentation/admin-guide/console-mouse-reporting.rst


Looks good to me.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
