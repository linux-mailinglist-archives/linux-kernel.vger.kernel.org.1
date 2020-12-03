Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C08F2CDDB2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgLCScq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLCScq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:32:46 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BB0C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 10:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=tBIj2zDo22n3fEMQCuqoef2DD0qvtMwVSckH6uiJOkI=; b=fcNxwcRN7HFCGM4ei7OnOsDAbh
        2m8P4OrG7wzZYSvM+8Kk+pRHKOZM7oe0z0WSnRwsXKJvcPu9F+gbzmMCVPoo1uPewNXIguK+ih0cQ
        pt+XJw5IekHmA5vDFZNGOo9FyitFxbjGoph2x0H8tpziz6rHe9tak9mEcASdSMzNsta1KhqzEaNYg
        Jo/fdOUAHO/gOvEXm7aClGNhNmJ1ZqeMNKz2fUhwBSJ9UPDpNV7Pq9SMDPz8i9kGzhyzla3l0L4oI
        Py2SiR8KFsAwL0BDSKZA5O3PCespfn+SKiQqubU32YbyWsbzHnFLHv28veoiIzC1RfM/OoG27CudT
        k5ebdDpA==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kktOX-0003kE-QR; Thu, 03 Dec 2020 18:31:58 +0000
Subject: Re: [RFC PATCH] checkpatch: correctly detect lines of help text
To:     Joe Perches <joe@perches.com>,
        Nicolai Fischer <nicolai.fischer@fau.de>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
References: <133ac827-c0d2-c5c7-39d8-7d2c17de7c76@fau.de>
 <8436bc4191d92af283ea6aa7ca450e36da653e2e.camel@perches.com>
 <16f0bfd4-61ca-48d8-c9ab-10bfc9a233ad@infradead.org>
 <a83033e9fcc706be129e9c4c0d30a0542f13d406.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7a81a3c0-2734-4799-5b34-0a6279c1e59d@infradead.org>
Date:   Thu, 3 Dec 2020 10:31:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a83033e9fcc706be129e9c4c0d30a0542f13d406.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/20 9:58 AM, Joe Perches wrote:
> On Wed, 2020-12-02 at 10:59 -0800, Randy Dunlap wrote:
> 
>> There are also large hunks of block/Kconfig and drivers/hid/Kconfig
>> that don't use any indentation for help text...
>> in case that matters here.
> 
> Maybe something like this could help.
> 
> Indent the unindented help blocks by 2 spaces and reflow where appropriate.
> 
> ---
>  block/Kconfig       | 105 +++++-----
>  drivers/hid/Kconfig | 549 +++++++++++++++++++++++++++-------------------------
>  2 files changed, 335 insertions(+), 319 deletions(-)


LGTM. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
