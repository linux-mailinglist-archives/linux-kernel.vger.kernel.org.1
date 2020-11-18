Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE022B72FF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 01:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgKRAX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 19:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKRAXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 19:23:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE56C0613CF;
        Tue, 17 Nov 2020 16:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=x66IiCb3J78ZY3ZCN379wprOnWskvKlwPEBSJOmY+qk=; b=h/ilHSI//Cj40icPF5NAyf72zk
        oJ2mH8JAKNXT8MvGjd3tA/Ej26ljvchcRTuv5EyhszSepD7NWHZ+Z+pOWObqA+KdnBsCqV/pXmy5N
        PZwBWzPa1wn0PM63RCJZ5yARcc9ZPO47HlrQwOTMkEYKze79YmLVHuG9yOluaCsZcTOnhaOBphZoZ
        z+MwcBvumcMA7Ak/HKM6/lLkDvM+nknrtIF/Awt/aF9Y8N3rKM4FVPgVxBiO1elcPG5LIkIM+WwTZ
        cn8/q0wbw1Rv6QcaujlyJv/jO2uPNMXCbYOVF2x3/e7aIAE+tj9bjU22BQSyJMR/X/qo3pXxQqoEU
        ddU/0ZTw==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfBGK-0006C5-SH; Wed, 18 Nov 2020 00:23:53 +0000
Subject: Re: [RFC] Add kernel-doc test script
To:     Eduardo Habkost <ehabkost@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20201030144713.201372-1-pbonzini@redhat.com>
 <20201030144713.201372-3-pbonzini@redhat.com>
 <20201113152106.7b4a07ee@lwn.net>
 <20201113223912.GK17076@casper.infradead.org>
 <20201117212452.GM1235237@habkost.net>
 <20201117213051.GA29991@casper.infradead.org>
 <20201117223612.GN1235237@habkost.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <16145b8b-3213-8bc9-1826-d3ae006f78fa@infradead.org>
Date:   Tue, 17 Nov 2020 16:23:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201117223612.GN1235237@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/20 2:36 PM, Eduardo Habkost wrote:
> Add a kernel-doc test script to tools/testing/kernel-doc.
> 
> radix_tree_lookup_slot test case provided by Matthew Wilcox.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Very good idea.

I have had a kernel-doc test source file for (?) 10-12 years,
while I was the docs maintainer.

I didn't have the "expected" files for comparison.
I just used $web_browser.

> ---
>  tools/testing/kernel-doc/test-case.h          | 111 ++++++++++
>  .../testing/kernel-doc/test-case.man.expected | 150 ++++++++++++++
>  .../kernel-doc/test-case.none.expected        |   0
>  .../kernel-doc/test-case.rst2.expected        | 195 ++++++++++++++++++
>  .../kernel-doc/test-case.rst3.expected        | 195 ++++++++++++++++++
>  tools/testing/kernel-doc/test.sh              |  90 ++++++++
>  6 files changed, 741 insertions(+)
>  create mode 100644 tools/testing/kernel-doc/test-case.h
>  create mode 100644 tools/testing/kernel-doc/test-case.man.expected
>  create mode 100644 tools/testing/kernel-doc/test-case.none.expected
>  create mode 100644 tools/testing/kernel-doc/test-case.rst2.expected
>  create mode 100644 tools/testing/kernel-doc/test-case.rst3.expected
>  create mode 100755 tools/testing/kernel-doc/test.sh

thanks.
-- 
~Randy

