Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9261F201BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 21:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390628AbgFSTuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 15:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390220AbgFSTuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:50:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231EFC06174E;
        Fri, 19 Jun 2020 12:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=n1UPsAHB0y9IVi7VcljjN+43r9iZXlHeVMqIrA/ckXs=; b=qJQHBNzKevUrCiO8YV7tpcvn6e
        AIXyCox3G1fzDVtZZk3hu4PSE5j2zTF9bIIko1V3CidMKaAUnQ8FhuWRBifqU9S02Do0bCaPY7ZEW
        ORuEjRbYYr9ShTImBv9wAZD5NDLlb59hbtbxz0cHu/CRVIvcXiAHUBWj+D0tsdGn5oD5JNdh7HbGi
        PdBqTKOb86R4fc3zuC5BjmYW87UJVF4E9Z9wHBahGuUvUksyJBSTdofdLSiyS/r5EPzpibJGFhBqW
        UqLg50WA4AZUwn6/PHH8lWU1jKP1mOM32LqANvCkgOYLnMQLdSWwbNuaBfSt7brhXoxdIuTHWj6+W
        ps82JzEg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmN1g-00088j-B3; Fri, 19 Jun 2020 19:50:12 +0000
Subject: Re: [PATCH] Documentation: Fix most typos
To:     Jonathan Corbet <corbet@lwn.net>, Joe Perches <joe@perches.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <9587fe318ac88299131e751a07bdd1f4b69ae0de.camel@perches.com>
 <20200619132045.6120f4eb@lwn.net>
 <369b8060416ad9507ba1cd1160e20bc2f0ea7e5d.camel@perches.com>
 <20200619134633.51e1b2ec@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e856ae0c-a85e-5db5-ae96-20d032230a22@infradead.org>
Date:   Fri, 19 Jun 2020 12:50:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619134633.51e1b2ec@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/20 12:46 PM, Jonathan Corbet wrote:
> On Fri, 19 Jun 2020 12:37:13 -0700
> Joe Perches <joe@perches.com> wrote:
> 
>> Maybe your tree should be added to -next so
>> people don't have to search out specific trees.
>>
>> git git://git.lwn.net/linux.git docs-next

in a linux-next tree, the file Next/Trees contains this line:

jc_docs		git	git://git.lwn.net/linux.git#docs-next

> What makes you think it's not there...?  That doesn't help much when
> patches from other trees dig around in Documentation/ too.
> 
> jon


-- 
~Randy

