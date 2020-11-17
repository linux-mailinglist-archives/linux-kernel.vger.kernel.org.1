Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B852B7034
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgKQUgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKQUgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:36:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE09C0613CF;
        Tue, 17 Nov 2020 12:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=oJYI9L3oiXkFcCPNemvmAO3tCBC9E9iUG5QLGCipFfU=; b=D9oEeMD5QyXlFsPSpU1BXoj7xA
        Q+P3e9V57HcsatlptBcqq9ZhlIm1B8ilqWa2U8EovSugU2ytK7GE1AU78kwonoDncyrxLS/ghjl2k
        t7/MsRMSYvb7N24sdr7PSU27NKjx6/ZMvFeHvBLqbHw+Wvdmcl39f99lhce6M1YIEWa8kZqPqhawu
        UctjB/gygHKlXwGCeA48VNfM6UX/wGopJSWkkyyBC57uMdj14KzUPzMW6MIlNglf1U7/ldPZ6Msna
        23yaA2sHCVE4fJ8fC/k66SS3FdD105jkceY4hZ5nur1jpPKZw9vKZwuMqce1v0MppmwqCl/2RM2yz
        KcBVueaQ==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf7i1-0001bI-7X; Tue, 17 Nov 2020 20:36:13 +0000
Subject: Re: [PATCH 8/9] platform/surface: Add Surface Aggregator user-space
 interface
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20201115192143.21571-1-luzmaximilian@gmail.com>
 <20201115192143.21571-9-luzmaximilian@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5341e4aa-4af3-104e-af54-577f5b6a3594@infradead.org>
Date:   Tue, 17 Nov 2020 12:36:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201115192143.21571-9-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/20 11:21 AM, Maximilian Luz wrote:
> +#define SSAM_CDEV_REQUEST	_IOWR(0xA5, 1, struct ssam_cdev_request)

All ioctl major numbers (0xA5) should be documented in
Documentation/userspace-api/ioctl/ioctl-number.rst

Apologies if I missed it somewhere else.

thanks.
-- 
~Randy

